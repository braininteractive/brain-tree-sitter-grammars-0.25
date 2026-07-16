trait Shape<T> {
    fn area(self: @T) -> u64;
}

#[derive(Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

impl RectangleShape of Shape<Rectangle> {
    fn area(self: @Rectangle) -> u64 {
        *self.width * *self.height
    }
}
