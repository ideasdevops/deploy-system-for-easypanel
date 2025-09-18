#!/bin/bash

# ===============================================
# SCRIPT DE VALIDACIÓN PRE-DEPLOY
# ===============================================
# Sistema de Deploy Automático - Taker SA
# Valida que todo esté listo para el deploy
# ===============================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contadores
ERRORS=0
WARNINGS=0
CHECKS=0

# Función para imprimir mensajes
print_message() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
    ((CHECKS++))
}

print_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
    ((WARNINGS++))
    ((CHECKS++))
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
    ((ERRORS++))
    ((CHECKS++))
}

print_header() {
    echo ""
    echo "==============================================="
    echo "VALIDACIÓN PRE-DEPLOY - TAKER SA"
    echo "==============================================="
    echo ""
}

print_footer() {
    echo ""
    echo "==============================================="
    echo "RESUMEN DE VALIDACIÓN"
    echo "==============================================="
    echo "Checks realizados: $CHECKS"
    echo "Errores: $ERRORS"
    echo "Advertencias: $WARNINGS"
    echo ""
    
    if [ $ERRORS -eq 0 ]; then
        if [ $WARNINGS -eq 0 ]; then
            print_success "¡Todo está listo para el deploy!"
            echo "Puedes proceder con confianza."
        else
            print_warning "Deploy posible con advertencias."
            echo "Revisa las advertencias antes de continuar."
        fi
    else
        print_error "Hay errores que deben corregirse antes del deploy."
        echo "Corrige los errores y ejecuta la validación nuevamente."
        exit 1
    fi
    echo "==============================================="
}

# ===============================================
# VALIDACIÓN 1: ARCHIVOS REQUERIDOS
# ===============================================
validate_required_files() {
    print_message "Validando archivos requeridos..."
    
    # Dockerfile
    if [ -f "Dockerfile.easypanel-optimized" ]; then
        print_success "Dockerfile.easypanel-optimized encontrado"
    else
        print_error "Dockerfile.easypanel-optimized no encontrado"
        echo "  Ejecuta: ./deploy-templates/setup-deploy.sh primero"
    fi
    
    # config.json
    if [ -f "config.json" ]; then
        print_success "config.json encontrado"
    else
        print_error "config.json no encontrado"
    fi
    
    # env.example
    if [ -f "env.example" ]; then
        print_success "env.example encontrado"
    else
        print_error "env.example no encontrado"
    fi
    
    # .dockerignore
    if [ -f ".dockerignore" ]; then
        print_success ".dockerignore encontrado"
    else
        print_warning ".dockerignore no encontrado (recomendado)"
    fi
}

# ===============================================
# VALIDACIÓN 2: ESTRUCTURA DE DIRECTORIOS
# ===============================================
validate_directory_structure() {
    print_message "Validando estructura de directorios..."
    
    # Frontend
    if [ -d "frontend" ] && [ "$(ls -A frontend 2>/dev/null)" ]; then
        print_success "Directorio frontend con contenido"
    else
        print_warning "Directorio frontend vacío o no existe"
        echo "  Se creará una página de inicio básica"
    fi
    
    # Scripts
    if [ -d "scripts" ] && [ "$(ls -A scripts 2>/dev/null)" ]; then
        print_success "Directorio scripts con contenido"
    else
        print_warning "Directorio scripts vacío o no existe"
        echo "  Se creará un script de healthcheck básico"
    fi
}

# ===============================================
# VALIDACIÓN 3: DOCKERFILE
# ===============================================
validate_dockerfile() {
    print_message "Validando Dockerfile..."
    
    if [ ! -f "Dockerfile.easypanel-optimized" ]; then
        return
    fi
    
    # Verificar que no tenga variables sin reemplazar
    if grep -q "mi-aplicacion" Dockerfile.easypanel-optimized; then
        print_error "Dockerfile contiene variables sin reemplazar"
        echo "  Ejecuta: ./deploy-templates/setup-deploy.sh primero"
    else
        print_success "Dockerfile configurado correctamente"
    fi
    
    # Verificar sintaxis básica
    if grep -q "FROM nginx:alpine" Dockerfile.easypanel-optimized; then
        print_success "Base image correcta (nginx:alpine)"
    else
        print_error "Base image incorrecta o no encontrada"
    fi
    
    # Verificar que tenga healthcheck
    if grep -q "HEALTHCHECK" Dockerfile.easypanel-optimized; then
        print_success "Healthcheck configurado"
    else
        print_warning "Healthcheck no encontrado"
    fi
}

# ===============================================
# VALIDACIÓN 4: CONFIGURACIÓN
# ===============================================
validate_configuration() {
    print_message "Validando configuración..."
    
    # config.json
    if [ -f "config.json" ]; then
        if python3 -c "import json; json.load(open('config.json'))" 2>/dev/null; then
            print_success "config.json es válido"
        else
            print_error "config.json tiene formato JSON inválido"
        fi
    fi
    
    # Verificar que no haya archivos .env en el repo
    if find . -name ".env*" -not -name "env.example" | grep -q .; then
        print_warning "Archivos .env encontrados en el repositorio"
        echo "  Considera agregarlos a .gitignore"
    else
        print_success "No hay archivos .env en el repositorio"
    fi
}

# ===============================================
# VALIDACIÓN 5: GIT
# ===============================================
validate_git() {
    print_message "Validando configuración de Git..."
    
    # Verificar que estemos en un repo git
    if [ -d ".git" ]; then
        print_success "Repositorio Git encontrado"
    else
        print_error "No se encontró repositorio Git"
        echo "  Inicializa con: git init"
    fi
    
    # Verificar que no haya cambios sin commit
    if [ -d ".git" ]; then
        if git diff --quiet && git diff --cached --quiet; then
            print_success "No hay cambios sin commit"
        else
            print_warning "Hay cambios sin commit"
            echo "  Considera hacer commit antes del deploy"
        fi
        
        # Verificar que tengamos un remote
        if git remote -v | grep -q .; then
            print_success "Remote configurado"
        else
            print_warning "No hay remote configurado"
            echo "  Configura con: git remote add origin <url>"
        fi
    fi
}

# ===============================================
# VALIDACIÓN 6: DEPENDENCIAS
# ===============================================
validate_dependencies() {
    print_message "Validando dependencias del sistema..."
    
    # Docker
    if command -v docker >/dev/null 2>&1; then
        print_success "Docker instalado"
    else
        print_warning "Docker no encontrado"
        echo "  Necesario para testing local"
    fi
    
    # Git
    if command -v git >/dev/null 2>&1; then
        print_success "Git instalado"
    else
        print_error "Git no encontrado"
    fi
    
    # Curl
    if command -v curl >/dev/null 2>&1; then
        print_success "Curl instalado"
    else
        print_warning "Curl no encontrado"
        echo "  Necesario para healthcheck"
    fi
}

# ===============================================
# VALIDACIÓN 7: TESTING LOCAL (OPCIONAL)
# ===============================================
validate_local_test() {
    print_message "Validando build local (opcional)..."
    
    if command -v docker >/dev/null 2>&1; then
        print_message "Intentando build local..."
        if docker build -f Dockerfile.easypanel-optimized -t test-deploy . >/dev/null 2>&1; then
            print_success "Build local exitoso"
            # Limpiar imagen de test
            docker rmi test-deploy >/dev/null 2>&1 || true
        else
            print_warning "Build local falló"
            echo "  Revisa el Dockerfile para errores"
        fi
    else
        print_warning "Docker no disponible para testing local"
    fi
}

# ===============================================
# FUNCIÓN PRINCIPAL
# ===============================================
main() {
    print_header
    
    validate_required_files
    validate_directory_structure
    validate_dockerfile
    validate_configuration
    validate_git
    validate_dependencies
    validate_local_test
    
    print_footer
}

# Ejecutar validación
main "$@"
