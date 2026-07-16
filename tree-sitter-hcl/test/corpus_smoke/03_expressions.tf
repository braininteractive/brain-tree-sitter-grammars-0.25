locals {
  sum        = 1 + 2 * 3
  difference = 10 - 4 / 2
  remainder  = 7 % 3
  negated    = -5
  not_true   = !false
  is_equal   = local.sum == 7
  is_greater = local.sum > local.difference
  both       = true && local.is_equal
  either     = false || local.is_greater
  choice     = local.is_equal ? "yes" : "no"
  nested     = (1 + 2) * (3 + 4)
}
