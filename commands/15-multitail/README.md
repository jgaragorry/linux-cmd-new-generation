# comando `multitail`

## 🚀 La Alternativa Moderna a `tail -f`

`multitail` te permite hacer `tail` a múltiples archivos en una sola terminal, dividiendo la pantalla en varias ventanas. Es una herramienta clásica pero increíblemente poderosa para la monitorización de logs.

### ¿Qué es y por qué es mejor?

-   **Múltiples Ventanas:** Su principal característica. Puedes ver 2, 4, o más archivos de log actualizándose en tiempo real en una sola pantalla.
-   **Resaltado de Color:** Puedes definir esquemas de colores para resaltar palabras clave (como "error", "warning", IPs, etc.), haciendo que la información importante salte a la vista.
-   **Fusión de Archivos:** Puede tomar varios archivos y fusionar su salida en una sola ventana, intercalando las líneas cronológicamente.
-   **Filtrado:** Puede actuar como `grep`, mostrando solo las líneas que coinciden (o no coinciden) con una expresión regular.
-   **Ejecución de Comandos:** No solo monitorea archivos, también puede monitorear la salida de comandos (como `ping` o `netstat`).

### Instalación en Ubuntu 24.04 LTS

`multitail` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y multitail
```

### Sintaxis Básica

```
multitail [OPCIONES] -i [ARCHIVO_1] -i [ARCHIVO_2] ...
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Para leer logs del sistema, se necesita `sudo`.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-i <file>`      | Añade un archivo a una nueva ventana.                                       |
| `-I <file>`      | Fusiona la salida de este archivo con la del anterior en la misma ventana.  |
| `-s N`           | Divide la pantalla en N columnas.                                           |
| `-cS <scheme>`   | Aplica un esquema de colores predefinido (ej: `apache`, `syslog`).          |
| `-e <regex>`     | Resalta una expresión regular con un color.                                 |
| `-ev <regex>`    | Invierte el filtro: oculta las líneas que coinciden con la regex.           |
| `-l <command>`   | Ejecuta un comando y muestra su salida en una ventana.                      |

### Configuración de Alias Permanente (Bash)

No se recomienda un alias, ya que `multitail` tiene una sintaxis y propósito muy diferentes a `tail`.

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Monitorizar un Servidor Web Completo (Acceso y Errores)

**Tarea:** Estás depurando un problema en un servidor web Apache/Nginx. Necesitas ver en tiempo real tanto las peticiones que llegan (`access.log`) como los errores que se producen (`error.log`).

**Comando:**
```bash
# Abre el log de acceso en una ventana y el de errores en otra
sudo multitail /var/log/nginx/access.log -i /var/log/nginx/error.log
```
**Utilidad:** Tu pantalla se dividirá en dos. Verás las peticiones de los usuarios en una mitad y, si una de esas peticiones causa un error, lo verás aparecer instantáneamente en la otra mitad. Es la forma más efectiva de correlacionar causa y efecto en un servidor web.

#### Ejercicio 2: Crear un Dashboard de Red Básico

**Tarea:** Sospechas de problemas de conectividad intermitentes. Quieres monitorizar la latencia a un host importante (como la puerta de enlace) y ver las conexiones activas al mismo tiempo.

**Comando:**
```bash
# -l ejecuta comandos. Dividimos la pantalla en 2 columnas (-s 2)
multitail -s 2 -l "ping 8.8.8.8" -l "ss -t"
```
**Utilidad:** Tendrás una ventana mostrando el `ping` constante a Google, lo que te alertará de cualquier pérdida de paquetes o aumento de latencia. En la otra ventana, `ss -t` (una alternativa a `netstat`) mostrará las conexiones TCP activas, actualizándose periódicamente. Es un dashboard de red simple pero efectivo.

#### Ejercicio 3: Filtrar y Colorear Logs de una Aplicación para Depuración

**Tarea:** Estás depurando una aplicación compleja que genera muchos logs. Solo te interesan las líneas que contienen "ERROR" o "DEBUG", y quieres que los errores se vean en rojo brillante.

**Comando:**
```bash
# -ev invierte el filtro para ocultar lo que NO es ERROR o DEBUG
# -e colorea la palabra ERROR en rojo
sudo multitail \
  -ev "^(?!.*(ERROR|DEBUG))" \
  -e "ERROR" -c red \
  /var/log/mi_aplicacion/app.log
```
**Utilidad:** Este comando crea una vista de log altamente enfocada. Elimina todo el ruido y resalta visualmente los problemas más críticos. Cuando estás buscando la aguja en el pajar durante una sesión de depuración intensa, este nivel de filtrado y coloreado no tiene precio.
