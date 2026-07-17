const std = @import("std");

fn hash(data: []const u8) u64 {
    var h: u64 = 14695981039346656037;
    for (data) |b| {
        h ^= b;
        h *%= 1099511628211;
    }
    return h;
}

comptime {
    _ = @sizeOf(u64);
    _ = @alignOf(*u8);
}
