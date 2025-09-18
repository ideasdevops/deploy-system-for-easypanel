# 🚀 Deploy System for EasyPanel

Sistema de deploy automático y reutilizable para EasyPanel, desarrollado por IdeasDevOps. Basado en la experiencia exitosa del proyecto `sendera-app.

## ✨ Características

- 🐳 **Dockerfile optimizado** para Alpine Linux
- ⚙️ **Configuración automática** de nginx y supervisor
- 🔍 **Healthcheck integrado** para monitoreo
- ✅ **Validación pre-deploy** automática
- 📚 **Documentación generada** automáticamente
- 🐍 **Soporte completo para Python** con dependencias automáticas
- 🌐 **Frontend estático** con nginx optimizado
- 📊 **Logs centralizados** y persistentes
- 🔧 **Scripts de automatización** reutilizables

## 🚀 Inicio Rápido

### 1. Instalación
```bash
# Clonar el repositorio
git clone https://github.com/ideasdevops/deploy-system-for-easypanel.git
cd deploy-system-for-easypanel

# Hacer ejecutables los scripts
chmod +x *.sh
```

### 2. Uso Básico
```bash
# Configurar deploy para tu aplicación
./deploy-master.sh setup -n "mi-aplicacion" -p "flask requests"

# Validar configuración
./deploy-master.sh validate

# Ver ejemplos de uso
./deploy-master.sh examples
```

### 3. Deploy Completo
```bash
# Ejecutar deploy completo (setup + validate + git)
./deploy-master.sh deploy -n "mi-aplicacion" -p "django gunicorn"
```

## 📖 Documentación

- **[Guía Completa](README-DEPLOY-SYSTEM.md)** - Documentación detallada del sistema
- **[Ejemplos de Uso](example-usage.sh)** - Ejemplos prácticos interactivos
- **[Templates](Dockerfile.easypanel-template)** - Template de Dockerfile optimizado

## 🛠️ Scripts Disponibles

| Script | Descripción |
|--------|-------------|
| `deploy-master.sh` | Script principal con menú integrado |
| `setup-deploy.sh` | Configuración automática de deploy |
| `validate-deploy.sh` | Validación pre-deploy |
| `example-usage.sh` | Ejemplos interactivos de uso |

## 🎯 Casos de Uso

### API Python con FastAPI
```bash
./deploy-master.sh setup -n "mi-api" -p "fastapi uvicorn sqlalchemy"
```

### Aplicación Web con Frontend
```bash
./deploy-master.sh setup -n "mi-webapp" -f "./dist" -p "django gunicorn"
```

### Aplicación con Scripts Personalizados
```bash
./deploy-master.sh setup -n "mi-app" -s "./scripts" -p "requests schedule"
```

## 🔧 Configuración en EasyPanel

1. **Crear aplicación** en EasyPanel
2. **SSH Git** con tu repositorio
3. **Dockerfile:** `Dockerfile.easypanel-optimized`
4. **Volúmenes:** Según `DEPLOY.md` generado
5. **Variables de entorno:** Según `env.example`
6. **Deploy** y verificar funcionamiento

## 📊 Monitoreo y Logs

- **Health Check:** `http://tu-dominio/health`
- **Logs Nginx:** `/data/logs/nginx/`
- **Logs Supervisor:** `/data/logs/supervisor.log`
- **Logs Aplicación:** `/data/logs/sistema.log`

## 🤝 Contribuir

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -m 'feat: agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📄 Licencia

Desarrollado por **IdeasDevOps** para uso interno y proyectos cliente.

## 🏆 Basado en Experiencia Real

Este sistema está basado en la experiencia exitosa del proyecto `taker_sa_envio_masivo_whatsapp`, que fue desplegado exitosamente en EasyPanel después de resolver múltiples problemas de configuración.

### Problemas Resueltos
- ✅ Bucles de reinicio de contenedores
- ✅ Configuración incorrecta de nginx
- ✅ Dependencias de compilación faltantes
- ✅ Directorios de supervisor inexistentes
- ✅ Healthcheck no funcional
- ✅ Volúmenes mal configurados

## 📞 Soporte

Para soporte técnico o consultas:
- **Email:** devops@ideasdevops.com
- **GitHub Issues:** [Crear issue](https://github.com/ideasdevops/deploy-system-for-easypanel/issues)

---

**Desarrollado con ❤️ por IdeasDevOps**

*Sistema de Deploy Automático - Versión 1.0.0*
