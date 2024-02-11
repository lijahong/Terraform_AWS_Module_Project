# EC2 모듈에 대한 정의
# 정의된 EC2 인스턴스를 생성합니다.
# 입력 : 태크, ami id, 인스턴스 타입, 키 페어 이름, 보안그룹 id, 공인 ip 필요 여부, 볼륨 크기, 볼륨 타입
# 출력 : 생성한 인스턴스 id

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.flavor
  key_name = var.keypair_name
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = var.need_public_ip
  subnet_id = var.subnet_id

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
  }

  user_data = file("start.sh")
  
  tags = {
    Name = var.name
  }
  
}
