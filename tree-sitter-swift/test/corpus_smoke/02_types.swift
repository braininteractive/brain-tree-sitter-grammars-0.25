struct Point: Equatable {
    var x: Double
    var y: Double

    var norm: Double {
        (x * x + y * y).squareRoot()
    }
}

final class Circle {
    let center: Point
    var radius: Double

    init(center: Point, radius: Double) {
        self.center = center
        self.radius = radius
    }
}

enum Direction: Int, CaseIterable {
    case north = 0, east = 90, south = 180, west = 270
}
