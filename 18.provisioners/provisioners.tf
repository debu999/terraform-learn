provider "aws" {
  region = "us-west-1"
}

data "aws_ami" "free_tier_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_security_group" "provisioner-sg" {
  name        = "provisioner-sg"
  description = "Allow inbound traffic to HTTP, HTTPS, and SSH"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "prov-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "prov-key-pair" {
  key_name   = "prov-key"
  public_key = tls_private_key.prov-private-key.public_key_openssh
}

resource "aws_instance" "prov_ec2" {
  ami           = data.aws_ami.free_tier_ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "prov_ec2"
  }
  vpc_security_group_ids = [aws_security_group.provisioner-sg.id]
  key_name = aws_key_pair.prov-key-pair.key_name

  provisioner "local-exec" {
    command = <<EOF
            echo ${self.public_ip} > public_ip.txt
            echo ${self.private_ip} > private_ip.txt
        EOF
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.prov-private-key.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nginx", "sudo systemctl start nginx",
    ]
  }

  provisioner "local-exec" {
    command = "echo Destroying the resource with terraform destroy > private_ip.txt"
    when = destroy
  }
}

// use http://public_ip to connect to nginx server
/*
provisioner "local-exec" {
        command = <<EOF
            echo ${self.public_ip} > public_ip.txt
            echo ${self.private_ip} > private_ip.txt
        EOF
    }

we can also use the following as well

provisioner "local-exec" {
  command = "echo ${self.public_ip} > public_ip.txt"
}
provisioner "local-exec" {
  command = "echo ${self.private_ip} > private_ip.txt"
}

for destroy time provisioner we have to add when = destroy
if creation time provisioner fails resource is marked tainted so next apply it will be replaced
on_failure = continue <-- we can override the default behaviour
on_failure = fail. <-- this is default
*/