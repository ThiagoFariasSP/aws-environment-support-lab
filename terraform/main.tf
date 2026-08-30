terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "aws-environment-support-lab-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_security_group" "web" {
  name        = "web-security-group"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name        = "web-server"
    Environment = "lab"
    Purpose     = "AWS Environment Support Lab"
  }
}

resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.web.id]
  subnets         = [aws_subnet.public.id]

  tags = {
    Name = "web-alb"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web_server.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_db_subnet_group" "main" {
  name = "main-db-subnet-group"

  subnet_ids = [
    aws_subnet.public.id
  ]

  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_db_instance" "database" {
  identifier = "lab-database"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "labdb"
  username = var.db_username
  password = var.db_password

  publicly_accessible = false

  db_subnet_group_name = aws_db_subnet_group.main.name

  skip_final_snapshot = true

  tags = {
    Name = "lab-database"
  }
}