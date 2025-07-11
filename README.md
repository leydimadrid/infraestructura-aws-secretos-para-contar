# 🌩️ Infraestructura AWS – Secretos para contar

Repositorio de infraestructura como código (IaC) para desplegar el proyecto **"Secretos para contar"** en **Amazon Web Services (AWS)** utilizando **Terraform** con estructura modular.

Este proyecto crea dos instancias EC2 (una para el frontend Remix y otra para el backend .NET), configura automáticamente las dependencias y abre los puertos necesarios mediante un módulo reutilizable de Security Groups.


## 📁 Estructura del proyecto

```bash
infraestructura-aws-secretos-para-contar/
├── modules/
│   ├── ec2_backend/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data_backend.sh
│   │
    ├── ec2_frontend/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data_frontend.sh
│   │
    ├── rds_postgres/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
    └── security_group/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tf
├── terraform.tfvars
├── README.md
└── .gitignore


```
## 🚀 Despliegue rápido

1. **Clona el repositorio**

```bash
git clone https://github.com/leydimadrid/infraestructura-aws-secretos-para-contar.git
cd infraestructura-aws-secretos-para-contar
```


2. **Inicializa Terraform**

```bash
terraform init
```

3. **Verifica el plan de ejecución**

```bash
terraform plan
```

4. **Aplica la infraestructura**

```bash
terraform apply
```

Al finalizar, se mostrarán las IPs públicas del backend y frontend.

### 🔐 Módulo Security Group

Este módulo crea un Security Group reutilizable para EC2. Recibe una lista de puertos y los habilita como entrada (ingress) en la VPC por defecto.

- **Parámetro:** `puertos` (lista de números), por ejemplo: `[22, 3000, 5173]`  
- **Output:** `security_group_id`, usado por los módulos EC2

**Ejemplo de uso:**

```hcl
module "sg_frontend" {
  source  = "./modules/security_group"
  puertos = [22, 5173, 3000]
}

module "sg_backend" {
  source  = "./modules/security_group"
  puertos = [22, 5000]
}

```

## 🚀 Despliegue automático - Frontend

Una vez que Terraform crea la instancia EC2, el **servidor frontend se levanta automáticamente** sin necesidad de conexión manual, gracias al siguiente `user_data_frontend`:

```bash
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
```

## 🌍  Visualización del sitio
Una vez desplegada la infraestructura:

✅ El frontend queda activo automáticamente
📍 Solo debes copiar y pegar la IP pública de la EC2 más el puerto 3000 en tu navegador:
```bash
http://<IP-PUBLICA>:3000
```
![image](https://github.com/user-attachments/assets/dfadb29d-e312-441c-8b0e-793707416241)

## 📌 Notas adicionales
- El servidor Remix se ejecuta usando pnpm run start en el puerto 3000 y está administrado por pm2.
- PM2 asegura que la aplicación se reinicie automáticamente si la instancia se reinicia.


## 🚀 Despliegue automático - Backend 

Se configura una instancia EC2 usando user_data_backend para:

- Actualizar el sistema operativo.

- Instalar dependencias necesarias: git, wget, icu.

- Instalar y configurar el SDK de .NET 9.

- Clonar automáticamente el repositorio:
 ```hcl
https://github.com/leydimadrid/secretos-para-contar.git
```

- Restaurar y compilar el proyecto ubicado en:
```hcl
/Backend/TeslaACDC.API.
```

- Ejecutar el backend con:
```hcl
dotnet run --urls=http://0.0.0.0:5000.
```

Esto expone la API desde la IP pública de la instancia EC2 por el puerto 5000.

##  RDS PostgreSQL
- Se crea una base de datos en RDS con PostgreSQL mediante Terraform.
- El endpoint de la base de datos es expuesto como output para ser referenciado por otros recursos o aplicaciones.
- Asegúrate de configurar correctamente las variables de entorno en el backend para conectarse al endpoint generado.

## Pruebas
Una vez desplegado, puedes probar la API accediendo a:
```hcl
http://<IP_PUBLICA_EC2>:5000
```

<img width="1636" height="305" alt="image" src="https://github.com/user-attachments/assets/344899e2-21c7-4a26-bb59-e89ebcd65fd6" />

## 📥 Repositorio

🔗 https://github.com/leydimadrid/secretos-para-contar

## 🌐 Requisitos

- Cuenta de AWS con permisos para EC2  
- Par de llaves SSH configurado (key pair)  
- Terraform >= 1.5.0  
- Conexión a internet  


## 🧩 Tecnologías usadas

- **Terraform** (Infraestructura como código)  
- **AWS EC2** (Máquinas virtuales)  
- **Remix** (Frontend)  
- **.NET 7 + PostgreSQL** (Backend + Base de datos)  
- **Amazon Linux 2023** (Base AMI)  
- **Security Groups personalizados**
- **AWS RDS (PostgreSQL) – Base de datos relacional desplegada y conectada al backend**


## 🧪 Funcionalidad esperada

- Aplicación frontend disponible en la IP pública de su instancia EC2  
- API backend accesible en su propia IP pública  
- Conexión funcional entre frontend y backend (registro/login)  
- Migraciones aplicadas automáticamente a PostgreSQL en el backend
- 
---

## 🧪 Tecnologías utilizadas

| Tecnología        | Uso                                       |
|------------------|-------------------------------------------|
| Terraform         | Infraestructura como código               |
| AWS EC2           | Máquina virtual para alojar la API        |
| Amazon Linux 2023 | Sistema operativo base                    |
| .NET 9 SDK        | Framework para ejecutar el backend        |
| PostgreSQL        | Base de datos opcional/local              |

---

## 📝 Funcionalidades del backend

- **API RESTful** construida en **.NET 9**.
- Permite operaciones CRUD sobre libros, autores y audiolibros.
- Se conecta a una base de datos PostgreSQL (RDS).

---

## 👩‍💻 Equipo

- Cristian Daniel Zuluaga García
- Lorena Quiceno Giraldo
- Melissa Giselle García Turizo
- Leydi Johana Madrid Vásquez


## 📄 Licencia

Este proyecto es con fines académicos y educativos.
