# 🔍 ripgrep — Búsqueda ultrarrápida en terminal para archivos y código

`ripgrep` (`rg`) es una herramienta moderna de búsqueda en texto plano que combina la velocidad de `grep` con la inteligencia de `ack` y la simplicidad de `ag` (Silver Searcher). Está diseñada para entornos técnicos donde se requiere velocidad, precisión y compatibilidad con expresiones regulares.

---

## 📦 Instalación en Ubuntu Server 20.04 / 24.04 LTS (TTY)

```bash
# Actualizar repositorios
sudo apt update

# Instalar ripgrep desde repositorio oficial
sudo apt install ripgrep
```

> ✅ No requiere entorno gráfico. Funciona perfectamente en TTY, SSH y terminales minimalistas.

---

## 🧠 ¿Qué hace `ripgrep`?

- Busca texto en archivos y carpetas usando expresiones regulares.
- Ignora automáticamente archivos listados en `.gitignore`, `.ignore`, etc.
- Es extremadamente rápido gracias a su motor basado en Rust (`regex` + `grep` + `walkdir`).
- Compatible con UTF-8, binarios, y múltiples formatos.

---

## 🔄 ¿A quién reemplaza?

| Herramienta       | ¿Qué hacía?                  | ¿Qué mejora `ripgrep`?                                      |
|-------------------|------------------------------|--------------------------------------------------------------|
| `grep`            | Búsqueda básica en texto     | Mucho más rápido, ignora archivos ocultos, mejor UX         |
| `ack`             | Búsqueda en código fuente    | Más rápido, menos dependencias                              |
| `ag` (Silver Searcher) | Búsqueda rápida en proyectos | Mejor soporte de expresiones regulares y binarios           |
| `find + grep`     | Búsqueda recursiva           | `rg` lo hace en un solo paso, más eficiente                 |

---

## 🧑‍💻 Segmentación por rol técnico

### 🖥️ SysOps
- Auditoría de logs del sistema
- Búsqueda de errores en `/var/log`
- Validación de configuraciones en `/etc`

### 🌐 NetOps
- Búsqueda de IPs, MACs o patrones en archivos de configuración de red
- Validación de reglas en `iptables`, `nftables`, `dnsmasq`, etc.

### 🛡️ SecOps
- Detección de patrones sospechosos en logs
- Búsqueda de indicadores de compromiso (IOCs)
- Validación de firmas en archivos de reglas (Snort, Suricata)

### 🔧 DevOps
- Búsqueda de variables en `.env`, YAML, JSON
- Validación de pipelines, CI/CD, Terraform, Ansible
- Refactorización de configuraciones en múltiples repositorios

### 🚀 SRE
- Detección de errores en logs de producción
- Validación de trazas en sistemas distribuidos
- Búsqueda de métricas o eventos en archivos de monitoreo

---

## ⚙️ Uso básico

```bash
# Buscar "error" en todos los archivos del directorio actual
rg error

# Buscar IPs en archivos de configuración
rg -e '\b\d{1,3}(\.\d{1,3}){3}\b' /etc/

# Buscar "timeout" en archivos .log ignorando binarios
rg timeout --type log

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
| `--type <tipo>`     | Filtra por tipo de archivo (`html`, `log`, `py`, etc.)|
| `--ignore-case`     | Ignora mayúsculas/minúsculas                          |
| `--hidden`          | Incluye archivos ocultos                              |
| `--no-ignore`       | Ignora `.gitignore` y similares                       |

---

## 🧪 Ejemplos prácticos por perfil

### 🖥️ SysOps — Buscar errores en logs del sistema

```bash
rg "error" /var/log/syslog
```

### 🌐 NetOps — Validar reglas de firewall

```bash
rg "DROP" /etc/iptables/rules.v4
```

### 🛡️ SecOps — Detectar accesos sospechosos

```bash
rg "Accepted password" /var/log/auth.log
```

### 🔧 DevOps — Verificar uso de variables en YAML

```bash
rg "DB_PASSWORD" ./config/*.yml
```

### 🚀 SRE — Buscar trazas de timeout en producción

```bash
rg "timeout" /var/log/app/*.log
```

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
