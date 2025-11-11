# Calculadora de Constantes Médicas

Aplicación web desarrollada en Ruby on Rails 7 para el registro y evaluación de constantes vitales de pacientes, mostrando si los valores se encuentran dentro de los rangos normales.

## Características Principales

- **Gestión de Pacientes**
  - Registro de información de pacientes
  - Listado, edición y eliminación de registros

- **Registro de Constantes Vitales**
  - Captura de múltiples parámetros vitales:
    - Temperatura corporal
    - Presión arterial (sistólica/diastólica)
    - Frecuencia cardíaca (pulso)
    - Frecuencia respiratoria
    - Saturación de oxígeno (SpO₂)
    - Índice de Masa Corporal (IMC)
  - Evaluación automática de valores normales

## Requisitos del Sistema

- Ruby 3.3.6
- Rails 7.2.3
- PostgreSQL 16+

## Instalación

1. Clonar el repositorio:
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   cd calculadora-de-constantes-medicas
   ```

2. Instalar dependencias:
   ```bash
   bundle install
   ```

3. Configurar base de datos:

   Si tu configuración de PostgreSQL requiere autenticación (método md5 en pg_hba.conf), sigue estos pasos:

   3.1. Crear un archivo `.env` en la raíz del proyecto con las credenciales de PostgreSQL:
   ```bash
   # .env
   DB_USER=tu_usuario_postgres
   DB_PASSWORD=tu_contraseña_postgres
   ```

   3.2. Asegúrate de agregar `.env` a tu archivo `.gitignore` para no subir credenciales al repositorio:
   ```bash
   echo ".env" >> .gitignore
   ```

   3.3. Crear y migrar la base de datos:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Iniciar el servidor de desarrollo:
   ```bash
   ./bin/dev
   ```

5. Abrir en el navegador:
   ```
   http://localhost:3000
   ```
