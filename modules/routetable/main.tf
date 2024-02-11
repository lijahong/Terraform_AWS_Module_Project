# Route Table 모듈에 대한 정의
# 정의된 Route Table을 생성합니다.
# 입력 : 위치할 vpc id, local 라우팅을 위한 vpc ipv4 cidr 블록, 외부 라우팅을 위한 gateway id, 태그
# 출력 : 생성한 Route Table 태그

resource "aws_route_table" "routing_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = var.name
  }
}
