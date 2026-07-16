variable "instance_count" {
  type        = number
  default     = 2
  description = "How many instances to launch"

  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be positive."
  }
}

output "instance_ids" {
  value       = aws_instance.web[*].id
  description = "IDs of all web instances"
  sensitive   = false
}
