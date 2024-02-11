# 보안 그룹 모듈에 대한 정의
# 정의된 보안 그룹을 생성합니다
# 입력 : 보안 그룹 태그, 보안 그룹이 속한 vpc id
# 출력 : 생성한 보안 그룹 id

resource "aws_security_group" "security_group" {
  name        = var.name
  vpc_id      = var.vpc_id
  tags = {
    Name = var.name
  }
}