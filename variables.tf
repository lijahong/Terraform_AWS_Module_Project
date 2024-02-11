# VPC 설정 변수
variable "vpc_name" { 
  type = string
  description = "vpc 태그"
}

variable "vpc_cidr" { 
  type = string
  description = "vpc ipv4 cidr 블록"
}

variable "subnet_nat_name" {
  type = string
  description = "nat subnet 태그"
}

variable "subnet_bastion_name" {
  type = string
  description = "bastion subnet 태그"
}

variable "subnet_web_name" {
  type = string
  description = "web subnet 태그"
}

variable "subnet_web2_name" {
  type = string
  description = "web2 subnet 태그"
}

variable "subnet_az_1" {
  type = string
  description = "가용영역 1"
}

variable "subnet_az_2" {
  type = string
  description = "가용영역 2"
}

variable "subnet_nat_cidr" {
  type = string
  description = "nat subnet ipv4 cidr 블록"
}

variable "subnet_bastion_cidr" {
  type = string
  description = "bastion subnet ipv4 cidr 블록"
}

variable "subnet_web_cidr" {
  type = string
  description = "web subnet ipv4 cidr 블록"
}

variable "subnet_web2_cidr" {
  type = string
  description = "web2 subnet ipv4 cidr 블록"
}

variable "route_table_public_name" {
  type = string
  description = "public route table 태그"
}

variable "route_table_private_name" {
  type = string
  description = "private route table 태그"
}

# EC2 설정 변수

variable "keypair_name" {
  type = string
  description = "키 페어 이름"
}

variable "instance1_name" {
  type = string
  description = "web 1 인스턴스 태그"
}

variable "instance1_ami_id" {
  type = string
  description = "web 1 인스턴스 이미지 id"
}

variable "instance1_flavor" {
  type = string
  description = "web 1 인스턴스 flavor"
}

variable "instance1_need_public_ip" {
  type = bool
  description = "web 1 인스턴스 공인 ip 사용 여부"
}

variable "instance1_volume_size" {
  type = number
  description = "web 1 인스턴스 루트 볼륨 크기"
}

variable "instance1_volume_type" {
  type = string
  description = "web 1 인스턴스 루트 볼륨 타입"
}

variable "instance2_name" {
  type = string
  description = "web 2 인스턴스 태그"
}

variable "instance2_ami_id" {
  type = string
  description = "web 2 인스턴스 이미지 id"
}

variable "instance2_flavor" {
  type = string
  description = "web 2 인스턴스 flavor"
}

variable "instance2_need_public_ip" {
  type = bool
  description = "web 2 인스턴스 공인 ip 사용 여부"
}

variable "instance2_volume_size" {
  type = number
  description = "web 2 인스턴스 루트 볼륨 크기"
}

variable "instance2_volume_type" {
  type = string
  description = "web 2 인스턴스 루트 볼륨 타입"
}

# 보안 그룹 설정 변수

variable "alb_security_group_name"{
    type = string
    description = "ALB 보안 그룹 태그"
}

variable "web_security_group_name"{
    type = string
    description = "WEB 인스턴스 보안 그룹 태그"
}

# ALB 설정 변수
variable "elb_name"{
    type = string
    description = "ELB 태그"
}

variable "elb_isinternal"{
    type = bool
    description = "ELB 외부 통신 여부"
}

variable "elb_type"{
    type = string
    description = "ELB 타입"
}

# ALB 타겟 그룹 설정 변수
variable "target_group_name" {
  type = string
  description = "target group 태그"
}

variable "target_group_port" {
  type = number
  description = "요청을 받을 포트"
}

variable "target_group_protocol" {
  type = string
  description = "사용할 프로토콜"
}

variable "target_group_health_check_interval" {
  type = number
  description = "헬스 체크 주기"
}

variable "target_group_health_check_path" {
  type = string
  description = "헬스 체크에 사용할 경로"
}

variable "target_group_health_check_port" {
  type = number
  description = "헬스 체크에 사용할 포트"
}

variable "target_group_health_check_healthy_threshold" {
  type = number
  description = "가동 중단 시, 재동작을 판단하는 헬스 체크 시도 횟수"
}

variable "target_group_health_check_unhealthy_threshold" {
  type = number
  description = "가동 중단을 판단하는 헬스 체크 시도 횟수"
}

# ALB 리스너 설정 변수
variable "elb_listener_port"{
    type = number
    description = "요청을 받을 리스너 포트"
}

variable "elb_listener_protocol"{
    type = string
    description = "요청을 받을 프로토콜"
}

variable "elb_listener_type"{
    type = string
    description = "ELB 리스너 타입"
}

# ALB 타겟 그룹 연결 설정 변수
variable "targetgroup_attachment_port" {
    type = number
    description = "타겟 그룹으로부터 요청을 받을 인스턴스의 포트"
}