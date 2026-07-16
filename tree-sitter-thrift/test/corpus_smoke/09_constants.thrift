// Constants of primitive, container, and struct-literal shapes.
const i32 MAX_RETRIES = 5
const double PI = 3.14159
const string GREETING = "hello world"
const bool ENABLED = true

const list<i32> FIBONACCI = [1, 1, 2, 3, 5, 8]
const set<string> ADMINS = ["root", "admin"]
const map<string, i32> LIMITS = {"soft": 100, "hard": 200}

struct Settings {
  1: i32 retries;
  2: string label;
}

const Settings DEFAULT_SETTINGS = {"retries": 3, "label": "default"}
