provider "aws" {
  region  = var.region
  profile = var.profile
}

# Pull the latest ami for centos7.  Only used if var.base_ami blank
data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }

  owners = ["679593333241"] # CentOS? or Marketplace? not sure which
}

# Pull the subnet information
data "aws_subnet" "jump" {
  id = var.subnet_id
}

# Create the jump ec2 instance
resource "aws_instance" "jump" {
  ami                    = data.aws_ami.centos7.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jump.id]
  subnet_id              = data.aws_subnet.jump.id

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "40"
    delete_on_termination = "true"
  }

  lifecycle {
    ignore_changes = [
      ami,
      ebs_optimized,
      instance_type,
      key_name,
      root_block_device,
      user_data,
    ]
  }

  tags = {
    Name = "GrayMetaPlatform-${var.platform_instance_id}-Jump"
  }
}

# Create public ip and associate it with jump server
resource "aws_eip" "jump" {
  vpc = true
}

resource "aws_eip_association" "jump" {
  instance_id   = aws_instance.jump.id
  allocation_id = aws_eip.jump.id
}

# Create the security group
resource "aws_security_group" "jump" {
  name_prefix = "jump-nsg"
  description = "jump-nsg"
  vpc_id      = data.aws_subnet.jump.vpc_id

  tags = {
    Name = "GrayMetaPlatform-${var.platform_instance_id}-Jump"
  }
}

# Allow all outbound traffic
resource "aws_security_group_rule" "jump-egress" {
  security_group_id = aws_security_group.jump.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow ssh inbound traffic
resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = aws_security_group.jump.id
  description       = "Allow inbound ssh"
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}