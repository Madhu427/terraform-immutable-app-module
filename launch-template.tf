resource "aws_launch_template" "launch-template" {
  name = "${var.COMPONENT}-${var.ENV}"
  image_id = data.aws_ami.ami.id

  instance_market_options {
    market_type = "spot"
    spot_options {
#      instance_interruption_behavior = "stop"
##      spot_instance_type = "persistent"
      spot_instance_type = "one-time"

    }
  }

  instance_type = var.INSTANCE_TYPE
  vpc_security_group_ids = [aws_security_group.sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.COMPONENT}-${var.ENV}"
    }
  }

  //user_data = filebase64("${path.module}/example.sh")
}