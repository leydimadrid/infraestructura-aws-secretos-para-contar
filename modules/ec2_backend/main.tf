resource "aws_instance" "ec2_instance" {
  count         = 1
  ami           = var.ami_back_id
  instance_type = var.instance_type
  security_groups = ["custom_sg"]
  vpc_security_group_ids = [var.security_group_id]

  user_data = file("${path.module}/user_data_backend.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "instance-backend-${count.index + 1}-cloud3"
  }
}

# Elastic IP para el backend
resource "aws_eip" "backend_eip" {
  vpc = true
}

# Asocia la Elastic IP a la instancia EC2 del backend
resource "aws_eip_association" "backend_eip_assoc" {
  instance_id   = aws_instance.ec2_instance[0].id
  allocation_id = aws_eip.backend_eip.id
}


  
 