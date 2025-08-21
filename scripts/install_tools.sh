#!/bin/bash

# SCRIPT DE INSTALACIÓN PARA HERRAMIENTAS DE NUEVA GENERACIÓN
# PROBADO EN UBUNTU SERVER 24.04 LTS

echo "🚀 Iniciando la instalación de herramientas de nueva generación..."

# --- Función para registrar errores ---
error_exit() {
    echo "❌ Error: $1" >&2
    exit 1
}

# --- Actualizar repositorios ---
sudo apt-get update || error_exit "No se pudo actualizar los repositorios."

# --- Instalar prerrequisitos base ---
sudo apt-get install -y curl gpg build-essential || error_exit "No se pudieron instalar los prerrequisitos."

# --- Instalar RUST y CARGO (necesario para varias herramientas) ---
if ! command -v cargo &> /dev/null; then
    echo "📦 Instalando Rust y Cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "✅ Rust y Cargo ya están instalados."
fi

# --- 1. EZA (Reemplazo de EXA) ---
# Necesita su propio repositorio
echo "📦 Instalando eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update
sudo apt-get install -y eza || error_exit "Falló la instalación de eza."

# --- Herramientas disponibles en repositorios de Ubuntu 24.04 ---
echo "📦 Instalando herramientas desde los repositorios de Ubuntu..."
sudo apt-get install -y bat duf btop glances fd-find ripgrep lnav multitail || error_exit "Falló la instalación de herramientas desde APT."

# --- Herramientas que se instalan con CARGO ---
echo "📦 Instalando herramientas con Cargo (puede tomar un tiempo)..."
cargo install dust || echo "⚠️  Advertencia: 'dust' ya podría estar instalado."
cargo install gdu || echo "⚠️  Advertencia: 'gdu' ya podría estar instalado."
cargo install bottom || echo "⚠️  Advertencia: 'bottom' ya podría estar instalado."
cargo install procs || echo "⚠️  Advertencia: 'procs' ya podría estar instalado."
cargo install bandwhich || echo "⚠️  Advertencia: 'bandwhich' ya podría estar instalado."
cargo install dogdns || echo "⚠️  Advertencia: 'dog' ya podría estar instalado."

echo "✅ Instalación completada con éxito."
echo "👉 Ahora, ejecuta 'source configure_aliases.sh' para establecer los alias."
echo "👉 Y luego ejecuta 'source ~/.bashrc' para aplicarlos a tu sesión."
