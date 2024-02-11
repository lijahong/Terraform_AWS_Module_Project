#!/bin/bash

# APACHE HTTPD 컴파일을 위한 라이브러리 설치
sudo yum update -y
sudo yum install -y gcc gcc-c++ expat-devel.x86_64 pcre-devel

cd /usr/local/src/
sudo wget https://sourceforge.net/projects/pcre/files/pcre/8.44/pcre-8.44.tar.gz
sudo tar zxvf pcre-8.44.tar.gz
cd pcre-8.44
sudo ./configure --prefix=/usr/local/pcre
sudo make install

# APACHE HTTPD 컴파일을 위한 라이브러리 및 소스 코드 다운로드
cd /usr/local/src
sudo wget https://dlcdn.apache.org/httpd/httpd-2.4.58.tar.gz
sudo wget https://dlcdn.apache.org//apr/apr-1.7.4.tar.gz
sudo wget https://dlcdn.apache.org//apr/apr-util-1.6.3.tar.gz

sudo tar zxvf httpd-2.4.58.tar.gz
sudo tar zxvf apr-1.7.4.tar.gz
sudo tar zxvf apr-util-1.6.3.tar.gz

sudo mv apr-1.7.4 ./httpd-2.4.58/srclib/apr
sudo mv apr-util-1.6.3 ./httpd-2.4.58/srclib/apr-util

cd httpd-2.4.58/

# APACHE HTTPD 설정
sudo ./configure \
--prefix=/usr/local/apache \
--with-included-apr \
--with-pcre=/usr/local/pcre

# APACHE HTTPD 컴파일 및 설치
sudo make install

# 서버 이름 수정
echo "ServerName localhost:80" | sudo tee -a /usr/local/apache/conf/httpd.conf

# apache systemd 등록
sudo touch /usr/lib/systemd/system/apache.service
cat << EOF | sudo tee -a /usr/lib/systemd/system/apache.service
[Unit]
Description=apache
After=network.target syslog.target

[Service]
Type=forking
User=root
Group=root
ExecStart=/usr/local/apache/bin/apachectl start
ExecStop=/usr/local/apache/bin/apachectl stop
Umask=007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 웹 페이지 생성
sudo touch /home/ec2-user/indexfile.html
cat << EOF | sudo tee -a /home/ec2-user/indexfile.html
<!DOCTYPE html>
<html>
<body>
<h1>NeoPin Tech Assignment</h1>
<p>WEB PRIVATE IP : SETIP </p>
</body>
</html>
EOF

# 웹 페이지 내용 수정
ip_tmp=$(ifconfig | awk '/inet/' | awk '{print $2}' | head -1)
sed -i "s/SETIP/${ip_tmp}/g" /home/ec2-user/indexfile.html

# 페이지 반영
cat /home/ec2-user/indexfile.html | sudo tee /usr/local/apache/htdocs/index.html

# apache 실행
sudo systemctl daemon-reload
sudo systemctl enable apache
sudo systemctl start apache