resource "aws_iam_policy" "example" {
  name = "example"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": []
}
EOF
}

locals {
  script = <<-EOT
    #!/bin/sh
    echo "indented heredoc"
    exit 0
  EOT
}
