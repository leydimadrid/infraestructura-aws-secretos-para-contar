# 🌩️ Infraestructura AWS – Secretos para contar

Repositorio de infraestructura como código (IaC) para desplegar el proyecto **"Secretos para contar"** en **Amazon Web Services (AWS)** utilizando **Terraform** con estructura modular.

Este proyecto crea dos instancias EC2 (una para el frontend Remix y otra para el backend .NET), configura automáticamente las dependencias y abre los puertos necesarios mediante un módulo reutilizable de Security Groups.


## 📁 Estructura del proyecto

```bash
infraestructura-aws-secretos-para-contar/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
│
├── modules/
│   ├── ec2_backend/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data_backend.sh
│   │
│   └── ec2_frontend/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── user_data_frontend.sh
    │
    └── security_group/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
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


## 🧪 Funcionalidad esperada

- Aplicación frontend disponible en la IP pública de su instancia EC2  
- API backend accesible en su propia IP pública  
- Conexión funcional entre frontend y backend (registro/login)  
- Migraciones aplicadas automáticamente a PostgreSQL en el backend  


## 👩‍💻 Equipo

- Cristian Daniel Zuluaga García
- Lorena Quiceno Giraldo
- Melissa Giselle García Turizo
- Leydi Johana Madrid Vásquez


## 📄 Licencia

Este proyecto es con fines académicos y educativos.
