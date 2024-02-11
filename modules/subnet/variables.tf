variable "vpc_id"{
    type = string
    description = "subnet이 위치할 vpc id"
}
variable "cidr"{ 
    type = string
    description = "subnet의 ipv4 cidr"
}
variable "subnet_az"{ 
    type = string
    description = "subnet이 위치할 가용 영역"
}
variable "name"{ 
    type = string
    description = "subnet 태그"
}