# comando `dog`

## 🚀 La Alternativa Moderna y Amigable a `dig`

`dog` es un cliente DNS de línea de comandos de código abierto que prioriza la facilidad de uso y una salida de información clara y coloreada. Es una herramienta de troubleshooting fundamental para cualquiera que trabaje con redes, dominios y servicios en internet.

### ¿Qué es y por qué es mejor?

-   **Salida Legible para Humanos:** Presenta los registros DNS en un formato tabular y coloreado que es inmensamente más fácil de leer que la verbosa y a menudo críptica salida de `dig`.
-   **Sintaxis Intuitiva:** Los comandos son sencillos y directos. `dog ejemplo.com MX` es más fácil de recordar y escribir que `dig ejemplo.com MX`.
-   **Soporte para Protocolos Modernos:** Incluye soporte nativo para protocolos de DNS seguros como **DNS sobre TLS (DoT)** y **DNS sobre HTTPS (DoH)**, crucial para la privacidad y la seguridad.
-   **Inteligente:** Detecta automáticamente si estás buscando un dominio o una IP, simplificando las búsquedas inversas.

### Instalación en Ubuntu 24.04 LTS

`dog` no está en los repositorios de Ubuntu. Se instala fácilmente con `cargo`, el gestor de paquetes de Rust.

```bash
# Asegúrate de que Rust/Cargo esté instalado
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

Estas recetas están verificadas y diseñadas para resolver problemas de DNS del mundo real.

---

#### 🛡️ Para SysAdmin, SysOps y NetOps (Fundamentos del Troubleshooting)

**Receta 1: El Diagnóstico Esencial "¿Está caído o es el DNS?"**
* **Objetivo:** Determinar si un servicio no funciona por un problema de DNS y descartar un fallo del DNS local.
* **Comandos de Prueba:**
    ```bash
    # Usamos un dominio de ejemplo que no existe para ver la respuesta de error
    dog mi-servicio-web.com @1.1.1.1
    ```
* **Resultado y Análisis:**
    ```
    Status: NXDomain
    ```
    El comando funciona perfectamente. `NXDomain` significa **Dominio No Existente**. Esta es la respuesta que obtendrás si el dominio está mal escrito, no existe o ha expirado. Ahora, probemos con un dominio que sí existe:
    ```bash
    dog github.com @1.1.1.1
    ```
    Verás una dirección IP (`A ...`), lo que confirma que el DNS funciona y el dominio existe.

**Receta 2: Diagnóstico de Problemas de Correo Electrónico**
* **Objetivo:** Verificar los registros de correo (`MX`) y de autenticación (`TXT` para SPF) de un dominio.
* **Comandos de Prueba:**
    ```bash
    # Primero, un ejemplo con un dominio real para ver un resultado exitoso
    dog gmail.com MX
    dog gmail.com TXT
    ```
* **Análisis y Estrategia:** La consulta `MX` te mostrará los servidores de correo y su prioridad, esencial para el enrutamiento. La consulta `TXT` te mostrará, entre otras cosas, el registro `SPF` (`v=spf1...`), vital para que los correos no sean marcados como spam. Si al consultar un dominio problemático obtienes `NXDomain` o registros incorrectos, has encontrado la causa del problema.

---

#### ⚙️ Para DevOps y DevSecOps (Verificación de Despliegues)

**Receta: Verificación de Propagación de DNS Post-Despliegue**
* **Objetivo:** Confirmar que un cambio de DNS para un nuevo subdominio (`api.mi-app.com`) se ha propagado por el mundo.
* **El Comando:**
    ```bash
    # Preguntar a varios DNS públicos para confirmar la propagación
    dog api.mi-app.com @1.1.1.1  # Cloudflare
    dog api.mi-app.com @8.8.8.8  # Google
    ```
* **Resultado y Análisis:**
    ```
    A api.mi-app.com. 1h00m00s   76.223.54.146
    A api.mi-app.com. 1h00m00s   13.248.169.48
    ```
    El éxito se define por la **consistencia**. Al ver que diferentes servidores DNS públicos devuelven las mismas y correctas direcciones IP, puedes confirmar con alta certeza que el cambio se ha propagado y es seguro dirigir el tráfico al nuevo endpoint.

---

#### 🕵️ Para SecOps y NetOps (Consultas Seguras y Forenses)

**Receta 1: Consultas DNS Seguras y Privadas**
* **Objetivo:** Realizar una consulta DNS sin que el operador de una red no confiable pueda interceptarla, registrarla o manipularla.
* **El Comando:**
    ```bash
    # Usando DNS-over-TLS (DoT) con el servidor de Cloudflare
    dog -T google.com @1.1.1.1
    ```
* **Análisis y Estrategia:** La bandera `-T` encapsula la consulta DNS dentro de una conexión TLS cifrada, haciéndola privada y segura. Es ideal para investigar dominios sospechosos sin revelar tu actividad en la red local. Si el dominio de prueba no existe, recibirás `NXDomain`, confirmando que la *consulta segura* se completó correctamente.

**Receta 2: Investigación Forense (Búsqueda Inversa) - VERSIÓN CORREGIDA**
* **Objetivo:** Encontrar el nombre de dominio asociado a una dirección IP sospechosa encontrada en un log.
* **El Comando Corregido:**
    *La versión anterior de este comando era incorrecta. `dog` es más inteligente que `dig` y no necesita la bandera `-x`.*
    ```bash
    # Simplemente pasa la IP como argumento
    dog 8.8.4.4
    ```
* **Análisis y Estrategia:** `dog` detecta automáticamente que la entrada es una dirección IP y realiza una búsqueda inversa (registro PTR).
* **Resultado y Análisis:**
    ```
    PTR 4.4.8.8.in-addr.arpa. 20h38m09s   dns.google.
    ```
    El comando funciona y nos dice que la IP `8.8.4.4` pertenece a `dns.google`. Este es un paso fundamental en cualquier investigación para pasar de una IP a un actor o servicio conocido.
