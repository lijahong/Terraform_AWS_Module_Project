# vpc, igw, nat gw 정의
module "HONG-VPC"{
  source = "./modules/vpc"
  name = var.vpc_name
  cidr = var.vpc_cidr
  subnet_id = module.HONG-NAT-PUBLIC.subnet_id
}

# subnet 정의
module "HONG-NAT-PUBLIC"{
  source = "./modules/subnet"
  name = var.subnet_nat_name
  cidr = var.subnet_nat_cidr
  subnet_az = var.subnet_az_1
  vpc_id = module.HONG-VPC.vpc_id
}

module "HONG-BASTION-PUBLIC"{
  source = "./modules/subnet"
  name = var.subnet_bastion_name
  cidr = var.subnet_bastion_cidr
  subnet_az = var.subnet_az_2
  vpc_id = module.HONG-VPC.vpc_id
}

module "HONG-WEB-PRIVATE"{
  source = "./modules/subnet"
  name = var.subnet_web_name
  cidr = var.subnet_web_cidr
  subnet_az = var.subnet_az_1
  vpc_id = module.HONG-VPC.vpc_id
}

module "HONG-WEB2-PRIVATE"{
  source = "./modules/subnet"
  name = var.subnet_web2_name
  cidr = var.subnet_web2_cidr
  subnet_az = var.subnet_az_2
  vpc_id = module.HONG-VPC.vpc_id
}

# Route Table 정의
module "Public-Route-Table" {
  source = "./modules/routetable"
  name = var.route_table_public_name
  gateway_id = module.HONG-VPC.igw_id
  vpc_cidr = var.vpc_cidr
  vpc_id = module.HONG-VPC.vpc_id
}

module "Private-Route-Table" {
  source = "./modules/routetable"
  name = var.route_table_private_name
  gateway_id = module.HONG-VPC.natgw_id
  vpc_cidr = var.vpc_cidr
  vpc_id = module.HONG-VPC.vpc_id
}

module "Subnet-Nat-Route-Association"{
  source = "./modules/routetable_association"
  subnet_id = module.HONG-NAT-PUBLIC.subnet_id
  routetable_id = module.Public-Route-Table.routing_table_id
}

module "Subnet-BASTION-Route-Association"{
  source = "./modules/routetable_association"
  subnet_id = module.HONG-BASTION-PUBLIC.subnet_id
  routetable_id = module.Public-Route-Table.routing_table_id
}

module "Subnet-WEB-Route-Association"{
  source = "./modules/routetable_association"
  subnet_id = module.HONG-WEB-PRIVATE.subnet_id
  routetable_id = module.Private-Route-Table.routing_table_id
}

module "Subnet-WEB2-Route-Association"{
  source = "./modules/routetable_association"
  subnet_id = module.HONG-WEB2-PRIVATE.subnet_id
  routetable_id = module.Private-Route-Table.routing_table_id
}


# KeyPair 정의
module "HONG-KEYPAIR" {
  source = "./modules/keypair"
  name = var.keypair_name
}

# ALB 보안 그룹 정의
module "ALB-SG"{
  source = "./modules/securitygroup"
  name = var.alb_security_group_name
  vpc_id = module.HONG-VPC.vpc_id
}

# WEB 보안 그룹 정의
module "WEB-SG"{
  source = "./modules/securitygroup"
  name = var.web_security_group_name
  vpc_id = module.HONG-VPC.vpc_id
}

# ALB 보안 그룹 규칙 정의
module "ALB-SG-INGRESS-RULE"{
  source = "./modules/securitygroup_rule_cidr"
  from_port = 80
  to_port = 80
  security_group_id = module.ALB-SG.sg_id
  type = "ingress"
  protocol = "TCP"
  cidr = "0.0.0.0/0"
}
module "ALB-SG-EGRESS-RULE"{
  source = "./modules/securitygroup_rule_sg"
  from_port = 80
  to_port = 80
  security_group_id = module.ALB-SG.sg_id
  type = "egress"
  protocol = "TCP"
  target_security_group_id = module.WEB-SG.sg_id
}

# WEB 인스턴스 보안 그룹 규칙 정의
module "WEB-SG-INGRESS-RULE"{
  source = "./modules/securitygroup_rule_sg"
  from_port = 80
  to_port = 80
  security_group_id = module.WEB-SG.sg_id
  type = "ingress"
  protocol = "TCP"
  target_security_group_id = module.ALB-SG.sg_id
}
module "WEB-SG-EGRESS-RULE"{
  source = "./modules/securitygroup_rule_cidr"
  from_port = 0
  to_port = 0
  security_group_id = module.WEB-SG.sg_id
  type = "egress"
  protocol = "-1"
  cidr = "0.0.0.0/0"
}

# WEB 인스턴스 정의
module "HONG-WEB1-INSTANCE"{
  source = "./modules/ec2"
  name = var.instance1_name
  ami_id = var.instance1_ami_id
  subnet_id = module.HONG-WEB-PRIVATE.subnet_id
  flavor = var.instance1_flavor
  keypair_name = module.HONG-KEYPAIR.keypair_name
  security_group_id = module.WEB-SG.sg_id
  need_public_ip = var.instance1_need_public_ip
  volume_size = var.instance1_volume_size
  volume_type = var.instance1_volume_type
}

module "HONG-WEB2-INSTANCE"{
  source = "./modules/ec2"
  name = var.instance2_name
  ami_id = var.instance2_ami_id
  flavor = var.instance2_flavor
  subnet_id = module.HONG-WEB2-PRIVATE.subnet_id
  keypair_name = module.HONG-KEYPAIR.keypair_name
  security_group_id = module.WEB-SG.sg_id
  need_public_ip = var.instance2_need_public_ip
  volume_size = var.instance2_volume_size
  volume_type = var.instance2_volume_type
}

# ALB 설정
module "HONG-ALB" {
  source = "./modules/elb"
  name = var.elb_name
  isinternal = var.elb_isinternal
  type = var.elb_type
  sg_id = module.ALB-SG.sg_id
  subnet_a_id = module.HONG-NAT-PUBLIC.subnet_id
  subnet_b_id = module.HONG-BASTION-PUBLIC.subnet_id
}

# ALB 타겟 그룹 설정
module "HONG-ALB-TARGETGROUP"{
  source = "./modules/elb_target_group"
  name = var.target_group_name
  port = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id = module.HONG-VPC.vpc_id

  health_check_interval = var.target_group_health_check_interval
  health_check_path = var.target_group_health_check_path
  health_check_port = var.target_group_health_check_port
  health_check_healthy_threshold = var.target_group_health_check_healthy_threshold
  health_check_unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
}

# ALB 리스너 설정
module "HONG-ALB-LISTENER" {
  source = "./modules/elb_listener"
  port = var.elb_listener_port
  protocol = var.elb_listener_protocol
  type = var.elb_listener_type
  target_group_arn = module.HONG-ALB-TARGETGROUP.target_group_arn
  load_balancer_arn = module.HONG-ALB.LB_ARN
}

# ALB 타겟 그룹 연결 설정
module "HONG-WEB-TARGET-GROUP-ATTACHMENT"{
  source = "./modules/elb_target_group_attachment"
  target_group_arn = module.HONG-ALB-TARGETGROUP.target_group_arn
  instance_id = module.HONG-WEB1-INSTANCE.ec2_id
  port = var.targetgroup_attachment_port
}

module "HONG-WEB2-TARGET-GROUP-ATTACHMENT"{
  source = "./modules/elb_target_group_attachment"
  target_group_arn = module.HONG-ALB-TARGETGROUP.target_group_arn
  instance_id = module.HONG-WEB2-INSTANCE.ec2_id
  port = var.targetgroup_attachment_port
}