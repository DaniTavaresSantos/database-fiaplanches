variable "app_name" {
  default = "fiap-lanches"
  type    = string
}

variable "ecr_regitry_url" {
  default = "516194196157.dkr.ecr.us-east-1.amazonaws.com/fiap-lanches:latest"
  type    = string
}

variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "Deployment Environment"
  default     = "develop"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24"]
}

variable "vpc_info" {
  type = object({
    vpc_id           = string
    private_subnet_1 = string
    private_subnet_2 = string
    public_subnet_1  = string
    public_subnet_2  = string
  })
  description = "Informacoes da vpc fiap lanches"
  default = {
    vpc_id           = "vpc-056c8ad0a004f0cac"
    private_subnet_1 = "subnet-029d36db94f609bca"
    private_subnet_2 = "subnet-0f37608a67d95733c"
    public_subnet_1  = "subnet-061cc1584dfbf7f85"
    public_subnet_2  = "subnet-086cc8d90563e4c0c"
  }
}

variable "sg_info" {
  type    = string
  default = "sg-09a43e6cf8a443c1e"
}
