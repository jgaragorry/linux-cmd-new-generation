# comando `bottom` (`btm`)

## 🚀 La Alternativa Moderna a `top`

`bottom` es un monitor de sistema gráfico, multiplataforma y altamente personalizable. Presenta la información de una forma mucho más visual y densa que `top` o `htop`.

### ¿Qué es y por qué es mejor?

-   **Widgets Personalizables:** Puedes elegir qué información ver (CPU, memoria, red, discos, procesos, sensores) y cómo distribuirla en la pantalla.
-   **Gráficos Históricos:** Muestra gráficos del uso de CPU, memoria y red a lo largo del tiempo, facilitando la identificación de picos y tendencias.
-   **Soporte para Sensores:** Puede mostrar temperaturas de CPU/GPU y velocidades de ventiladores si están soportados.
-   **Navegación Intuitiva:** Se puede controlar con el teclado y el ratón (scroll, clics).
-   **Vista de Árbol para Procesos:** Muestra los procesos en una estructura jerárquica.

### Instalación en Ubuntu 24.04 LTS


```bash
# 2. Instala bottom
sudo snap install bottom

```
El comando para ejecutarlo es `btm`.

### Sintaxis Básica

```
btm [OPCIONES]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario puede ejecutarlo. Algunas métricas, como las de ciertos procesos del sistema, pueden requerir `sudo`.

### Argumentos y Opciones Clave

| Opción               | Descripción                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| `-C`, `--config`     | Especifica una ruta a un archivo de configuración personalizado.         |
| `-b`, `--basic`      | Inicia en modo básico, sin gráficos ni colores avanzados.                |
| `-g`, `--group`      | Agrupa procesos con el mismo nombre.                                     |
| `-T`, `--tree`       | Inicia con la vista de árbol de procesos activada.                       |
| `-t`, `--temperature_type` | Especifica la unidad de temperatura (k, f, c).                     |

### Configuración de Alias Permanente (Bash)

Aunque `btop` es un reemplazo más directo, si prefieres `bottom`, este alias es útil.

```bash
alias top='btm'
```

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Crear un Dashboard de Monitorización Específico

**Tarea:** Eres un administrador de bases de datos. Quieres un monitor que se enfoque en el uso de CPU, la actividad de I/O del disco donde reside la base de datos y los procesos específicos de PostgreSQL.

**Comando:**
```bash
# Inicia btm y personaliza la vista
btm
```
**Utilidad:** Dentro de `btm`, puedes presionar `L` para cambiar el layout. Puedes configurar un layout que solo muestre los widgets de CPU, Disk I/O y la tabla de procesos. Luego, en la tabla de procesos, puedes filtrar (`/`) por "postgres". `btm` recordará tu layout, dándote un dashboard a medida cada vez que lo inicies.

#### Ejercicio 2: Diagnosticar Picos de Carga de CPU

**Tarea:** Los usuarios reportan que una aplicación web se vuelve lenta intermitentemente. Sospechas que hay picos de carga de CPU.

**Comando:**
```bash
btm
```
**Utilidad:** Mantén `btm` abierto en una pantalla. Gracias a sus gráficos históricos, cuando ocurra el pico de lentitud, podrás ver una subida abrupta en el gráfico de CPU. Al mismo tiempo, en la tabla de procesos (ordenada por uso de CPU), verás qué proceso fue el causante del pico, permitiéndote diagnosticar el problema con precisión.

#### Ejercicio 3: Monitorizar la Temperatura del Servidor Durante una Tarea Intensiva

**Tarea:** Vas a ejecutar una compilación de software muy larga o un backup intensivo. Quieres asegurarte de que la temperatura del CPU del servidor se mantenga dentro de límites seguros.

**Comando:**
```bash
btm -t c
```
**Utilidad:** El widget de temperatura (`--temperature_type c` para Celsius) te dará una lectura en tiempo real de los sensores del sistema. Si ves que la temperatura se acerca a niveles peligrosos durante la tarea, puedes decidir pausarla o reducir su prioridad para evitar daños por sobrecalentamiento.
