#!/bin/bash

# Actualizar paquetes
sudo yum update -y

# Instalar dependencias necesarias
sudo yum install -y git
sudo yum install -y wget
sudo yum install -y icu

# Instalar .NET SDK (ejemplo con .NET 7 en Amazon Linux 2)
sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm

mkdir -p /home/ec2-user/dotnet
wget https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.301/dotnet-sdk-9.0.301-linux-x64.tar.gz -O dotnet9.tar.gz
tar -zxf dotnet9.tar.gz -C /home/ec2-user/dotnet

# Exportar variables para la sesión actual
export DOTNET_ROOT=/home/ec2-user/dotnet
export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/home/ec2-user/dotnet

# Agregar las variables al perfil del usuario para que persistan
echo 'export DOTNET_ROOT=/home/ec2-user/dotnet' >> /home/ec2-user/.bashrc
echo 'export PATH=/home/ec2-user/dotnet:$PATH' >> /home/ec2-user/.bashrc

# También agregar al perfil del sistema
echo 'export DOTNET_ROOT=/home/ec2-user/dotnet' | sudo tee -a /etc/environment
echo 'export PATH=/home/ec2-user/dotnet:$PATH' | sudo tee -a /etc/environment

# Hacer que ec2-user sea el propietario del directorio dotnet
sudo chown -R ec2-user:ec2-user /home/ec2-user/dotnet
# Recargar el perfil
source /home/ec2-user/.bashrc

# Instalar PostgreSQL (cliente y servidor, opcional)
sudo amazon-linux-extras enable postgresql14
sudo yum install -y postgresql postgresql-server

# Inicializar PostgreSQL (si quieres levantar el servidor local)
sudo /usr/bin/postgresql-setup initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Configurar acceso local (opcional: depende de si se conecta a un RDS externo o localhost)
# sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
# sudo -u postgres createdb mydb -O myuser

# Clonar el repositorio
git clone ${var.git_repo_url} /home/ec2-user/repo

# Entrar al directorio del proyecto y construir
cd /home/ec2-user/repo
dotnet restore
dotnet build

# Ejecutar la app (suponiendo que sea un proyecto ejecutable)
dotnet run --urls=http://0.0.0.0:5000
