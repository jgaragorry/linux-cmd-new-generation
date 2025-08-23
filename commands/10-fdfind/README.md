# Comando `fdfind` (`fd`)

`fd` es una alternativa moderna y eficiente al comando `find`, diseñada para facilitar búsquedas en el sistema de archivos con una sintaxis más intuitiva y rápida.

---

## 🛠️ Instalación

```bash
sudo apt update
sudo apt install -y fd-find
echo "alias fd='fdfind'" >> ~/.bashrc
source ~/.bashrc
```

---

## 👤 Comandos por Perfil Técnico

### 🔧 DevOps & SRE

```bash
fd -e conf --changed-within 1d . /etc
fd -e sh -e py "deploy|script|ansible" . /opt
fd -e log --size +10M . /var/log
fd --changed-within 2h . /jenkins/workspace
```

### 🔐 DevSecOps & SecOps

```bash
fd "password|secret|key|token" . /etc --exec grep -l {} \;
fd . / --exec bash -c '[[ -f {} && -w {} ]] && ls -la {}'
fd . / --exec bash -c '[[ -u {} ]] && echo "SUID: {}"'
fd -e sh -e py "\.|hidden" . /tmp /dev/shm
```

### 🖥️ SysAdmins & SysOps

```bash
fd -e tmp -e temp --changed-before 30d . /tmp --exec rm -v {} \;
fd -e conf -e cfg -e ini . /etc --list-details
fd --size +100M . /home --list-details
fd -e service -e timer . /etc/systemd
```

### 🌐 NetOps

```bash
fd "network|net|dns|iptables|ufw" . /etc --extension conf
fd -e sh -e py "network|bridge|vlan" . /usr/local/bin
fd "interfaces|netplan|route" . /etc
```

### 👨‍💻 Developers & Programmers

```bash
fd -e py -e js -e java -e go "TODO|FIXME|HACK" . /src
fd "requirements|package\.json|gemfile|pom.xml" .
fd -e pyc -e class -e o -e so . --exec rm {} \;
fd -e js "function.*api|const.*config" . /src
```

### 📊 Data Scientists & Engineers

```bash
fd -e csv -e parquet -e avro --size +1G . /data
fd -e ipynb "analysis|model|experiment" . /notebooks
fd "database|db|postgres|mysql|mongodb" . /etc --extension conf
fd -e log "pipeline|etl|processing" . /logs
```

### 🧑‍🏫 Principiantes & Usuarios Normales

```bash
fd "documento|proyecto|tesis" . ~/Documents
fd -e jpg -e png -e gif -e mp4 . ~/Pictures ~/Videos
fd -e pdf -e docx -e xlsx -e txt . ~/Downloads
fd -e mp3 -e wav -e flac . ~/Music
```

---

## ⚙️ Características Principales

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

```bash
fd -e conf --changed-within 1d . /etc --list-details
fd -e log --size +50M . /var/log --list-details
fd -e sh . /usr/local/bin --exec bash -c '[[ -x {} ]] && ls -la {}'
fd "password|secret|key" . /etc /home --exec grep -l {} \;
fd -e conf . /etc --exec stat -c "%a %n" {} \;
fd . /usr/bin /usr/sbin --exec bash -c '[[ -u {} || -g {} ]] && ls -la {}'
fd -e pyc -e class -e o -e so . --exec rm {} \;
fd "node_modules|vendor|__pycache__" . --exec rm -rf {} \;
fd -e log --changed-before 7d . /tmp --exec rm {} \;
```

---

## 📌 Notas Importantes

```bash
sudo fd -e conf . /etc
sudo fd -e log . /var/log --exec ls -la {} \;
fd --max-depth 1 . /mnt/nas-share
fd "*.db" . /var/lib/mysql
fd . /
fd "*.log" . /var/log/specific-app
```
