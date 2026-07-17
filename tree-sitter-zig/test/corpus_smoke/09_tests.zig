const std = @import("std");
const expect = std.testing.expect;

fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "add works" {
    try expect(add(2, 3) == 5);
}

test {
    try expect(true);
}
