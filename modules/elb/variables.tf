variable "name" {
  type = string
  description = "ELB 태그"
}
variable "isinternal" {
  type = bool
  description = "ELB 외부 통신 여부"
}
variable "type" {
  type = string
  description = "ELB 타입"
}
variable "sg_id" {
  type = string
  description = "ELB 보안 그룹 ID"
}
variable "subnet_a_id" {
  type = string
  description = "ELB 서브넷 A"
}
variable "subnet_b_id" {
  type = string
  description = "ELB 서브넷 B"
}