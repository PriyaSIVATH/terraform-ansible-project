variable "ami_value" {
    description = "value for the ami"
}

variable "instance_type_value" {
    description = "value for instance_type"
    default = "t2.micro"
}

variable "tag_name" {
     description = "name of the ec2 instance"
}

/*variable "subnet_id_value" {
    description = "value for the subnet_id"
}*/

variable "access_key_value" {
    description = "terraform-keys--Aws access key of IAM user - terraform-admin"
}

variable "secret_key_value" {
    description = "terraform-keys--Aws secret key of IAM user - terraform-admin"
}

variable "key_name" {
    description = "name for key-pair - using -to identify pem key file"
}

variable "ssh_port" {
    description = "Custom SSH port"
}

variable "http_port" {
    description = "Custom SSH port"
}

variable "vpc_id_value" {
    description = "Security group using Terraform"

}
