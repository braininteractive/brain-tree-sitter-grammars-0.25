locals {
  names        = ["alpha", "beta", "gamma"]
  upper_names  = [for n in local.names : upper(n)]
  filtered     = [for n in local.names : n if n != "beta"]
  indexed      = [for i, n in local.names : "${i}-${n}"]
  name_lengths = { for n in local.names : n => length(n) }
  swapped      = { for k, v in { a = 1, b = 2 } : v => k }
}
