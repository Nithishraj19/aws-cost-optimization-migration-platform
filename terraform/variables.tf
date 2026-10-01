variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "cost-migration-reference"
}

variable "vpc_cidr" {
  type    = string
  default = "10.40.0.0/16"
}

variable "tags" {
  type = map(string)
  default = {
    Project     = "aws-cost-optimization-migration-platform"
    Environment = "reference"
    Owner       = "replace-me"
    CostCenter  = "replace-me"
  }
}
