# Comando `fdfind` (`fd`)

`fd` es una alternativa moderna y eficiente al comando `find`, diseñada para facilitar búsquedas en el sistema de archivos con una sintaxis más intuitiva y rápida.

---

## 🛠️ Instalación

Instala `fd` en sistemas basados en Debian/Ubuntu y crea un alias para usarlo como `fd`.

```bash
sudo apt update
sudo apt install -y fd-find
echo "alias fd='fdfind'" >> ~/.bashrc
source ~/.bashrc
```

---

## 👤 Comandos por Perfil Técnico

### 🔧 DevOps & SRE

Comandos útiles para buscar archivos de configuración, scripts de despliegue y logs grandes o recientes.

```bash
fd -e conf --changed-within 1d . /etc                      # Archivos .conf modificados en las últimas 24h
fd -e sh -e py "deploy|script|ansible" . /opt              # Scripts relacionados con despliegues
fd -e log --size +10M . /var/log                           # Logs mayores a 10MB
fd --changed-within 2h . /jenkins/workspace                # Archivos modificados recientemente en Jenkins
```

### 🔐 DevSecOps & SecOps

Auditoría de seguridad: búsqueda de secretos, archivos con permisos peligrosos, y scripts ocultos.

```bash
fd "password|secret|key|token" . /etc --exec grep -l {} \; # Buscar posibles secretos en archivos
fd . / --exec bash -c '[[ -f {} && -w {} ]] && ls -la {}'   # Archivos que son modificables por el usuario
fd . / --exec bash -c '[[ -u {} ]] && echo "SUID: {}"'      # Archivos con bit SUID
fd -e sh -e py "\.|hidden" . /tmp /dev/shm                  # Scripts ocultos en directorios temporales
```

### 🖥️ SysAdmins & SysOps

Mantenimiento del sistema: limpieza de archivos temporales, inspección de configuraciones y archivos grandes.

```bash
fd -e tmp -e temp --changed-before 30d . /tmp --exec rm -v {} \; # Eliminar archivos temporales antiguos
fd -e conf -e cfg -e ini . /etc --list-details                    # Listar archivos de configuración
fd --size +100M . /home --list-details                            # Archivos grandes en /home
fd -e service -e timer . /etc/systemd                             # Unidades de systemd
```

### 🌐 NetOps

Diagnóstico de red: búsqueda de configuraciones y scripts relacionados con interfaces y redes.

```bash
fd "network|net|dns|iptables|ufw" . /etc --extension conf         # Configuraciones de red
fd -e sh -e py "network|bridge|vlan" . /usr/local/bin             # Scripts relacionados con red
fd "interfaces|netplan|route" . /etc                              # Archivos de configuración de interfaces
```

### 👨‍💻 Developers & Programmers

Mantenimiento de código fuente: búsqueda de comentarios técnicos, dependencias y archivos compilados.

```bash
fd -e py -e js -e java -e go "TODO|FIXME|HACK" . /src             # Comentarios técnicos en código
fd "requirements|package\.json|gemfile|pom.xml" .                # Archivos de dependencias
fd -e pyc -e class -e o -e so . --exec rm {} \;                   # Archivos compilados para limpiar
fd -e js "function.*api|const.*config" . /src                    # Funciones y constantes clave en JS
```

### 📊 Data Scientists & Engineers

Gestión de datos: búsqueda de archivos pesados, notebooks y configuraciones de bases de datos.

```bash
fd -e csv -e parquet -e avro --size +1G . /data                  # Archivos de datos grandes
fd -e ipynb "analysis|model|experiment" . /notebooks            # Notebooks de análisis
fd "database|db|postgres|mysql|mongodb" . /etc --extension conf # Configuraciones de bases de datos
fd -e log "pipeline|etl|processing" . /logs                     # Logs de procesamiento de datos
```

### 🧑‍🏫 Principiantes & Usuarios Normales

Búsqueda de archivos personales por tipo o nombre.

```bash
fd "documento|proyecto|tesis" . ~/Documents                     # Documentos importantes
fd -e jpg -e png -e gif -e mp4 . ~/Pictures ~/Videos            # Imágenes y videos
fd -e pdf -e docx -e xlsx -e txt . ~/Downloads                  # Archivos de oficina
fd -e mp3 -e wav -e flac . ~/Music                              # Archivos de audio
```

---

## ⚙️ Características Principales

Demostración de velocidad, filtros por tamaño, profundidad, exclusiones y expresiones regulares.

```bash
time fd "*.conf" . /etc
time find /etc -name "*.conf"
fd -e conf . /etc --list-details
fd --size +100M . /home --list-details
fd -i "database" .
fd --exclude node_modules --exclude vendor .
fd --max-depth 2 "*.conf" /etc
fd "*.tmp" .
fd "café|naïve" .
fd "^config.*\.json$" .
```

---

## 🔌 Integraciones Útiles

Combinación con otras herramientas como `grep`, `fzf`, `xargs`.

```bash
fd -e py . | xargs grep "import pandas"
fd -e js . /src | xargs grep -l "axios"
fd -e conf . /etc | fzf --preview 'cat {}'
fd -e log . /var/log | fzf -m --bind 'enter:execute(less {})'
fd -e log --changed-before 7d . /logs --exec gzip {} \;
fd -e conf . /etc --exec cp {} /backup/ \;
fd -e sh . /scripts --exec chmod +x {} \;
```

---

## 🧩 Configuración Personalizada

Creación de archivo de configuración y alias útiles para uso frecuente.

```bash
mkdir -p ~/.config/fd
fd --generate-config > ~/.config/fd/config.toml
nano ~/.config/fd/config.toml

echo "alias findconf='fd -e conf . /etc --list-details'" >> ~/.bashrc
echo "alias findrecent='fd --changed-within 1d .'" >> ~/.bashrc
echo "alias findlarge='fd --size +100M .'" >> ~/.bashrc
echo "alias findscripts='fd -e sh -e py -e js . /usr/local/bin'" >> ~/.bashrc
source ~/.bashrc
```

---

## 🚀 Consejos de Rendimiento

Optimización de búsquedas en directorios grandes y específicos.

```bash
fd "*.log" . /var/log/app-specific
fd "access_.*\.log" . /var/log/nginx
fd -e log --size +10M --changed-within 7d . /var/log
fd --exclude node_modules --exclude .git "*.js" .
fd --max-depth 3 "*.conf" /etc
fd "*.db" . /var/lib/mysql
```

---

## 🔍 Comparación con `find`

Equivalencias entre `fd` y `find` para tareas comunes.

```bash
# Buscar archivos .conf
fd "*.conf" . /etc
find /etc -name "*.conf"

# Archivos .py mayores a 1MB
fd -e py --size +1M
find -name "*.py" -size +1M

# Listar detalles
fd --list-details
find -ls

# Archivos .tmp
fd "*.tmp" .
find . -name "*.tmp"

# Cambiar permisos
find . -name "*.conf" -exec chmod 644 {} \;

# Logs >10MB y modificados hace más de 30 días
find . -type f -name "*.log" -size +10M -mtime +30

# Archivos con SUID
find /etc -perm -u=s -type f
```

---

## 🔄 Flujos de Trabajo

Comandos encadenados para tareas comunes de mantenimiento y auditoría.

```bash
fd -e conf --changed-within 1d . /etc --list-details
fd -e log --size +50M . /var/log --list-details
fd -e sh . /usr/local/bin --exec bash -c '[[ -x {} ]] && ls -la {}'
fd "password|secret|key" . /etc /home --exec grep -l {} \;
fd -e conf . /etc --exec stat -c "%a %n" {} \;
fd . /usr/bin /usr/sbin --exec bash -c '[[ -u {} || -g {} ]] && ls -la {}'
fd -e pyc -e class -e o -e so . --exec rm {} \;
fd "node_modules|vendor|__pycache__"
