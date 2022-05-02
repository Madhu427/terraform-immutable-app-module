data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "${var.COMPONENT}-${var.APP_VERSION}"
  owners           = ["self"]
}

output "AMI_OUTPUT" {
   value = data.aws_ami.ami.id
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tf-bucket-61"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "tf-bucket-61"
    key    = "immutable/alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_secretsmanager_secret" "common2" {
  name = "common2/ssh"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.common2.id
}