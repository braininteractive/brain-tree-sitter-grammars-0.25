abstract class Repository<T, ID> {
  T? findById(ID id);
  void save(T entity);
}

mixin Loggable {
  void log(String msg) => print('[log] $msg');
}

class UserRepo with Loggable implements Repository<String, int> {
  final _store = <int, String>{};

  @override
  String? findById(int id) => _store[id];

  @override
  void save(String entity) {
    _store[_store.length] = entity;
    log('saved $entity');
  }
}
