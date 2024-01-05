# General Variables
variable "aws_region" {
  description = "Default region for provider"
  type        = string
}

variable "aws_access_key" { #Will be Prompted if not passed in .tfvars
  description = "Provide the AWS Access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" { #Will be Prompted if not passed in .tfvars
  description = "Provide the AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Project Name used for resource name and tags"
}

#EC2
variable "build_server" {
  description = "EC2 type and volume size of buildserver"
  default     = [{ ec2_type = "t2.micro", volume_size = "10" }]
}

variable "db_server" {
  description = "EC2 type and volume size of db1server"
  default     = [{ ec2_type = "t2.micro", volume_size = "10" }]
}

variable "keypair_name" {
  description = "Name of Keypair of EC2"
  default     = "staging_ec2-key"
}

variable "smtp_email" {
  description = "Email to be used as verified identity"
}

variable "tags" {
  type = map(string)
  default = {
    Terraform   = "true"
    Environment = "Staging"
  }
}

