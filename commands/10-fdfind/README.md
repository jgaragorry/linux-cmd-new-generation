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

Tras nuestra experiencia, hemos aprendido que entender la sintaxis de `fdfind` es crucial. Su estructura es estricta y lógica:

`fdfind [OPCIONES] <PATRÓN> [RUTA]`

1.  **OPCIONES:** Flags como `--type`, `--extension`, `--changed-within`, etc.
2.  **PATRÓN:** El **nombre** o expresión regular que buscas. **Este campo es obligatorio.**
3.  **RUTA:** El directorio donde quieres buscar. Si se omite, busca en el directorio actual.

> **La Regla de Oro del Punto (`.`):** Si no quieres buscar por un nombre específico (PATRÓN), sino filtrar todos los archivos de una RUTA según ciertas OPCIONES (como tamaño, fecha o extensión), debes usar un punto `.` como PATRÓN comodín. Este fue el aprendizaje clave de nuestros ejercicios.

### ¿Quién puede ejecutarlo?

Cualquier usuario del sistema. Para buscar en directorios protegidos como `/etc` o `/var`, necesitarás usar `sudo`.

### Argumentos y Opciones Clave

| Opción | Alias | Descripción |
| :--- | :--- | :--- |
| `--type` | `-t` | Busca por tipo: `f` (fichero), `d` (directorio), `l` (enlace simbólico). |
| `--extension` | `-e` | Busca por extensión de archivo (sin el punto). |
| `--exec` | `-x` | Ejecuta un comando por cada resultado encontrado. |
| `--exec-batch` | `-X` | Ejecuta un comando una sola vez, pasándole todos los resultados. |
| `--changed-within` | | Busca archivos modificados **dentro** del marco de tiempo (ej: `2d`). |
| `--changed-before` | | Busca archivos modificados **antes** del marco de tiempo (ej: `90d`). |
| `--print0` | `-0` | Separa los resultados con un carácter nulo, para pipelines robustos. |

### Configuración de Alias Permanente (Bash)

Para usar `fdfind` de forma transparente, es casi obligatorio crear un alias.
```bash
alias find='fdfind'
alias fd='fdfind'
```
*Nuestro script `configure_aliases.sh` ya configura `alias find='fdfind'`.*

### 🎓 Ejercicios Prácticos: De Básico a Profesional

Estos ejercicios están verificados en Ubuntu 24.04 y están diseñados para resolver tareas reales, incorporando todo lo que hemos aprendido.

---

#### Ejercicio 1: Búsqueda por Antigüedad (Auditoría de Cambios)

**Objetivo:** Como SysAdmin, quieres auditar qué archivos de configuración en `/etc` se han modificado en los últimos 2 días.

**Comando:**
```bash
sudo fdfind . --extension conf --changed-within 2d /etc
```
* **¿Qué hace?** Busca (`fdfind`) cualquier archivo (`.`) con la extensión `.conf` (`--extension conf`) que haya cambiado en los últimos 2 días (`--changed-within 2d`), dentro del directorio `/etc`.
* **¿Por qué usarlo?** Es la forma más rápida y limpia de auditar cambios recientes en configuraciones críticas, ya sea por mantenimiento, actualizaciones o por motivos de seguridad.
* **Resultado Esperado:** Una lista de los archivos `.conf` modificados recientemente. Si no hay salida, significa que la búsqueda fue exitosa y ningún archivo cumplió los criterios.

---

#### Ejercicio 2: Búsqueda por Tipo y Ejecución de Comandos (Mantenimiento)

**Objetivo:** Encontrar todos los enlaces simbólicos rotos en tu directorio personal (`~`), que pueden causar errores en scripts.

**Comando:**
```bash
fdfind . -t l ~ --exec-batch file | grep "broken symbolic link"
```
* **¿Qué hace?** Busca (`fdfind`) cualquier cosa (`.`) que sea un enlace simbólico (`-t l`) en tu home (`~`). Luego, pasa todos los resultados de una vez (`--exec-batch`) a la utilidad `file`, que los analiza. Finalmente, `grep` filtra la salida de `file` para mostrar solo los enlaces que están rotos.
* **¿Por qué usarlo?** Es una tarea de mantenimiento proactiva. Limpiar enlaces rotos previene errores inesperados. La opción `--exec-batch` es mucho más eficiente que `--exec` si tienes miles de archivos.
* **Resultado Esperado:** Una lista de los enlaces rotos y a dónde apuntaban. Si no hay salida, significa que tu sistema está limpio de enlaces simbólicos rotos en esa ubicación.

> **Pro-Tip:** Para verificar este comando, puedes crear un enlace roto de prueba con `ln -s archivo_inexistente enlace_roto`, ejecutar la búsqueda para verlo, y luego limpiarlo con `rm enlace_roto`.

---

#### Ejercicio 3: Ejecutando Comandos de Forma Segura (Inspección Previa)

**Objetivo:** Antes de borrar viejos backups de logs (`.gz`) en `/var/log`, quieres inspeccionar sus detalles (tamaño, fecha) para estar seguro.

**Comando:**
```bash
sudo fdfind . --extension gz --changed-before 90d /var/log --exec ls -lh
```
* **¿Qué hace?** Busca (`fdfind`) cualquier archivo (`.`) con la extensión `.gz` que sea más antiguo de 90 días (`--changed-before 90d`) en `/var/log`. Por cada archivo encontrado, ejecuta (`--exec`) el comando `ls -lh` para mostrar sus detalles en un formato legible.
* **¿Por qué usarlo?** Es el principio de "medir dos veces, cortar una". En lugar de un destructivo `--exec rm`, usamos un inofensivo `--exec ls -lh` para inspeccionar. Es una práctica fundamental para cualquier administrador de sistemas para evitar errores costosos.
* **Resultado Esperado:** Una lista detallada (permisos, dueño, tamaño, fecha) de cada archivo de log comprimido que sea más antiguo de 90 días.

---

#### Ejercicio 4: La Receta Profesional (Búsqueda Robusta a Prueba de Fallos)

**Objetivo:** Quieres encontrar todos los archivos ejecutables en tu directorio actual, pero de una manera que **nunca falle**, incluso si los nombres de archivo contienen espacios, saltos de línea o caracteres extraños.

**El Desafío:** Un pipeline simple como `fdfind ... | xargs stat` puede romperse si un archivo se llama `"Mi script con espacios.sh"`.

**La Solución Robusta:**
```bash
fdfind . -0 --type f . | xargs -0 stat -c "%a %n" | grep "^7"
```
* **¿Qué hace?** Este pipeline es una obra de arte de la robustez:
    1.  `fdfind . -0 --type f .`: Busca cualquier (`.`) archivo (`-t f`) en el directorio actual (`.`) y separa los resultados con un carácter nulo invisible (`-0` o `--print0`).
    2.  `| xargs -0 stat ...`: `xargs -0` está diseñado específicamente para leer la lista separada por nulos, por lo que nunca se confundirá con los espacios o caracteres especiales en los nombres. Luego, ejecuta `stat` en cada archivo para obtener sus permisos numéricos (`%a`) y su nombre (`%n`).
    3.  `| grep "^7"`: Finalmente, `grep` filtra la lista para mostrar solo los archivos cuyos permisos empiezan por `7` (permiso de ejecución para el dueño).
* **¿Por qué usarlo?** Esta es la forma profesional de construir scripts y comandos en Linux. Garantiza que tu lógica funcione de manera predecible y segura, sin importar cuán extraños sean los nombres de los archivos.
* **Resultado Esperado:** Una lista limpia de dos columnas: los permisos numéricos y el nombre del archivo de todos los ficheros ejecutables en la ubicación.
