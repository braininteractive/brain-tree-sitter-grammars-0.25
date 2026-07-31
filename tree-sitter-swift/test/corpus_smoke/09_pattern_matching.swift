enum Shape {
    case square(side: Double)
    case circle(radius: Double)
    case rectangle(w: Double, h: Double)
}

func area(_ shape: Shape) -> Double {
    switch shape {
    case .square(let s):
        return s * s
    case .circle(let r):
        return .pi * r * r
    case let .rectangle(w, h) where w == h:
        return w * w
    case let .rectangle(w, h):
        return w * h
    }
}

let point = (1, -1)
switch point {
case (0, 0): print("origin")
case (let x, 0): print("x-axis at \(x)")
case (-2...2, -2...2): print("near origin")
default: print("elsewhere")
}

print(area(.circle(radius: 2)))
