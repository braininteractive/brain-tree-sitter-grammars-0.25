const Point = struct {
    x: f64,
    y: f64,

    pub fn norm(self: Point) f64 {
        return @sqrt(self.x * self.x + self.y * self.y);
    }
};

const Vec3 = packed struct { x: f32, y: f32, z: f32 };
