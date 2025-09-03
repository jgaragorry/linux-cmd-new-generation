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

### 🌐 NetOps — Análisis de tráfico web (Nginx)

```bash
sudo lnav /var/log/nginx/access.log
```

Dentro de `lnav`, presiona `;` y ejecuta:

```sql
SELECT c_ip, COUNT(*) AS errors
FROM access_log
WHERE sc_status >= 400
GROUP BY c_ip
ORDER BY errors DESC
LIMIT 10;
```

📊 Resultado: IPs que generan más errores HTTP. Útil para `fail2ban`.

---

## 🧪 Recomendaciones de Prueba

- Usa logs reales en `/var/log` o crea archivos de prueba.
- Resaltado automático: errores en rojo, warnings en amarillo.
- Histograma (`Ctrl-H`) para visualizar picos de actividad.

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
