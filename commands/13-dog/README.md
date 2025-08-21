# comando `dog`

## 🚀 La Alternativa Moderna a `dig` y `nslookup`

`dog` es un cliente DNS de línea de comandos. Su objetivo es ser una alternativa más amigable y con una salida más clara que las herramientas tradicionales como `dig` o `nslookup`.

### ¿Qué es y por qué es mejor?

-   **Salida Colorida y Clara:** Presenta los registros DNS en un formato tabular y coloreado que es mucho más fácil de leer que la verbosa salida de `dig`.
-   **Sintaxis Sencilla:** Los argumentos son más intuitivos. `dog example.com MX` es más directo que `dig example.com MX`.
-   **Soporte para Protocolos Modernos:** Soporta DNS sobre TLS (DoT) y DNS sobre HTTPS (DoH) de forma nativa.
-   **JSON Output:** Puede formatear la salida en JSON, ideal para scripting.

### Instalación en Ubuntu 24.04 LTS

`dog` no está en los repositorios de Ubuntu. Se instala con `cargo`. El paquete se llama `dogdns`.

```bash
# 1. Asegúrate de tener Rust/Cargo instalado
source "$HOME/.cargo/env"

# 2. Instala dog
cargo install dogdns
```

### Sintaxis Básica

```
dog [OPCIONES] [DOMINIO] [TIPO_DE_REGISTRO]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario del sistema.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `A`, `AAAA`, `MX`, `TXT`... | Especifica el tipo de registro a consultar.                         |
| `@<servidor>`    | Especifica el servidor DNS a utilizar (ej: `@1.1.1.1`).                   |
| `-H`, `--https`    | Realiza la consulta usando DNS sobre HTTPS (DoH).                         |
| `-T`, `--tls`      | Realiza la consulta usando DNS sobre TLS (DoT).                           |
| `-x`             | Realiza una búsqueda inversa (de IP a nombre de dominio).                   |
| `--json`         | Formatea la salida en JSON.                                                 |

### Configuración de Alias Permanente (Bash)

Reemplazar `dig` con `dog` para las consultas diarias es una excelente idea.

```bash
alias dig='dog'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Diagnosticar un Problema de Entrega de Correo

**Tarea:** Los correos electrónicos no están llegando a un dominio. Necesitas verificar rápidamente los registros `MX` (Mail Exchange) para asegurarte de que están configurados correctamente.

**Comando:**
```bash
dog google.com MX
```
**Utilidad:** `dog` te devolverá una lista clara y ordenada por prioridad de los servidores de correo de Google. La salida es tan limpia que puedes compartirla directamente en un chat o un ticket sin necesidad de limpiarla, a diferencia de la compleja salida de `dig`.

#### Ejercicio 2: Verificar la Propagación de un Nuevo Registro DNS

**Tarea:** Acabas de añadir un nuevo subdominio `api.midominio.com` y quieres comprobar si ya se ha propagado y si resuelve correctamente, pero quieres preguntarle a un servidor DNS público como el de Google, no al de tu red local.

**Comando:**
```bash
dog api.midominio.com A @8.8.8.8
```
**Utilidad:** Este comando dirige la consulta específicamente al servidor DNS `8.8.8.8`. Es la forma más rápida de confirmar si tus cambios de DNS ya son visibles para el resto del mundo, un paso crucial en cualquier migración o despliegue.

#### Ejercicio 3: Realizar una Consulta DNS Segura y Privada

**Tarea:** Estás en una red no confiable (como una Wi-Fi pública) y necesitas hacer una consulta DNS sin que el operador de la red pueda verla o manipularla.

**Comando:**
```bash
# Usando DNS sobre TLS con el servidor de Cloudflare
dog --tls midominio.com @1.1.1.1
```
**Utilidad:** `dog` facilita enormemente el uso de protocolos DNS seguros. Con un simple flag (`--tls` o `--https`), tu consulta viaja cifrada, protegiendo tu privacidad y asegurando la integridad de la respuesta. Hacer esto con `dig` es mucho más complicado.
