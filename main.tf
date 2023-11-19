resource "aws_key_pair" "key" {
  key_name   = "hitesh_key"
  public_key = file("./ssh/PublicJolge")
}

resource "aws_default_vpc" "default_vpc" {

}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  # using default VPC
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "TLS from VPC"

    # we should allow incoming and outoging
    # TCP packets
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    # Allow all outbound traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "ec2_instance" {
  ami             = var.ami_id
  instance_type   = "t2.micro"

  # refering key which we created earlier
  key_name        = aws_key_pair.key.key_name

  # refering security group created earlier
  security_groups = [aws_security_group.allow_ssh.name]

  tags = var.tags

  provisioner "remote-exec" {
    inline = [
        
      #Instalar Docker
      "sudo apt-get update",
      "sudo apt-get -y install docker.io",

      #Instalar Docker Compose
      #"curl -L 'https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose",
      #"chmod +x /usr/local/bin/docker-compose",
      
      #Instalar Git
      "sudo apt-get update",
      "sudo apt-get install -y git",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  # El usuario depende de la AMI, en este caso es ubuntu para la AMI de Ubuntu
      private_key = file("./ssh/PrivateJolge")
      host        = self.public_ip
    }
  }
}


variable "ami_id" {
  description = "Ubuntu ami id"

  # Amazon linux image
  default     = "ami-0f2e255ec956ade7f"
}

variable "tags" {
  type = map(string)
  default = {
    "name" = "Hitesh's ec2"
  }
}

