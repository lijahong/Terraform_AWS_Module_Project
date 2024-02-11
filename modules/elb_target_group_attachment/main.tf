# ELB Target Group Attachment 모듈에 대한 정의
# 정의된 Target Group에 EC2 인스턴스를 연결합니다.
# 입력 : Target Group arn, EC2 인스턴스 ID, 요청을 받을 EC2 인스턴스의 포트

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = var.instance_id
  port             = var.port
}