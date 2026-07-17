const FileError = error{ NotFound, AccessDenied } || error{OutOfMemory};

fn readSize(path: []const u8) FileError!usize {
    if (path.len == 0) return error.NotFound;
    return path.len;
}

fn wrap() void {
    const n = readSize("x") catch |err| switch (err) {
        error.NotFound => 0,
        else => unreachable,
    };
    _ = n;
}
