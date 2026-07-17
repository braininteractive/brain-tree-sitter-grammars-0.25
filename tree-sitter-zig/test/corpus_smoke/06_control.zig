fn classify(n: i32) []const u8 {
    if (n < 0) {
        return "negative";
    } else if (n == 0) {
        return "zero";
    }
    var i: usize = 0;
    while (i < 10) : (i += 1) {
        if (i == 5) break;
    }
    for ([_]u8{ 1, 2, 3 }, 0..) |v, idx| {
        _ = v;
        _ = idx;
    }
    return switch (n) {
        1...9 => "digit",
        else => "big",
    };
}
