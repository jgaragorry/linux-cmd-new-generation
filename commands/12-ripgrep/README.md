# comando `ripgrep` (`rg`)

## 🚀 La Alternativa Moderna a `grep`

`ripgrep` o `rg` es una herramienta de búsqueda de texto orientada a líneas, recursiva, y extremadamente rápida. Supera a herramientas tradicionales como `grep` en velocidad y facilidad de uso.

### ¿Qué es y por qué es mejor?

-   **Velocidad Excepcional:** Es consistentemente más rápido que `grep`, `ack` y `ag`, especialmente en proyectos grandes.
-   **Recursivo por Defecto:** Busca en el directorio actual y en todos sus subdirectorios de forma automática.
-   **Inteligente:** Respeta tus archivos `.gitignore` y `.ignore`, y no busca en archivos binarios por defecto. Esto hace las búsquedas más rápidas y relevantes.
-   **Soporte Unicode:** Maneja correctamente una gran variedad de codificaciones de texto.
-   **Sintaxis Amigable:** Opciones más intuitivas y fáciles de recordar.

### Instalación en Ubuntu 24.04 LTS

`ripgrep` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y ripgrep
```
El comando para ejecutarlo es `rg`.

### Sintaxis Básica

```
rg [OPCIONES] PATRÓN [RUTA]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario del sistema.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-i`, `--ignore-case` | Búsqueda sin distinguir mayúsculas de minúsculas.                       |
| `-v`, `--invert-match` | Muestra las líneas que NO coinciden con el patrón.                     |
| `-l`, `--files-with-matches` | Muestra solo los nombres de los archivos que contienen coincidencias. |
| `-w`, `--word-regexp` | Busca solo palabras completas.                                          |
| `-t`, `--type`   | Busca solo en archivos de un tipo específico (ej: `-t py` para Python).     |
| `-C`, `--context` | Muestra N líneas de contexto antes y después de la coincidencia.           |
| `--hidden`       | Incluye archivos ocultos en la búsqueda.                                    |

### Configuración de Alias Permanente (Bash)

Reemplazar `grep` con `rg` es una mejora de productividad masiva.

```bash
alias grep='rg'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Encontrar una Configuración en todo `/etc`

**Tarea:** No recuerdas en qué archivo de configuración de `/etc` definiste un parámetro específico, por ejemplo `AllowUsers`. Necesitas encontrarlo rápidamente.

**Comando:**
```bash
# Busca la palabra exacta, sin distinguir mayúsculas/minúsculas
sudo rg -iw 'AllowUsers' /etc
```
**Utilidad:** `rg` escaneará recursivamente todo `/etc` a una velocidad sorprendente. Al ignorar archivos binarios y respetar permisos, te dará una lista limpia y relevante de archivos de configuración que contienen esa directiva, junto con el número de línea y la línea exacta.

#### Ejercicio 2: Listar todos los archivos de un proyecto que usan una función obsoleta

**Tarea:** Eres un desarrollador y se ha decidido dejar de usar una función llamada `get_legacy_data()`. Necesitas encontrar todos los archivos de código Python que todavía la llaman.

**Comando:**
```bash
# -t py busca solo en archivos python, -l solo lista los nombres de archivo
rg -t py -l 'get_legacy_data'
```
**Utilidad:** Este comando es perfecto para refactorizar código. Te da una lista de tareas de todos los archivos que necesitas modificar. Como `rg` ignora `node_modules` o directorios de compilación, los resultados son limpios y se centran solo en tu código fuente.

#### Ejercicio 3: Buscar un ID de error específico en un mar de logs

**Tarea:** Un usuario reporta un error con el ID `a3f-7b1-c9d`. Tienes gigabytes de logs en `/var/log` y necesitas encontrar todas las ocurrencias de este error, junto con algunas líneas de contexto para entender qué pasó antes y después.

**Comando:**
```bash
# -C 5 muestra 5 líneas de contexto antes y después
sudo rg -C 5 'a3f-7b1-c9d' /var/log
```
**Utilidad:** A diferencia de `grep`, que sería mucho más lento, `rg` procesará los archivos de log a gran velocidad. El contexto (`-C 5`) es crucial para el diagnóstico, ya que te permite ver las trazas de la pila o los eventos que llevaron al error sin tener que abrir cada archivo de log manualmente.
