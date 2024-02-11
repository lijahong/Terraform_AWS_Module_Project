variable "name"{
  type = string
  description = "target group 태그"
}
variable "port"{
  type = number
  description = "요청을 받을 포트"
}
variable "protocol"{
  type = string
  description = "사용할 프로토콜"
}
variable "vpc_id"{
  type = string
  description = "속한 VPC ID"
}

variable "health_check_interval"{
  type = number
  description = "헬스 체크 주기"
}
variable "health_check_path"{
  type = string
  description = "헬스 체크에 사용할 경로"
}
variable "health_check_port"{
  type = number
  description = "헬스 체크에 사용할 포트"
}
variable "health_check_healthy_threshold"{
  type = number
  description = "가동 중단 시, 재동작을 판단하는 헬스 체크 시도 횟수"
}
variable "health_check_unhealthy_threshold"{
  type = number
  description = "가동 중단을 판단하는 헬스 체크 시도 횟수"
}