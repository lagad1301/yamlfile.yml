//////simple resource file////
resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Allow HTTP port"

  ingress {
    from_port   = 80
    to_port     = 80
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
resource "aws_instance" "web" {
  ami           = "ami-09e143e99e8fa74f9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  tags = {
    Name = "HelloWorld"
  }
}



////for variable block ///////
resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Allow HTTP port"

  ingress {
    from_port   = 80
    to_port     = 80
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
resource "aws_instance" "web1" {
  ami           = var.images_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name       = var.key_pair
  tags = {
    Name = "HelloWorld"
  }
}



*******var file*****
variable "images_id" {
     type = string
     default = "ami-09e143e99e8fa74f9"
    description = " Enter AMI ID"
}
variable "instance_type" {
     default = "t2.micro"
}
variable "key_pair" {
    default = "k8s"
}
