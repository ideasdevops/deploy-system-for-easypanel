#!/bin/bash

# ===============================================
# EJEMPLO DE USO DEL SISTEMA DE DEPLOY
# ===============================================
# Sistema de Deploy Automático - Taker SA
# Ejemplos prácticos de uso
# ===============================================

set -e

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}===============================================${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}[PASO $1]${NC} $2"
    echo ""
}

print_note() {
    echo -e "${YELLOW}[NOTA]${NC} $1"
    echo ""
}

# ===============================================
# EJEMPLO 1: APLICACIÓN PYTHON BÁSICA
# ===============================================
example_python_basic() {
    print_header "EJEMPLO 1: API Python con FastAPI"
    
    print_step "1" "Crear directorio del proyecto"
    echo "mkdir mi-api-python && cd mi-api-python"
    echo ""
    
    print_step "2" "Configurar deploy automático"
    echo "./deploy-templates/setup-deploy.sh \\"
    echo "  -n \"mi-api-python\" \\"
    echo "  -v \"1.0.0\" \\"
    echo "  -p \"fastapi uvicorn sqlalchemy psycopg2\" \\"
    echo "  -d \"API REST con FastAPI y PostgreSQL\""
    echo ""
    
    print_step "3" "Validar configuración"
    echo "./deploy-templates/validate-deploy.sh"
    echo ""
    
    print_step "4" "Hacer commit y push"
    echo "git add ."
    echo "git commit -m \"feat: Configurar deploy automático\""
    echo "git push origin main"
    echo ""
    
    print_note "El sistema creará automáticamente:"
    echo "  ✅ Dockerfile.easypanel-optimized"
    echo "  ✅ config.json con metadatos"
    echo "  ✅ env.example con variables"
    echo "  ✅ frontend/index.html básico"
    echo "  ✅ scripts/healthcheck.sh"
    echo "  ✅ DEPLOY.md con instrucciones"
    echo ""
}

# ===============================================
# EJEMPLO 2: APLICACIÓN CON FRONTEND
# ===============================================
example_with_frontend() {
    print_header "EJEMPLO 2: Aplicación Web Completa"
    
    print_step "1" "Preparar frontend"
    echo "# Construir frontend (React, Vue, Angular, etc.)"
    echo "npm run build"
    echo "ls -la dist/"
    echo ""
    
    print_step "2" "Configurar deploy con frontend"
    echo "./deploy-templates/setup-deploy.sh \\"
    echo "  -n \"mi-webapp\" \\"
    echo "  -v \"2.0.0\" \\"
    echo "  -p \"django gunicorn psycopg2 pillow\" \\"
    echo "  -f \"./dist\" \\"
    echo "  -d \"Aplicación web con Django y React\""
    echo ""
    
    print_step "3" "Configurar en EasyPanel"
    echo "1. Crear nueva aplicación"
    echo "2. SSH Git: git@github.com:usuario/mi-webapp.git"
    echo "3. Dockerfile: Dockerfile.easypanel-optimized"
    echo "4. Configurar volúmenes según DEPLOY.md"
    echo "5. Configurar variables de entorno"
    echo "6. Ejecutar deploy"
    echo ""
    
    print_note "El frontend se servirá automáticamente con nginx"
    echo ""
}

# ===============================================
# EJEMPLO 3: APLICACIÓN CON SCRIPTS PERSONALIZADOS
# ===============================================
example_with_scripts() {
    print_header "EJEMPLO 3: Aplicación con Scripts Personalizados"
    
    print_step "1" "Preparar scripts"
    echo "mkdir -p scripts"
    echo "cat > scripts/start-app.sh << 'EOF'"
    echo "#!/bin/bash"
    echo "echo 'Iniciando aplicación personalizada...'"
    echo "python app.py"
    echo "EOF"
    echo "chmod +x scripts/start-app.sh"
    echo ""
    
    print_step "2" "Configurar deploy con scripts"
    echo "./deploy-templates/setup-deploy.sh \\"
    echo "  -n \"mi-app-scripts\" \\"
    echo "  -v \"1.5.0\" \\"
    echo "  -p \"requests schedule psutil\" \\"
    echo "  -s \"./scripts\" \\"
    echo "  -d \"Aplicación con scripts de automatización\""
    echo ""
    
    print_step "3" "Personalizar Dockerfile (opcional)"
    echo "# Editar Dockerfile.easypanel-optimized para usar scripts personalizados"
    echo "# Ejemplo: cambiar CMD para ejecutar scripts/start-app.sh"
    echo ""
    
    print_note "Los scripts se copiarán automáticamente a /data/scripts/"
    echo ""
}

# ===============================================
# EJEMPLO 4: WORKFLOW COMPLETO
# ===============================================
example_complete_workflow() {
    print_header "EJEMPLO 4: Workflow Completo de Deploy"
    
    print_step "1" "Preparar proyecto"
    echo "# Crear directorio del proyecto"
    echo "mkdir mi-proyecto-completo && cd mi-proyecto-completo"
    echo ""
    echo "# Inicializar git"
    echo "git init"
    echo "git remote add origin git@github.com:usuario/mi-proyecto.git"
    echo ""
    
    print_step "2" "Configurar deploy automático"
    echo "./deploy-templates/setup-deploy.sh \\"
    echo "  -n \"mi-proyecto-completo\" \\"
    echo "  -v \"1.0.0\" \\"
    echo "  -p \"flask gunicorn redis celery\" \\"
    echo "  -f \"./frontend-build\" \\"
    echo "  -s \"./deploy-scripts\" \\"
    echo "  -c \"./config\" \\"
    echo "  -d \"Aplicación completa con Flask, Redis y Celery\""
    echo ""
    
    print_step "3" "Validar configuración"
    echo "./deploy-templates/validate-deploy.sh"
    echo ""
    
    print_step "4" "Personalizar según necesidad"
    echo "# Editar config.json si es necesario"
    echo "# Modificar env.example con variables específicas"
    echo "# Ajustar Dockerfile.easypanel-optimized si es necesario"
    echo ""
    
    print_step "5" "Commit y push"
    echo "git add ."
    echo "git commit -m \"feat: Configurar deploy automático para EasyPanel\""
    echo "git push origin main"
    echo ""
    
    print_step "6" "Configurar en EasyPanel"
    echo "1. Crear aplicación en EasyPanel"
    echo "2. Configurar SSH Git con el repositorio"
    echo "3. Seleccionar Dockerfile.easypanel-optimized"
    echo "4. Configurar volúmenes según DEPLOY.md"
    echo "5. Configurar variables de entorno"
    echo "6. Ejecutar deploy"
    echo ""
    
    print_step "7" "Verificar deploy"
    echo "# Verificar que la aplicación esté funcionando"
    echo "curl http://tu-dominio/health"
    echo ""
    echo "# Verificar logs"
    echo "# En EasyPanel: ir a la sección de logs"
    echo ""
    
    print_note "¡Deploy completado exitosamente!"
    echo ""
}

# ===============================================
# MENÚ PRINCIPAL
# ===============================================
show_menu() {
    print_header "SISTEMA DE DEPLOY AUTOMÁTICO - EJEMPLOS DE USO"
    echo ""
    echo "Selecciona un ejemplo:"
    echo ""
    echo "1. Aplicación Python básica (FastAPI)"
    echo "2. Aplicación con frontend (Django + React)"
    echo "3. Aplicación con scripts personalizados"
    echo "4. Workflow completo de deploy"
    echo "5. Mostrar todos los ejemplos"
    echo "6. Salir"
    echo ""
    echo -n "Ingresa tu opción (1-6): "
}

# ===============================================
# FUNCIÓN PRINCIPAL
# ===============================================
main() {
    while true; do
        show_menu
        read -r option
        
        case $option in
            1)
                example_python_basic
                ;;
            2)
                example_with_frontend
                ;;
            3)
                example_with_scripts
                ;;
            4)
                example_complete_workflow
                ;;
            5)
                example_python_basic
                example_with_frontend
                example_with_scripts
                example_complete_workflow
                ;;
            6)
                echo "¡Hasta luego!"
                exit 0
                ;;
            *)
                echo "Opción inválida. Intenta de nuevo."
                echo ""
                ;;
        esac
        
        echo ""
        echo "Presiona Enter para continuar..."
        read -r
        clear
    done
}

# Ejecutar menú
main "$@"
