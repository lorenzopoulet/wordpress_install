variable "vpc_region" {
  type    = string
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.16.0.0/16"
}

variable "subnets_nb" {
  type    = number
  default = 2
}

variable "ami_id" {
  type    = string
  default = "ami-0aa74281da945b6b5"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}
