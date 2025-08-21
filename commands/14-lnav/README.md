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

### 🧠 ¡Importante! Cómo Funciona `lnav` (Una Herramienta Interactiva)

A diferencia de `cat` o `grep`, `lnav` es una aplicación de terminal **interactiva y de pantalla completa**.

1.  Cuando ejecutas `lnav`, **tomará el control de toda tu ventana de terminal**. Verás una nueva interfaz con tus logs.
2.  Para interactuar, usa las teclas. Las más importantes para empezar son:
    * **`q`**: Para **Salir** (Quit) de `lnav` y volver a tu terminal normal.
    * **Flechas (↑ ↓)**: Para desplazarte arriba y abajo.
    * **`e`**: Para saltar al siguiente mensaje de **E**rror.
    * **`w`**: Para saltar a la siguiente **W**arning (advertencia).
    * **`;`**: Para abrir el prompt de **SQL**.

### 🎓 Guía de Troubleshooting Avanzado con `lnav` por Rol

---

#### 🛡️ Para el Administrador de Sistemas / SysOps

**Receta: Correlación de Eventos en Todo el Sistema**
* **Objetivo:** Investigar un problema reportado por un usuario sobre una "lentitud del sistema" a una hora específica.
* **El Comando:**
    ```bash
    # Abrimos el directorio completo de logs del sistema
    sudo lnav /var/log
    ```
* **La Acción dentro de `lnav`:**
    1.  Una vez en la interfaz de `lnav`, presiona la tecla `g`. Escribe la hora del incidente (ej: `22:30`) y presiona Enter para saltar a ese momento.
    2.  Presiona `e` o `w` repetidamente para navegar entre los errores y advertencias que ocurrieron alrededor de esa hora.
* **Análisis y Estrategia:** `lnav` te presenta una línea de tiempo única de todo lo que ocurrió en el servidor. Este método te permite ver la "película completa" y encontrar la causa-efecto entre diferentes servicios del sistema.
* **Resultado Esperado:** Verás una interfaz a pantalla completa con todos los logs de `/var/log` fusionados y ordenados por fecha. Podrás navegar y encontrar la causa del problema correlacionando eventos.

---

#### ⚙️ Para el Ingeniero DevOps / DevSecOps

**Receta: Análisis Estructurado de Logs de Aplicación (JSON)**
* **Objetivo:** Encontrar en un log JSON todas las peticiones fallidas (HTTP 5xx) y extraer el `user_id` de cada una.
* **El Comando:**
    > **Nota:** La siguiente ruta es un ejemplo. Deberás reemplazarla con la ruta a tu propio archivo de log. Si no tienes uno, sigue los pasos de prueba.

    ```bash
    lnav /ruta/a/tu/app.json.log
    ```
* **Cómo Probarlo Sin Un Log Real (¡Recomendado!):**
    1.  **Crea un archivo de log de prueba:**
        ```bash
        echo '{"timestamp":"2025-08-21T10:00:00","level":"ERROR","status":500,"user_id":"user-123","trx_id":"abc-xyz"}' > /tmp/test.json.log
        echo '{"timestamp":"2025-08-21T10:01:00","level":"INFO","status":200,"user_id":"user-456","trx_id":"def-uvw"}' >> /tmp/test.json.log
        ```
    2.  **Abre el archivo de prueba con lnav:**
        ```bash
        lnav /tmp/test.json.log
        ```
* **La Acción dentro de `lnav` (SQL Query):**
    1.  Dentro de `lnav`, presiona la tecla `;` para abrir el prompt de SQL.
    2.  Escribe la siguiente consulta y presiona Enter:
    ```sql
    SELECT log_time, json_extract(log_body, '$.user_id') AS user FROM generic_log WHERE json_extract(log_body, '$.status') >= 500;
    ```
* **Análisis y Estrategia:** Usamos el poder de SQL para consultar directamente nuestros logs como si fueran una base de datos, extrayendo (`json_extract`) solo los campos que nos interesan de las entradas que cumplen nuestra condición (`status >= 500`).
* **Resultado Esperado:** Una tabla perfectamente formateada con la hora y el ID de usuario de cada petición fallida.

---

#### 🕵️ Para el Analista de Seguridad / NetOps

**Receta: Detección de Ataques de Fuerza Bruta en SSH**
* **Objetivo:** Identificar las direcciones IP con la mayor cantidad de intentos de login fallidos en las últimas 24 horas.
* **El Comando:**
    ```bash
    # El archivo auth.log debería existir en la mayoría de los sistemas Ubuntu
    sudo lnav /var/log/auth.log
    ```
* **La Acción dentro de `lnav` (SQL Query):**
    Presiona `;` y ejecuta:
    ```sql
    SELECT COUNT(*) AS attempts, client_host FROM sshd_log WHERE log_time > '24 hours ago' AND log_message LIKE 'Failed password for%' GROUP BY client_host ORDER BY attempts DESC LIMIT 10;
    ```
* **Análisis y Estrategia:** `lnav` entiende el formato de `auth.log` y lo parsea. Con SQL, filtramos los mensajes de `Failed password` de las últimas 24 horas (`log_time > '24 hours ago'`), los agrupamos por IP (`GROUP BY client_host`) y obtenemos un "Top 10" de los atacantes.
* **Resultado Esperado:** Una tabla con dos columnas: `attempts` y `client_host`, mostrándote las 10 IPs más persistentes que puedes usar para bloquear en tu firewall.

**Receta 2: Análisis de Tráfico Web (si tienes un servidor web)**
> **Requisito:** Esta receta asume que tienes un servidor web como Nginx o Apache instalado.

* **Objetivo:** Encontrar qué IPs están generando la mayor cantidad de errores en tu servidor web.
* **Comando:** `sudo lnav /var/log/nginx/access.log`
* **Acción SQL:** `;` y luego `SELECT c_ip, COUNT(*) AS errors FROM access_log WHERE sc_status >= 400 GROUP BY c_ip ORDER BY errors DESC LIMIT 10;`
* **Utilidad:** Te da un reporte claro del "Top 10" de IPs que están causando problemas, ideal para alimentar herramientas como `fail2ban`.
