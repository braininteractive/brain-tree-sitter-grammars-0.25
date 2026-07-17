type
  Point = object
    x, y: float

  Shape = ref object of RootObj
    name: string

  Circle = ref object of Shape
    radius: float

  Color = enum
    cRed, cGreen, cBlue

proc area(c: Circle): float =
  3.14159 * c.radius * c.radius
