variable "cidr" { 
  type = string
  description = "vpc의 ipv4 cidr 블록"
}

variable "name" { 
  type = string
  description = "vpc의 태그"
}

variable "subnet_id" { 
  type = string
  description = "nat gw가 위치할 subnet id"
}