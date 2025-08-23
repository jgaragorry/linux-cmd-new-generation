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

# 2. Instala bottom
```bash
sudo snap install bottom
```

# 2.1 Verificar la Instalcion
```bash
bottom --version
```

# 2.2 Crear alias (opcional pero recomendado)
```bash
echo "alias btm='bottom'" >> ~/.bashrc
source ~/.bashrc
```

El comando para ejecutarlo es `btm`.

### Sintaxis Básica

```
btm [OPCIONES]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario puede ejecutarlo. Algunas métricas, como las de ciertos procesos del sistema, pueden requerir `sudo`.

### Configuración de Alias Permanente (Bash)

Aunque `btop` es un reemplazo más directo, si prefieres `bottom`, este alias es útil.

```bash
alias top='btm'
```

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: MONITOREO GENERAL

**Comando:**
```bash
# Monitor estándar (1 segundo refresco)
btm

# Monitor con refresco lento (3 segundos) - Ideal para servidores
btm --rate 3000

# Monitor minimalista (modo básico, menos consumo)
btm --basic --rate 5000
```
**Utilidad:** Dentro de `btm`, puedes presionar `L` para cambiar el layout. Puedes configurar un layout que solo muestre los widgets de CPU, Disk I/O y la tabla de procesos. Luego, en la tabla de procesos, puedes filtrar (`/`) por "postgres". `btm` recordará tu layout, dándote un dashboard a medida cada vez que lo inicies.

#### Ejercicio 2: VISUALIZACIÓN DE PROCESOS

**Comando:**
```bash
# Ver procesos en árbol jerárquico (muy útil)
btm --tree

# Agrupar procesos por nombre
btm --group_processes

# Mostrar comando completo instead de nombre
btm --process_command
```

#### Ejercicio 3: MONITOREO DE RECURSOS ESPECÍFICOS

**Comando:**
```bash
# Enfoque en CPU y Memoria
btm --theme default --rate 2000

# Monitorear actividad de red (bits por segundo)
btm --network_use_bytes

# Monitorear disco y procesos
btm --basic --rate 3000
```

#### Ejercicio 4: TEMAS DE COLORES (Para mejor visualización)

**Comando:**
```bash
# Tema oscuro estándar
btm --theme default

# Tema Gruvbox (excelente contraste)
btm --theme gruvbox

# Tema Nord (azul profesional)
btm --theme nord

# Tema para fondos claros (SSH desde terminal clara)
btm --theme default-light
```

#### Ejercicio 5: MODO SÓLO LECTURA (Para monitoreo seguro)

**Comando:**
```bash
# Simplemente no usar teclas de interacción (k, F9)
btm --basic --rate 3000
```

#### Ejercicio 6: COMANDOS AVANZADOS

**Comando:**
```bash
# Mostrar memoria cache y buffers
btm --enable_cache_memory

# CPU usage sin normalizar por núcleos
btm --unnormalized_cpu

# Leyenda de red en posición específica
btm --network_legend right
```

#### Ejercicio 7: Para debugging de performance:

**Comando:**
```bash
btm --tree --rate 2000
```

#### Ejercicio 8: Para monitoreo de servidor remoto:

**Comando:**
```bash
btm --basic --rate 5000
```

#### Ejercicio 9: Para analizar consumo de memoria:

**Comando:**
```bash
btm --enable_cache_memory --theme gruvbox
```

#### Ejercicio 10: Para monitoreo de red:

**Comando:**
```bash
btm --network_use_bytes --rate 1000
```

#### Ejercicio 11: CONFIGURACIÓN PERSISTENTE:

**Comando:**
```bash
# Generar configuración personalizada
mkdir -p ~/.config/bottom
btm --generate-config > ~/.config/bottom/bottom.toml

# Editar configuración (opciones preferidas)
nano ~/.config/bottom/bottom.toml
```

#### Ejercicio 12: Ejemplo de configuración útil para administradores:

**Comando:**
```bash
rate = 3000
theme = "gruvbox"
group_processes = true
tree = true
basic = false
```

#### Ejercicio 12:  RESUMEN EJECUTIVO:

**Comando:**
```bash
Procedimiento que SÍ funciona:

sudo snap install bottom

Usar bottom o crear alias btm

Usar --theme instead de --color

Usar --rate para tiempo de refresco

Comando estrella: btm --tree --rate 3000

Para servidores: btm --basic --rate 5000
Para debugging: btm --tree --theme gruvbox
Para redes: btm --network_use_bytes

¡Este procedimiento está probado y garantizado que funciona en Ubuntu 22.04!
```
