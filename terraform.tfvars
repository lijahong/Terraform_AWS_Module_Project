# Vpc 설정
vpc_name = "HONG-VPC"
vpc_cidr = "10.23.0.0/16"

# Subnet 설정
subnet_nat_name = "HONG-NAT-SUBNET"
subnet_nat_cidr = "10.23.1.0/24"

subnet_bastion_name = "HONG-BASTION-SUBNET"
subnet_bastion_cidr = "10.23.2.0/24"

subnet_web_name = "HONG-WEB-SUBNET"
subnet_web_cidr = "10.23.3.0/24"

subnet_web2_name = "HONG-WEB2-SUBNET"
subnet_web2_cidr = "10.23.4.0/24"

subnet_az_1 = "ap-northeast-2a"
subnet_az_2 = "ap-northeast-2c"

# Route Table 설정
route_table_private_name = "Hong-Route-Table-Private"
route_table_public_name = "Hong-Route-Table-Public"

# EC2 설정

# web 서버 1
instance1_name = "Hong-WEB1-EC2"
instance1_ami_id = "ami-07eff2bc4837a9e01"
instance1_flavor = "t2.micro"
instance1_need_public_ip = false
instance1_volume_size = 8
instance1_volume_type = "gp3"

# web 서버 2
instance2_name = "Hong-WEB2-EC2"
instance2_ami_id = "ami-07eff2bc4837a9e01"
instance2_flavor = "t2.micro"
instance2_need_public_ip = false
instance2_volume_size = 8
instance2_volume_type = "gp3"

# 키 페어 이름
keypair_name = "HONG-keypair"

# ALB 보안 그룹 설정
alb_security_group_name = "ALB-SG"

# WEB 인스턴스 보안 그룹 설정
web_security_group_name = "WEB-SG"

# ALB 설정
elb_name = "HONG-ALB"
elb_isinternal = false
elb_type = "application"

# ALB 타겟 그룹 설정
target_group_name = "HONG-ALB-TARGET-GROUP"
target_group_port = 80
target_group_protocol = "HTTP"
target_group_health_check_interval = 15
target_group_health_check_healthy_threshold = 3
target_group_health_check_unhealthy_threshold = 3
target_group_health_check_path = "/index.html"
target_group_health_check_port = 80

# ALB 리스너 설정
elb_listener_port = 80
elb_listener_protocol = "HTTP"
elb_listener_type = "forward"

# ALB 타겟 그룹-EC2 인스턴스 연결 설정
targetgroup_attachment_port = 80