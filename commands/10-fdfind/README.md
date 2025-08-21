# comando `fdfind` (`fd`)

## 🚀 La Alternativa Moderna a `find`

`fd` (instalado como `fdfind` en Ubuntu) es una alternativa a `find` que es simple, rápida e intuitiva. Está escrita en Rust y optimizada para ser ergonómica y veloz en el uso diario.

### ¿Qué es y por qué es mejor?

-   **Sintaxis Sencilla:** Olvídate de la compleja sintaxis de `find`. `find . -name "*.py"` se convierte en el intuitivo `fdfind --extension py`.
-   **Velocidad Extrema:** Es significativamente más rápido que `find`, especialmente en directorios grandes, gracias a su paralelización.
-   **Inteligente por Defecto:** Ignora automáticamente archivos y directorios ocultos, así como los patrones de tu archivo `.gitignore`. Esto produce resultados más limpios y relevantes sin necesidad de añadir exclusiones complejas.
-   **Uso de Colores:** La salida está coloreada por defecto, facilitando la diferenciación de tipos de archivo.

### Instalación en Ubuntu 24.04 LTS

Está en los repositorios oficiales de Ubuntu, pero el binario se llama `fdfind` para evitar colisión de nombres con otro paquete.

```bash
sudo apt update
sudo apt install -y fd-find
```
**Importante:** El comando a usar es `fdfind`. Se recomienda encarecidamente crear un alias.

### La Sintaxis Correcta: La Clave del Éxito

Entender la sintaxis de `fdfind` es crucial para usarlo correctamente. Su estructura es estricta y lógica:

`fdfind [OPCIONES] <PATRÓN> [RUTA]`

1.  **OPCIONES:** Flags como `--type`, `--extension`, `--changed-within`, etc.
2.  **PATRÓN:** El **nombre** o expresión regular que buscas. **Este campo es obligatorio.**
3.  **RUTA:** El directorio donde quieres buscar. Si se omite, busca en el directorio actual.

> **La Regla de Oro del Punto (`.`):** Si no quieres buscar por un nombre específico (PATRÓN), sino filtrar todos los archivos de una RUTA según ciertas OPCIONES (como tamaño, fecha o extensión), debes usar un punto `.` como PATRÓN comodín.

### Configuración de Alias Permanente (Bash)

Para usar `fdfind` de forma transparente, es casi obligatorio crear un alias.
```bash
alias find='fdfind'
alias fd='fdfind'
```
*Nuestro script `configure_aliases.sh` ya configura `alias find='fdfind'`.*

### 🎓 Guía Práctica: De Tareas Básicas a Recetas Profesionales

Esta guía contiene todos los comandos que hemos probado y verificado. Está organizada de forma progresiva para que domines `fdfind` desde cero.

---

### Parte 1: Fundamentos Esenciales

#### Ejercicio 1: Búsqueda por Extensión (El Pan de Cada Día)

**Objetivo:** Encontrar todos los scripts de Python (`.py`) en el directorio actual.
**Comando:**
```bash
fdfind --extension py .
```
* **Análisis:** Busca (`fdfind`) archivos con la extensión `py` (`--extension py`) en el directorio actual (`.`). Esta es la forma más común y directa de usar la herramienta para encontrar tipos de archivo específicos.

#### Ejercicio 2: Encontrar y Actuar sobre Archivos (Ejecución de Comandos)

**Objetivo:** Tienes un directorio con scripts (`.sh`) y quieres asegurarte de que todos tengan permisos de ejecución.
**Comando:**
```bash
fdfind . --extension sh --exec-batch chmod +x
```
* **Análisis:** Busca (`fdfind`) cualquier archivo (`.`) con la extensión `sh` (`--extension sh`) y ejecuta una sola vez (`--exec-batch`) el comando `chmod +x`, pasándole como argumentos todos los scripts encontrados. Es una forma masiva y eficiente de modificar archivos.

#### Ejercicio 3: Búsqueda por Antigüedad (Auditoría de Cambios)

**Objetivo:** Como SysAdmin, quieres auditar qué archivos de configuración en `/etc` se han modificado en los últimos 2 días.
**Comando:**
```bash
sudo fdfind . --extension conf --changed-within 2d /etc
```
* **Análisis:** Busca (`fdfind`) cualquier archivo (`.`) con la extensión `.conf` que haya cambiado en los últimos 2 días (`--changed-within 2d`), dentro de `/etc`. Es la forma más rápida de auditar cambios recientes en configuraciones críticas. Si no hay salida, significa que ningún archivo cumplió los criterios.

---

### Parte 2: Pipelines y Mantenimiento del Sistema

#### Ejercicio 4: Búsqueda por Tipo y Verificación de Enlaces Rotos

**Objetivo:** Encontrar y verificar todos los enlaces simbólicos rotos en tu directorio personal (`~`).
**Procedimiento Completo (Prueba y Ejecución):**

1.  **Paso de Prueba (Opcional pero recomendado):** Para ver el comando en acción, primero crearemos un enlace roto a propósito.
    ```bash
    # Este comando crea un enlace a un archivo que no existe
    ln -s archivo_que_no_existe.txt enlace_roto
    ```

2.  **Ejecución del Comando de Búsqueda:**
    ```bash
    fdfind . -t l ~ --exec-batch file | grep "broken symbolic link"
    ```
    * **Análisis:** Busca (`fdfind`) cualquier cosa (`.`) que sea un enlace simbólico (`-t l`) en tu home (`~`). Luego, pasa todos los resultados (`--exec-batch`) a la utilidad `file`, y `grep` filtra la salida para mostrar solo los enlaces rotos.

3.  **Limpieza del Archivo de Prueba:**
    ```bash
    rm enlace_roto
    ```
* **Utilidad:** Esta es una tarea de mantenimiento proactiva. Limpiar enlaces rotos previene errores inesperados en scripts y aplicaciones.

---

### Parte 3: Recetas Profesionales para SysAdmin, DevOps y SecOps

Estas recetas resuelven problemas complejos del mundo real, utilizando pipelines robustos y las herramientas adecuadas para cada trabajo.

#### Receta 1: El Detective de Logs (SysOps / DevOps / SecOps)

**Objetivo:** Durante un incidente, encontrar todas las menciones de un ID de error (`TRX-5A8E2C`) en cualquier archivo de log modificado en `/var/log` en las últimas 6 horas, mostrando el contexto.

**Comando:**
```bash
sudo fdfind . -0 --type f --changed-within 6h /var/log | xargs -0 sudo rg --with-filename --context 10 'TRX-5A8E2C'
```
* **Análisis:**
    1. `sudo fdfind ... -0`: Como `root`, encuentra todos los archivos modificados recientemente en `/var/log` y los pasa de forma segura (con delimitador nulo `-0`).
    2. `| xargs -0 sudo rg ...`: `xargs` recibe la lista segura (`-0`) y ejecuta `ripgrep` (`rg`) también con `sudo` (clave para evitar errores de permisos). `rg` busca el ID, mostrando el nombre del archivo y 10 líneas de contexto.
* **Lección Clave:** Los privilegios de `sudo` no se heredan a través de las tuberías (`|`). Cada comando que necesite acceso elevado debe tener su propio `sudo`.

#### Receta 2: Auditor de Seguridad Automatizado (SecOps / SysAdmin)

**Objetivo:** Auditar todos los archivos de configuración de SSH para encontrar si alguno permite el inicio de sesión de `root` y revisar los archivos sospechosos.

**Script Completo:**
```bash
# Paso 1: Usamos un glob (-g) para ser más específicos y robustos
archivos_peligrosos=$(sudo rg --glob 'sshd_config' --glob 'sshd_config.d/*.conf' -l '^\s*PermitRootLogin\s+yes' /etc/ssh/)

# Paso 2: La lógica para revisar y mostrar los hallazgos
if [[ -n "$archivos_peligrosos" ]]; then
    echo "🚨 ¡ADVERTENCIA! Se encontraron archivos con PermitRootLogin activado:"
    echo "$archivos_peligrosos"
    echo "--- Mostrando contenido con resaltado: ---"
    echo "$archivos_peligrosos" | xargs -d '\n' sudo bat
else
    echo "✅ ¡Excelente! No se encontraron configuraciones de SSH inseguras."
fi
```
* **Análisis:** Este script primero usa `ripgrep` con patrones `glob` (`-g`) para buscar de forma fiable la directiva insegura. Si encuentra archivos, los guarda en una variable y luego usa `bat` para mostrártelos de forma legible. Si no, te da una confirmación de que todo está bien.
* **Utilidad:** Automatiza una auditoría de seguridad crítica, identificando y presentándote los puntos de riesgo para una acción inmediata.

#### Receta 3: Forense de Espacio en Disco (SysAdmin / SysOps)

**Objetivo:** Encontrar los 10 archivos más grandes (multimedia, comprimidos) en tu directorio personal (`~`) para liberar espacio.

**Comando:**
```bash
fdfind . -0 --type f -e mov -e mp4 -e zip -e gz -e rar ~ | xargs -0 du -h | sort -rh | head -n 10
```
* **Análisis:**
    1.  `fdfind ... ~`: Busca en tu home (`~`) todos los archivos con las extensiones especificadas.
    2.  `| xargs -0 du -h`: Calcula el tamaño de cada archivo de forma segura.
    3.  `| sort -rh`: Ordena los resultados numéricamente de mayor a menor (la opción `-h` es crucial para que entienda `G` > `M` > `K`).
    4.  `| head -n 10`: Muestra solo el top 10.
* **Utilidad:** Es una herramienta quirúrgica para la gestión de disco. Obtienes un reporte limpio, ordenado y priorizado para tomar decisiones informadas sobre qué borrar.
