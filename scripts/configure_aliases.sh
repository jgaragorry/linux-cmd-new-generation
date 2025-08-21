#!/bin/bash

# SCRIPT PARA CONFIGURAR ALIAS PERMANENTES EN BASH

ALIAS_FILE="$HOME/.bash_aliases"

echo "✍️  Configurando alias en $ALIAS_FILE..."

# Crear el archivo si no existe
touch $ALIAS_FILE

# Función para agregar alias si no existe
add_alias() {
    if ! grep -q "alias $1=" "$ALIAS_FILE"; then
        echo "alias $1='$2'" >> "$ALIAS_FILE"
        echo "   -> Alias para '$1' agregado."
    else
        echo "   -> Alias para '$1' ya existe."
    fi
}

# --- Aliases ---
add_alias ls 'eza --icons'
add_alias ll 'eza -l --icons'
add_alias la 'eza -la --icons'
add_alias ltree 'eza --tree --icons'
add_alias cat 'batcat' # En Ubuntu, bat se instala como batcat
add_alias df 'duf'
add_alias du 'dust'
add_alias top 'btop'
add_alias ps 'procs'
add_alias find 'fdfind'
add_alias grep 'rg'
add_alias dig 'dog'

# Mover los binarios de cargo al path (si no lo está ya)
if ! grep -q 'export PATH="$HOME/.cargo/bin:$PATH"' "$HOME/.bashrc"; then
    echo '' >> "$HOME/.bashrc"
    echo '# Añadir binarios de Cargo al PATH' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.bashrc"
fi


echo "✅ Configuración de alias completada."
echo "🔥 ¡Ejecuta 'source ~/.bashrc' o reinicia tu terminal para aplicar los cambios!"
