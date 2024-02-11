# ELB 모듈에 대한 정의
# 정의된 ELB 를 생성합니다.
# 입력 : ELB 이름, 외부 통신 여부, ELB 타입, 보안 그룹, 속할 서브넷
# 출력 : 생성한 ELB의 ARN

resource "aws_lb" "load_balancer" {
  name               = var.name
  internal           = var.isinternal
  load_balancer_type = var.type
  security_groups    = [var.sg_id]
  subnets            = [var.subnet_a_id,var.subnet_b_id]

  tags = {
    Name = var.name
  }
}
