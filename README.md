# Terraform Module을 활용한 AWS 기반 Public Web Service 구축

## 구축될 AWS 인프라
![AS2](https://github.com/lijahong/Terraform_AWS_Module_Project/assets/69387517/a22a5a9c-0637-4178-bc24-d72860f7a342)
#### Terraform 코드로 구축될 AWS 인프라는 위와 같으며, Web 서버에 Apache Httpd 2.4.58버전이 자동으로 설치되어 동작한다.

---

## Root Module
- provider.tf : 프로비저너를 지정하는 파일
- main.tf : Child Module을 호출하여 전체 인프라를 정의
- variables.tf : Root Module에서 사용할 변수를 정의
- terraform.tfvars : 정의한 변수에 주입할 값
- outputs.tf : 프로비저닝 완료 후 출력하는 값 정의 ( ALB의 도메인 주소가 출력됩니다 )
- start.sh : WEB 인스턴스를 설정해주는 Shell Script 입니다. 인스턴스 부팅 시, 아래 과정을 자동으로 실행합니다.
> 1. 소스 컴파일 설치 방식으로 Apache Httpd를 설치
> 2. systemd에 Apache Service 등록
> 3. 웹 페이지 html 파일 수정 및 반영
> 4. Apache Httpd 실행

---

## Child Module
### ec2
- EC2 인스턴스를 생성하는 모듈
### elb
- ELB를 생성하는 모듈
### elb_listenser
- ELB Listener를 생성하는 모듈
### elb_target_group
- Target Group을 생성하는 모듈
### elb_target_group_attachment
- Target Group에 EC2 인스턴스를 연결하는 모듈
### keypair
- Key Pair를 생성하는 모듈
### routetable
- Route Table을 생성하는 모듈
### routetable_association
- 서브넷에 Route Table을 연결하는 모듈
### securitygroup
- 보안 그룹을 생성하는 모듈
### securitygroup_rule_cidr
- CIDR 블록을 대상으로 하는 보안 그룹 규칙을 생성하는 모듈
### securitygroup_rule_sg
- 다른 보안 그룹을 대상으로 하는 보안 그룹 규칙을 생성하는 모듈
### subnet
- Subnet을 생성하는 모듈
### vpc
- Vpc를 생성하는 모듈
