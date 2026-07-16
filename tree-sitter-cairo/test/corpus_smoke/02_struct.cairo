#[derive(Drop, Serde)]
struct Point {
    x: u32,
    y: u32,
}

fn distance_sq(p: Point) -> u32 {
    p.x * p.x + p.y * p.y
}
