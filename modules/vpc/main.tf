# vpc 모듈에 대한 정의
# vpc, igw, nat gw, nat gw를 위한 eip를 생성합니다
# 입력 : vpc 태그, vpc ipv4 cidr 블록, igw와 natgw가 위치할 vpc id
# 출력 : 생성한 리소스의 id

resource "aws_vpc" "vpc" {
    cidr_block = var.cidr
    tags = {
        Name = var.name
    } 
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-%s",var.name,"IGW")
  }
}

resource "aws_eip" "eip_nat" {
  domain = "vpc"
  tags = {
    Name = format("%s-%s",var.name,"NAT-EIP")
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = var.subnet_id
  tags = {
    Name = format("%s-%s",var.name,"NAT-GW")
  }
}