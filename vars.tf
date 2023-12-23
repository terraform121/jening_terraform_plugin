variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "Creating VPC"
    type = string 
}
variable "subnet_cidr" {
    default = ["10.0.0.0/24", "10.0.1.0/24"]
    description = "Enter subnet CIDR"
    type=list(string)
}

variable "ami" {
    default = "ami-0230bd60aa48260c6"
  
}
