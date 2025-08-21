# comando `lnav`

## 🚀 El Navegador de Logs Avanzado para la Terminal

`lnav` (Log File Navigator) es mucho más que un simple visor de logs. Es una herramienta de análisis y troubleshooting interactiva que transforma tus archivos de log de texto plano en una base de datos estructurada y consultable en tiempo real.

### ¿Qué es y por qué es mejor?

-   **Unificación Automática:** Su superpoder. `lnav` puede abrir múltiples archivos o un directorio entero (como `/var/log`), detectar sus formatos y fusionarlos en una **única vista ordenada cronológicamente**. Se acabó el `tail -f` en 5 ventanas distintas.
-   **Comprensión de Formatos:** Reconoce docenas de formatos de log comunes (syslog, logs de acceso web, JSON, etc.) y los analiza en campos estructurados, permitiendo un filtrado y análisis mucho más profundo.
-   **Consultas SQL:** Su característica más potente. Te permite ejecutar consultas SQL directamente sobre tus archivos de log para agregar, filtrar y correlacionar datos de formas que serían imposibles con `grep` y `awk`.
-   **Vistas Avanzadas:** Ofrece una vista de histograma para detectar picos de actividad, resaltado de sintaxis automático (errores en rojo, warnings en amarillo) y filtrado interactivo.

### Instalación en Ubuntu 24.04 LTS

`lnav` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y lnav
```

### 🎓 Guía de Troubleshooting Avanzado con `lnav` por Rol

`lnav` es una herramienta de diagnóstico. Las siguientes recetas muestran cómo diferentes roles pueden usarla para resolver problemas complejos rápidamente.

---

#### 🛡️ Para el Administrador de Sistemas / SysOps

*Tu misión es mantener la salud del sistema. Necesitas correlacionar eventos de diferentes servicios para entender la causa raíz de un problema.*

**Receta: Correlación de Eventos en Todo el Sistema**
* **Objetivo:** Un usuario reporta que "el sistema se sintió lento anoche, sobre las 22:30". Necesitas investigar qué estaba pasando en todo el servidor en ese preciso momento.
* **El Comando:**
    ```bash
    # Abrimos el directorio completo de logs del sistema
    sudo lnav /var/log
    ```
* **La Acción dentro de `lnav`:**
    1.  Una vez dentro, presiona la tecla `g`. Se abrirá un cuadro para "Ir a la fecha". Escribe `22:30` y presiona Enter. `lnav` saltará instantáneamente a esa hora en la vista de logs fusionada.
    2.  Presiona la tecla `e` para saltar al siguiente error (en rojo) o `w` para saltar a la siguiente advertencia (en amarillo) a partir de ese punto.
* **Análisis y Estrategia:**
    * `lnav` te presenta una línea de tiempo única de todo lo que ocurrió en el servidor. Al saltar a las 22:30, puedes ver si un error en `syslog` coincide con un pico de actividad en `auth.log` o un problema en `kern.log`.
    * Este método te permite ver la "película completa" en lugar de fotogramas aislados. Es la forma más rápida de encontrar la causa-efecto entre diferentes componentes del sistema.
* **Resultado Esperado:** Una vista cronológica de todos los logs. Al navegar con `e` y `w`, podrás identificar rápidamente cualquier evento anómalo (ej: un `CRON` fallido, un error de disco, un pico de logins) que ocurrió alrededor de la hora del incidente.

---

#### ⚙️ Para el Ingeniero DevOps / DevSecOps

*Tu mundo son las aplicaciones, los microservicios y los logs estructurados (JSON). Necesitas una forma de analizar y depurar el comportamiento de tus aplicaciones.*

**Receta: Análisis Estructurado de Logs de Aplicación (JSON)**
* **Objetivo:** Tu microservicio de pagos está generando errores HTTP 500. Los logs están en formato JSON. Necesitas encontrar todas las peticiones fallidas y extraer el `user_id` y el `transaction_id` de cada una para notificar a los usuarios afectados.
* **El Comando:**
    ```bash
    # Apunta lnav al log de tu aplicación
    lnav /var/log/mi_aplicacion/payments.json.log
    ```
* **La Acción dentro de `lnav`:**
    1.  `lnav` detectará automáticamente el formato JSON.
    2.  Presiona la tecla `;` para abrir el prompt de SQL en la parte inferior.
    3.  Escribe la siguiente consulta y presiona Enter:
    ```sql
    SELECT log_time, json_extract(log_body, '$.user_id') AS user, json_extract(log_body, '$.transaction_id') AS trx_id FROM generic_log WHERE log_body LIKE '%"status":5__%';
    ```
* **Análisis y Estrategia:**
    * En lugar de usar `grep` y `jq` en un pipeline complejo, usamos el poder de SQL directamente en la terminal.
    * `FROM generic_log`: `lnav` carga los logs en una tabla virtual.
    * `WHERE log_body LIKE '%"status":5__%'`: Filtramos para encontrar solo las líneas que contienen un código de estado 5xx.
    * `json_extract(...)`: Usamos la función de SQL para extraer valores específicos de las claves (`user_id`, `transaction_id`) dentro del cuerpo del JSON.
* **Resultado Esperado:** Obtendrás una tabla perfectamente formateada que contiene la hora, el ID de usuario y el ID de transacción de cada una de las peticiones fallidas. Es un reporte listo para ser exportado y utilizado.

---

#### 🕵️ Para el Analista de Seguridad / NetOps

*Tu trabajo es monitorear el tráfico, detectar anomalías y responder a amenazas. Los logs de acceso y de autenticación son tu principal fuente de inteligencia.*

**Receta 1: Detección de Ataques de Fuerza Bruta en SSH**
* **Objetivo:** Sospechas que alguien está intentando acceder por fuerza bruta a tu servidor SSH. Necesitas identificar las direcciones IP con la mayor cantidad de intentos de login fallidos.
* **El Comando:**
    ```bash
    sudo lnav /var/log/auth.log
    ```
* **La Acción dentro de `lnav` (SQL Query):**
    Presiona `;` y ejecuta:
    ```sql
    SELECT COUNT(*) AS attempts, client_host FROM sshd_log WHERE log_message LIKE 'Failed password for%' GROUP BY client_host ORDER BY attempts DESC LIMIT 10;
    ```
* **Análisis y Estrategia:**
    * `lnav` reconoce el formato del `auth.log` y lo carga en una tabla `sshd_log`.
    * Filtramos los mensajes de `Failed password` y luego `GROUP BY client_host` para agrupar los intentos por dirección IP.
    * `ORDER BY attempts DESC LIMIT 10` nos da un "Top 10" de los atacantes.
* **Resultado Esperado:** Una tabla con dos columnas: `attempts` y `client_host`, mostrándote las 10 IPs más persistentes que puedes usar para bloquear en tu firewall.

**Receta 2: Análisis de Tráfico Web Anómalo**
* **Objetivo:** Encontrar qué direcciones IP están generando la mayor cantidad de errores (4xx, 5xx) en tu servidor web Nginx y cuánto ancho de banda están consumiendo en esas peticiones fallidas.
* **El Comando:**
    ```bash
    sudo lnav /var/log/nginx/access.log
    ```
* **La Acción dentro de `lnav` (SQL Query):**
    Presiona `;` y ejecuta:
    ```sql
    SELECT c_ip, COUNT(*) AS errors, SUM(sc_bytes) AS total_bytes FROM access_log WHERE sc_status >= 400 GROUP BY c_ip ORDER BY errors DESC LIMIT 10;
    ```
* **Análisis y Estrategia:**
    * `lnav` parsea `access.log` en una tabla con columnas como `c_ip` (IP del cliente), `sc_status` (código de estado) y `sc_bytes` (tamaño de la respuesta).
    * Filtramos por códigos de estado `WHERE sc_status >= 400` (errores del cliente y del servidor).
    * Agrupamos por IP (`GROUP BY c_ip`) y usamos funciones de agregación como `COUNT(*)` (para contar los errores) y `SUM(sc_bytes)` (para sumar el consumo de ancho de banda).
* **Resultado Esperado:** Un reporte claro del "Top 10" de IPs que están causando problemas en tu servidor web, ideal para alimentar herramientas de seguridad como `fail2ban` o para investigar posibles ataques a tu aplicación.
