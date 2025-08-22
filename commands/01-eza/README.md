# comando `exa`

## 🚀 La Alternativa Moderna a `ls` y `tree`

`exa` es un reemplazo moderno para el comando `ls`. Escrito en Rust, es rápido, seguro y viene con características que `ls` no tiene por defecto.

### ¿Qué es y por qué es mejor?

-   **Colores por defecto:** Identifica tipos de archivo, permisos y tamaños de un vistazo.
-   **Iconos:** Soporte para Nerd Fonts que añade iconos según el tipo de archivo (¡genial!).
-   **Vista de Árbol (`tree`):** Incorpora la funcionalidad de `tree` de forma nativa.
-   **Conciencia de Git:** Muestra el estado de los archivos en un repositorio Git (nuevo, modificado, etc.).
-   **Más rápido:** En directorios grandes, su rendimiento es notablemente superior.

### Instalación en Ubuntu 24.04 LTS

`exa` no está en los repositorios por defecto de Ubuntu 24.04, por lo que debemos añadir el repositorio de su mantenedor.

```bash
# 1. Instalar prerrequisitos
sudo apt update
sudo apt install -y gpg wget

# 2. Crear el directorio para las llaves GPG
sudo apt install -y exa
```

### Sintaxis Básica

La sintaxis es muy similar a `ls` para facilitar la transición.

```
exa [OPCIONES] [RUTAS]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario del sistema puede ejecutar `exa` para listar los archivos a los que tenga permiso de lectura.

### Argumentos y Opciones Clave

| Opción               | Descripción                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| `-l`, `--long`       | Muestra la vista larga con detalles (permisos, dueño, tamaño, fecha).    |
| `-a`, `--all`        | Muestra todos los archivos, incluyendo los ocultos (que empiezan con `.`).|
| `-T`, `--tree`       | Muestra los archivos en una estructura de árbol.                         |
| `--icons`            | Muestra iconos junto a los nombres de archivo (requiere Nerd Font).      |
| `--git`              | Muestra el estado de Git para cada archivo.                              |
| `-s`, `--sort`       | Ordena la salida (ej: `size`, `modified`, `name`).                       |
| `-h`, `--header`     | Añade una cabecera a la vista de columnas.                               |
| `--grid`             | Muestra los archivos en una cuadrícula.                                  |

### Configuración de Alias Permanente (Bash)

Para reemplazar `ls` por completo, añade estos alias a tu archivo `~/.bash_aliases` o `~/.bashrc`:

```bash
alias ls='exa --icons'
alias ll='exa -l --icons'
alias la='exa -la --icons'
alias ltree='exa --tree --icons'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Inspección Rápida de un Directorio de Configuración

**Tarea:** Como administrador, necesitas ver rápidamente los archivos de configuración de Nginx, incluyendo permisos, dueño y archivos ocultos, para diagnosticar un problema.

**Comando:**
```bash
# Navega al directorio y usa el alias 'la' que creamos
cd /etc/nginx
la
```
**Utilidad:** Verás instantáneamente si hay archivos ocultos (`.swp`, `.bak`) o si los permisos (`-rw-r--r--`) y el dueño (`root:root`) son correctos, todo con colores que facilitan la lectura.

#### Ejercicio 2: Visualizar la Estructura de un Proyecto con Estado de Git

**Tarea:** Eres un desarrollador y acabas de clonar un repositorio. Quieres entender su estructura de directorios y ver qué archivos fueron modificados recientemente por un compañero.

**Comando:**
```bash
# Navega al directorio del proyecto
cd /ruta/a/tu/proyecto
exa --tree --git
```
**Utilidad:** Este comando te dará un mapa visual de todo el proyecto. Además, al lado de cada archivo modificado aparecerá una `M` amarilla, o una `N` verde para los nuevos, dándote una visión clara del estado actual del repositorio sin necesidad de ejecutar `git status`.

#### Ejercicio 3: Encontrar los Archivos de Log más Pesados

**Tarea:** El disco del servidor se está llenando. Sospechas de los logs en `/var/log`. Necesitas listar todos los archivos en ese directorio, ordenados por tamaño, para identificar al culpable.

**Comando:**
```bash
# El flag -s ordena por un campo, -r revierte el orden (de mayor a menor)
exa -l -s size -r /var/log
```
**Utilidad:** Este comando es mucho más directo que un `ls -l | sort -k 5 -nr`. Te muestra inmediatamente los archivos más grandes en la parte superior, permitiéndote identificar y actuar sobre los logs que están consumiendo espacio de forma descontrolada.
