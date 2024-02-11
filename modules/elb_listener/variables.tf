variable"port"{
  type = number
  description = "요청을 받을 포트"
}
variable"protocol"{
  type = string
  description = "요청을 받을 프로토콜"
}
variable"type"{
  type = string
  description = "리스너 타입"
}
variable"target_group_arn"{
  type = string
  description = "요청을 보낼 타겟 그룹 arn"
}
variable "load_balancer_arn" {
  type = string
  description = "요청을 받을 로드밸런서 arn"
}