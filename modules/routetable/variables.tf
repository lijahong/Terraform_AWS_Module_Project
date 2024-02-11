variable "vpc_id" { 
  type = string
  description = "Route Table이 위치할 vpc id"
}

variable "vpc_cidr" { 
  type = string
  description = "내부 라우팅을 위한 vpc ipv4 cidr 블록"
}

variable "name" {
  type = string
  description = "태그"
}

variable "gateway_id" {
  type = string
  description = "외부 라우팅을 위한 gateway id"
}