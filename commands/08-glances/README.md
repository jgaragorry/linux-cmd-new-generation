# comando `glances`

## 🚀 La Alternativa Moderna a `top`, `iotop`, `nethogs` y más

`glances` es la navaja suiza de la monitorización en terminal. Su objetivo es presentar la máxima cantidad de información del sistema en el mínimo espacio posible, de forma dinámica.

### ¿Qué es y por qué es mejor?

-   **Todo en Uno:** Combina la funcionalidad de múltiples herramientas (`top`, `htop`, `iotop`, `nethogs`, `iftop`) en una sola interfaz.
-   **Alertas Configurables:** Puedes definir umbrales (ej: CPU > 90%) y `glances` resaltará los valores en colores de advertencia o críticos.
-   **Modo Cliente/Servidor:** Puedes ejecutar `glances` en modo servidor en una máquina remota y conectarte a ella desde un cliente local.
-   **Web UI:** ¡Incluye una interfaz web! Puedes monitorizar tu servidor desde un navegador.
-   **Módulos Extensibles:** Puede monitorizar contenedores Docker, sensores, GPUs, y mucho más.

### Instalación en Ubuntu 24.04 LTS

`glances` está disponible en los repositorios de Ubuntu. Para funcionalidades extra como la web UI, se necesitan paquetes adicionales.

```bash
# Instalación básica
sudo apt update
sudo apt install -y glances

# Para la web UI y otras funcionalidades (opcional pero recomendado)
sudo apt install -y python3-bottle python3-docker
```

### Sintaxis Básica

```
glances [OPCIONES]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Se recomienda `sudo` para ver todos los detalles del sistema.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-s`             | Ejecuta en modo cliente/servidor (para conectarse a un servidor glances).     |
| `--browser`      | Inicia `glances` y abre la UI en un navegador.                            |
| `--export`       | Exporta los datos a un formato (ej: `csv`, `json`).                         |
| `-t`             | Intervalo de refresco en segundos.                                          |
| `-p`             | Puerto a usar en modo servidor/web (por defecto 61208 y 61209).             |
| `--disable-plugin` | Desactiva un plugin específico (ej: `--disable-docker`).                    |

### Configuración de Alias Permanente (Bash)

No se suele crear un alias para `glances`, ya que su uso es más para una monitorización profunda que para un vistazo rápido.

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Monitorizar un Servidor Remoto sin SSH

**Tarea:** Quieres tener una vista en tiempo real del rendimiento de un servidor remoto "headless" (sin monitor), pero no quieres mantener una sesión SSH abierta constantemente.

**Comando:**
```bash
# En el servidor remoto
glances -w

# Se mostrará una URL como http://<ip_servidor>:61208
# Abre esa URL en el navegador de tu máquina local
```
**Utilidad:** La interfaz web te da una vista completa y en tiempo real de todos los recursos del servidor. Puedes dejar esa pestaña abierta en tu navegador y tener un dashboard de monitorización persistente y de bajo consumo.

#### Ejercicio 2: Diagnosticar Qué Proceso Está Saturando el Disco

**Tarea:** El LED de actividad del disco del servidor no para de parpadear y las aplicaciones responden lento. Necesitas saber qué proceso está causando esa intensa actividad de I/O.

**Comando:**
```bash
# Inicia glances y ordena por I/O
sudo glances
```
**Utilidad:** Dentro de `glances`, presiona la tecla `i` para ordenar la lista de procesos por actividad de I/O (lectura/escritura). El proceso que esté en la cima de la lista es el culpable. `glances` te muestra exactamente cuántos bytes por segundo está leyendo o escribiendo.

#### Ejercicio 3: Monitorizar el Consumo de Recursos de Contenedores Docker

**Tarea:** Tienes varios servicios corriendo en contenedores Docker y quieres ver cómo se distribuye el uso de CPU y memoria entre ellos.

**Comando:**
```bash
# Asegúrate de haber instalado python3-docker
sudo glances
```
**Utilidad:** `glances` detectará automáticamente que Docker está corriendo y mostrará una sección dedicada a los contenedores. Verás una lista de tus contenedores activos con su consumo individual de CPU, memoria y I/O, dándote una visión clara del rendimiento de tu infraestructura containerizada.
