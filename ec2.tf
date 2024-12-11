provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  ami                   ="ami-0166fe664262f664c"
  instance_type          = "t2.micro"
  count                  = 1
  key_name               = "spandana"
  associate_public_ip_address = true
  user_data              = file("data.sh")
  subnet_id = "subnet-0c85ac199c0740b9f"
  tags = {
    Name = "WordPressServer"
  }
}

resource "aws_security_group" "demosg" {
  name        = "demosg"
  description = "Security group for WordPress and MySQL"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port=443
    to_port=443
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
   from_port=22
   to_port=22
   protocol="tcp"
   cidr_blocks=["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
