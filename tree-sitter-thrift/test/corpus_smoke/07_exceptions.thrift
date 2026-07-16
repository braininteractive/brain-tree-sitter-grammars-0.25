// Exception definitions.
exception NotFound {
  1: required string message;
  2: optional i32 code = 404;
}

exception InvalidOperation {
  1: i32 what_op,
  2: string why,
}
