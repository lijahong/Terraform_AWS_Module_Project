variable "target_group_arn"{
  type = string
  description = "Target Group ARN"
}
variable "instance_id"{
  type = string
  description = "EC2 인스턴스 ID"
}
variable "port"{
  type = number
  description = "요청을 받을 EC2 인스턴스의 포트"
}