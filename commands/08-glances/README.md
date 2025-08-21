# comando `glances`

## 🚀 La Alternativa Moderna a `top`, `iotop`, `nethogs` y más

`glances` es la navaja suiza de la monitorización en terminal. Su objetivo es presentar la máxima cantidad de información del sistema en una sola pantalla, de forma dinámica y en múltiples modos, incluyendo una potente interfaz web.

### ¿Qué es y por qué es mejor?

-   **Todo en Uno:** Combina la funcionalidad de `top` (procesos), `htop` (procesos mejorado), `iotop` (I/O de disco), y `nethogs` (uso de red) en una sola interfaz cohesiva.
-   **Multi-Modo:** Funciona en tres modalidades principales: como una aplicación de terminal local (estándar), como un servidor web con una interfaz gráfica, y en modo cliente/servidor para monitorización remota de terminal a terminal.
-   **Alertas Configurables:** Resalta los valores que superan umbrales predefinidos (ej: CPU > 90%) en colores de advertencia o críticos, permitiéndote ver problemas de un vistazo.
-   **Extensible:** Puede monitorizar un ecosistema enorme gracias a sus plugins: contenedores Docker, sensores de temperatura, GPUs NVIDIA, y mucho más.

### Instalación en Ubuntu 24.04 LTS

`glances` está disponible en los repositorios de Ubuntu. Para funcionalidades extra como la interfaz web, se recomiendan paquetes adicionales.

```bash
# Instalación básica
sudo apt update
sudo apt install -y glances

# Para la interfaz web (muy recomendado)
sudo apt install -y python3-bottle
```

### Sintaxis Básica

`glances` se puede invocar de varias maneras dependiendo del modo que desees utilizar:

```bash
# 1. Modo Estándar (en la terminal local)
glances

# 2. Modo Servidor Web
glances -w

# 3. Modo Servidor (para cliente/servidor)
glances -s

# 4. Modo Cliente (para conectarse a un servidor)
glances -c <IP_DEL_SERVIDOR>
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Se recomienda ejecutarlo con `sudo glances` para poder ver detalles de todos los procesos y discos del sistema.

### Argumentos y Opciones Clave

| Opción | Descripción |
| :--- | :--- |
| `-w` | **(Web)** Inicia Glances en modo servidor web. |
| `-s` | **(Server)** Inicia Glances en modo servidor para conexiones cliente-servidor. |
| `-c <IP/HOST>` | **(Client)** Se conecta a un servidor Glances remoto. |
| `--browser` | Inicia el servidor web y trata de abrirlo en un navegador local. |
| `-p <PORT>` | Especifica el puerto a usar en modo servidor/web (por defecto 61208). |
| `-t <SECONDS>` | Intervalo de refresco de la pantalla en segundos. |
| `--disable-plugin` | Desactiva un plugin específico (ej: `--disable-docker`). |

### Configuración de Alias Permanente (Bash)

No se suele crear un alias para `glances`, ya que su uso es más para una monitorización profunda que para un vistazo rápido. Se invoca directamente cuando se necesita.

### 🎓 Ejercicios Prácticos: Dominando los 3 Modos de Glances

A continuación, tres ejercicios que te enseñarán a usar cada modo de `glances` para resolver problemas reales.

---

#### Ejercicio 1: Diagnóstico Rápido en la Terminal (Modo Estándar)

**Tarea:** El rendimiento de tu servidor es lento. Sospechas que un proceso está escribiendo o leyendo excesivamente del disco, pero no sabes cuál.

**Comando:**
```bash
sudo glances
```
**Procedimiento:**
1.  Una vez dentro de la interfaz de `glances`, observa la sección de procesos.
2.  Presiona la tecla `d` para mostrar/ocultar las estadísticas de I/O de disco.
3.  Presiona la tecla `i` para ordenar la lista de procesos por su actividad de I/O (lectura/escritura).
**Utilidad:** El proceso que esté en la cima de la lista es el culpable de la alta actividad de disco. `glances` te muestra al instante cuántos bytes por segundo está utilizando, permitiéndote diagnosticar cuellos de botella de I/O en segundos sin necesidad de otra herramienta.

---

#### Ejercicio 2: Crear un Panel de Monitoreo Web Remoto (Modo Servidor Web)

**Tarea:** Necesitas vigilar el estado de un servidor durante todo el día desde tu portátil o incluso tu teléfono, sin mantener una conexión SSH abierta.

**Procedimiento Paso a Paso:**

1.  **En el servidor que quieres monitorizar, inicia Glances en modo web:**
    ```bash
    glances -w
    ```
    Verás una confirmación: `Glances Web User Interface started on http://0.0.0.0:61208/`.
    **🚨 ¡Importante!** Deja esta terminal abierta. El servidor debe seguir ejecutándose.

2.  **Encuentra la dirección IP de tu servidor:**
    Abre una **nueva terminal** en el mismo servidor y ejecuta:
    ```bash
    hostname -I
    ```
    El resultado será la IP local, por ejemplo: `172.28.160.209`.

3.  **Conéctate desde otro dispositivo:**
    Ve a cualquier otro dispositivo (tu portátil, PC, teléfono) que esté en la misma red.
    * Abre un navegador web (Chrome, Firefox, etc.).
    * En la barra de direcciones, escribe `http://`, la IP de tu servidor, y el puerto `:61208`.
    * Ejemplo: `http://172.28.160.209:61208`

**Utilidad:** Ahora tienes un panel de control gráfico y en tiempo real de tu servidor, accesible desde cualquier lugar de tu red. Es ideal para mantener una vigilancia pasiva, mostrar el estado del sistema en un monitor de pared o simplemente para tener una vista más amigable.

---

#### Ejercicio 3: Vigilar un Servidor desde la Terminal de Otro (Modo Cliente/Servidor)

**Tarea:** Eres un administrador de sistemas y estás conectado por SSH al `Servidor-B`, que es un host de salto (bastion). Necesitas ver el rendimiento detallado del `Servidor-A` sin tener que iniciar otra sesión SSH hacia él.

**Procedimiento:**

1.  **En el `Servidor-A` (el que será monitorizado), inicia Glances en modo servidor:**
    Este modo lo prepara para aceptar conexiones de clientes de Glances.
    ```bash
    # En la terminal del Servidor-A
    glances -s
    ```
    (Para un uso permanente, esto se podría configurar como un servicio del sistema).

2.  **En el `Servidor-B` (tu máquina local o de salto), conéctate como cliente:**
    Usa la bandera `-c` seguida de la dirección IP del `Servidor-A`.
    ```bash
    # En la terminal del Servidor-B
    glances -c <IP_DEL_SERVIDOR_A>
    ```
    Por ejemplo: `glances -c 172.28.160.209`

**Utilidad:** Verás la interfaz de terminal estándar de Glances en tu `Servidor-B`, pero todos los datos (CPU, RAM, procesos, etc.) provendrán del `Servidor-A`. Este método es extremadamente eficiente y perfecto para administradores que viven en la terminal y necesitan saltar entre la monitorización de diferentes máquinas rápidamente.
