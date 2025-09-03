# 🧠 Comando `lnav` — Log File Navigator

## 📌 Descripción General
`lnav` (Log File Navigator) es una herramienta interactiva para visualizar, analizar y consultar archivos de log directamente desde la terminal. Convierte logs planos en una base de datos estructurada y navegable en tiempo real, con soporte para SQL, resaltado de errores y vistas cronológicas.

---

## 🧰 Instalación en Ubuntu Server 20.04 / 24.04 LTS

```bash
sudo apt update
sudo apt install -y lnav
```

✅ Disponible en los repositorios oficiales. No requiere entorno gráfico.

---

## 🧑‍💻 Uso Básico

```bash
lnav /var/log
```

🔎 Abre todos los archivos dentro de `/var/log`, detecta sus formatos y los fusiona en una vista cronológica interactiva.

---

## 🧭 Navegación Interactiva

| Tecla | Acción |
|-------|--------|
| `q`   | Salir de lnav |
| `↑ ↓` | Desplazarse entre líneas |
| `e`   | Saltar al siguiente error |
| `w`   | Saltar al siguiente warning |
| `;`   | Abrir el prompt SQL |
| `g`   | Ir a una hora específica |

---

## 🔍 Segmentación por Rol Técnico

### 🖥️ SysOps — Correlación de eventos del sistema

```bash
sudo lnav /var/log
```

1. Presiona `g`, escribe `22:30`, Enter.
2. Usa `e` y `w` para navegar entre errores y advertencias.

📈 Resultado: Línea de tiempo completa del sistema para investigar incidentes.

---

### 🔧 DevOps — Análisis estructurado de logs JSON

```bash
echo '{"timestamp":"2025-08-21T10:00:00","level":"ERROR","status":500,"user_id":"user-123"}' > /tmp/test.json.log
echo '{"timestamp":"2025-08-21T10:01:00","level":"INFO","status":200,"user_id":"user-456"}' >> /tmp/test.json.log
lnav /tmp/test.json.log
```

Dentro de `lnav`, presiona `;` y ejecuta:

```sql
SELECT log_time, json_extract(log_body, '$.user_id') AS user
FROM generic_log
WHERE json_extract(log_body, '$.status') >= 500;
```

📊 Resultado: Tabla con hora e ID de usuario de cada error HTTP 5xx.

---

### 🛡️ SecOps — Detección de fuerza bruta en SSH

```bash
sudo lnav /var/log/auth.log
```

Dentro de `lnav`, presiona `;` y ejecuta:

```sql
SELECT COUNT(*) AS attempts, client_host
FROM sshd_log
WHERE log_time > '24 hours ago'
  AND log_message LIKE 'Failed password for%'
GROUP BY client_host
ORDER BY attempts DESC
LIMIT 10;
```

📊 Resultado: Top 10 IPs con más intentos fallidos.

---

### 🌐 NetOps — Análisis de tráfico web (simulado)

```bash
cat <<EOF > /tmp/fake-access.log
127.0.0.1 - - [03/Sep/2025:18:00:00 +0000] "GET /index.html HTTP/1.1" 200 1024
192.168.1.10 - - [03/Sep/2025:18:01:00 +0000] "POST /login HTTP/1.1" 403 512
10.0.0.5 - - [03/Sep/2025:18:02:00 +0000] "GET /admin HTTP/1.1" 500 256
EOF

lnav /tmp/fake-access.log
```

Dentro de `lnav`, presiona `;` y ejecuta:

```sql
SELECT c_ip, COUNT(*) AS errores
FROM access_log
WHERE sc_status >= 400
GROUP BY c_ip
ORDER BY errores DESC;
```

📊 Resultado: IPs que generan errores HTTP. Útil para detección temprana sin necesidad de Nginx.

---

## 🧪 Ejemplos Reproducibles Validados

Esta sección incluye ejemplos funcionales probados en sistemas reales, sin dependencias externas adicionales. Cada uno está diseñado para onboarding rápido, demostraciones en vivo y validación de funcionalidades clave de `lnav`.

---

### ✅ Ejemplo 1: Visualizar logs del sistema en tiempo real

```bash
sudo lnav /var/log/syslog
```

🔧 **Uso**: Monitorear eventos del sistema conforme ocurren.

🎯 **Resultado**:
- Vista cronológica interactiva.
- Navegación por hora (`g`), búsqueda (`/`), y salto a errores (`e`).
- Resaltado automático de errores y advertencias.

🧠 Ideal para SysOps y DevOps durante incidentes o auditorías.

---

### ✅ Ejemplo 3 (Alternativo): Simular log de acceso web y detectar errores HTTP

```bash
cat <<EOF > /tmp/fake-access.log
127.0.0.1 - - [03/Sep/2025:18:00:00 +0000] "GET /index.html HTTP/1.1" 200 1024
192.168.1.10 - - [03/Sep/2025:18:01:00 +0000] "POST /login HTTP/1.1" 403 512
10.0.0.5 - - [03/Sep/2025:18:02:00 +0000] "GET /admin HTTP/1.1" 500 256
EOF

lnav /tmp/fake-access.log
```

🔧 **Uso**: Simular tráfico web y detectar errores sin instalar Nginx.

🎯 **Resultado**:
- `lnav` detecta el formato tipo Apache.
- Ejecuta SQL para identificar IPs con errores:

```sql
SELECT c_ip, COUNT(*) AS errores
FROM access_log
WHERE sc_status >= 400
GROUP BY c_ip
ORDER BY errores DESC;
```

🧠 Útil para NetOps y DevOps en entornos sin servidor web.

---

### ✅ Ejemplo 4: Detectar fuerza bruta en intentos SSH

```bash
sudo lnav /var/log/auth.log
```

🔧 **Uso**: Identificar IPs con múltiples intentos fallidos de login.

🎯 **Resultado**:
- Navegación por eventos de autenticación.
- Consulta SQL para detectar patrones de ataque:

```sql
SELECT client_host, COUNT(*) AS intentos
FROM sshd_log
WHERE log_message LIKE 'Failed password%'
GROUP BY client_host
ORDER BY intentos DESC;
```

🧠 Clave para SecOps en detección temprana de amenazas.

---

## 🧩 Comparación con Herramientas Tradicionales

| Herramienta     | Limitación                  | Ventaja de `lnav`                    |
|------------------|-----------------------------|--------------------------------------|
| `cat` / `less`   | No estructuran              | `lnav` parsea y ordena               |
| `grep` / `awk`   | No correlacionan            | `lnav` permite SQL                   |
| `tail -f`        | Vista fragmentada           | `lnav` unifica múltiples fuentes     |

---

## ✅ Ventajas Clave

- 🔍 Unificación automática de múltiples logs
- 🧠 Reconocimiento de formatos comunes (syslog, JSON, Apache, etc.)
- 🧩 Consultas SQL sobre logs en tiempo real
- 📊 Vistas cronológicas e interactivas
- 🧵 Compatible con TTY, SSH y entornos minimalistas

---

## 📚 Recursos Adicionales

- [Repositorio oficial del comando lnav](https://github.com/jgaragorry/linux-cmd-new-generation/tree/main/commands/14-lnav)
- [Sitio oficial del proyecto lnav](https://lnav.org)
- [Documentación extendida y ejemplos](https://github.com/tstack/lnav)

---

> 🧠 Este README está diseñado para onboarding técnico, defensibilidad en auditorías y enseñanza por rol. Puedes clonarlo como plantilla para tu biblioteca de documentación reproducible.
