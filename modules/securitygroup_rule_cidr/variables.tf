variable "type"{
  type = string
  description = "보안 그룹 규칙 종류"
}
variable "from_port"{
  type = number
  description = "출발지 포트"
}
variable "to_port"{
  type = number
  description = "도착지 포트"
} 
variable "cidr"{
  type = string
  description = "ipv4 cidr 블록"
}
variable "protocol"{
  type = string
  description = "허용 프로토콜"
}
variable "security_group_id"{
  type = string
  description = "규칙이 속한 보안 그룹 ID"
}