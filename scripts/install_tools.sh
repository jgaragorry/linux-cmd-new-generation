#!/bin/bash

# ==============================================================================
# SCRIPT DE INSTALACIÓN PARA HERRAMIENTAS DE NUEVA GENERACIÓN
# PROBADO EN UBUNTU SERVER 24.04 LTS
# Versión corregida para evitar errores de fin de línea (CRLF).
# ==============================================================================

set -e # Salir inmediatamente si un comando falla

# --- Función para registrar mensajes ---
log() {
    echo "✅ [LOG] $1"
}

# --- Función para registrar errores y salir ---
error_exit() {
    echo "❌ [ERROR] $1" >&2
    exit 1
}

log "Iniciando la instalación de herramientas de nueva generación..."

# --- Actualizar repositorios ---
log "Actualizando repositorios APT..."
sudo apt-get update || error_exit "No se pudo actualizar los repositorios."

# --- Instalar prerrequisitos base ---
log "Instalando prerrequisitos: curl, gpg, build-essential, libpcap-dev..."
sudo apt-get install -y curl gpg build-essential libpcap-dev || error_exit "No se pudieron instalar los prerrequisitos."

# --- Instalar RUST y CARGO (necesario para varias herramientas) ---
if ! command -v cargo &> /dev/null; then
    log "Instalando Rust y Cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
else
    log "Rust y Cargo ya están instalados."
fi

# Es necesario cargar el entorno de cargo para el resto del script
# shellcheck source=/dev/null
source "$HOME/.cargo/env"


# --- 1. EZA (Reemplazo de EXA) ---
if ! command -v eza &> /dev/null; then
    log "Instalando eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update
    sudo apt-get install -y eza || error_exit "Falló la instalación de eza."
else
    log "eza ya está instalado."
fi


# --- 2. Herramientas disponibles en repositorios de Ubuntu 24.04 ---
log "Instalando herramientas desde los repositorios de Ubuntu: bat, duf, btop, glances, fd-find, ripgrep, lnav, multitail..."
sudo apt-get install -y bat duf btop glances fd-find ripgrep lnav multitail || error_exit "Falló la instalación de herramientas desde APT."


# --- 3. Herramientas que se instalan con CARGO ---
log "Instalando herramientas con Cargo (puede tomar un tiempo)..."

cargo_install() {
    local pkg=$1
    if ! command -v "$pkg" &> /dev/null; then
        log "Instalando $pkg con cargo..."
        cargo install "$pkg" || error_exit "Falló la instalación de $pkg con cargo."
    else
        log "$pkg ya está instalado."
    fi
}

# El paquete de dog es dogdns
if ! command -v "dog" &> /dev/null; then
    log "Instalando dog (dogdns) con cargo..."
    cargo install dogdns || error_exit "Falló la instalación de dogdns."
else
    log "dog (dogdns) ya está instalado."
fi

cargo_install dust
cargo_install gdu
cargo_install bottom
cargo_install procs
cargo_install bandwhich

log "=========================================================="
log "🎉 ¡Instalación completada con éxito!"
log "👉 A continuación, ejecuta el script 'configure_aliases.sh'."
log "👉 Finalmente, ejecuta 'source ~/.bashrc' para aplicar los cambios."
log "=========================================================="
