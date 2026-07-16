// Services with oneway functions, throws clauses, and inheritance.
exception StorageError {
  1: string message;
}

service BaseService {
  bool ping();
}

service KeyValueStore extends BaseService {
  string get(1: required string key) throws (1: StorageError err);
  void put(1: required string key, 2: required string value) throws (1: StorageError err);
  oneway void expire(1: string key, 2: i64 after_ms);
  list<string> keys();
}
