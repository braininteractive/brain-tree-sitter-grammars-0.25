// Container types: list, set, map, and nesting thereof.
struct Inventory {
  1: required list<string> tags;
  2: optional set<i32> ids;
  3: required map<string, double> prices;
  4: optional map<string, list<i32>> groups;
  5: optional list<map<string, set<i64>>> deep;
  6: optional map<i32, map<string, string>> matrix;
}

typedef list<set<i32>> IdBuckets
