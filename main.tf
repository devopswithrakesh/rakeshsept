resource "aws_instance" "rakesh-instance" {
    ami ="ami-066784287e358dad1"
    instance_type = "t2.micro"
    subnet_id = "aws_subnet.rakesh-subnet.id"
    availability_zone = "us-east-1"
    vpc_security_group_ids = [aws_security_group.rakesh-sg.id]
}

resource "aws_vpc" "rakesh-vpc" {
    cidr_block ="10.10.0.0/16"
  
}

resource "aws_subnet" "rakesh-subnet" {
    cidr_block ="10.10.0.0/24"
    vpc_id ="aws_vpc.rakesh-vpc.id"

    tags = {
        Name="rak-sub"
    }
}

resource "aws_internet_gateway" "rakesh-ig" {
    vpc_id = "aws_vpc.rakesh-vpc.id"

    tags = {
      Name="rak-ig"
    }
}

resource "aws_route_table" "rakesh-rt" {
    vpc_id ="aws_vpc.rakesh-vpc.id"

    route{
        cidr_block = "0.0.0.0"
        gateway_id ="aws_internet_gateway.rakesh-ig.id"
    }
}
resource "aws_route_table_association" "rakesh-rta"{
  subnet_id= "aws_subnet.rakesh-subnet.id"
  route_table_id ="aws_route_table.rakesh-rt.id"
  }
  
  resource "aws_security_group" "rakesh-sg"{
  vpc_id ="aws_vpc.rakesh-vpc.id"
  
  ingress{
  from_port=22
  to_port =22
  protocol ="tcp"
  cidr_block ="0.0.0.0/0"
  }
  
  egress{
  from_port=22
  to_port =22
  protocol ="-1"
  cidr_block ="0.0.0.0/0"
  
}
}


