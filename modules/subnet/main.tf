# subnet 모듈에 대한 정의
# 정의된 subnet을 생성합니다.
# 입력 : 위치할 vpc id, subnet ipv4 cidr 블록, 가용영역, subnet 태그
# 출력 : 생성한 subent id

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr
  availability_zone = var.subnet_az
  tags = {
    "Name" = var.name
  }
}