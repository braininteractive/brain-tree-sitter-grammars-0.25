machine labels_groups;

grouped = ( 'a' | 'b' ) . ( 'c' | 'd' )*;
labelled = start: 'go' . finish: 'stop';
nested = ( ( '(' . ')' ) | ( '[' . ']' ) );
main := grouped | labelled | nested;
