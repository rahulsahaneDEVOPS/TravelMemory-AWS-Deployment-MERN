# ---------------------------------------------
# SSH Key Pair
# ---------------------------------------------
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-deployer-key"
  public_key = var.ssh_public_key
}

# ---------------------------------------------
# Web Server EC2 Instance (Public Subnet)
# ---------------------------------------------
resource "aws_instance" "web_server" {
  ami                  = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id
  key_name             = aws_key_pair.deployer.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y python3 python3-pip
              EOF

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
    Role        = "web"
    Project     = "TravelMemory"
    Owner       = "Rahul Sahane"
    ManagedBy   = "Terraform"
  }
}

# ---------------------------------------------
# Database Server EC2 Instance (Private Subnet)
# ---------------------------------------------
resource "aws_instance" "db_server" {
  ami                  = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.private.id
  key_name             = aws_key_pair.deployer.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y python3 python3-pip
              EOF

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.project_name}-db-server"
    Environment = var.environment
    Role        = "database"
    Project     = "TravelMemory"
    Owner       = "Rahul Sahane"
    ManagedBy   = "Terraform"
  }
}