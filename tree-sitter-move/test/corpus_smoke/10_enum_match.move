module 0x1::shapes {
    enum Shape has copy, drop {
        Circle { radius: u64 },
        Rectangle { width: u64, height: u64 },
        Point,
    }

    public fun area(shape: &Shape): u64 {
        match (shape) {
            Shape::Circle { radius } => 3 * *radius * *radius,
            Shape::Rectangle { width, height } => *width * *height,
            Shape::Point => 0,
        }
    }

    public fun is_point(shape: &Shape): bool {
        match (shape) {
            Shape::Point => true,
            _ => false,
        }
    }
}
