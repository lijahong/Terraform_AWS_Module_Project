# 다른 보안 그룹을 대상으로 하는 보안 그룹 규칙 모듈에 대한 정의
# 정의된 보안 그룹 규칙을 생성합니다
# 입력 : 속한 보안 그룹 ID, 규칙 종류, 출발지 포트, 도착지 포트, 대상 보안 그룹 ID, 허용 프로토콜

resource "aws_security_group_rule" "security_group_rule" {
  security_group_id = var.security_group_id
  type = var.type
  from_port   = var.from_port
  to_port     = var.to_port 
  protocol    = var.protocol
  source_security_group_id = var.target_security_group_id
}