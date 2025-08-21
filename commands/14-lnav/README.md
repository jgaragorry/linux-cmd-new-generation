# comando `lnav`

## 🚀 La Alternativa Moderna a `tail`, `less` y `grep` para Logs

`lnav` (Log File Navigator) es una herramienta avanzada para visualizar y analizar archivos de log. Va mucho más allá de simplemente mostrar texto; entiende el formato de los logs.

### ¿Qué es y por qué es mejor?

-   **Unión de Archivos:** Abre múltiples archivos de log y los presenta en una única vista, ordenados por fecha y hora. ¡Se acabó el cambiar entre terminales para seguir diferentes logs!
-   **Detección Automática de Formato:** Reconoce formatos comunes de log (syslog, Apache, etc.) y los estructura, permitiendo una mejor navegación y análisis.
-   **Resaltado de Sintaxis:** Colorea los logs según la severidad (errores en rojo, warnings en amarillo), además de resaltar palabras clave, IPs, etc.
-   **Filtrado Interactivo:** Permite filtrar los logs en tiempo real (tanto para incluir como para excluir líneas).
-   **Consultas SQL:** ¡Puedes ejecutar consultas SQL directamente sobre tus logs! (`SELECT * FROM apache_log WHERE sc_status >= 500`).
-   **Vistas de Histograma:** Genera histogramas para visualizar la distribución de mensajes a lo largo del tiempo.

### Instalación en Ubuntu 24.04 LTS

`lnav` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y lnav
```

### Sintaxis Básica

```
lnav [OPCIONES] [RUTA_A_LOS_LOGS]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario, pero para leer logs del sistema (como los de `/var/log`) necesitará `sudo`.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-t`             | Añade una marca de tiempo a las líneas leídas de la entrada estándar.       |
| `-i`             | Instala formatos de log adicionales desde un archivo.                       |
| `-c`             | Ejecuta un comando o consulta SQL al iniciar.                               |
| `-n`             | No abre los archivos de log por defecto (modo "headless").                  |

### Configuración de Alias Permanente (Bash)

No se recomienda un alias, ya que `lnav` es una herramienta de análisis profundo, no un reemplazo directo para `tail` o `less`.

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Diagnóstico de un Problema de Acceso al Servidor

**Tarea:** Un usuario no puede iniciar sesión vía SSH. Necesitas correlacionar los logs de autenticación con los logs generales del sistema para entender qué está pasando.

**Comando:**
```bash
# lnav abrirá y fusionará ambos archivos en una vista cronológica
sudo lnav /var/log/auth.log /var/log/syslog
```
**Utilidad:** Verás los intentos de conexión del `auth.log` intercalados con los mensajes del `syslog` en el momento exacto en que ocurrieron. Esto te puede revelar si un problema del sistema (ej: un error de disco) está ocurriendo justo antes del fallo de autenticación, algo que sería muy difícil de ver mirando los archivos por separado.

#### Ejercicio 2: Encontrar Todos los Errores 500 en un Log de Acceso Web

**Tarea:** La monitorización ha detectado errores en tu aplicación web. Necesitas encontrar todas las peticiones que resultaron en un código de estado 5xx (Error del Servidor) en el log de acceso de Apache o Nginx.

**Comando:**
```bash
# Abre el log con lnav
sudo lnav /var/log/apache2/access.log

# Una vez dentro, presiona ';' para abrir la línea de comandos SQL y ejecuta:
# SELECT * FROM log_text WHERE log_body LIKE '% 5__ %'
# O, si el formato es reconocido:
# SELECT * FROM apache_log WHERE sc_status >= 500
```
**Utilidad:** La capacidad de usar SQL transforma tus logs de texto plano en una base de datos consultable. Puedes hacer agregaciones (`COUNT(*)`), filtrar por IP (`WHERE c_ip = '...'`), y realizar análisis complejos que serían imposibles con `grep`.

#### Ejercicio 3: Crear una Vista en Tiempo Real de Errores y Advertencias

**Tarea:** Quieres una ventana de terminal que te muestre, en tiempo real, solo las líneas que contienen "ERROR" o "WARNING" de todos los logs de tu aplicación.

**Comando:**
```bash
# Abre todos los logs del directorio de tu aplicación
sudo lnav /var/log/mi_aplicacion/*.log

# Una vez dentro, presiona 'i' para entrar al modo de filtrado interactivo
# Escribe: error|warn
# lnav filtrará y mostrará solo las líneas que coincidan, actualizándose en tiempo real.
```
**Utilidad:** Esto crea un "dashboard de problemas" en vivo. Mientras tu aplicación corre, esta ventana solo se actualizará cuando ocurra algo que requiera tu atención, eliminando el ruido de los logs informativos y permitiéndote reaccionar a los problemas al instante.
