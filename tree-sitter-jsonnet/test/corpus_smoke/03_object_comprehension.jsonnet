// Object comprehensions with for and if specs.
local names = ["alpha", "beta", "gamma"];

{
  [name]: std.length(name)
  for name in names
} + {
  ["env_" + key]: key
  for key in ["dev", "prod"]
  if key != "dev"
}
