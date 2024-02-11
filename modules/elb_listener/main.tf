# ELB Listener 모듈에 대한 정의
# 정의된 ELB Listener 를 생성합니다.
# 입력 : ELB ARN, TARGET GROUP ARN, 요청을 받을 포트와 프로토콜

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = var.type
    target_group_arn = var.target_group_arn
  }
}