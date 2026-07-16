locals {
  name        = "example"
  count       = 3
  enabled     = true
  disabled    = false
  nothing     = null
  ratio       = 0.75
  ports       = [80, 443, 8080]
  labels      = { app = "web", tier = "frontend" }
  description = "a simple set of attribute values"
}
