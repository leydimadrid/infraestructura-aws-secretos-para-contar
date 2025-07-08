#!/bin/bash

sudo yum update -y

# Instalar dependencias necesarias
sudo yum install -y git
sudo yum install -y wget
sudo yum install -y icu

# Instalar .NET SDK 9
sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
mkdir -p /home/ec2-user/dotnet
wget https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.301/dotnet-sdk-9.0.301-linux-x64.tar.gz -O dotnet9.tar.gz
tar -zxf dotnet9.tar.gz -C /home/ec2-user/dotnet
echo 'export DOTNET_ROOT=/home/ec2-user/dotnet' >> /home/ec2-user/.bashrc
echo 'export PATH=$PATH:/home/ec2-user/dotnet' >> /home/ec2-user/.bashrc
export DOTNET_ROOT=/home/ec2-user/dotnet
export PATH=$PATH:/home/ec2-user/dotnet

# Cambiar propietario del SDK
chown -R ec2-user:ec2-user /home/ec2-user/dotnet

# Clonar el repositorio
git clone https://github.com/leydimadrid/secretos-para-contar.git /home/ec2-user/repo
chown -R ec2-user:ec2-user /home/ec2-user/repo
chmod -R u+rwX /home/ec2-user/repo

# Instalar dotnet-ef para migraciones
/home/ec2-user/dotnet/dotnet tool install --global dotnet-ef
echo 'export PATH="$PATH:/home/ec2-user/.dotnet/tools"' >> /home/ec2-user/.bashrc
export PATH=$PATH:/home/ec2-user/.dotnet/tools

# Entrar al proyecto, restaurar, migrar y ejecutar
cd /home/ec2-user/repo/Backend/TeslaACDC.API
dotnet restore
dotnet build

# Ejecutar la aplicación
dotnet run --urls=http://0.0.0.0:5000