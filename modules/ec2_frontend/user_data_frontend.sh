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
echo "VITE_API_URL=http://3.14.34.150:5000" > .env
sudo pnpm build

npm install -g pm2
pm2 start "pnpm run start -- --port 3000 --hostname 0.0.0.0"
pm2 startup
pm2 save

echo "Finalizando"