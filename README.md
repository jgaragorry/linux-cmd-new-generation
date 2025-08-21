# 🐧 New Generation Command Line Linux 🚀

¡Bienvenido al curso y repositorio de "Comandos de Nueva Generación para Linux"!

Este espacio está diseñado para modernizar tu caja de herramientas de la terminal. Aquí descubrirás, aprenderás a instalar y dominarás un conjunto de utilidades modernas, rápidas y visualmente atractivas que son alternativas superiores a los comandos clásicos que has usado por años (`ls`, `cat`, `du`, `df`, `top`, `ps`, `find`, `grep`, `dig`, etc.).

**🎯 Nuestro Objetivo:** Que te vuelvas más rápido, más eficiente y disfrutes más tu tiempo en la terminal TTY.

**🧑‍💻 Audiencia:** Administradores de Sistemas Linux, Desarrolladores, DevOps y cualquier entusiasta de la terminal que trabaje sobre **Ubuntu Server 24.04 LTS**.

---

### 🗂️ Estructura del Repositorio

Todo está organizado para un fácil aprendizaje:

-   **/commands**: Cada herramienta tiene su propio directorio con un `README.md` detallado que incluye:
    -   **Qué es** y por qué es mejor que su contraparte clásica.
    -   **Instrucciones de instalación** paso a paso en Ubuntu Server 24.04 LTS.
    -   **Sintaxis**, opciones clave y quién puede ejecutarlo.
    -   **3 ejercicios prácticos** 100% útiles para el día a día.
-   **/scripts**: Contiene scripts para automatizar la instalación y configuración.

---

### ⚡ Quick Start: Instalación y Configuración

Hemos preparado unos scripts para que empieces a trabajar en minutos.

#### Paso 1: Prerrequisitos

Algunas herramientas necesitan el gestor de paquetes de Rust, `cargo`. Otras, un repositorio externo. Nuestro script se encargará de todo. Primero, asegúrate de tener `curl` y `gpg`:

```bash
sudo apt update && sudo apt install curl gpg -y
```

#### Paso 2: Ejecutar el Script de Instalación

Este script instalará todas las herramientas listadas en el curso.

```bash
# Descarga y ejecuta el script de instalación
curl -sL https://URL_DEL_SCRIPT_install_tools.sh | bash
```
*(Nota: Deberás subir el script `install_tools.sh` a tu repositorio para que esta URL funcione)*

#### Paso 3: Configurar Alias Permanentes

Para reemplazar de verdad los comandos antiguos, necesitamos crear alias. Nuestro script lo hace fácil.

```bash
# Descarga y ejecuta el script de configuración de alias
curl -sL https://URL_DEL_SCRIPT_configure_aliases.sh | bash

# Aplica los cambios a tu sesión actual
source ~/.bashrc
```
*(Nota: Deberás subir el script `configure_aliases.sh` a tu repositorio)*

¡Y listo! Ya puedes usar `ls`, `cat`, `df`, etc., y en realidad estarás ejecutando `eza`, `bat`, `duf`.

---

### 🛠️ Las Herramientas del Futuro

| Herramienta Moderna | Reemplaza a... | Descripción Breve                                       |
| :------------------ | :------------- | :------------------------------------------------------ |
| **eza** | `ls`, `tree`   | Un listador de archivos con colores, iconos y Git-awareness. |
| **bat** | `cat`          | Un `cat` con resaltado de sintaxis y paginación.      |
| **dust** | `du`           | Visualiza el uso de disco de forma intuitiva.           |
| **duf** | `df`           | Un `df` con salida colorida, tabular y fácil de leer.   |
| **gdu** | `du`, `ncdu`   | Analizador de uso de disco increíblemente rápido.       |
| **bottom (btm)** | `top`          | Monitor de sistema gráfico y personalizable.            |
| **btop** | `top`, `htop`  | El monitor de recursos más completo y visual.           |
| **glances** | `top`, `iotop` | Monitor de sistema todo-en-uno con API y web UI.        |
| **procs** | `ps`           | Un `ps` con colores, formato de árbol y Docker-awareness. |
| **fdfind (fd)** | `find`         | Una alternativa a `find` simple, rápida e intuitiva.    |
| **bandwhich** | `nethogs`      | Muestra el uso de ancho de banda por proceso y conexión.|
| **ripgrep (rg)** | `grep`         | Un `grep` recursivo y ultra-rápido.                     |
| **dog** | `dig`, `nslookup`| Un cliente DNS colorido y amigable.                   |
| **lnav** | `tail`, `less` | Visor avanzado de logs que los enriquece y formatea.    |
| **multitail** | `tail -f`      | Monitorea múltiples archivos de log en una sola pantalla. |

---
¡Explora el directorio `commands` para empezar a dominar cada herramienta!
