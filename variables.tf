# Region and AZ
#
variable "region" {
	default = "eu-west-3"
}

variable "az1" {
	default = "eu-west-3a"
}

variable "az2" {
	default = "eu-west-3b"
}

variable "az3" {
	default = "eu-west-3c"
}

# Profile and ssh pub keys
#
variable "ssh_pub_key_path" {
	default = "/home/kbelgadi/work/training/terraform/ssh_key_pair/ec2-user_key.pub"
}

variable "profile" {
	description = "AWS user credentials"
	default="terraform-test"
}

# VPC
#
variable "vpc_name" {
	description = "VPC Name"
	default = "lab"
}

