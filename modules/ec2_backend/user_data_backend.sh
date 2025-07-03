#!/bin/bash

# Actualizar paquetes
sudo yum update -y

# Instalar dependencias necesarias
sudo yum install -y git
sudo yum install -y wget
sudo yum install -y icu

# Instalar .NET SDK (ejemplo con .NET 7 en Amazon Linux 2)
sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
sudo yum install -y dotnet-sdk-7.0

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
