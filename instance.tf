resource "aws_security_group" "security_Group" {
    name = "Allow_tls"
    description = "Allow TLS inbound traffic"
    vpc_id = aws_vpc.main.id
    ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    }

    ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    }

    ingress {
        description      = "TLS from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]

    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
}

resource "aws_instance" "docker" {
    ami = var.ami
    subnet_id = aws_subnet.public_subnet.*.id[0]
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.security_Group.id]
    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              docker ps
              EOF
    
    tags = {
      Name = "Docker"
    }
  
}

# resource "aws_s3_bucket" "mys3bucket" {
#   bucket = "my-dynamodb-test-bucket-1" 
#   tags = {
#     Name = "My bucket"
#   }
# }

# resource "aws_dynamodb_table" "mydynamodb" {
#   name = "svc-file-data-store"
#   billing_mode = "PROVISIONED"
#   read_capacity = 5
#   write_capacity = 5
#   hash_key = "ID"
#   range_key = "SK"
#   attribute {
#     name = "ID"
#     type = "S"
#   }

#   attribute {
#     name = "SK"
#     type = "S"
#   }
#   tags = {
#     Name = "dynamodb-table"
#   }

# }