# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "172.30.0.0/16"		# IPv4 CIDR BLOCK
  enable_dns_hostnames = true		# DNS Hostname 사용 옵션, 기본은 false
  tags = { 				# tag 입력
    Name = "vpc",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


# Internet gateway
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.vpc.id	# 어떤 vpc와 연결할지 결정
  tags = {
    Name = "terra-igw",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


#Subnet Public
resource "aws_subnet" "terra-subnet-public-1" {
  vpc_id = aws_vpc.vpc.id			# 위에서 생성한 vpc 별칭
  cidr_block = "172.30.0.0/20"			# Ipv4 CIDR 블럭
  availability_zone = "ap-northeast-2a"		# 가용영역 지정
  map_public_ip_on_launch = true		# 퍼블릭 IP 자동부여 설정
  tags = {                              	# tag 입력
    Name = "terra-subnet-public-1",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


resource "aws_subnet" "terra-subnet-public-2" {
  vpc_id = aws_vpc.vpc.id                       # 위에서 생성한 vpc 별칭
  cidr_block = "172.30.16.0/20"                 # Ipv4 CIDR 블럭
  availability_zone = "ap-northeast-2b"         # 가용영역 지정
  map_public_ip_on_launch = true                # 퍼블릭 IP 자동부여 설정
  tags = {                                      # tag 입력
    Name = "terra-subnet-public-2",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


#Subnet Private
resource "aws_subnet" "terra-subnet-private-1" {
  vpc_id = aws_vpc.vpc.id                       # 위에서 생성한 vpc 별칭
  cidr_block = "172.30.32.0/20"                 # Ipv4 CIDR 블럭
  availability_zone = "ap-northeast-2a"         # 가용영역 지정
  map_public_ip_on_launch = true                # 퍼블릭 IP 자동부여 설정
  tags = {                                      # tag 입력
    Name = "terra-subnet-private-1",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


resource "aws_subnet" "terra-subnet-private-2" {
  vpc_id = aws_vpc.vpc.id                       # 위에서 생성한 vpc 별칭
  cidr_block = "172.30.48.0/20"                 # Ipv4 CIDR 블럭
  availability_zone = "ap-northeast-2b"         # 가용영역 지정
  map_public_ip_on_launch = true                # 퍼블릭 IP 자동부여 설정
  tags = {                                      # tag 입력
    Name = "terra-subnet-private-2",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


#Routing table public
resource "aws_route_table" "terra-route-public" {
  vpc_id = aws_vpc.vpc.id			        # VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id	# Internet Gateway 별칭입력
  }
  tags = {                                              # tag 입력
    Name = "terra-route-public",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}



#Routing table private
resource "aws_route_table" "terra-route-private" {
  vpc_id = aws_vpc.vpc.id                               # VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id      # Internet Gateway 별칭입력
  }
  tags = {                                              # tag 입력
    Name = "terra-route-private",
    Team = "sample",
    Repository = "infrastructure",
    Service = "sample"
  }
}


#Route table subnet 연결
resource "aws_route_table_association" "terra-routing-public-1" {
  subnet_id      = aws_subnet.terra-subnet-public-1.id
  route_table_id = aws_route_table.terra-route-public.id
}


resource "aws_route_table_association" "terra-routing-public-2" {
  subnet_id      = aws_subnet.terra-subnet-public-2.id
  route_table_id = aws_route_table.terra-route-public.id
}


resource "aws_route_table_association" "terra-routing-private-1" {
  subnet_id      = aws_subnet.terra-subnet-private-1.id
  route_table_id = aws_route_table.terra-route-private.id
}


resource "aws_route_table_association" "terra-routing-private-2" {
  subnet_id      = aws_subnet.terra-subnet-private-2.id
  route_table_id = aws_route_table.terra-route-private.id
}


