# comando `dog`

## 🚀 La Alternativa Moderna y Amigable a `dig`

`dog` es un cliente DNS de línea de comandos de código abierto que prioriza la facilidad de uso y una salida de información clara y coloreada. Es una herramienta de troubleshooting fundamental para cualquiera que trabaje con redes, dominios y servicios en internet.

### ¿Qué es y por qué es mejor?

-   **Salida Legible para Humanos:** Presenta los registros DNS en un formato tabular y coloreado que es inmensamente más fácil de leer que la verbosa y a menudo críptica salida de `dig`.
-   **Sintaxis Intuitiva:** Los comandos son sencillos y directos. `dog ejemplo.com MX` es más fácil de recordar y escribir que `dig ejemplo.com MX`.
-   **Soporte para Protocolos Modernos:** Incluye soporte nativo para protocolos de DNS seguros como **DNS sobre TLS (DoT)** y **DNS sobre HTTPS (DoH)**, crucial para la privacidad y la seguridad.
-   **Salida JSON:** Puede formatear la salida en JSON (`--json`), lo que lo hace perfecto para usarlo en scripts y automatizaciones.

### Instalación en Ubuntu 24.04 LTS

`dog` no está en los repositorios de Ubuntu. Se instala fácilmente con `cargo`, el gestor de paquetes de Rust.

```bash
# Asegúrate de que Rust/Cargo esté instalado
# (El script principal del repositorio se encarga de esto)
source "$HOME/.cargo/env"

# Instala dog (el paquete se llama dogdns)
cargo install dogdns
```

### Configuración de Alias Permanente (Bash)
Para que la transición desde `dig` sea natural, un alias es muy recomendable.
```bash
alias dig='dog'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Guía de Troubleshooting con `dog` por Rol Profesional

A continuación, se presentan recetas verificadas para resolver problemas de DNS comunes a los que se enfrentan diferentes roles profesionales.

---

#### 🛡️ Para SysAdmin, SysOps y NetOps (Fundamentos del Troubleshooting)

*Tu misión es asegurar que los servicios estén en línea y el correo fluya. DNS es tu primera línea de defensa.*

**Receta 1: El Diagnóstico Esencial "¿Está caído o es el DNS?"**
* **Objetivo:** Un usuario reporta que `mi-servicio-web.com` no funciona. Necesitas determinar si el problema es del servidor o si es un problema de resolución de DNS, y descartar que sea un fallo de tu DNS local.
* **Comandos (en dos pasos):**
    1.  **Verificar con el DNS local:**
        ```bash
        dog mi-servicio-web.com
        ```
    2.  **Verificar contra un DNS público (Cloudflare):**
        ```bash
        dog mi-servicio-web.com @1.1.1.1
        ```
* **Análisis y Estrategia:**
    * El primer comando usa el DNS configurado en tu sistema. El segundo (`@1.1.1.1`) salta tu configuración local y le pregunta directamente a un servidor DNS de confianza en Internet.
    * **Si ambos fallan:** El problema probablemente sea el registro DNS del dominio en sí (mal configurado, no propagado, expirado).
    * **Si el primero falla pero el segundo funciona:** El problema está en tu red local (el servidor DNS de tu oficina, tu ISP, un firewall, etc.).
* **Utilidad:** Este es el protocolo de troubleshooting de DNS más fundamental. En 10 segundos, puedes aislar la causa raíz de un "no me funciona la web" y saber si el problema es tuyo o del dueño del dominio.

**Receta 2: Diagnóstico de Problemas de Correo Electrónico**
* **Objetivo:** El correo enviado a `empresa-cliente.com` está siendo rebotado. Necesitas verificar si sus registros de correo (`MX`) y de autenticación (`TXT` para SPF/DMARC) son correctos.
* **Comandos:**
    ```bash
    # 1. Verificar los servidores de correo (MX)
    dog empresa-cliente.com MX

    # 2. Verificar el registro anti-spoofing (SPF)
    dog empresa-cliente.com TXT
    ```
* **Análisis y Estrategia:**
    * La consulta `MX` te mostrará los servidores de correo del dominio y su prioridad. Si no devuelve nada o apunta a un host incorrecto, has encontrado el problema.
    * La consulta `TXT` te mostrará varios registros de texto, entre ellos el SPF (que empieza con `v=spf1...`). Si falta o está mal configurado, muchos servidores de correo rechazarán los emails de ese dominio.
* **Utilidad:** Imprescindible para cualquier SysAdmin. Te permite diagnosticar rápidamente la causa más común de problemas de entrega de correo.

---

#### ⚙️ Para DevOps y DevSecOps (Verificación de Despliegues)

*Tu mundo es la automatización, la nube y la infraestructura como código. DNS es el pegamento que une tus microservicios.*

**Receta: Verificación de Propagación de DNS Post-Despliegue**
* **Objetivo:** Acabas de desplegar una nueva versión de tu aplicación en la nube y has apuntado un subdominio (`api.mi-app.com`) a un nuevo balanceador de carga. Necesitas confirmar que el cambio de DNS se ha propagado por el mundo.
* **El Comando:**
    ```bash
    # Preguntar a varios DNS públicos para confirmar la propagación
    dog api.mi-app.com @1.1.1.1  # Cloudflare
    dog api.mi-app.com @8.8.8.8  # Google
    dog api.mi-app.com @9.9.9.9  # Quad9
    ```
* **Análisis y Estrategia:** El DNS no se actualiza instantáneamente en todo el mundo. Al consultar directamente a diferentes proveedores de DNS públicos, puedes verificar si el cambio ya es visible para los usuarios en diferentes partes del mundo.
* **Utilidad:** Es un paso de validación crucial en cualquier pipeline de CI/CD que involucre cambios de DNS. Te permite saber cuándo es seguro dirigir el tráfico de producción al nuevo endpoint y evitar caídas de servicio.

---

#### 🕵️ Para SecOps y NetOps (Consultas Seguras y Forenses)

*Tu enfoque es la seguridad, la privacidad y el análisis. Necesitas herramientas que protejan tus consultas y te den información para tus investigaciones.*

**Receta 1: Consultas DNS Seguras y Privadas**
* **Objetivo:** Estás en una red no confiable (Wi-Fi pública, red de un cliente) y necesitas hacer una consulta DNS sin que el operador de la red pueda interceptarla, registrarla o manipularla (DNS spoofing).
* **El Comando:**
    ```bash
    # Usando DNS-over-TLS (DoT) con el servidor de Cloudflare
    dog -T mi-dominio-secreto.com @1.1.1.1
    ```
* **Análisis y Estrategia:**
    * La bandera `-T` le dice a `dog` que encapsule la consulta DNS dentro de una conexión TLS cifrada. Esto la hace completamente privada e inmune a la manipulación. `dog` también soporta DNS-over-HTTPS con la bandera `-H`.
* **Utilidad:** Esencial para analistas de seguridad que investigan dominios maliciosos sin alertar a los monitores de la red, o para cualquiera que valore su privacidad.

**Receta 2: Investigación Forense (Búsqueda Inversa)**
* **Objetivo:** En un log de seguridad, ha aparecido una alerta de una dirección IP sospechosa (`8.8.4.4`). Necesitas saber a qué nombre de dominio (si lo tiene) está asociada esa IP.
* **El Comando:**
    ```bash
    dog -x 8.8.4.4
    ```
* **Análisis y Estrategia:**
    * La bandera `-x` realiza una búsqueda inversa de DNS (consulta de registro PTR). En lugar de preguntar "¿Qué IP tiene este dominio?", pregunta "¿Qué dominio tiene esta IP?".
* **Utilidad:** Un paso fundamental en cualquier investigación de seguridad o análisis forense. Te permite pasar de un simple dato (una IP) a un posible actor (un nombre de dominio), dándote mucho más contexto para continuar tu investigación.
