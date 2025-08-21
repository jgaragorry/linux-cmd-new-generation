# comando `gdu`

## 🚀 La Alternativa Moderna a `du` y `ncdu`

`gdu` (Go Disk Usage) es un analizador de uso de disco increíblemente rápido, diseñado para sacar el máximo provecho de los discos SSD gracias a su procesamiento en paralelo.

### ¿Qué es y por qué es mejor?

-   **Velocidad Extrema:** Es significativamente más rápido que `du` y `ncdu`, especialmente en directorios con muchos archivos y en unidades SSD. El análisis del disco raíz que a `ncdu` le toma minutos, a `gdu` le toma segundos.
-   **Interfaz Interactiva:** Al igual que `ncdu`, te permite navegar por los directorios, ver qué ocupa espacio y eliminar archivos o directorios directamente desde la interfaz.
-   **Exportación de Resultados:** Puedes escanear un directorio una vez y exportar los resultados a un archivo. Luego, puedes cargar ese archivo en `gdu` en otro momento para analizarlo sin tener que volver a escanear.

### Instalación en Ubuntu 24.04 LTS

`gdu` no está en los repositorios de Ubuntu. La forma recomendada de instalarlo es a través de `cargo`.

```bash
# 1. Asegúrate de tener Rust/Cargo instalado
# (El script principal del repositorio se encarga de esto)
source "$HOME/.cargo/env"

# 2. Instala gdu
cargo install gdu
```

### Sintaxis Básica

```
gdu [OPCIONES] [DIRECTORIO]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Para analizar directorios del sistema, se debe ejecutar con `sudo`.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-i`, `--ignore-dirs` | Ignora directorios específicos (ej: `-i /proc,/sys`).                     |
| `-o`, `--output-file` | Exporta los resultados del escaneo a un archivo (ej: `-o scan.json`).     |
| `-f`, `--input-file` | Carga los resultados desde un archivo previamente exportado.              |
| `-n`, `--no-progress` | No muestra la barra de progreso durante el escaneo (útil en scripts).   |
| `-d`, `--show-disks` | Muestra una lista de discos montados para elegir cuál analizar.         |

### Configuración de Alias Permanente (Bash)

No se suele crear un alias para `gdu`, ya que su uso interactivo es distinto a `du`. Se usa cuando se necesita un análisis profundo y rápido.

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Análisis de Emergencia del Disco Raíz

**Tarea:** El servidor principal está al 99% de su capacidad. Necesitas encontrar y eliminar los archivos más grandes lo más rápido posible para evitar una caída del servicio. El tiempo es crítico.

**Comando:**
```bash
# Escanea el directorio raíz, ignorando sistemas de archivos virtuales
sudo gdu -i /proc,/sys,/dev /
```
**Utilidad:** `gdu` escaneará el disco a una velocidad vertiginosa. En segundos, tendrás una vista interactiva donde podrás navegar con las flechas, presionar `d` para eliminar un archivo/directorio grande (como un log rotado antiguo o un backup fallido) y liberar espacio de inmediato.

#### Ejercicio 2: Análisis "Offline" de un Servidor Remoto

**Tarea:** Necesitas analizar el uso de disco de un servidor en producción, pero no quieres consumir recursos de forma interactiva durante las horas pico. Quieres generar un reporte y analizarlo más tarde en tu máquina local.

**Comando:**
```bash
# En el servidor de producción (durante la noche)
sudo gdu /var/log -o /tmp/log_scan.json -n

# Luego, copia el archivo a tu máquina local
scp usuario@servidor:/tmp/log_scan.json .

# En tu máquina local, carga el archivo
gdu -f log_scan.json
```
**Utilidad:** Este método te permite realizar un análisis pesado sin afectar el rendimiento en momentos críticos. Puedes analizar los datos con calma en tu propia máquina sin necesidad de estar conectado al servidor.

#### Ejercicio 3: Comparar el Uso de Disco Antes y Después de una Limpieza

**Tarea:** Vas a ejecutar un script de limpieza masiva en un directorio. Quieres tener un "antes" y un "después" para documentar cuánto espacio se liberó y dónde.

**Comando:**
```bash
# Antes de la limpieza
gdu /path/to/directory -o antes.json -n

# ... ejecuta tu script de limpieza ...

# Después de la limpieza
gdu /path/to/directory -o despues.json -n

# Ahora puedes cargar y comparar ambos reportes cuando quieras
gdu -f antes.json
# (en otra terminal)
gdu -f despues.json
```
**Utilidad:** Tener un registro del estado del disco es invaluable para la gestión de capacidad y la elaboración de informes. `gdu` facilita la creación de estas "instantáneas" del uso del disco para análisis posteriores.
