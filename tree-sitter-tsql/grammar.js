const precedences = require('./grammar/precedences.js');
const built_in_functions = require('./grammar/builtins.js');
const odbc_scalar_functions = require('./grammar/functions/odbc_scalar_functions.js');
const aggregate_window_functions = require('./grammar/functions/aggregate_functions.js');
const analytic_windowed_functions = require('./grammar/functions/analytic_windowed_functions.js');
const bit_manipulation_functions = require('./grammar/functions/bit_manipulation_functions.js');
const collation_functions = require('./grammar/functions/collation_functions.js');
const configuration_functions = require('./grammar/functions/configuration_functions.js');
const conversion_functions = require('./grammar/functions/conversion_functions.js');
const data_type = require('./grammar/data_types.js');

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

//
// LEXER https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlLexer.g4
//

//TODO doublecheck * and + semantics
const SEMI = token(';');
//FULLWIDTH handling?
//NOTE (fork): upstream required 2+ chars, rejecting single-letter identifiers/aliases like `o`
const ID                = token(/[A-Za-z_#][A-Za-z_#$@0-9]*/);
//NOTE (fork): upstream only allowed [A-Za-z_#]+; real bracket identifiers may contain digits/spaces/etc.
const SQUARE_BRACKET_ID = token(/\[[^\]]+\]/);
const LOCAL_ID          = token(/@[A-Za-z_$@#0-9]+/);
const INT               = token(/[0-9]+/);
const DOT               = token(/\./);
const STRING            = token(/N?'([^']|'')*'/);
const DECIMAL           = token(/[0-9]+/);
const DOUBLE_COLON      = token('::');
const DEC_DOT_DEC       = token(/([0-9]+\.[0-9]+|[0-9]+\.|\.?[0-9]+)/);
const COMMA             = token(',');

//
// UTILS
//
const parens = (...rule) => seq('(', ...rule, ')');

//
// PARSER https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4
//

module.exports = grammar({
  name: "tsql",

  extras: $ => [
    /\s/
    ,$.comment
  ],

  conflicts: $ => [
    [$.batch]
  ],

  ...precedences,

  rules: {

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L35
    tsql_file: $ => choice(
      repeat($.batch)
      ,seq($.execute_body_batch, repeat($.go_statement))
    ),

    batch: $ => choice(
      prec(1,$.go_statement)
      ,seq(optional($.execute_body_batch),choice($.go_statement, repeat1($.sql_clauses)), repeat($.go_statement))
      ,//TODO seq($.batch_level_statement, repeat($.go_statement))
       //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L46-L51
    ),

    //https://learn.microsoft.com/en-us/sql/t-sql/language-elements/sql-server-utilities-statements-go?view=sql-server-ver16
    go_statement: $ => seq(token(/GO/i), optional(field("count", $.integer))),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3145
    execute_body_batch: $ => prec.left(seq(
      $.func_proc_name_server_database_schema, optional(seq($.execute_statement_arg, repeat(seq(token(','), $.execute_statement_arg)))), optional(SEMI)
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5145
    func_proc_name_server_database_schema: $ => choice(
      seq(optional(field('server', $.id_)), DOT, optional(field('database', $.id_)), DOT, optional(field('schema', $.id_)), DOT, field('procedure', $.id_))
      ,$.func_proc_name_database_schema
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5140
    func_proc_name_database_schema: $ => choice(
      seq(optional(field('database', $.id_)), DOT, optional(field('schema', $.id_)), DOT, field('procedure', $.id_))
      ,$.func_proc_name_schema
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5136
    func_proc_name_schema: $ => prec.right(seq(optional(seq(field('schema',$.id_), DOT)), field('procedure', $.id_))),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3158
    execute_statement_arg: $ => choice(
      prec.left(seq($.execute_statement_arg_unnamed, repeat(seq(token(','), $.execute_statement_arg))))   //Unnamed params can continue unnamed
      ,prec.left(seq($.execute_statement_arg_named, repeat(seq(token(','), $.execute_statement_arg_named)))) //Named can only be continued by unnamed
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3163
    execute_statement_arg_named: $ => seq(
      field('name', LOCAL_ID), token('='), field('value', $.execute_parameter)
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3167
    execute_statement_arg_unnamed : $ => field('value', $.execute_parameter),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3171
    execute_parameter: $ => choice(
      $.constant
      ,seq($.LOCAL_ID_, optional($.OUTPUT))
      ,$.id_
      ,$.default
      ,$.null_
    ),

    LOCAL_ID_: $ => LOCAL_ID,
    OUTPUT: $ => token(/OUT(PUT)?/i),

    default: $ => token(/DEFAULT/i),
    null_: $ => token(/NULL/i),

    constant: $ => choice(
      STRING
      ,seq(optional(token(/-/)), choice(DECIMAL)) //TODO
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5270
    ),

    //TODO batch_level_statement: $ => 'TODO', //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L46-L51

    sql_clauses: $ => prec.right(choice(
      seq($.dml_clause, optional(SEMI))
      ,seq($.ddl_clause, optional(SEMI))
      ,seq($.cfl_statement, optional(SEMI))
      ,seq($.another_statement, optional(SEMI))
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L53-L61
    )),

    another_statement: $ => choice(
      $.declare_statement
      ,$.set_statement
      ,$.transaction_statement
      ,$.use_statement
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L350
      ,$.execute_statement
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L72
    ddl_clause: $ => choice(
      $.create_table
      ,$.create_procedure
      ,$.create_view
      ,$.create_index
      ,$.alter_table
      ,$.drop_statement
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L327
    cfl_statement: $ => choice(
      $.block_statement
      ,$.if_statement
      ,$.while_statement
      ,$.break_statement
      ,$.continue_statement
      ,$.return_statement
      ,$.try_catch_statement
      ,$.print_statement
      ,$.throw_statement
      ,$.raiserror_statement
    ),

    //
    // CONTROL FLOW
    //

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L339
    block_statement: $ => seq($.begin_, repeat($.sql_clauses), $.end_),

    begin_: $ => token(/BEGIN/i),
    end_: $ => token(/END/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L344
    if_statement: $ => prec.right(seq(
      $.if_, $.search_condition, $.sql_clauses, optional(seq($.else_, $.sql_clauses))
    )),

    else_: $ => token(/ELSE/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L365
    while_statement: $ => seq(token(/WHILE/i), $.search_condition, $.sql_clauses),

    break_statement: $ => token(/BREAK/i),
    continue_statement: $ => token(/CONTINUE/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L355
    return_statement: $ => prec.left(seq(token(/RETURN/i), optional($.expression))),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L361
    try_catch_statement: $ => seq(
      $.begin_try_, field('try_block', repeat($.sql_clauses)), $.end_try_
      ,$.begin_catch_, field('catch_block', repeat($.sql_clauses)), $.end_catch_
    ),

    begin_try_: $ => seq($.begin_, $.try_),
    end_try_: $ => seq($.end_, $.try_),
    begin_catch_: $ => seq($.begin_, $.catch_),
    end_catch_: $ => seq($.end_, $.catch_),
    try_: $ => token(/TRY/i),
    catch_: $ => token(/CATCH/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L351
    print_statement: $ => seq(token(/PRINT/i), $.expression),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L297
    throw_statement: $ => prec.left(seq(
      token(/THROW/i)
      ,optional(seq(
        field('error_number', choice($.decimal_, $.LOCAL_ID_))
        ,COMMA, field('message', choice($.string_lit, $.LOCAL_ID_))
        ,COMMA, field('state', choice($.decimal_, $.LOCAL_ID_))))
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L307
    raiserror_statement: $ => prec.right(seq(
      token(/RAISERROR/i)
      ,parens(
        field('msg', choice($.decimal_, $.string_lit, $.LOCAL_ID_))
        ,COMMA, field('severity', $.expression)
        ,COMMA, field('state', $.expression)
        ,repeat(seq(COMMA, $.expression)))
      ,optional(seq($.WITH, $.id_))
    )),

    //
    // VARIABLES / SESSION
    //

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2493
    declare_statement: $ => choice(
      seq($.declare_, $.declare_local, repeat(seq(COMMA, $.declare_local)))
      ,seq($.declare_, $.LOCAL_ID_, optional($.as), $.table_, parens($.column_def_table_constraints))
    ),

    declare_: $ => token(/DECLARE/i),
    table_: $ => token(/TABLE/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4930
    declare_local: $ => seq(
      field('name', $.LOCAL_ID_)
      ,optional($.as)
      ,field('type', $.data_type)
      ,optional(seq(token('='), field('value', $.expression)))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L371
    set_statement: $ => choice(
      seq($.set_, $.LOCAL_ID_, choice(token('='), $.assignment_operator), $.expression)
      ,seq($.set_, $.set_special)
    ),

    set_: $ => token(/SET/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4869 (simplified)
    set_special: $ => choice(
      seq(field('option', $.id_), choice($.on_, $.off_))
      ,seq($.transaction_, token(/ISOLATION/i), token(/LEVEL/i)
        ,choice(
          seq(token(/READ/i), choice(token(/UNCOMMITTED/i), token(/COMMITTED/i)))
          ,seq(token(/REPEATABLE/i), token(/READ/i))
          ,token(/SNAPSHOT/i)
          ,token(/SERIALIZABLE/i)))
    ),

    on_: $ => token(/ON/i),
    off_: $ => token(/OFF/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L389 (simplified)
    transaction_statement: $ => prec.right(choice(
      seq($.begin_, $.transaction_, optional(field('name', choice($.id_, $.LOCAL_ID_))))
      ,seq($.commit_, optional($.transaction_), optional(field('name', choice($.id_, $.LOCAL_ID_))))
      ,seq($.rollback_, optional($.transaction_), optional(field('name', choice($.id_, $.LOCAL_ID_))))
      ,seq($.save_, $.transaction_, field('name', choice($.id_, $.LOCAL_ID_)))
    )),

    transaction_: $ => token(/TRAN(SACTION)?/i),
    commit_: $ => token(/COMMIT/i),
    rollback_: $ => token(/ROLLBACK/i),
    save_: $ => token(/SAVE/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L406
    use_statement: $ => seq(token(/USE/i), field('database', $.id_)),

    // https://msdn.microsoft.com/en-us/library/ms188332.aspx
    // https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3141
    execute_statement: $ => prec.left(seq($.execute, $.execute_body, optional(SEMI))),

    execute: $ => token(/EXEC(UTE)?/i),

    // https://learn.microsoft.com/en-us/sql/t-sql/language-elements/execute-transact-sql?view=sql-server-ver15
    execute_body: $ => prec.right(choice(
      seq(optional(seq(field('return_status',$.LOCAL_ID_), token(/=/)))
        , choice($.func_proc_name_server_database_schema, $.execute_var_string)
        , optional($.execute_statement_arg)
        , optional(seq($.WITH, $.execute_option, repeat(seq(token(','), $.execute_option)))))
      //TODO execute_option https://learn.microsoft.com/en-us/sql/t-sql/language-elements/execute-transact-sql?view=sql-server-ver15

      ,seq(parens(seq($.execute_var_string, repeat(seq(token(','), $.execute_var_string))))
        ,optional(seq($.AS, choice($.LOGIN,$.USER), token('='), $.string_lit))
        ,optional(seq($.AT_KEYWORD, field('linkedServer', $.id_))))
      //TODO AT_DATA_SOURCE https://learn.microsoft.com/en-us/sql/t-sql/language-elements/execute-transact-sql?view=sql-server-ver16&redirectedfrom=MSDN#:~:text=AT%20DATA_SOURCE%20data_source_name%20Applies%20to%3A%20SQL%20Server%202019%20(15.x)%20and%20later
    )),

    WITH: $ => token(/WITH/i),

    execute_option: $ => choice(
      $.RECOMPILE
      ,seq($.RESULT_SETS, choice($.NONE, $.UNDEFINED))
      //TODO Result Sets Definition
      // https://learn.microsoft.com/en-us/sql/t-sql/language-elements/execute-transact-sql?view=sql-server-ver15
    ),

    RESULT_SETS: $ => seq(token(/RESULT/i), token(/SETS/i)),
    NONE: $ => token(/NONE/i),
    UNDEFINED: $ => token(/UNDEFINED/i),

    RECOMPILE: $ => token(/RECOMPILE/i),

    AS: $ => token(/AS/i),
    LOGIN: $ => token(/LOGIN/i),
    USER: $ => token(/USER/i),
    AT_KEYWORD: $ => token(/AT/i),

    // https://learn.microsoft.com/en-us/sql/t-sql/language-elements/execute-transact-sql?view=sql-server-ver15
    // https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3175-L3178
    execute_var_string: $ => choice(
      seq($.LOCAL_ID_, optional(seq($.PLUS, $.LOCAL_ID_, optional(seq($.PLUS, $.execute_var_string)))))
      ,seq($.string_lit, optional(seq($.PLUS, $.LOCAL_ID_, optional(seq($.PLUS, $.execute_var_string)))))
    ),

    string_lit: $ => token(seq(
      optional('N')
      ,"'" //Opening Single Quote
      ,repeat(choice(
        /[^']/,               // Any character except a single quote
        "''"                  // Escaped single quote (two single quotes)
      ))
      ,"'" //Closing Single Quote

    )),


    PLUS: $ => token(/\+/),

    dml_clause: $ => choice(
      $.select_statement_standalone
      ,$.insert_statement
      ,$.update_statement
      ,$.delete_statement
      ,$.merge_statement
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L63-L70
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2183
    select_statement_standalone: $ => seq(
      optional($.with_expression)
      ,$.select_statement
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3960
    with_expression: $ => seq(
      $.WITH, $.common_table_expression, repeat(seq(COMMA, $.common_table_expression))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3964
    common_table_expression: $ => seq(
      field('name', $.id_)
      ,optional(parens($.column_name_list))
      ,$.AS
      ,parens($.select_statement)
    ),

    column_name_list: $ => seq($.id_, repeat(seq(COMMA, $.id_))),

    select_statement: $ => prec.right(seq(
      $.query_expression
      ,optional($.order_by_clause)
      ,optional(SEMI)
      //TODO for_clause / option_clause https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2186
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3999
    query_expression: $ => prec.right(seq(
      choice($.query_specification, parens($.query_expression))
      ,repeat($.sql_union)
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4004
    sql_union: $ => seq(
      choice(
        seq($.union_, optional($.all_))
        ,$.except_
        ,$.intersect_
      )
      ,choice($.query_specification, parens($.query_expression))
    ),

    union_: $ => token(/UNION/i),
    all_: $ => token(/ALL/i),
    except_: $ => token(/EXCEPT/i),
    intersect_: $ => token(/INTERSECT/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4010-L4023
    query_specification: $ => prec.right(seq(
      $.select
      ,optional(choice($.all_, $.distinct_))
      ,optional($.top_clause)
      ,$.select_list
      ,optional(seq($.into_, field('into_table', $.full_table_name)))
      ,optional(seq($.from_, $.table_sources))
      ,optional($.where_clause)
      ,optional($.groupby)
      ,optional($.having_clause)
    )),

    distinct_: $ => token(/DISTINCT/i),
    into_: $ => token(/INTO/i),
    from_: $ => token(/FROM/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4054
    top_clause: $ => seq(
      token(/TOP/i)
      ,choice(parens($.expression), $.decimal_)
      ,optional($.percent_)
      ,optional(seq($.WITH, $.ties_))
    ),

    percent_: $ => token(/PERCENT/i),
    ties_: $ => token(/TIES/i),

    where_clause: $ => seq(token(/WHERE/i), field('condition', $.search_condition)),

    having_clause: $ => seq(token(/HAVING/i), field('condition', $.search_condition)),

    //
    // INSERT / UPDATE / DELETE / MERGE
    //

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2020
    insert_statement: $ => seq(
      token(/INSERT/i)
      ,optional($.into_)
      ,field('target', choice($.full_table_name, $.LOCAL_ID_))
      ,optional(parens($.column_name_list))
      ,$.insert_statement_value
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2032
    insert_statement_value: $ => choice(
      $.table_value_constructor
      ,$.select_statement_standalone
      ,$.execute_statement
      ,seq($.default, token(/VALUES/i))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3993
    table_value_constructor: $ => seq(
      token(/VALUES/i)
      ,parens($.expression_list_)
      ,repeat(seq(COMMA, parens($.expression_list_)))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2273
    update_statement: $ => seq(
      token(/UPDATE/i)
      ,optional($.top_clause)
      ,field('target', choice($.full_table_name, $.LOCAL_ID_))
      ,$.set_, $.update_elem, repeat(seq(COMMA, $.update_elem))
      ,optional(seq($.from_, $.table_sources))
      ,optional($.where_clause)
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2288
    update_elem: $ => seq(
      field('column', choice($.full_column_name, $.LOCAL_ID_))
      ,choice(token('='), $.assignment_operator)
      ,field('value', $.expression)
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L1901
    delete_statement: $ => prec.left(seq(
      token(/DELETE/i)
      ,optional($.top_clause)
      ,optional($.from_)
      ,field('target', choice($.full_table_name, $.LOCAL_ID_))
      ,optional($.as_table_alias)
      ,optional(seq($.from_, $.table_sources))
      ,optional($.where_clause)
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2065 (simplified: no output clause / hints)
    merge_statement: $ => seq(
      token(/MERGE/i)
      ,optional($.top_clause)
      ,optional($.into_)
      ,field('target', $.full_table_name)
      ,optional($.as_table_alias)
      ,$.using_, field('source', $.table_source)
      ,$.on_, $.search_condition
      ,repeat1($.when_match)
    ),

    using_: $ => token(/USING/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2078-L2087
    when_match: $ => choice(
      seq($.when_, $.matched_, optional(seq($.and_, $.search_condition)), $.then_, $.merge_matched)
      ,seq($.when_, $.not_, $.matched_, optional(seq($.by_, $.target_)), optional(seq($.and_, $.search_condition)), $.then_, $.merge_not_matched)
      ,seq($.when_, $.not_, $.matched_, $.by_, $.source_, optional(seq($.and_, $.search_condition)), $.then_, $.merge_matched)
    ),

    when_: $ => token(/WHEN/i),
    matched_: $ => token(/MATCHED/i),
    then_: $ => token(/THEN/i),
    by_: $ => token(/BY/i),
    target_: $ => token(/TARGET/i),
    source_: $ => token(/SOURCE/i),
    and_: $ => token(/AND/i),
    not_: $ => token(/NOT/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2091
    merge_matched: $ => choice(
      seq(token(/UPDATE/i), $.set_, $.update_elem, repeat(seq(COMMA, $.update_elem)))
      ,token(/DELETE/i)
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2097
    merge_not_matched: $ => seq(
      token(/INSERT/i)
      ,optional(parens($.column_name_list))
      ,choice($.table_value_constructor, seq($.default, token(/VALUES/i)))
    ),

    select: $ => token(/SELECT/i),
    //https://learn.microsoft.com/en-us/sql/t-sql/queries/select-clause-transact-sql?view=sql-server-ver16&redirectedfrom=MSDN
    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4119
    select_list: $ => seq($.select_list_elem, repeat(seq(token(','), $.select_list_elem))),

    //TODO REDO THIS ONE
    select_list_elem: $ => choice(
      seq(optional(seq(field('table', $.id_), DOT)), $.asterisk)
      ,$.udt_elem
      ,seq($.LOCAL_ID_, choice($.assignment_operator, token('=')), $.expression)
      ,$.expression_elem
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4143-L4148
    ),

    //TODO
    groupby: $ => seq($.groupby_, choice(
      field('groupBys',seq($.group_by_item, repeat(seq(token(','), $.group_by_item))))
    )),

    //TODO
    group_by_item: $ => choice(
      $.expression
    ),

    groupby_: $ => token(/GROUP BY/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L6294
    assignment_operator: $ => choice(
       token('+=')
      ,token('-=')
      ,token('*=')
      ,token('/=')
      ,token('%=')
      ,token('&=')
      ,token('^=')
      ,token('|=')
    ),

    asterisk: $ => token(/\*/),

    //https://learn.microsoft.com/en-us/sql/t-sql/queries/select-clause-transact-sql?view=sql-server-ver16
    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4133
    udt_elem: $ => prec.left(choice(
      seq(field('udt_column_name', $.id_), DOT, field('non_static_attr',$.id_), $.udt_method_arguments, optional($.as_column_alias))

      ,prec.right(seq(field('udt_column_name', $.id_), DOUBLE_COLON, field('non_static_attr',$.id_)
        ,optional($.udt_method_arguments)
        ,optional($.as_column_alias)))
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4123
    udt_method_arguments: $ => seq(
      parens($.execute_var_string, repeat(seq(token(','), $.execute_var_string)))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4138
    expression_elem: $ => prec.right(choice(
      seq(field('leftAlias', $.column_alias), token(/=/), field('leftAssignment', $.expression))
      ,seq(field('expressionAs', $.expression), optional($.as_column_alias))
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4910
    as_column_alias: $ => seq(optional($.as), $.column_alias),
    as: $ => token(/AS/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4990
    column_alias: $ => choice(
      $.id_
      ,$.string_lit
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4150-L4153
    table_sources: $ => seq(
      $.table_source, repeat(seq(COMMA, $.table_source))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4160C4-L4163
    table_source: $ => prec.left(seq($.table_source_item, repeat($.join_part))),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4180 (simplified)
    table_source_item: $ => choice(
      prec.right(seq($.full_table_name, optional($.as_table_alias), optional($.with_table_hints)))
      ,prec.right(seq($.LOCAL_ID_, optional($.as_table_alias)))
      ,prec.right(seq(field('derived_table', parens($.select_statement)), optional($.as_table_alias), optional(parens($.column_name_list))))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4914
    //NOTE: alias deliberately excludes $.keyword (GO) so batch separators are never taken as aliases
    as_table_alias: $ => seq(optional($.as), field('alias', alias($.table_alias, $.id_))),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4919 (simplified)
    with_table_hints: $ => seq($.WITH, parens($.id_, repeat(seq(COMMA, $.id_)))),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4227 (simplified: no nested parenthesized joins / APPLY / PIVOT)
    join_part: $ => choice($.join_on, $.cross_join),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4234
    join_on: $ => seq(
      optional(choice(
        $.inner_
        ,seq(choice($.left_, $.right_, $.full_), optional($.outer_))
      ))
      ,$.join_
      ,field('source', $.table_source_item)
      ,$.on_
      ,field('cond', $.search_condition)
    ),

    cross_join: $ => seq($.cross_, $.join_, field('source', $.table_source_item)),

    inner_: $ => token(/INNER/i),
    outer_: $ => token(/OUTER/i),
    full_: $ => token(/FULL/i),
    cross_: $ => token(/CROSS/i),
    join_: $ => token(/JOIN/i),

    //TODO CORPUS
    table_name: $ => prec.right(seq(
      optional(choice(
        seq(field('database', $.id_), DOT, field('schema', $.id_))
        ,seq(field('schema', $.id_), DOT)
      ))
      ,choice(
        field('table', $.id_)
        //TODO blocking_hiearchy
        //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5128
      )
    )),


    full_table_name: $ => prec.right(seq(
      optional(choice(
      //NOTE? whats this dotdot example https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5118
        seq(field('server', $.id_), DOT, field('database', $.id_), DOT, field('schema', $.id_), DOT)
        ,seq(field('database', $.id_), DOT, field('schema', $.id_), DOT)
        ,seq(field('schema', $.id_), DOT)
      ))
      ,field('table', $.id_)
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5155-L5160
    full_column_name: $ => prec.right(choice(
      field('column', $.id_)
      ,seq(field('tablename', $.id_), DOT, field('column', $.id_))
      ,seq(field('schema', $.id_), DOT, field('tablename', $.id_), DOT, field('column', $.id_))
      ,seq(field('database', $.id_), DOT, field('schema', $.id_), DOT, field('tablename', $.id_), DOT, field('column', $.id_))
    )),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3900-L3917
    expression: $ => choice(
      $.primitive_expression
      ,$.function_call
      ,$.full_column_name
      ,$.binary_expression
      ,$.unary_expression
      ,$.bracket_expression
      ,$.case_expression
      ,$.subquery
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3906-L3909
    binary_expression: $ => choice(
      prec.left(4, seq(field('left', $.expression), field('op', choice(token('*'), token('/'), token('%'))), field('right', $.expression)))
      ,prec.left(3, seq(field('left', $.expression), field('op', choice(token('+'), token('-'), token('&'), token('^'), token('|'))), field('right', $.expression)))
    ),

    unary_expression: $ => prec(5, seq(field('op', choice(token('-'), token('+'), token('~'))), $.expression)),

    bracket_expression: $ => parens($.expression),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3942
    subquery: $ => parens($.select_statement),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3947-L3956
    case_expression: $ => choice(
      seq($.case_, field('input', $.expression), repeat1($.switch_section), optional(seq($.else_, field('else', $.expression))), $.end_)
      ,seq($.case_, repeat1($.switch_search_condition_section), optional(seq($.else_, field('else', $.expression))), $.end_)
    ),

    case_: $ => token(/CASE/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4941
    switch_section: $ => seq($.when_, field('when', $.expression), $.then_, field('then', $.expression)),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4945
    switch_search_condition_section: $ => seq($.when_, field('when', $.search_condition), $.then_, field('then', $.expression)),

    //
    // SEARCH CONDITIONS / PREDICATES
    //

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4025
    search_condition: $ => choice(
      prec.left(1, seq(field('left', $.search_condition), $.and_, field('right', $.search_condition)))
      ,prec.left(0, seq(field('left', $.search_condition), $.or_, field('right', $.search_condition)))
      ,prec.right(2, seq($.not_, $.search_condition))
      ,$.predicate
    ),

    or_: $ => token(/OR/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4032 (simplified: no ALL/SOME/ANY, no freetext)
    predicate: $ => choice(
      seq($.exists_, parens($.select_statement))
      ,prec.left(3, seq($.expression, $.comparison_operator, $.expression))
      ,prec.left(3, seq($.expression, optional($.not_), $.between_, $.expression, $.and_, $.expression))
      ,prec.left(3, seq($.expression, optional($.not_), $.in_, parens(choice($.select_statement, $.expression_list_))))
      ,prec.left(3, seq($.expression, optional($.not_), $.like_, $.expression, optional(seq($.escape_, $.expression))))
      ,prec.left(3, seq($.expression, $.is_, optional($.not_), $.null_))
      ,parens($.search_condition)
    ),

    exists_: $ => token(/EXISTS/i),
    between_: $ => token(/BETWEEN/i),
    in_: $ => token(/IN/i),
    like_: $ => token(/LIKE/i),
    escape_: $ => token(/ESCAPE/i),
    is_: $ => token(/IS/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5310
    comparison_operator: $ => choice(
      token('='), token('>'), token('<'), token('<='), token('>=')
      ,token('<>'), token('!='), token('!<'), token('!>')
    ),

    //TODO CORPUS
    function_call: $ => choice(
      $.ranking_windowed_function
      ,$.aggregate_functions
      ,$.analytic_windowed_functions

      ,$.built_in_functions
      //TODO built_in_function ~~200 rules https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4291

      ,choice(
        seq($.scalar_function_name, parens(optional($.expression_list_)))
        ,seq(choice($.binary_checksum_, $.checksum_), parens(choice($.asterisk, $.expression_list_))) //TODO MOVE TO BUILTINS
      )

      ,$.partition_function
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4287
      ,$.hierarchyid_static_method
      //TODO freetext_function
      ,$.odbc_scalar_functions
      ,$.bit_manipulation_functions
      ,$.collation_functions
      ,$.configuration_functions
      ,$.conversion_functions
    ),

    ...built_in_functions,
    ...odbc_scalar_functions,
    ...aggregate_window_functions,
    ...analytic_windowed_functions,
    ...bit_manipulation_functions,
    ...collation_functions,
    ...configuration_functions,
    ...conversion_functions,
    ...data_type,

    //https://learn.microsoft.com/en-us/sql/t-sql/data-types/hierarchyid-data-type-method-reference?view=sql-server-ver16
    hierarchyid_static_method: $ => choice(
      seq($.hierachyid_, DOUBLE_COLON, choice(
        seq($.getroot_, parens())
        ,seq($.parse_, parens(field('input',$.expression)))
        )
      )
      ,seq($.id_, DOT, choice(
        $.getlevel_
        ,$.tostring_
      ), parens())

      ,seq($.id_, DOT, choice(
        $.getancestor_
        ,$.is_descendant_of_
      ), parens($.expression))

      ,seq($.id_, DOT, choice(
        $.get_reparented_value_
        ,$.get_descendant_
      ), parens(seq($.expression, token(','), $.expression)))


    ),

    hierachyid_: $ => token(/HIERARCHYID/i),

    get_descendant_: $ => token(/GetDescendant/i),
    get_reparented_value_: $ => token(/GetReparentedValue/i),
    getancestor_: $ => token(/GETANCESTOR/i),
    is_descendant_of_: $ => token(/IsDescendantOf/i),
    getlevel_: $ => token(/GETLEVEL/i),
    getroot_: $ => token(/GETROOT/i),
    tostring_: $ => token(/ToString/i),


    parse_: $ => token(/PARSE/i),

    // https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4298-L4300
    partition_function: $ => seq(
      optional(seq(field('database', $.id_), DOT)), $.dollar_partition_, DOT, field('func_name', $.id_), parens($.expression)
    ),

    dollar_partition_: $ => token(/\$PARTITION/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5198
    scalar_function_name: $ => choice(
      $.func_proc_name_database_schema
      ,$.right_
      ,$.left_
    ),

    right_: $ => token(/RIGHT/i),
    left_: $ => token(/LEFT/i),
    binary_checksum_: $ => token(/BINARY_CHECKSUM/i),
    checksum_: $ => token(/CHECKSUM/i),

    local_id_: $ => LOCAL_ID,
    seperator: $ => choice(
      $.local_id_
      ,$.string_lit
    ),
    //https://msdn.microsoft.com/en-us/library/ms189798.aspx
    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5004
    ranking_windowed_function: $ => choice(
      seq(choice($.rank_, $.dense_rank_, $.row_number_)
        ,token('('), token(')'), $.over_clause)
      ,seq($.ntile_, parens($.expression), $.over_clause)
    ),

    ntile_: $ => token(/NTILE/i),
    rank_: $ => token(/RANK/i),
    dense_rank_: $ => token(/DENSE_RANK/i),
    row_number_: $ => token(/ROW_NUMBER/i),

    //https://msdn.microsoft.com/en-us/library/ms189461.aspx
    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5033
    over_clause: $ => seq(
      token(/OVER/i)
      ,token('(')
        ,optional($.partition_by_clause)
        ,optional($.order_by_clause)
        ,optional($.row_or_range_clause)
      ,token(')')
    ),

    partition_by_clause: $ => seq(token(/PARTITION/i), token(/BY/i), $.expression_list_),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4999
    expression_list_: $ => prec.left(seq($.expression, repeat(seq(token(','), $.expression)))),

    //https://docs.microsoft.com/en-us/sql/t-sql/queries/select-over-clause-transact-sql?view=sql-server-ver16
    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4041
    order_by_clause: $ => seq(
      token(/ORDER/i), token(/BY/i), $.order_by_expression, repeat(seq(token(','), $.order_by_expression))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L4071
    order_by_expression: $ => seq(
      field('order_by', $.expression)
      ,optional($.collation_)
      ,optional(choice(
        field('ascending', $.asc_)
        ,field('descending', $.desc_)
      )),
    ),

    collation_: $ => seq(
      token(/COLLATE/i)
      ,field('collation_name', $.id_)
    ),

    asc_: $ => token(/ASC/i),
    desc_: $ => token(/DESC/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5041
    window_frame_extent: $ => choice(
      $.window_frame_preceding
      ,seq(token(/BETWEEN/i), $.window_frame_bound, token(/AND/i), $.window_frame_bound)
    ),

    window_frame_bound: $ => choice(
      $.window_frame_preceding
      ,$.window_frame_following
    ),

    window_frame_following: $ => choice(
      seq(token(/UNBOUNDED/i), token(/FOLLOWING/i))
      ,seq(DECIMAL, token(/FOLLOWING/i))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5051
    window_frame_preceding: $ => choice(
      seq(token(/UNBOUNDED/i), token(/PRECEDING/i))
      ,seq(DECIMAL, token(/PRECEDING/i))
      ,seq(token(/CURRENT/i), token(/ROW/i))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5037
    row_or_range_clause: $ => seq(
      choice(token(/ROWS/i), token(/RANGE/i)),
      $.window_frame_extent
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3927
    primitive_expression: $ => choice(
      $.default
      ,$.null_
      ,$.LOCAL_ID_
      ,$.primitive_constant
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5278
    primitive_constant: $ => choice(
      $.string_lit
      ,$.binary
      ,$.real_
      ,$.decimal_
      ,$.float_
      ,$.money_
      ,$.parameter_
    ),

    binary: $ => token(/0x[0-9A-F]*/),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5283
    money_: $ => seq(field('dollar', token('$')), optional(choice(token('-'),token('+'))), choice($.real_, $.float_)),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L3919-L3921
    parameter_: $ => token('?'),


    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlLexer.g4#L1231
    real_: $ => seq(
      choice(DECIMAL,DEC_DOT_DEC)
      ,token(/E/i)
      ,optional(choice(token('+'),token('-')))
      ,token(/[0-9]+/)),

    float_: $ => DEC_DOT_DEC,
    decimal_: $ => DECIMAL,

    //
    // DDL
    //

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L1250 (simplified: no filegroup/partition options)
    create_table: $ => seq(
      $.create_, $.table_, field('name', $.table_name)
      ,parens($.column_def_table_constraints)
    ),

    create_: $ => token(/CREATE/i),

    column_def_table_constraints: $ => seq(
      $.column_def_table_constraint
      ,repeat(seq(COMMA, $.column_def_table_constraint))
    ),

    column_def_table_constraint: $ => choice(
      $.column_definition
      ,$.table_constraint
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2551 (simplified)
    column_definition: $ => seq(
      field('name', $.id_)
      ,field('type', $.data_type)
      ,repeat($.column_definition_element)
    ),

    column_definition_element: $ => prec.right(choice(
      seq($.not_, $.null_)
      ,$.null_
      ,seq($.identity_, optional(parens(field('seed', $.decimal_), COMMA, field('increment', $.decimal_))))
      ,seq(optional(seq($.constraint_, field('constraint_name', $.id_))), $.default, field('default_value', $.expression))
      ,seq(optional(seq($.constraint_, field('constraint_name', $.id_))), $.primary_, $.key_, optional(choice($.clustered_, $.nonclustered_)))
      ,seq(optional(seq($.constraint_, field('constraint_name', $.id_))), $.unique_)
      ,seq(optional(seq($.constraint_, field('constraint_name', $.id_))), $.references_, field('ref_table', $.table_name), optional(parens($.column_name_list)))
      ,seq(optional(seq($.constraint_, field('constraint_name', $.id_))), $.check_, parens($.search_condition))
      ,$.collation_
      ,$.rowguidcol_
    )),

    identity_: $ => token(/IDENTITY/i),
    constraint_: $ => token(/CONSTRAINT/i),
    primary_: $ => token(/PRIMARY/i),
    key_: $ => token(/KEY/i),
    unique_: $ => token(/UNIQUE/i),
    references_: $ => token(/REFERENCES/i),
    check_: $ => token(/CHECK/i),
    clustered_: $ => token(/CLUSTERED/i),
    nonclustered_: $ => token(/NONCLUSTERED/i),
    rowguidcol_: $ => token(/ROWGUIDCOL/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2721 (simplified)
    table_constraint: $ => prec.right(seq(
      optional(seq($.constraint_, field('name', $.id_)))
      ,choice(
        seq(choice(seq($.primary_, $.key_), $.unique_), optional(choice($.clustered_, $.nonclustered_)), parens($.column_name_list_with_order))
        ,seq($.foreign_, $.key_, parens($.column_name_list), $.references_, field('ref_table', $.table_name), optional(parens($.column_name_list))
          ,repeat(seq($.on_, choice(token(/DELETE/i), token(/UPDATE/i)), choice(seq(token(/NO/i), token(/ACTION/i)), token(/CASCADE/i), seq($.set_, $.null_), seq($.set_, $.default)))))
        ,seq($.check_, parens($.search_condition))
      )
    )),

    foreign_: $ => token(/FOREIGN/i),

    column_name_list_with_order: $ => seq(
      seq($.id_, optional(choice($.asc_, $.desc_)))
      ,repeat(seq(COMMA, $.id_, optional(choice($.asc_, $.desc_))))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L843 (simplified: no CLR/external, no WITH options body variants)
    create_procedure: $ => prec.right(seq(
      choice(
        seq($.create_, optional(seq($.or_, $.alter_)))
        ,$.alter_
      )
      ,$.proc_
      ,field('name', $.func_proc_name_schema)
      ,optional($.procedure_params)
      ,optional(seq($.WITH, $.procedure_option, repeat(seq(COMMA, $.procedure_option))))
      ,$.AS
      ,field('body', repeat1($.sql_clauses))
    )),

    alter_: $ => token(/ALTER/i),
    proc_: $ => token(/PROC(EDURE)?/i),

    procedure_params: $ => choice(
      seq($.procedure_param, repeat(seq(COMMA, $.procedure_param)))
      ,parens($.procedure_param, repeat(seq(COMMA, $.procedure_param)))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L910
    procedure_param: $ => seq(
      field('name', $.LOCAL_ID_)
      ,optional($.as)
      ,field('type', $.data_type)
      ,optional(seq(token('='), field('default_val', choice($.constant, $.null_, $.LOCAL_ID_))))
      ,optional(choice($.OUTPUT, $.readonly_))
    ),

    readonly_: $ => token(/READONLY/i),

    procedure_option: $ => choice(
      $.RECOMPILE
      ,token(/ENCRYPTION/i)
      ,seq(token(/EXECUTE/i), $.AS, choice(token(/CALLER/i), token(/SELF/i), token(/OWNER/i), $.string_lit))
    ),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L2426 (simplified: no attributes/check option)
    create_view: $ => seq(
      choice(
        seq($.create_, optional(seq($.or_, $.alter_)))
        ,$.alter_
      )
      ,$.view_
      ,field('name', $.table_name)
      ,optional(parens($.column_name_list))
      ,$.AS
      ,$.select_statement_standalone
    ),

    view_: $ => token(/VIEW/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L440 (simplified: no filegroup/options)
    create_index: $ => seq(
      $.create_
      ,optional($.unique_)
      ,optional(choice($.clustered_, $.nonclustered_))
      ,$.index_
      ,field('name', $.id_)
      ,$.on_
      ,field('table', $.table_name)
      ,parens($.column_name_list_with_order)
      ,optional(seq($.include_, parens($.column_name_list)))
      ,optional($.where_clause)
    ),

    index_: $ => token(/INDEX/i),
    include_: $ => token(/INCLUDE/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L1181 (simplified: ADD/DROP COLUMN + ADD constraint only)
    alter_table: $ => seq(
      $.alter_, $.table_, field('name', $.table_name)
      ,choice(
        seq($.add_, choice($.column_def_table_constraints))
        ,seq($.drop_, $.column_, $.id_, repeat(seq(COMMA, $.id_)))
        ,seq($.drop_, $.constraint_, $.id_)
      )
    ),

    add_: $ => token(/ADD/i),
    drop_: $ => token(/DROP/i),
    column_: $ => token(/COLUMN/i),

    //https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4 (drop rules, simplified)
    drop_statement: $ => seq(
      $.drop_
      ,choice($.table_, $.proc_, $.view_, $.index_, token(/FUNCTION/i))
      ,optional(seq($.if_, $.exists_))
      ,$.table_name, repeat(seq(COMMA, $.table_name))
    ),

    if_: $ => token(/IF/i),

    //
    // HELPERS
    //

    comment: $ => token(choice(
      seq('--', /[^\r\n]*/)
      ,seq('/*', /[^*]*\*+([^/*][^*]*\*+)*/, '/')
    )),

    //https://msdn.microsoft.com/en-us/library/ms175874.aspx
    id_: $ => choice(
      ID
      ,SQUARE_BRACKET_ID
      ,$.keyword
      //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L6261
    ),

    //TODO https://github.com/antlr/grammars-v4/blob/master/sql/tsql/TSqlParser.g4#L5287
    keyword: $ => choice(
      token(/GO/i)
    ),

    //id_ minus $.keyword — used for table aliases (see as_table_alias)
    table_alias: $ => choice(ID, SQUARE_BRACKET_ID),

    integer: $ => INT,

    placeholder: $ => alias('TODO', $.dummy),

  }
});
