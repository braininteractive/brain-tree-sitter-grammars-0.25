const Color = enum(u8) {
    red = 1,
    green,
    blue,

    fn isWarm(self: Color) bool {
        return self == .red;
    }
};

const Value = union(enum) {
    int: i64,
    float: f64,
    none: void,
};
