#!/bin/bash
sudo dnf install -y git
# 1. Descargar el instalador oficial
wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh

# 2. Darle permisos de ejecución
chmod +x dotnet-install.sh

# 3. Instalar el SDK de .NET 9 (preview)
./dotnet-install.sh --channel 9.0

# 4. Agregar el SDK instalado al PATH (solo afecta a tu usuario actual)
echo 'export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools' >> ~/.bashrc
source ~/.bashrc

echo "Cloning repository 📁"
cd /home/ec2-user
git clone https://github.com/leydimadrid/secretos-para-contar.git repo
echo "Cloned repository from ${git_repo_url}"
cd repo/Backend

echo "Installing dependencies 📦"
dotnet restore
dotnet build

# Ejecutar la app
dotnet run --urls=http://0.0.0.0:5000
