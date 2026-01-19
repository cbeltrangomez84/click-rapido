#!/bin/bash
# Script de deploy automatizado para Railway (100% sin interacción)

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "🚀 Iniciando deploy a Railway..."

# Cargar configuración
if [ -f ".env.railway" ]; then
    export $(cat .env.railway | xargs)
else
    echo -e "${RED}Error: No se encontró .env.railway${NC}"
    exit 1
fi

# Verificar que Railway CLI está instalado
if ! command -v railway &> /dev/null; then
    echo "Instalando Railway CLI..."
    brew install railway
fi

# Deploy
echo "📦 Desplegando..."
railway up --service "$RAILWAY_SERVICE" --detach

echo -e "${GREEN}✅ Deploy completado!${NC}"
echo "🌐 URL: https://click-rapido-production.up.railway.app"
