resource "aws_instance" "bastion" {
  ami = "ami-079db87dc4c10ac91"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id

  #vpc_security_group_ids = "${aws_security_group.allow_ssh.id}"
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
  }

  tags = {
    Name = "${var.common.env}-${var.common.project}-bastion"
  }
  user_data = <<EOF
  #!/bin/bash
  echo "Copying the SSH Key Of Local Machine to the server"
  echo -e ${var.ssh_public_key} >> /home/ubuntu/.ssh/authorized_keys
  sudo apt update
  sudo apt install unzip -y
  # curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  # unzip awscliv2.zip
  # sudo ./aws/install
  # aws --version
  # aws configure --profile default set region ${var.common.region}
  # aws configure --profile default set aws_access_key_id ${jsondecode(data.aws_secretsmanager_secret_version.ugc_secret_version.secret_string)["key"]}
  # aws configure --profile default set aws_secret_access_key ${jsondecode(data.aws_secretsmanager_secret_version.ugc_secret_version.secret_string)["secret"]}
  # aws configure list
  EOF
}

data "aws_secretsmanager_secret" "ugc_secret_dev" {
  name = "ugc_secret_dev"
}

data "aws_secretsmanager_secret_version" "ugc_secret_version" {
  secret_id = data.aws_secretsmanager_secret.ugc_secret_dev.id
}

resource "aws_security_group" "allow_ssh" {
    name = "${var.common.env}-${var.common.project}-bastion"
    vpc_id = var.vpc_id

    ingress {
      from_port = "22"
      to_port = "22"
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 8
      to_port = 0
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
