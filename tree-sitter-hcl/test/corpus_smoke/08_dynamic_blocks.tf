variable "ingress_rules" {
  type = list(object({
    port     = number
    protocol = string
  }))
  default = []
}

resource "aws_security_group" "example" {
  name = "dynamic-example"

  dynamic "ingress" {
    for_each = var.ingress_rules
    iterator = rule

    content {
      from_port   = rule.value.port
      to_port     = rule.value.port
      protocol    = rule.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
