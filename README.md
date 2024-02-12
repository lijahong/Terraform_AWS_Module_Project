# Terraform Module을 활용한 AWS 기반 Public Web Service 구축

# 1. AWS 인프라 아키텍처
![AS2](https://github.com/lijahong/Terraform_AWS_Module_Project/assets/69387517/a22a5a9c-0637-4178-bc24-d72860f7a342)
#### Terraform 코드로 구축될 AWS 인프라는 위와 같으며, Web 서버에 Apache Httpd 2.4.58버전이 자동으로 설치되어 동작한다.

#### 프로비저닝 소요 시간 : 7분 30초 -> 인프라 프로비저닝 3분 + Shell Script 실행 4분 30초 ( 소스 컴파일 설치 방식을 사용하기 때문에 시간이 조금 걸립니다 )

---

# 2. Root Module

#### 코드 및 변수에 대한 상세 설명은 main.tf, variables.tf, start.sh에서 확인할 수 있습니다.

## 2.1 Root Module 구조

- provider.tf : 프로비저너를 지정하는 파일
- main.tf : Child Module을 호출하여 설정을 통해 전체 인프라를 정의
- variables.tf : Root Module에서 사용할 변수를 정의
- terraform.tfvars : 정의한 변수에 주입할 값
- outputs.tf : 프로비저닝 완료 후 출력하는 값 정의 ( ALB의 도메인 주소가 출력됩니다 )
- start.sh : WEB 인스턴스를 설정해주는 Shell Script 입니다. 인스턴스 부팅 시, 아래 과정을 자동으로 실행합니다.
> 1. 소스 컴파일 설치 방식으로 Apache Httpd를 설치
> 2. systemd에 Apache Service 등록
> 3. 웹 페이지 html 파일 수정 및 반영
> 4. Apache Httpd 실행

## 2.2. terraform.tfvars 변수 설정 값 설명

### 2.2.1. Vpc 설정
| Variable | Type | Description |
| --- | --- | --- |
| vpc_name | string | vpc의 태그 |
| vpc_cidr | string | vpc의 ipv4 cidr 블록 |

### 2.2.2. Subnet 설정
| Variable | Type | Description |
| --- | --- | --- |
| subnet_nat_name | string | nat subnet 태그 |
| subnet_nat_cidr | string | nat subnet의 ipv4 cidr |
| subnet_bastion_name | string | bastion subnet 태그 |
| subnet_bastion_cidr | string | bastion subnet의 ipv4 cidr |
| subnet_web_name | string | web subnet 태그 |
| subnet_web_cidr | string | web subnet의 ipv4 cidr |
| subnet_web2_name | string | web2 subnet 태그 |
| subnet_web2_cidr | string | web2 subnet의 ipv4 cidr |
| subnet_az_1 | string | subnet이 위치할 가용 영역 1 |
| subnet_az_2 | string | subnet이 위치할 가용 영역 2 |

### 2.2.3. Route Table 설정
| Variable | Type | Description |
| --- | --- | --- |
| route_table_private_name | string | Private Subnet에 대한 Route Table 태그 |
| route_table_public_name | string | Public Subnet에 대한 Route Table 태그 |

### 2.2.4. EC2 Web1 인스턴스 설정
| Variable | Type | Description |
| --- | --- | --- |
| instance1_name | string | web 인스턴스 1의 태그 |
| instance1_ami_id | string | web 인스턴스 1의 이미지 id |
| instance1_flavor | string | web 인스턴스 1의 인스턴스 타입 |
| instance1_need_public_ip | bool | web 인스턴스 1의 공인 IP 필요 여부 |
| instance1_volume_size | number | web 인스턴스 1의 Root 볼륨 크기 |
| instance1_volume_type | string | web 인스턴스 1의 Root 볼륨 타입 |

### 2.2.5. EC2 Web2 인스턴스 설정
| Variable | Type | Description |
| --- | --- | --- |
| instance2_name | string | web 인스턴스 2의 태그 |
| instance2_ami_id | string | web 인스턴스 2의 이미지 id |
| instance2_flavor | string | web 인스턴스 2의 인스턴스 타입 |
| instance2_need_public_ip | bool | web 인스턴스 2의 공인 IP 필요 여부 |
| instance2_volume_size | number | web 인스턴스 2의 Root 볼륨 크기 |
| instance2_volume_type | string | web 인스턴스 2의 Root 볼륨 타입 |

### 2.2.6. Key Pair 설정
| Variable | Type | Description |
| --- | --- | --- |
| keypair_name | string | Key Pair 이름 |

### 2.2.7. ALB & WEB 보안 그룹 설정 값
| Variable | Type | Description |
| --- | --- | --- |
| alb_security_group_name | string | ALB 보안 그룹 이름 |
| web_security_group_name | string | WEB 인스턴스 보안 그룹 이름 |

### 2.2.8. ELB 설정 값
| Variable | Type | Description |
| --- | --- | --- |
| elb_name | string | ELB 이름 |
| elb_isinternal | bool | ELB 외부 통신 여부 |
| elb_type | string | ELB 타입 |

### 2.2.9. Target Group 설정 값
| Variable | Type | Description |
| --- | --- | --- |
| target_group_name | string | Target Group 태그 |
| target_group_port | number | 요청을 받을 포트 |
| target_group_protocol | string | 사용할 프로토콜 |
| target_group_health_check_interval | number | 헬스 체크 주기 ( sec ) |
| target_group_health_check_healthy_threshold | number | 서비스 상태를 성공으로 판단하는 연속 헬스 체크 횟수 |
| target_group_health_check_unhealthy_threshold | number | 서비스 상태를 실패로 판단하는 연속 헬스 체크 횟수 |
| target_group_health_check_path | string | 헬스 체크에 사용할 경로 |
| target_group_health_check_port | number | 헬스 체크에 사용할 포트 |

### 2.2.10. ELB Listener 설정 값
| Variable | Type | Description |
| --- | --- | --- |
| elb_listener_port | number | 요청을 받을 리스너의 포트 |
| elb_listener_protocol | string | 요청을 받을 프로토콜 |
| elb_listener_type | string | 리스너 타입 |

### 2.2.11. ELB Target Group과 EC2 인스턴스 연결 설정 값
| Variable | Type | Description |
| --- | --- | --- |
| targetgroup_attachment_port | number | 요청을 받을 EC2 인스턴스의 포트 |

---

# 3. Child Module

#### 코드 및 변수에 대한 상세 설명은 각 Module의 main.tf, variables.tf에서 확인할 수 있습니다.

## 3.1. Chile Module 구조
![image](https://github.com/lijahong/Terraform_AWS_Module_Project/assets/69387517/b8ab9bab-6375-4b02-96a2-a0826ec10351)
- main.tf : 리소스를 정의한 파일
- variables.tf : 리소스 정의에 사용할 변수를 정의한 파일
- outputs.tf : 리소스 생성 후 출력할 값을 정의한 파일

## 3.2. Child Module 설명

### 3.2.1. ec2
- EC2 인스턴스를 생성하는 모듈
### 3.2.2. elb
- ELB를 생성하는 모듈
### 3.2.3. elb_listenser
- ELB Listener를 생성하는 모듈
### 3.2.4. elb_target_group
- Target Group을 생성하는 모듈
### 3.2.5. elb_target_group_attachment
- Target Group에 EC2 인스턴스를 연결하는 모듈
### 3.2.6. keypair
- Key Pair를 생성하는 모듈
### 3.2.7. routetable
- Route Table을 생성하는 모듈
### 3.2.8. routetable_association
- 서브넷에 Route Table을 연결하는 모듈
### 3.2.9. securitygroup
- 보안 그룹을 생성하는 모듈
### 3.2.10. securitygroup_rule_cidr
- CIDR 블록을 대상으로 하는 보안 그룹 규칙을 생성하는 모듈
### 3.2.11. securitygroup_rule_sg
- 다른 보안 그룹을 대상으로 하는 보안 그룹 규칙을 생성하는 모듈
### 3.2.12. subnet
- Subnet을 생성하는 모듈
### 3.2.13. vpc
- Vpc를 생성하는 모듈
