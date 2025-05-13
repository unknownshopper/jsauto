# JSAuto - Sistema de Gestión de Tickets

Sistema web para la gestión de tickets de servicio automotriz, desarrollado con Ruby on Rails.

## Requisitos del Sistema

* Ruby 3.0.1 o superior
* Rails 6.1.7 o superior
* SQLite3 (desarrollo)
* Node.js y Yarn para la compilación de assets

## Instalación

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/jsauto.git
   cd jsauto
   ```

2. Instalar las dependencias:
   ```bash
   bundle install
   yarn install
   ```

3. Configurar la base de datos:
   ```bash
   cp config/database.yml.example config/database.yml
   rails db:create
   rails db:migrate
   rails db:seed  # Crea los usuarios por defecto
   ```

4. Iniciar el servidor:
   ```bash
   rails server
   ```

5. Acceder a la aplicación en `http://localhost:3000`

## Usuarios por Defecto

La aplicación viene con tres usuarios preconfigurados:

* **Administrador**
  - Email: admin@jsauto.com
  - Contraseña: GARPRI01

* **Usuario Regular**
  - Email: usuario@jsauto.com
  - Contraseña: GARPRI01

* **Almacén**
  - Email: almacen@jsauto.com
  - Contraseña: GARPRI01

## Características

* Gestión de tickets de servicio
* Sistema de autenticación multi-usuario
* Interfaz moderna y responsiva
* Seguimiento de fechas de ingreso
* Registro de información de contacto

## Configuración para Producción

Para desplegar en producción:

1. Configurar variables de entorno:
   ```bash
   RAILS_ENV=production
   RAILS_SERVE_STATIC_FILES=true
   SECRET_KEY_BASE=tu_clave_secreta
   ```

2. Compilar assets:
   ```bash
   rails assets:precompile
   ```

3. Configurar una base de datos PostgreSQL (recomendado)

## Contribuir

1. Fork el repositorio
2. Crear una rama para tu feature (`git checkout -b feature/nueva-caracteristica`)
3. Commit tus cambios (`git commit -am 'Agregar nueva caracteristica'`)
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Crear un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT.
