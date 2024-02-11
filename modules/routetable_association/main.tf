# Route Table 연결 모듈에 대한 정의
# 지정한 서브넷에 Route Table을 연결합니다.
# 입력 : 연결할 subnet id, 연결할 route table id

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = var.subnet_id
  route_table_id = var.routetable_id
}