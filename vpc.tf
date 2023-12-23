resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "Main_VPC"
    }
  
}
resource "aws_subnet" "public_subnet" {
    count = 2
    cidr_block = var.subnet_cidr[count.index]
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "Public_Subnet_${count.index}"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "docker_IG"
    }
  
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "Public_Route"
    }
  
}

resource "aws_route_table_association" "subnet_associate" {
    route_table_id = aws_route_table.route_table.id
    subnet_id = aws_subnet.public_subnet.*.id[0]
  
}