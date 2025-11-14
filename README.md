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


## Instalación y Puesta en Marcha

Sigue estos pasos para instalar y ejecutar la aplicación localmente:

1. **Clona el repositorio:**
   ```bash
   git clone git@github.com:josuelandero13/calculadora-de-constantes-medicas.git
   cd calculadora-de-constantes-medicas
   ```

2. **Instala las dependencias:**
   ```bash
   bundle install
   ```

3. **Configura la base de datos:**
   - Edita el archivo `config/database.yml` si necesitas personalizar la conexión.
   - Si tu PostgreSQL requiere autenticación (md5 en `pg_hba.conf`), crea un archivo `.env` en la raíz con:
     ```bash
     DB_USER=tu_usuario_postgres
     DB_PASSWORD=tu_contraseña_postgres
     ```
   - Añade `.env` a `.gitignore` para proteger tus credenciales:
     ```bash
     echo ".env" >> .gitignore
     ```
   - Crea y migra la base de datos:
     ```bash
     rails db:create
     rails db:migrate
     rails db:seed # Opcional, para datos de ejemplo
     ```

4. **Prepara los assets (opcional, para desarrollo avanzado):**
   ```bash
   rails assets:precompile
   ```

5. **Inicia el servidor de desarrollo:**
   ```bash
   ./bin/dev
   ```

   - O bien puedes omitir los pasos 4 y 3 anteriores y ejecutar el comando:
     ```bash
     ./bin/dev-with-assets
     ```

6. **Accede a la aplicación:**
   Abre tu navegador en:
   [http://localhost:3000](http://localhost:3000)

### Notas adicionales
- El proyecto utiliza Rails 7, Hotwire y TailwindCSS para una experiencia moderna y rápida.
- El archivo `Procfile.dev` permite iniciar todos los servicios necesarios en desarrollo.

### Documentación automática con Deepwiki

Si reemplazas `github.com` por `deepwiki.tech` en la URL del repositorio, se genera automáticamente una documentación interactiva y navegable del proyecto. Ejemplo:

```
https://deepwiki.tech/josuelandero13/calculadora-de-constantes-medicas
```

Esto te permite explorar la estructura, modelos, controladores y vistas del proyecto de forma visual y sencilla.
