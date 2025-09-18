# 🚀 Sistema de Deploy Automático - Taker SA

Sistema de deploy automatizado y reutilizable para EasyPanel, basado en la experiencia exitosa del proyecto `taker_sa_envio_masivo_whatsapp`.

## 📋 Características

- ✅ **Deploy automático** para EasyPanel
- ✅ **Dockerfile optimizado** para Alpine Linux
- ✅ **Configuración automática** de nginx y supervisor
- ✅ **Healthcheck integrado** para monitoreo
- ✅ **Scripts de validación** pre-deploy
- ✅ **Documentación automática** generada
- ✅ **Soporte para Python** con dependencias automáticas
- ✅ **Frontend estático** con nginx
- ✅ **Logs centralizados** y persistentes

## 🛠️ Instalación

1. **Clona o copia** los templates a tu proyecto:
```bash
# Copiar templates a tu proyecto
cp -r deploy-templates/ /ruta/a/tu/proyecto/
cd /ruta/a/tu/proyecto/
```

2. **Hacer ejecutables** los scripts:
```bash
chmod +x deploy-templates/*.sh
```

## 🚀 Uso Rápido

### 1. Configurar Deploy
```bash
./deploy-templates/setup-deploy.sh -n "mi-aplicacion" -v "1.0.0" -p "requests pandas flask"
```

### 2. Validar Configuración
```bash
./deploy-templates/validate-deploy.sh
```

### 3. Deploy en EasyPanel
1. Hacer commit y push
2. Configurar en EasyPanel
3. Ejecutar deploy

## 📖 Guía Detallada

### Configuración Inicial

El script `setup-deploy.sh` configura automáticamente:

#### Parámetros Requeridos
- `-n, --name`: Nombre de la aplicación
- `-v, --version`: Versión (opcional, default: 1.0.0)
- `-d, --description`: Descripción (opcional)
- `-p, --python`: Dependencias Python (opcional)

#### Parámetros Opcionales
- `-f, --frontend`: Ruta del frontend existente
- `-s, --scripts`: Ruta de scripts existentes
- `-c, --config`: Ruta de configuración existente

#### Ejemplos de Uso

**Aplicación Python básica:**
```bash
./deploy-templates/setup-deploy.sh -n "mi-api" -v "2.1.0" -p "flask requests sqlalchemy"
```

**Aplicación con frontend:**
```bash
./deploy-templates/setup-deploy.sh -n "mi-webapp" -f "./dist" -p "fastapi uvicorn"
```

**Aplicación completa:**
```bash
./deploy-templates/setup-deploy.sh \
  -n "mi-aplicacion" \
  -v "1.0.0" \
  -d "Aplicación web completa" \
  -p "django gunicorn psycopg2" \
  -f "./build" \
  -s "./scripts" \
  -c "./config"
```

### Archivos Generados

El script crea automáticamente:

```
tu-proyecto/
├── Dockerfile.easypanel-optimized    # Dockerfile optimizado
├── config.json                       # Configuración de la app
├── env.example                       # Variables de entorno
├── .dockerignore                     # Archivos a ignorar
├── DEPLOY.md                         # Documentación de deploy
├── frontend/                         # Frontend estático
│   └── index.html                    # Página de inicio
├── scripts/                          # Scripts de la aplicación
│   └── healthcheck.sh               # Healthcheck básico
└── deploy-templates/                 # Templates del sistema
    ├── Dockerfile.easypanel-template
    ├── setup-deploy.sh
    └── validate-deploy.sh
```

### Configuración en EasyPanel

#### 1. Crear Aplicación
- **Tipo:** SSH Git
- **Repositorio:** `git@github.com:tu-usuario/tu-repo.git`
- **Dockerfile:** `Dockerfile.easypanel-optimized`

#### 2. Configurar Volúmenes
| Tipo | Nombre | Ruta de Montaje |
|------|--------|-----------------|
| VOLUME | data | /data |
| VOLUME | logs | /data/logs |
| VOLUME | backup | /data/backups |
| FILE | supervisor-config | /etc/supervisor/conf.d/supervisord.conf |

#### 3. Variables de Entorno
Configurar según `env.example`:
```bash
APP_NAME=mi-aplicacion
APP_VERSION=1.0.0
APP_ENV=production
LOG_LEVEL=INFO
# ... otras variables según necesidad
```

### Validación Pre-Deploy

El script `validate-deploy.sh` verifica:

- ✅ Archivos requeridos presentes
- ✅ Estructura de directorios correcta
- ✅ Dockerfile configurado
- ✅ Configuración válida
- ✅ Repositorio Git configurado
- ✅ Dependencias del sistema
- ✅ Build local (opcional)

### Estructura del Dockerfile

El template incluye:

```dockerfile
# Base: nginx:alpine
# Dependencias: Python, supervisor, build tools
# Configuración: nginx, supervisor, healthcheck
# Volúmenes: /data para persistencia
# Puertos: 80 (HTTP)
# Healthcheck: /health endpoint
```

### Endpoints Disponibles

- **`/`** - Aplicación principal
- **`/health`** - Health check
- **`/api/`** - API endpoints (configurable)

### Logs y Monitoreo

Los logs se almacenan en:
- **Nginx:** `/data/logs/nginx/`
- **Supervisor:** `/data/logs/supervisor.log`
- **Aplicación:** `/data/logs/sistema.log`

### Personalización Avanzada

#### Modificar Dockerfile
Edita `Dockerfile.easypanel-optimized` después de la configuración inicial.

#### Agregar Dependencias
```dockerfile
# En el Dockerfile, modifica:
ARG PYTHON_REQUIREMENTS="requests pandas flask gunicorn"
```

#### Configurar nginx
Modifica la sección de configuración de nginx en el Dockerfile.

#### Agregar Scripts
Coloca tus scripts en `scripts/` y se copiarán automáticamente.

## 🔧 Troubleshooting

### Problemas Comunes

#### 1. Error de Build
```bash
# Verificar configuración
./deploy-templates/validate-deploy.sh

# Revisar logs
docker build -f Dockerfile.easypanel-optimized -t test .
```

#### 2. Contenedor no Inicia
- Verificar volúmenes en EasyPanel
- Verificar variables de entorno
- Revisar logs del contenedor

#### 3. Healthcheck Falla
- Verificar que nginx esté funcionando
- Verificar endpoint `/health`
- Revisar logs de nginx

### Comandos de Diagnóstico

```bash
# Validar configuración
./deploy-templates/validate-deploy.sh

# Test local
docker build -f Dockerfile.easypanel-optimized -t test .
docker run -p 8080:80 test

# Verificar healthcheck
curl http://localhost:8080/health
```

## 📚 Ejemplos

### Ejemplo 1: API Python con FastAPI
```bash
./deploy-templates/setup-deploy.sh \
  -n "mi-api" \
  -v "1.0.0" \
  -p "fastapi uvicorn sqlalchemy psycopg2" \
  -d "API REST con FastAPI"
```

### Ejemplo 2: Aplicación Web con Django
```bash
./deploy-templates/setup-deploy.sh \
  -n "mi-webapp" \
  -v "2.0.0" \
  -p "django gunicorn psycopg2 pillow" \
  -f "./static" \
  -d "Aplicación web con Django"
```

### Ejemplo 3: Aplicación Node.js
```bash
# Para Node.js, modifica el Dockerfile después de la configuración
# Cambia la base image y agrega Node.js
```

## 🤝 Contribuir

Para mejorar el sistema:

1. Modifica los templates en `deploy-templates/`
2. Actualiza la documentación
3. Prueba con diferentes tipos de aplicaciones
4. Reporta issues y mejoras

## 📄 Licencia

Sistema desarrollado por Taker SA para uso interno y proyectos cliente.

---

**Desarrollado con ❤️ por Taker SA**

*Basado en la experiencia exitosa de taker_sa_envio_masivo_whatsapp*
