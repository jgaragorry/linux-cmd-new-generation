# comando `bandwhich`

## 🚀 La Alternativa Moderna a `nethogs`

`bandwhich` es una utilidad de terminal que muestra el uso de ancho de banda en tiempo real por proceso, conexión y dirección IP remota. Te dice "quién está usando la red AHORA MISMO".

### ¿Qué es y por qué es mejor?

-   **Vista Consolidada:** Presenta la información de forma mucho más clara y compacta que `nethogs`.
-   **Resolución de DNS:** Intenta resolver las direcciones IP remotas a nombres de dominio, haciendo más fácil identificar a dónde se están conectando tus procesos.
-   **Interfaz Clara:** La UI es fácil de entender de un vistazo, mostrando el proceso, la conexión local, la remota y la velocidad de subida/bajada.
-   **Rápido y Ligero:** Escrito en Rust, es eficiente y consume pocos recursos.

### Instalación en Ubuntu 24.04 LTS

`bandwhich` no está en los repositorios de Ubuntu. Se instala con `cargo`. También requiere `libpcap-dev` para capturar paquetes.

```bash
# 1. Instalar dependencias
sudo apt update
sudo apt install -y libpcap-dev

# 2. Asegúrate de tener Rust/Cargo instalado
source "$HOME/.cargo/env"

# 3. Instala bandwhich
cargo install bandwhich
```

### Sintaxis Básica

```
sudo bandwhich [OPCIONES]
```
**Importante:** `bandwhich` necesita privilegios de `root` para capturar el tráfico de red.

### ¿Quién puede ejecutarlo?

Solo el usuario `root` o usuarios con las capacidades de red adecuadas (`sudo`).

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-i`, `--interface` | Especifica la interfaz de red a monitorear (ej: `-i eth0`).               |
| `-n`, `--no-resolve` | No intenta resolver las direcciones IP a nombres de dominio.              |
| `-r`, `--raw`    | Muestra la salida en un formato más simple, sin la UI, para scripting.      |

### Configuración de Alias Permanente (Bash)

No se recomienda un alias, ya que su uso es específico y requiere `sudo`.

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Identificar al Culpable de una Red Lenta

**Tarea:** La conexión a internet del servidor se ha vuelto repentinamente muy lenta. Necesitas identificar qué proceso está consumiendo todo el ancho de banda.

**Comando:**
```bash
sudo bandwhich
```
**Utilidad:** Al ejecutar el comando, verás una lista en tiempo real de los procesos que están usando la red, ordenados por el uso de ancho de banda. En segundos, podrás identificar si es un proceso de `apt`, una sincronización de `docker pull`, un `rsync` inesperado o algo peor.

#### Ejercicio 2: Verificar Conexiones Salientes de un Servicio

**Tarea:** Has desplegado una nueva aplicación y quieres verificar que solo se está conectando a los servicios externos que esperas (ej: una base de datos en AWS, una API de terceros).

**Comando:**
```bash
sudo bandwhich
```
**Utilidad:** Observa la columna "Remote Address". Verás los nombres de dominio y las IPs a las que se están conectando tus procesos. Esto te permite auditar las conexiones de red de tus aplicaciones y detectar cualquier comunicación inesperada o sospechosa.

#### Ejercicio 3: Monitorizar el Tráfico en una Interfaz de Red Específica

**Tarea:** Tu servidor tiene múltiples interfaces de red (una pública, una para la red interna, una para Docker). Quieres monitorizar exclusivamente el tráfico que entra y sale por la interfaz pública (`eth0`).

**Comando:**
```bash
sudo bandwhich --interface eth0
```
**Utilidad:** Esto aísla el análisis a una única interfaz, eliminando el "ruido" del tráfico interno o de la red de contenedores. Es crucial para entender cómo tu servidor se está comunicando con el mundo exterior y para diagnosticar problemas de conectividad o de seguridad en el perímetro de tu red.
