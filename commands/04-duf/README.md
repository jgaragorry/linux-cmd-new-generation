# comando `duf`

## 🚀 La Alternativa Moderna a `df`

`duf` (Disk Usage/Free) es una reimplementación de `df` que prioriza una salida limpia, colorida y fácil de leer para los humanos.

### ¿Qué es y por qué es mejor?

-   **Salida Tabular y Clara:** Organiza la información en una tabla bien formateada, a diferencia de la salida a menudo desalineada de `df`.
-   **Uso de Colores:** Usa un degradado de color para indicar el uso del disco (verde -> amarillo -> rojo), permitiéndote identificar sistemas de archivos llenos de un solo vistazo.
-   **Agrupación Inteligente:** Agrupa y ordena los dispositivos de forma lógica (ej: discos locales, red, especiales).
-   **Información Relevante:** Se enfoca en mostrar la información que realmente importa, ocultando por defecto sistemas de archivos "falsos" o irrelevantes como `tmpfs`.
-   **JSON Output:** Puede exportar la información en formato JSON, ideal para scripting.

### Instalación en Ubuntu 24.04 LTS

`duf` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y duf
```

### Sintaxis Básica

```
duf [OPCIONES] [RUTAS]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario del sistema puede ejecutar `duf`.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                      |
| ---------------- | ---------------------------------------------------------------- |
| `--all`          | Muestra todos los sistemas de archivos, incluyendo los pseudo, duplicados y ocultos. |
| `--output`       | Especifica las columnas a mostrar (ej: `mountpoint,size,used`). |
| `--sort`         | Ordena la salida por una columna (ej: `size`, `used`, `avail`).   |
| `--json`         | Exporta la salida en formato JSON.                               |
| `--inodes`       | Muestra información sobre el uso de inodos en lugar de bloques.  |

### Configuración de Alias Permanente (Bash)

Hacer que `df` llame a `duf` es un cambio de calidad de vida inmediato.

```bash
alias df='duf'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Chequeo Rápido del Estado de Discos del Servidor

**Tarea:** Realizar la comprobación diaria del estado de los discos en un servidor para asegurarse de que ninguna partición crítica (`/`, `/var`, `/home`) esté cerca de su capacidad máxima.

**Comando:**
```bash
# Simplemente ejecuta df (que es nuestro alias de duf)
df
```
**Utilidad:** En lugar de analizar texto plano, obtendrás una tabla colorida. Si ves una barra roja, sabes inmediatamente que esa partición necesita atención. Es un chequeo de 2 segundos.

#### Ejercicio 2: Verificar el Uso de Inodos

**Tarea:** Has recibido una alerta de "No space left on device", pero `df` muestra que todavía hay espacio disponible. Sospechas que el problema es el agotamiento de inodos (causado por millones de archivos pequeños).

**Comando:**
```bash
duf --inodes
```
**Utilidad:** Este comando cambia la vista para mostrar el uso de inodos. Confirmarás al instante si una partición ha alcanzado el 100% de su capacidad de inodos, lo que te permitirá enfocar tus esfuerzos en encontrar y eliminar archivos pequeños innecesarios.

#### Ejercicio 3: Script para Monitorizar un Punto de Montaje Específico

**Tarea:** Quieres crear un script que verifique el uso de la partición `/srv/data` y te alerte si supera el 90%. Necesitas una forma fiable de obtener el porcentaje de uso.

**Comando:**
```bash
# Usamos el output JSON y la herramienta 'jq' para parsearlo
duf --json | jq '.[] | select(.mount_point=="/srv/data") | .usage'
```
**Utilidad:** La salida de `df` tradicional es difícil de "parsear" en un script de forma robusta. Al usar `duf --json` y `jq`, obtienes el valor numérico exacto del porcentaje de uso (ej: `0.91`), lo cual es perfecto para usar en una condición `if` dentro de un script de monitorización, haciéndolo más fiable y profesional.
