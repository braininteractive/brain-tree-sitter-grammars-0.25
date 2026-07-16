// Unions hold exactly one of their fields.
union SearchKey {
  1: string name;
  2: i64 id;
  3: binary fingerprint;
}

union Value {
  1: bool bool_value,
  2: i64 int_value,
  3: double double_value,
  4: string string_value,
}
