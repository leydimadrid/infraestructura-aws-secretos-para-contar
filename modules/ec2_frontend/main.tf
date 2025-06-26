resource "aws_instance" "my_instance" {
  count         = 1
  ami           = var.ami_front_id
  instance_type = "t2.micro"

  vpc_security_group_ids = [var.security_group_id]
  
  user_data = <<-EOF
#!/bin/bash
echo "Actualizando instancia"
sudo dnf update -y
echo "Instalando Git"
sudo dnf install -y git

echo "Instalando NodeJS 22"
echo "_____________"
sudo dnf install -y gcc-c++ make
cd /usr/local/src
curl -O https://nodejs.org/dist/v22.0.0/node-v22.0.0-linux-x64.tar.xz
tar -xf node-v22.0.0-linux-x64.tar.xz
cp -r node-v22.0.0-linux-x64/{bin,include,lib,share} /usr/local/
npm install -g pnpm
echo "-----------"

echo "Clonando repositorio"
git clone https://github.com/leydimadrid/secretos-para-contar.git /home/ec2-user/secretos-para-contar
cd /home/ec2-user/secretos-para-contar/Frontend
sudo pnpm install
sudo pnpm build

npm install -g pm2
pm2 start "pnpm run start -- --port 3000 --hostname 0.0.0.0"
pm2 startup
pm2 save

echo "Finalizando"
EOF

  user_data_replace_on_change = true
  
  tags = {
    Name = "instance-${count.index + 1}-cloud3"
  }
}