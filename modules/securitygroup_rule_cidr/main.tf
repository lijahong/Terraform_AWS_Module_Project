# CIDR 블록을 대상으로 하는 보안 그룹 규칙 모듈에 대한 정의
# 정의된 보안 그룹 규칙을 생성합니다
# 입력 : 속한 보안 그룹 ID, 규칙 종류, 출발지 포트, 도착지 포트, CIDR 블록, 허용 프로토콜

resource "aws_security_group_rule" "security_group_rule" {
  security_group_id = var.security_group_id
  type = var.type
  from_port   = var.from_port
  to_port     = var.to_port 
  cidr_blocks = [var.cidr]
  protocol    = var.protocol
}