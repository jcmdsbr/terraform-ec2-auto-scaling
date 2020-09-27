resource "aws_security_group" "autoscaling" {
  name        = "autoscaling"
  description = "Security group that allows ssh/http and egress traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.alb.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Auto Scaling"
  }
}

resource "aws_launch_configuration" "this" {
  name_prefix                 = "autoscaling-launcher"
  image_id                    = var.aws_ami
  instance_type               = var.aws_ec2_instance_type
  security_groups             = [aws_security_group.autoscaling.id]
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "this" {
  name                      = "terraform-autoscaling"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = aws_launch_configuration.this.name
  vpc_zone_identifier       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  target_group_arns         = [aws_lb_target_group.tg.arn]
}

resource "aws_autoscaling_policy" "scaleup" {
  name                   = "Scale Up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scaledown" {
  name                   = "Scale Up"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "SimpleScaling"
}

resource "aws_instance" "jenkins" {
  ami           = var.aws_ami
  instance_type = var.aws_ec2_instance_type

  vpc_security_group_ids = [aws_security_group.db.id]
  subnet_id              = aws_subnet.private_b.id
  availability_zone      = "${var.aws_region}b"

  tags = {
    Name = "Jenkins Machine"
  }
}


