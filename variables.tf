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
    vpc_id           = "vpc-0e2e5d16541f7b5b3"
    private_subnet_1 = "subnet-02cf83f8e2da11099"
    private_subnet_2 = "subnet-05498d3edd0d960d2"
    public_subnet_1  = "subnet-0d3d1953af04f7061"
    public_subnet_2  = "subnet-06b778e840e1f6649"
  }
}

variable "sg_info" {
  type    = string
  default = "sg-02819e6a01cac4bab"
}
