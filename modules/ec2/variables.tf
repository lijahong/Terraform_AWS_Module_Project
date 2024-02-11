variable "name" {
  type = string
  description = "인스턴스 태그"
}

variable "ami_id" {
  type = string
  description = "인스턴스 이미지 id"
}

variable "flavor" {
  type = string
  description = "인스턴스 타입"
}

variable "need_public_ip" {
  type = bool
  description = "공인 IP 필요 여부"
}

variable "volume_size" {
  type = number
  description = "볼륨 크기"
}

variable "volume_type" {
  type = string
  description = "볼륨 타입"
}

variable "keypair_name" {
  type = string
  description = "사용할 키 페어 이름"
}

variable "security_group_id" {
  type = string
  description = "보안그룹 id"
}

variable "subnet_id" {
  type = string
  description = "인스턴스가 위치할 Subnet id"
}