/**
 * Doc-block comment at the top of the file.
 */

// Line comment.
# Hash-style comment.

/* Multi-line
   block comment. */

struct Annotated {
  1: required string name (go.tag = "json:\"name\"");
  2: optional i32 weight;
} (cpp.type = "DenseAnnotated")

enum Level {
  LOW = 1,
  HIGH = 2 (deprecated = "use LOW")
}

typedef i64 Millis (unit = "ms")
