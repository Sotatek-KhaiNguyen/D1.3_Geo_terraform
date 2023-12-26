resource "aws_instance" "bastion" {
  ami = "ami-079db87dc4c10ac91"
  instance_type = "t4g.nano"
  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.network.security_group, aws_security_group.allow_ssh.id
  ]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 50
  }

  tags = {
    Name = "${var.common.env}-${var.common.project}-bastion"
  }
  user_data = <<EOF
  sudo apt install unzip
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  aws --version
  aws configure --profile default set region ${var.common.region}
  aws configure --profile default set aws_access_key_id ${var.iam_credentials.key}
  aws configure --profile default set aws_secret_access_key ${var.iam_credentials.secret}
  aws configure list
  EOF
}

resource "aws_security_group" "allow_ssh" {
    name = "${var.common.env}-${var.common.project}-bastion-ssh"
    vpc_id = var.network.vpc_id

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/24"]
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
