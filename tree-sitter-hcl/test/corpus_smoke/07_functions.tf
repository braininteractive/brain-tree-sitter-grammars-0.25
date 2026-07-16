locals {
  joined    = join("-", ["a", "b", "c"])
  maximum   = max(1, 2, 3)
  formatted = format("%s-%02d", "item", 7)
  looked_up = lookup({ a = 1 }, "a", 0)
  merged    = merge({ a = 1 }, { b = 2 })
  spread    = min([3, 1, 2]...)
  encoded   = jsonencode({ key = "value" })
  chained   = trimspace(lower("  MiXeD Case  "))
}
