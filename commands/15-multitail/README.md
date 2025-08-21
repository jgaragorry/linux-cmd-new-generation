# comando `multitail`

## 🚀 Monitorización de Múltiples Archivos en una Sola Terminal

`multitail` es una versión supervitaminada del clásico `tail -f`. Su superpoder es la capacidad de mostrar múltiples archivos de log (o la salida de comandos) en una **única pantalla de terminal**, dividiéndola en ventanas y resaltando patrones con colores. Es la herramienta definitiva para la correlación de eventos en tiempo real.

### ¿Qué es y por qué es mejor?

-   **Pantalla Dividida (Splitscreen):** En lugar de abrir múltiples terminales para ver diferentes logs, `multitail` divide tu terminal actual en varias ventanas, permitiéndote ver todo de un vistazo.
-   **Resaltado con Colores:** Puedes definir expresiones regulares para resaltar palabras clave (como "ERROR", "WARNING", IPs, etc.) con colores, haciendo que la información crítica salte a la vista.
-   **Fusión de Logs:** Puede tomar varios archivos y fusionar su salida en una sola ventana, intercalando las líneas. Es ideal para seguir una transacción a través de varios microservicios.
-   **Monitorización de Comandos:** No solo monitorea archivos, también puede mostrar en una ventana la salida en tiempo real de comandos como `ping`, `netstat`, o `docker stats`.

### Instalación en Ubuntu 24.04 LTS

`multitail` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y multitail
```

### 🧠 Fundamento Clave: ¿Cuándo usar `multitail` vs. `lnav`?

-   Usa **`multitail`** para **ver eventos en vivo mientras ocurren**. Es para monitorización activa y para ver la causa-efecto inmediata. Es tu "centro de comando".
-   Usa **`lnav`** para **investigar un problema que ya ocurrió**. Es para análisis forense, navegar en el tiempo y hacer consultas complejas sobre datos históricos. Es tu "laboratorio de análisis".

### 🎓 Guía de Troubleshooting en Tiempo Real con `multitail` por Rol

A continuación, se presentan recetas verificadas que muestran cómo cada rol puede usar `multitail` para resolver problemas de forma proactiva.

> **Nota Importante:** Algunas de las siguientes recetas usan rutas de log de ejemplo (como `/var/log/nginx/...` o `/var/log/mi_app/...`). Si no tienes ese software instalado, el comando dará un error de "archivo no encontrado". Adapta las rutas a los logs de tus propias aplicaciones.

---

#### 🛡️ Para el Administrador de Sistemas / SysOps

*Tu misión es entender la interacción entre los componentes del sistema y diagnosticar problemas complejos que abarcan múltiples servicios.*

**Receta: Diagnóstico de Causa y Efecto del Sistema**
* **Objetivo:** Un usuario se queja de que una acción específica (ej: ejecutar un comando con `sudo`) está causando un comportamiento extraño en el sistema. Necesitas correlacionar la acción del usuario con la respuesta del sistema.
* **El Comando:**
    ```bash
    # Muestra el log del sistema y el log de autenticación en dos ventanas horizontales
    sudo multitail /var/log/syslog -i /var/log/auth.log
    ```
* **Análisis y Estrategia:**
    * **¿Qué hace?** Abre `/var/log/syslog` en la ventana superior y, con `-i`, abre `/var/log/auth.log` en una nueva ventana en la parte inferior.
    * **¿Por qué usarlo?** Te permite ver la causa (una acción de autenticación en `auth.log`) y el efecto (un mensaje del kernel o de un servicio en `syslog`) en la misma pantalla y en el mismo momento.
    * **¿Cuándo usarlo?** Cuando sospechas que una acción de un usuario o un script está provocando un problema a nivel de sistema y necesitas ver la interacción directa.
* **Resultado Esperado:** Tu terminal se dividirá en dos. Podrás pedirle al usuario que repita la acción y verás las entradas aparecer en ambas ventanas simultáneamente, permitiéndote conectar los puntos.

---

#### ⚙️ Para el Ingeniero DevOps

*Tu mundo es el ciclo de vida de la aplicación. Necesitas depurar la interacción entre los diferentes componentes de tu stack (ej: un balanceador, un servidor web y tu aplicación).*

**Receta: Depuración Full-Stack en Tiempo Real**
* **Objetivo:** Un usuario reporta un error 500 en la web. Necesitas ver la petición HTTP entrante en el log de Nginx y la traza de error (traceback) que genera en tu aplicación Python/Java/etc. al mismo tiempo.
* **El Comando:**
    ```bash
    sudo multitail /var/log/nginx/access.log -cS apache_combined -i /var/log/mi_app/app.log -cT syslog -e "ERROR|TRACEBACK" -c red
    ```
* **Análisis y Estrategia:**
    * **¿Qué hace?** Divide la pantalla en dos. La primera ventana (`/var/log/nginx/access.log`) usa un esquema de colores (`-cS`) para logs web. La segunda (`-i /var/log/mi_app/app.log`) usa un esquema de colores de syslog (`-cT`) y además resalta (`-e`) las palabras "ERROR" o "TRACEBACK" en rojo (`-c red`).
    * **¿Por qué usarlo?** Es la forma más rápida de depurar problemas en una arquitectura de microservicios o multicapa. Te permite seguir el ciclo de vida de una petición fallida a través de todo el stack.
    * **¿Cuándo usarlo?** Durante un despliegue, al probar una nueva funcionalidad, o cuando un usuario reporta un error difícil de reproducir.
* **Resultado Esperado:** Una pantalla dividida. Cuando se produzca el error, verás la línea con el código de estado 500 en la ventana de Nginx y, una fracción de segundo después, la traza de error completa aparecerá resaltada en rojo en la ventana de tu aplicación.

---

#### 🕵️ Para el Analista de Seguridad / NetOps

*Tu enfoque es la monitorización activa de la salud de la red y la detección de amenazas en tiempo real.*

**Receta 1 (NetOps): Dashboard de Salud de Red**
* **Objetivo:** Mantener una vigilancia constante sobre la estabilidad de la conexión de red de un servidor y correlacionar posibles caídas con eventos del sistema.
* **El Comando:**
    ```bash
    # Divide la pantalla en 2 columnas verticales (-s 2)
    # En una, ejecuta un ping constante (-l "ping ..."). En la otra, muestra el syslog.
    sudo multitail -s 2 -l "ping 8.8.8.8" -i /var/log/syslog
    ```
* **Análisis y Estrategia:** `multitail` no solo ve archivos, sino que también ejecuta comandos (`-l`). Aquí, creamos un panel simple pero efectivo: a la izquierda, la latencia y pérdida de paquetes en tiempo real; a la derecha, los mensajes del sistema operativo.
* **¿Por qué usarlo?** Te permite responder a la pregunta: "¿Esta alerta de servicio en el log fue causada por un problema de red?". Si ves un `Request timeout` en la ventana de ping al mismo tiempo que un servicio loguea un error de conexión, has encontrado tu respuesta.
* **Resultado Esperado:** Una vista de dos columnas, ideal para dejar en un monitor dedicado o en una pestaña de terminal persistente para una monitorización pasiva.

**Receta 2 (SecOps): Panel de Monitoreo de Seguridad Activo**
* **Objetivo:** Crear un "ticker" de eventos de seguridad en vivo, fusionando los logs del firewall y de autenticación, y resaltando las actividades sospechosas.
* **El Comando:**
    ```bash
    # Fusiona (-M 0) los logs de UFW y auth en una sola ventana
    # y resalta en color los eventos de interés.
    sudo multitail -M 0 /var/log/ufw.log /var/log/auth.log -e "Failed password" -c red,bold -e "UFW BLOCK" -c yellow
    ```
* **Análisis y Estrategia:**
    * `-M 0`: **Fusiona** los dos archivos en una sola vista, intercalando las entradas.
    * `-e "Failed password" -c red,bold`: Busca la frase "Failed password" y la pone en **rojo y negrita** para un máximo impacto visual.
    * `-e "UFW BLOCK" -c yellow`: Busca los bloqueos del firewall y los resalta en amarillo.
* **Utilidad:** Esto crea un centro de comando de seguridad en tiempo real. Cualquier intento de login fallido o paquete bloqueado por el firewall aparece instantáneamente en una sola vista consolidada y coloreada, permitiéndote detectar patrones de ataque mientras ocurren.
