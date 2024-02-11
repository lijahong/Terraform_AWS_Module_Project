# ELB Target Group 모듈에 대한 정의
# 정의된 Target Group 를 생성합니다.
# 입력 : Target Group 이름, 요청을 받을 포트 및 프로토콜, 속할 VPC, 헬스체크 주기, 헬스체크에 사용할 포트 및 경로, 가동 중단 및 재가동을 판단할 헬스 체크 시도 횟수

resource "aws_lb_target_group" "target_group" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
	interval	= var.health_check_interval
	path		= var.health_check_path
	port		= var.health_check_port
	healthy_threshold = var.health_check_healthy_threshold
	unhealthy_threshold = var.health_check_unhealthy_threshold
  }
}