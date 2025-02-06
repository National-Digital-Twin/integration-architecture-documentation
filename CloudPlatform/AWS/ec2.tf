module "ec2_instance_bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name   = "${local.resource_prefix}-bastion"

  ami                    = var.ec2_ami_al2023 #data.aws_ami.amazon_linux_23.id
  instance_type          = "t2.small"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_bastion.id]
  subnet_id              = tolist(module.vpc.private_subnets)[0]

  create_iam_instance_profile = true
  iam_role_name               = "${local.resource_prefix}-ec2-instance-profile_bastion"
  iam_role_use_name_prefix    = false
  iam_role_description        = "IAM role profile for the Bastion EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    BastionPolicy                = aws_iam_policy.bastion_role.arn
  }
}

module "ec2_instance_ianode" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name   = "${local.resource_prefix}-ianode"

  ami                    = var.ec2_ami_al2023 #data.aws_ami.amazon_linux_23.id
  instance_type          = "t2.xlarge"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_ianode.id]
  subnet_id              = tolist(module.vpc.private_subnets)[0]

  user_data_base64            = base64encode(local.ianode_user_data)
  user_data_replace_on_change = true

  create_iam_instance_profile = true
  iam_role_name               = "${local.resource_prefix}-ec2-instance-profile_ianode"
  iam_role_use_name_prefix    = false
  iam_role_description        = "IAM role profile for the IA node EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    IanodePolicy                 = aws_iam_policy.ianode_role.arn
  }
}

locals {
  ianode_user_data = <<-EOT
    #!/bin/bash
    yum install docker -y
    service docker start
    chkconfig docker on
    aws s3 cp s3://ia-node-config/docker-compose-linux-x86_64 /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    adduser -m ssm-user
    tee /etc/sudoers.d/ssm-agent-users <<'EOF'
    ssm-user ALL=(ALL) NOPASSWD:ALL
    EOF
    chmod 440 /etc/sudoers.d/ssm-agent-users 
    usermod -a -G docker ssm-user
  EOT
}
