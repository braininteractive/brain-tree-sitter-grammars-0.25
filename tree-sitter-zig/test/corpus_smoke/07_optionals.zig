fn find(haystack: []const u8, needle: u8) ?usize {
    for (haystack, 0..) |c, i| {
        if (c == needle) return i;
    }
    return null;
}

fn use() void {
    if (find("abc", 'b')) |idx| {
        _ = idx;
    } else {
        @panic("missing");
    }
    const x: ?u32 = null;
    const y = x orelse 42;
    _ = y;
}
