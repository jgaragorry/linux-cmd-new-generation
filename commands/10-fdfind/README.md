# comando `fdfind` (`fd`)

## 🚀 La Alternativa Moderna a `find`

`fd` es una alternativa a `find` que es simple, rápida e intuitiva. Está escrita en Rust y optimizada para ser ergonómica y veloz.

### ¿Qué es y por qué es mejor?

-   **Sintaxis Sencilla:** La sintaxis es mucho más simple. `find -name "*.py"` se convierte en `fd .py`.
-   **Velocidad:** Es extremadamente rápido gracias a la paralelización y al uso de expresiones regulares optimizadas.
-   **Inteligente por Defecto:** Ignora automáticamente archivos y directorios ocultos, así como patrones de tu archivo `.gitignore`. ¡Se acabaron los `find . -name "node_modules" -prune`!
-   **Uso de Colores:** Colorea la salida para diferenciar tipos de archivo.
-   **Expresiones Regulares:** El patrón de búsqueda es tratado como una expresión regular por defecto.

### Instalación en Ubuntu 24.04 LTS

Está en los repositorios de Ubuntu, pero el binario se llama `fdfind` para evitar colisión de nombres.

```bash
sudo apt update
sudo apt install -y fd-find
```
**Importante:** El comando a usar es `fdfind`. Se recomienda encarecidamente un alias.

### Sintaxis Básica

```
fdfind [OPCIONES] [PATRÓN] [RUTA]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario del sistema.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-t`, `--type`   | Busca por tipo de archivo (`f` para archivo, `d` para dir, `l` para link). |
| `-e`, `--extension` | Busca por extensión de archivo.                                           |
| `-x`, `--exec`   | Ejecuta un comando por cada resultado encontrado (similar a `-exec` de find). |
| `-X`, `--exec-batch` | Ejecuta un comando una vez, con todos los resultados como argumentos.    |
| `-H`, `--hidden` | Incluye archivos y directorios ocultos en la búsqueda.                      |
| `-I`, `--no-ignore` | No respeta los patrones de `.gitignore`.                                   |

### Configuración de Alias Permanente (Bash)

Crear un alias de `find` a `fdfind` o de `fd` a `fdfind` es esencial.

```bash
alias find='fdfind' # O si prefieres: alias fd='fdfind'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti, aliando `find`.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Encontrar Todos los Archivos de Configuración Modificados en el Último Día

**Tarea:** Has estado haciendo cambios en varios archivos de configuración en `/etc`, pero no recuerdas cuáles. Necesitas encontrar todos los archivos `.conf` modificados en las últimas 24 horas.

**Comando:**
```bash
# El patrón es el final del nombre del archivo, y el flag --changed-within lo filtra por tiempo
fdfind --extension conf --changed-within 1d /etc
```
**Utilidad:** Esta sintaxis es mucho más legible y memorable que la de `find`: `find /etc -name "*.conf" -mtime -1`. `fd` hace que las búsquedas complejas se sientan naturales.

#### Ejercicio 2: Eliminar Todos los Archivos de Log Antiguos de un Proyecto

**Tarea:** El directorio de tu aplicación está lleno de archivos de log rotados (`.log.1`, `.log.2`, etc.). Quieres eliminarlos todos de una vez.

**Comando:**
```bash
# -x (o --exec) ejecuta un comando por cada resultado. {} es el placeholder para el archivo.
fdfind '\.log\.\d+' --exec rm {}
```
**Utilidad:** `fd` usa expresiones regulares por defecto, por lo que `\.log\.\d+` encuentra de forma precisa los logs numerados. La combinación con `--exec rm` es una forma poderosa y segura de realizar operaciones en lote sobre los archivos encontrados.

#### Ejercicio 3: Cambiar los Permisos de Todos los Scripts de un Directorio

**Tarea:** Tienes un directorio `~/scripts` con muchos scripts de shell (`.sh`) y quieres asegurarte de que todos sean ejecutables.

**Comando:**
```bash
# -X (o --exec-batch) es más eficiente porque llama a chmod una sola vez.
fdfind --extension sh --exec-batch chmod +x
```
**Utilidad:** Es una forma increíblemente rápida y eficiente de aplicar cambios a múltiples archivos. En lugar de ejecutar `chmod` para cada script, `fdfind` reúne todos los resultados y los pasa a `chmod` en un solo lote, lo que es mucho más rápido si hay cientos de archivos.
