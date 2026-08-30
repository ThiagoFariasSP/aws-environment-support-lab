variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability zone for resources"
  type        = string
  default     = "us-east-1a"
}
variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}