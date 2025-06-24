resource "aws_instance" "my_instance" {
  count         = 1
  ami           = var.ami_front_id
  instance_type = "t2.micro"

  vpc_security_group_ids = [var.security_group_id]
  
  user_data = <<-EOF
#!/bin/bash
sudo dnf update -y
sudo dnf install -y git
sudo dnf install -y nodejs
EOF
  
  tags = {
    Name = "instance-cloud3-${count.index + 1}"
  }
}