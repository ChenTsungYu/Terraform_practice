# Configure the AWS Provider
provider "aws" {
  region  = "us-east-2"
  version = "~> 2.55"
}

resource "aws_default_vpc" "default" {
  
}
// HTTP Server ->Security Group
// Security Group(即fire wall)=>  80 port : TCP , 22 port : TCP, CIDR: ["0.0.0.0/0"]
resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  # vpc_id = "vpc-4dbe6a26" # 貼上AWS 預設的VPC ID
  vpc_id = aws_default_vpc.default.id # 使用預設的VPC ID
  ingress {               // ingress為入口的限制規則
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { // ingress為入口的限制規則
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { # 讓任何人都能連進來
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "http_server_sg"
  }
}

variable "aws_key_pair" {
  default = "./aws_key_pair/ec2-terraform.pem"
}
resource "aws_instance" "http_server" {
  ami                    = "ami-0e01ce4ee18447327"
  key_name               = "ec2-terraform"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = "subnet-16ee127d"

  connection { # 遠端連接EC2
    type        = "ssh"
    host        = self.public_ip # 公有ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }
  provisioner "remote-exec" {      # 遠端執行指令
    inline = [                     # 連接遠端時，會開始執行一系列的指令
      "sudo yum install httpd -y", # install httpd
      "sudo service httpd start",  # start
      # 印出字串訊息至index.html 檔
      "echo Welcome to virtual server which is at ${self.public_dns} | sudo tee /var/www/html/index.html", # copy file
    ]
  }
}
