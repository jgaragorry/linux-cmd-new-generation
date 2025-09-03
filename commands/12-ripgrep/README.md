# 🔍 ripgrep (`rg`) — Búsqueda ultrarrápida en terminal para archivos y logs

`ripgrep` es una herramienta de búsqueda en texto plano que combina la velocidad de `grep` con la inteligencia de `ack` y la simplicidad de `ag`. Ideal para entornos Linux recién instalados, servidores sin entorno gráfico, y flujos DevOps/SecOps/SRE.

---

## 📦 Instalación en Ubuntu Server 20.04 / 22.04 / 24.04 LTS

```bash
# Actualizar repositorios
sudo apt update

# Instalar ripgrep desde repositorio oficial
sudo apt install ripgrep
```

> ✅ Compatible con TTY, SSH, WSL, y entornos minimalistas sin GUI.

---

## 🧠 ¿Qué hace `ripgrep`?

- Busca texto en archivos y carpetas usando expresiones regulares.
- Ignora automáticamente archivos listados en `.gitignore`, `.ignore`, etc.
- Es extremadamente rápido gracias a su motor en Rust.
- Compatible con UTF-8, binarios, y múltiples formatos.

---

## 🧑‍💻 Segmentación por rol técnico (con rutas reales en sistemas recién instalados)

### 🖥️ SysOps — Auditoría de logs del sistema

```bash
# Buscar errores en el log principal del sistema
rg "error" /var/log/syslog

# Buscar fallos de autenticación
rg "Failed password" /var/log/auth.log

# Buscar eventos de montaje de disco
rg "EXT4-fs" /var/log/kern.log
```

### 🌐 NetOps — Validación de configuración de red

```bash
# Buscar configuración de interfaces
rg "iface" /etc/network/interfaces

# Buscar reglas en resolv.conf
rg "nameserver" /etc/resolv.conf
```

### 🛡️ SecOps — Detección de accesos sospechosos

```bash
# Buscar intentos de acceso por SSH
rg "Accepted password" /var/log/auth.log

# Buscar comandos ejecutados por sudo
rg "COMMAND=" /var/log/syslog
```

### 🔧 DevOps — Validación de servicios y procesos

```bash
# Buscar fallos en servicios systemd
rg "failed" /var/log/syslog

# Buscar errores en journald (si está habilitado)
journalctl | rg "error"
```

### 🚀 SRE — Diagnóstico de rendimiento y errores

```bash
# Buscar timeouts en logs del sistema
rg "timeout" /var/log/syslog

# Buscar eventos de remount por errores
rg "errors=remount-ro" /var/log/kern.log
```

---

## ⚙️ Uso básico

```bash
# Buscar "error" en todos los archivos del directorio actual
rg error

# Buscar IPs en archivos de configuración
rg -e '\b\d{1,3}(\.\d{1,3}){3}\b' /etc/

# Buscar en archivos ocultos y sin respetar .gitignore
rg --no-ignore --hidden "token"
```

---

## 📘 Opciones útiles

| Opción              | Descripción                                           |
|---------------------|-------------------------------------------------------|
| `-i`                | Búsqueda insensible a mayúsculas                      |
| `-w`                | Coincidencia exacta de palabra                        |
| `-n`                | Muestra número de línea                               |
| `--color always`    | Fuerza color en salida                                |
| `--files`           | Lista todos los archivos que serían buscados          |
| `-g '*.log'`        | Filtra por extensión de archivo                       |
| `--hidden`          | Incluye archivos ocultos                              |
| `--no-ignore`       | Ignora `.gitignore` y similares                       |

---

## 🧪 Ejemplos reproducibles en sistemas recién instalados

```bash
# Buscar errores en logs del sistema
rg "error" /var/log/syslog

# Buscar eventos de autenticación fallida
rg "authentication failure" /var/log/auth.log

# Buscar configuraciones de red
rg "dhcp" /etc/netplan/*.yaml

# Buscar eventos del kernel relacionados con disco
rg "EXT4-fs" /var/log/kern.log

# Buscar comandos ejecutados con sudo
rg "COMMAND=" /var/log/syslog
```

> 🧠 Todos estos ejemplos funcionan en Ubuntu Server recién instalado, sin necesidad de configurar rutas adicionales ni instalar software extra.

---

## ✅ Ventajas clave

- 🔥 Velocidad extrema en búsquedas recursivas
- 🧠 Inteligencia para ignorar archivos irrelevantes
- 🎯 Precisión con expresiones regulares
- 🧩 Integración perfecta en scripts y pipelines
- 🧵 Compatible con TTY, SSH y entornos minimalistas

---

## 📚 Recursos adicionales

- [Repositorio oficial](https://github.com/BurntSushi/ripgrep)
- [Documentación extendida](https://github.com/BurntSushi/ripgrep/blob/master/README.md)
- [Comparativa con grep/ag/ack](https://blog.burntsushi.net/ripgrep/)

---

> 🧠 Este README está diseñado para onboarding técnico, defensibilidad en auditorías y enseñanza por rol. Puedes clonarlo como plantilla para tu biblioteca de documentación reproducible.
