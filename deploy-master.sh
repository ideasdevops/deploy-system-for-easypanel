#!/bin/bash

# ===============================================
# SCRIPT MAESTRO DE DEPLOY - TAKER SA
# ===============================================
# Sistema de Deploy Automático - Taker SA
# Script principal que integra toda la funcionalidad
# ===============================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Función para imprimir mensajes
print_header() {
    echo -e "${PURPLE}===============================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}===============================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[ℹ]${NC} $1"
}

# Función para mostrar ayuda
show_help() {
    print_header "SISTEMA DE DEPLOY AUTOMÁTICO - TAKER SA"
    echo ""
    echo "USO:"
    echo "  ./deploy-templates/deploy-master.sh [COMANDO] [OPCIONES]"
    echo ""
    echo "COMANDOS:"
    echo "  setup     Configurar deploy para una nueva aplicación"
    echo "  validate  Validar configuración antes del deploy"
    echo "  deploy    Ejecutar deploy completo (setup + validate + git)"
    echo "  examples  Mostrar ejemplos de uso"
    echo "  help      Mostrar esta ayuda"
    echo ""
    echo "OPCIONES PARA 'setup':"
    echo "  -n, --name NAME        Nombre de la aplicación (requerido)"
    echo "  -v, --version VERSION  Versión de la aplicación"
    echo "  -d, --description DESC Descripción de la aplicación"
    echo "  -p, --python REQS      Dependencias Python"
    echo "  -f, --frontend PATH    Ruta del frontend"
    echo "  -s, --scripts PATH     Ruta de scripts"
    echo "  -c, --config PATH      Ruta de configuración"
    echo ""
    echo "EJEMPLOS:"
    echo "  ./deploy-templates/deploy-master.sh setup -n mi-app -p 'flask requests'"
    echo "  ./deploy-templates/deploy-master.sh validate"
    echo "  ./deploy-templates/deploy-master.sh deploy -n mi-app -p 'django gunicorn'"
    echo "  ./deploy-templates/deploy-master.sh examples"
    echo ""
}

# Función para verificar dependencias
check_dependencies() {
    print_info "Verificando dependencias..."
    
    local missing_deps=()
    
    if ! command -v git >/dev/null 2>&1; then
        missing_deps+=("git")
    fi
    
    if ! command -v curl >/dev/null 2>&1; then
        missing_deps+=("curl")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Dependencias faltantes: ${missing_deps[*]}"
        echo "Instala las dependencias faltantes y vuelve a intentar."
        exit 1
    fi
    
    print_success "Todas las dependencias están disponibles"
}

# Función para setup
run_setup() {
    print_header "CONFIGURANDO DEPLOY AUTOMÁTICO"
    
    if [ ! -f "deploy-templates/setup-deploy.sh" ]; then
        print_error "Script setup-deploy.sh no encontrado"
        echo "Asegúrate de estar en el directorio correcto del proyecto."
        exit 1
    fi
    
    ./deploy-templates/setup-deploy.sh "$@"
}

# Función para validación
run_validate() {
    print_header "VALIDANDO CONFIGURACIÓN"
    
    if [ ! -f "deploy-templates/validate-deploy.sh" ]; then
        print_error "Script validate-deploy.sh no encontrado"
        echo "Asegúrate de estar en el directorio correcto del proyecto."
        exit 1
    fi
    
    ./deploy-templates/validate-deploy.sh
}

# Función para deploy completo
run_deploy() {
    print_header "EJECUTANDO DEPLOY COMPLETO"
    
    # Paso 1: Setup
    print_info "Paso 1/4: Configurando aplicación..."
    run_setup "$@"
    
    # Paso 2: Validación
    print_info "Paso 2/4: Validando configuración..."
    if ! run_validate; then
        print_error "La validación falló. Corrige los errores antes de continuar."
        exit 1
    fi
    
    # Paso 3: Git status
    print_info "Paso 3/4: Verificando estado de Git..."
    if [ -d ".git" ]; then
        if ! git diff --quiet || ! git diff --cached --quiet; then
            print_warning "Hay cambios sin commit. ¿Quieres hacer commit automático? (y/N)"
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                git add .
                git commit -m "feat: Configurar deploy automático para EasyPanel"
                print_success "Cambios committeados"
            else
                print_warning "Saltando commit. Asegúrate de hacer commit antes del deploy."
            fi
        else
            print_success "No hay cambios pendientes"
        fi
        
        if git remote -v | grep -q .; then
            print_success "Remote configurado"
        else
            print_warning "No hay remote configurado"
            echo "Configura un remote antes del deploy:"
            echo "  git remote add origin <url>"
        fi
    else
        print_warning "No se encontró repositorio Git"
        echo "Inicializa Git antes del deploy:"
        echo "  git init"
        echo "  git remote add origin <url>"
    fi
    
    # Paso 4: Instrucciones finales
    print_info "Paso 4/4: Instrucciones de deploy"
    echo ""
    print_success "¡Configuración completada!"
    echo ""
    echo "Próximos pasos:"
    echo "1. Revisar la configuración generada"
    echo "2. Hacer commit y push de los cambios (si no se hizo automáticamente)"
    echo "3. Configurar la aplicación en EasyPanel:"
    echo "   - Crear nueva aplicación"
    echo "   - SSH Git: tu repositorio"
    echo "   - Dockerfile: Dockerfile.easypanel-optimized"
    echo "   - Configurar volúmenes según DEPLOY.md"
    echo "   - Configurar variables de entorno"
    echo "4. Ejecutar deploy en EasyPanel"
    echo ""
    echo "Para más detalles, consulta DEPLOY.md"
}

# Función para mostrar ejemplos
run_examples() {
    if [ -f "deploy-templates/example-usage.sh" ]; then
        ./deploy-templates/example-usage.sh
    else
        print_error "Script example-usage.sh no encontrado"
        exit 1
    fi
}

# Función para mostrar información del sistema
show_system_info() {
    print_header "INFORMACIÓN DEL SISTEMA"
    echo "Sistema de Deploy Automático - Taker SA"
    echo "Versión: 1.0.0"
    echo "Basado en: taker_sa_envio_masivo_whatsapp"
    echo ""
    echo "Archivos disponibles:"
    if [ -f "deploy-templates/setup-deploy.sh" ]; then
        print_success "setup-deploy.sh - Configuración automática"
    fi
    if [ -f "deploy-templates/validate-deploy.sh" ]; then
        print_success "validate-deploy.sh - Validación pre-deploy"
    fi
    if [ -f "deploy-templates/example-usage.sh" ]; then
        print_success "example-usage.sh - Ejemplos de uso"
    fi
    if [ -f "deploy-templates/README-DEPLOY-SYSTEM.md" ]; then
        print_success "README-DEPLOY-SYSTEM.md - Documentación completa"
    fi
    echo ""
}

# Función principal
main() {
    # Verificar que estamos en el directorio correcto
    if [ ! -d "deploy-templates" ]; then
        print_error "Directorio deploy-templates no encontrado"
        echo "Asegúrate de estar en el directorio raíz del proyecto."
        echo "Los templates deben estar en ./deploy-templates/"
        exit 1
    fi
    
    # Verificar dependencias
    check_dependencies
    
    # Procesar comando
    case "${1:-help}" in
        setup)
            shift
            run_setup "$@"
            ;;
        validate)
            run_validate
            ;;
        deploy)
            shift
            run_deploy "$@"
            ;;
        examples)
            run_examples
            ;;
        info)
            show_system_info
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "Comando desconocido: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Ejecutar función principal
main "$@"
