
# 🔧 Backend AWS – Secretos para Contar

Repositorio de infraestructura como código (IaC) para desplegar el servidor **backend** del proyecto **Secretos para Contar** en **Amazon Web Services (AWS)**, utilizando **Terraform** en una arquitectura modular.

Este módulo crea una instancia EC2 para alojar la API desarrollada en .NET, y la configura automáticamente mediante un script de inicialización para dejarla funcionando al instante.

---

## 📁 Estructura del módulo

```
modules/
└── ec2_backend/
    ├── main.tf
    ├── outputs.tf
    ├── variables.tf
    └── user_data_backend.sh
```

---

## ⚙️ Variables utilizadas

```hcl
variable "ami_back_id" {
  description = "AMI ID for the backend server"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID to associate with the backend instance"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "region" {
  description = "Región de AWS donde se desplegará la instancia EC2"
}
```

---

## 💻 Archivo principal – `main.tf`

- Crea una **instancia EC2**.
- Usa un **script de inicialización (`user_data`)** para instalar .NET, clonar el backend, compilarlo y ejecutarlo.
- Asocia un grupo de seguridad y una AMI personalizada.
- Exporta la IP pública de la instancia como salida.

---

## 📦 Script de despliegue – `user_data_backend.sh`

Este script automatiza la configuración de la instancia:

1. **Actualiza paquetes y herramientas necesarias**:
   - Git, wget, ICU, PostgreSQL.

2. **Instala .NET SDK 9**:
   - Descarga y configura variables de entorno.

3. **Inicializa y habilita PostgreSQL (opcional)**:
   - Para entornos con base de datos local (alternativa a RDS).

4. **Clona el repositorio**:
   ```bash
   git clone https://github.com/leydimadrid/secretos-para-contar.git /home/ec2-user/repo
   ```

5. **Prepara carpetas para archivos estáticos**:
   ```bash
   mkdir -p uploads/libros/portadas ...
   ```

6. **Restaura, construye y ejecuta la API**:
   ```bash
   dotnet restore
   dotnet build
   dotnet run --urls=http://0.0.0.0:5000
   ```

---

## 🌐 Acceso al backend

Una vez desplegada la infraestructura:

- La API queda accesible en:

```
http://<IP_PUBLICA_EC2>:5000
```

- Puedes consumirla desde frontend o Postman.
- Asegúrate de que el puerto 5000 esté abierto en el **grupo de seguridad**.

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
- Se conecta a una base de datos PostgreSQL (local o RDS).
- Guarda imágenes y archivos PDF o MP3 en carpetas del servidor.

---

## ⚡ Pasos para desplegar

1. **Inicializa Terraform**:

```bash
terraform init
```

2. **Planifica los recursos**:

```bash
terraform plan
```

3. **Aplica la infraestructura**:

```bash
terraform apply
```

4. **Accede al backend desde un navegador**:

```
http://<IP_PUBLICA_BACKEND>:5000
```

---

## ✅ Requisitos previos

- Cuenta en AWS con permisos para EC2.
- Par de llaves SSH (key pair).
- Terraform ≥ 1.5.0 instalado.
- Proyecto backend alojado en GitHub:
  [https://github.com/leydimadrid/secretos-para-contar](https://github.com/leydimadrid/secretos-para-contar)

---

## 👥 Equipo

- Cristian Daniel Zuluaga García  
- Lorena Quiceno Giraldo  
- Melissa Giselle García Turizo  
- Leydi Johana Madrid Vásquez  

---

## 📝 Licencia

Proyecto con fines académicos y educativos.
