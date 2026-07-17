const std = @import("std");

pub fn collect(allocator: std.mem.Allocator) ![]u32 {
    var list = std.ArrayList(u32).init(allocator);
    defer list.deinit();
    errdefer @panic("leak");

    try list.append(1);
    try list.appendSlice(&[_]u32{ 2, 3 });
    return list.toOwnedSlice();
}
