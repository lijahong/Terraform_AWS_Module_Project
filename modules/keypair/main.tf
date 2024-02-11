# EC2 Key Pair 에 대한 정의
# 정의된 키 페어를 생성하고, 개인 키를 로컬 환경에 가져옵니다.

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "local_file" "cicd_downloads_key" {
  filename        = "./keypair_dic/keypair.pem"
  content         = tls_private_key.private_key.private_key_pem
  file_permission = "0600"
}
