data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*"]
  }
}

resource "aws_instance" "conditional" {
  count         = var.env == "prod" ? 3 : 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.env == "prod" ? "m5.large" : "t3.micro"
}
