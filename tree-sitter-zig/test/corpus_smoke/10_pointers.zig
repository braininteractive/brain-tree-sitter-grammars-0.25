fn bump(ptr: *i32) void {
    ptr.* += 1;
}

fn slices() void {
    var buf: [8]u8 = undefined;
    const s: []u8 = buf[0..4];
    const c: [*]u8 = &buf;
    _ = s;
    _ = c;
    var n: i32 = 0;
    bump(&n);
}
