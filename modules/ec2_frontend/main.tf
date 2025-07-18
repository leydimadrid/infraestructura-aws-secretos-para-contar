resource "aws_instance" "my_instance" {
  count         = 1
  ami           = var.ami_front_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  
  user_data = file("${path.module}/user_data_frontend.sh")
  user_data_replace_on_change = true
  
  tags = {
    Name = "instance-frontend-${count.index + 1}-cloud3"
  }
}