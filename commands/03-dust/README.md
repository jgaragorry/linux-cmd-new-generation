# comando `dust`

## 🚀 La Alternativa Moderna a `du`

`dust` es como `du`, pero más inteligente. Te da una visión instantánea y fácil de entender de qué directorios están ocupando espacio en disco, ordenándolos y mostrándolos en un árbol gráfico.

### ¿Qué es y por qué es mejor?

-   **Visual e Intuitivo:** Muestra un árbol de directorios con barras de porcentaje, permitiéndote ver de un vistazo dónde se concentra el uso del disco.
-   **Colores Significativos:** Usa colores para resaltar los directorios más grandes, guiando tu atención a lo importante.
-   **Más Rápido:** Está escrito en Rust y es significativamente más rápido que `du -sh *` en directorios con muchos archivos.
-   **Ordenado por Defecto:** Automáticamente ordena la salida para mostrar lo más pesado arriba. No necesitas combinarlo con `sort`.

### Instalación en Ubuntu 24.04 LTS

`dust` no está en los repositorios de Ubuntu. La forma recomendada de instalarlo es a través de `cargo`, el gestor de paquetes de Rust.

```bash
# 1. Asegúrate de tener Rust/Cargo instalado
sudo apt install -y rustc cargo rust-src rust-doc
source "$HOME/.cargo/env"

# 2. Instala dust
cargo install dust
```

### Sintaxis Básica

```
dust [OPCIONES] [DIRECTORIO]
```
Si no se especifica un directorio, analiza el actual.

### ¿Quién puede ejecutarlo?

Cualquier usuario. `dust` solo podrá analizar los directorios a los que el usuario tenga permisos de lectura. Para analizar todo el sistema, se necesita `sudo`.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                      |
| ---------------- | ---------------------------------------------------------------- |
| `-d`, `--depth`  | Profundidad del árbol a mostrar (ej: `-d 3`).                    |
| `-r`, `--reverse`| Ordena de menor a mayor tamaño.                                  |
| `-s`, `--apparent-size` | Muestra el tamaño "aparente" en lugar del espacio en bloque. |
| `-x`, `--limit-filesystem` | No cruza a otros sistemas de archivos (como `du -x`).    |
| `-i`, `--ignore_hidden` | Ignora los directorios y archivos ocultos.                   |

### Configuración de Alias Permanente (Bash)

Reemplazar `du` con `dust` para el análisis interactivo es una gran mejora.

```bash
alias du='dust'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Limpiar el Directorio Home de un Usuario

**Tarea:** Un usuario se queja de que su cuota de disco está casi llena. Necesitas encontrar rápidamente qué directorios en su `/home` están ocupando más espacio.

**Comando:**
```bash
# Como root, analiza el directorio home del usuario
sudo dust /home/usuario_problematico
```
**Utilidad:** En segundos, `dust` te mostrará un mapa visual. Probablemente veas que `~/.cache`, `~/Downloads` o algún directorio de un proyecto son los culpables, sin tener que ejecutar `du` y `sort` repetidamente.

#### Ejercicio 2: Investigar el Crecimiento del Directorio `/var`

**Tarea:** El disco raíz del servidor está perdiendo espacio libre. Sospechas que algo en `/var` está creciendo sin control (logs, cache, etc.). Quieres un desglose detallado.

**Comando:**
```bash
# Ejecuta dust con una profundidad de 3 para ver subdirectorios
sudo dust -d 3 /var
```
**Utilidad:** Este comando te mostrará el uso de `/var/log`, `/var/cache`, `/var/lib`, etc., y sus subdirectorios principales. Podrás identificar si, por ejemplo, es `/var/lib/docker/overlay2` o `/var/log/journal` el que está consumiendo gigabytes.

#### Ejercicio 3: Analizar el Tamaño de Artefactos de un Proyecto

**Tarea:** Eres un desarrollador y el directorio de tu proyecto es muy pesado. Quieres ver cuánto espacio ocupan las dependencias (`node_modules`), los builds (`dist` o `target`), etc., pero sin contar los archivos del repositorio.

**Comando:**
```bash
# Navega al directorio de tu proyecto y ejecuta dust
cd /ruta/a/mi/proyecto
dust
```
**Utilidad:** `dust` te mostrará una clara comparación visual entre el tamaño de tu código fuente y el de los directorios generados. Es perfecto para identificar si necesitas limpiar artefactos de compilación o dependencias innecesarias.
