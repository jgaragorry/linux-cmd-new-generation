# comando `procs`

## 🚀 La Alternativa Moderna a `ps`

`procs` es una reimplementación de `ps` escrita en Rust. Ofrece una visualización más amigable, con colores, información adicional y una búsqueda más intuitiva.

### ¿Qué es y por qué es mejor?

-   **Salida Legible:** Colorea la salida y la formatea en una tabla clara por defecto.
-   **Búsqueda por Palabra Clave:** No necesitas complicados `ps aux | grep ...`. Simplemente escribes `procs <palabra>`.
-   **Vista de Árbol:** Puede mostrar la jerarquía de procesos (`pstree`).
-   **Información Adicional:** Muestra información útil como puertos TCP/UDP abiertos por el proceso y acceso a métricas de contenedores Docker/LXC.
-   **Paginación por Defecto:** Al igual que `bat`, si la salida es muy larga, la envía a un paginador.

### Instalación en Ubuntu 24.04 LTS

`procs` no está en los repositorios de Ubuntu. Se instala con `cargo`.

```bash
# 1. Asegúrate de tener Rust/Cargo instalado
source "$HOME/.cargo/env"

# 2. Instala procs
cargo install procs
```

### Sintaxis Básica

```
procs [OPCIONES] [PALABRA_CLAVE]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Con `sudo` muestra más información sobre procesos del sistema.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `--tree`         | Muestra los procesos en formato de árbol.                                   |
| `procs bash`     | lista los procesos que inian con bash).                                     |
| `procs 0`        | lsito lso proceso con PID 0                                                 |


### Configuración de Alias Permanente (Bash)

Reemplazar `ps` con `procs` para búsquedas rápidas es muy conveniente.

```bash
alias ps='procs'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Encontrar Qué Proceso está Usando un Puerto Específico

**Tarea:** Intentas iniciar un servicio web y te da un error de "Address already in use" en el puerto 8080. Necesitas encontrar y terminar el proceso que ya está ocupando ese puerto.

**Comando:**
```bash
# Busca por el número de puerto
sudo procs 8080
```
**Utilidad:** A diferencia del engorroso `sudo lsof -i :8080` o `ss -ltnp | grep 8080`, `procs` te mostrará directamente el proceso que tiene abierto el puerto 8080. Verás su PID, usuario y comando, listo para que lo termines con `kill`.

#### Ejercicio 2: Entender la Jerarquía de un Servicio

**Tarea:** Quieres ver el proceso "maestro" de tu servidor de base de datos (ej: `mariadbd`) y todos los procesos "trabajadores" que ha generado.

**Comando:**
```bash
procs --tree mariadb
```
**Utilidad:** Esto te dará una vista de árbol clara, mostrando el proceso principal `mariadbd` y todos sus hijos anidados. Es mucho más visual y fácil de entender que la salida de `pstree` y te permite confirmar que el servicio está estructurado y corriendo como esperas.

#### Ejercicio 3: Monitorizar los Procesos de un Usuario Específico

**Tarea:** Sospechas que un usuario (`www-data`, por ejemplo) está consumiendo demasiados recursos. Quieres observar en tiempo real qué procesos está ejecutando y cuál es su consumo.

**Comando: Personalización Avanzada**
```bash
# El modo watch (--watch) refresca la pantalla, y el argumento filtra por usuario
procs --watch 2 www-data
procs --watch 1 --sortd cpu  # Top procesos por CPU
procs --watch 3 --sortd mem  # Top procesos por memoria
```

**Comando: Buscar Procesos Específicos**
```bash
# Buscar Procesos Específicos Buscar systemd AND root
 procs -a systemd root

# Buscar Procesos Específicos Buscar systemd OR root
procs -o systemd root
```

**Comando:**
```bash
# Configuración persistente
procs --generate-config > ~/.config/procs/procs.toml

# Usar tema de colores
procs --theme dark
procs --theme light
procs --theme auto
```

**Utilidad:** Este comando te da un `top` personalizado, filtrado solo para el usuario `www-data`. Es una forma extremadamente rápida de aislar y monitorizar la actividad de un usuario sin tener que configurar filtros complejos en `top` o `htop`.
