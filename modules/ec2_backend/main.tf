resource "aws_instance" "ec2_instance" {
  count         = 1
  ami           = var.ami_back_id
  instance_type = var.instance_type
  # key_name      = var.key_name
  # security_groups = [aws_security_group.ec2_sg.name]
  vpc_security_group_ids = [var.security_group_id]

  user_data = file("${path.module}/user_data_backend.sh")

  user_data_replace_on_change = true

  tags = {
    Name = "instance-${count.index + 1}-cloud3"
  }
}