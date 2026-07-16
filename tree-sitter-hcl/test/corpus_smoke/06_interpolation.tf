variable "env" {
  type    = string
  default = "dev"
}

locals {
  bucket_name = "logs-${var.env}-archive"
  greeting    = "Hello, ${upper(var.env)}!"
  combined    = "${var.env}-${local.bucket_name}"
  escaped     = "literal $${not_interpolated}"
  math_inside = "total: ${1 + 2}"
}
