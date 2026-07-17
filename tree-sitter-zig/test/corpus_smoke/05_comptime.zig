fn Matrix(comptime T: type, comptime rows: usize, comptime cols: usize) type {
    return struct {
        data: [rows][cols]T,

        const Self = @This();

        fn zero() Self {
            return .{ .data = std.mem.zeroes([rows][cols]T) };
        }
    };
}

const std = @import("std");
const M2 = Matrix(f32, 2, 2);
