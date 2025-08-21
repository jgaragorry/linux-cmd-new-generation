# comando `btop`

## 🚀 La Alternativa Moderna a `top` y `htop`

`btop` es posiblemente el monitor de recursos más avanzado y visualmente impresionante para la terminal. Es el sucesor de `bashtop` y `bpytop`, reescrito en C++ para un rendimiento máximo.

### ¿Qué es y por qué es mejor?

-   **Interfaz Completa y Atractiva:** Muestra gráficos detallados de CPU, memoria, discos y red en una sola pantalla bien organizada.
-   **Soporte Completo para Ratón:** Toda la interfaz es navegable y operable con el ratón (clic, scroll, selección).
-   **Filtrado y Búsqueda Avanzados:** Permite filtrar procesos de forma muy sencilla e intuitiva.
-   **Gráficos de Rendimiento Histórico:** Al igual que `bottom`, guarda un historial del uso de recursos.
-   **Extremadamente Rápido:** A pesar de su complejidad visual, es muy ligero y consume pocos recursos.

### Instalación en Ubuntu 24.04 LTS

`btop` está disponible directamente en los repositorios oficiales de Ubuntu 24.04.

```bash
sudo apt update
sudo apt install -y btop
```

### Sintaxis Básica

```
btop [OPCIONES]
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Para ver detalles de todos los procesos o enviar señales a procesos de otros usuarios, se necesita `sudo`.

### Argumentos y Opciones Clave

| Opción           | Descripción                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `-l`, `--low-color` | Desactiva los colores verdaderos, para terminales antiguas.               |
| `-v`, `--version` | Muestra la versión.                                                       |
| `F1` o `h`       | Dentro de la aplicación, muestra la ayuda.                                  |
| `F2` o `o`       | Dentro de la aplicación, muestra las opciones de configuración.             |

### Configuración de Alias Permanente (Bash)

Reemplazar `top` y `htop` con `btop` es una actualización masiva.

```bash
alias top='btop'
```
*Nuestro script `configure_aliases.sh` ya hace esto por ti.*

### 🎓 Ejercicios Prácticos

#### Ejercicio 1: Identificar un Proceso con Fuga de Memoria (Memory Leak)

**Tarea:** El rendimiento del servidor se degrada con el tiempo y sospechas de una fuga de memoria en una aplicación Java.

**Comando:**
```bash
# Inicia btop y ordena los procesos por uso de memoria
btop
```
**Utilidad:** Dentro de `btop`, puedes hacer clic en la cabecera de la columna "Memory" para ordenar los procesos por su consumo. Observa el gráfico de memoria global. Si ves una tendencia ascendente constante a lo largo de las horas, y en la lista de procesos una aplicación Java específica (`java`) incrementa su uso de memoria sin parar, has encontrado al culpable de la fuga de memoria.

#### Ejercicio 2: Enviar Señales a un Grupo de Procesos

**Tarea:** Un servicio web (ej: Apache) se ha quedado colgado y tiene múltiples procesos hijos que no responden. Necesitas terminarlos todos de forma limpia (`SIGTERM`).

**Comando:**
```bash
btop
```
**Utilidad:** Presiona `F4` o `/` para filtrar y escribe "apache2" o "httpd". `btop` mostrará solo los procesos que coincidan. Con las flechas, selecciona el proceso principal, presiona la tecla `T` para "taggear" (marcar) el proceso y sus hijos, y luego presiona `k` para enviar una señal. Elige `SIGTERM` (15) y presiona Enter para terminar todos los procesos marcados de una sola vez.

#### Ejercicio 3: Analizar el Impacto de I/O de un Proceso de Backup

**Tarea:** Un backup nocturno está ralentizando otras aplicaciones. Quieres ver cuánta carga de lectura/escritura en disco está generando el proceso de backup (ej: `rsync`).

**Comando:**
```bash
btop
```
**Utilidad:** En `btop`, la vista de procesos muestra columnas para "Disk R/W" (Lectura/Escritura en Disco). Filtra por el proceso `rsync` y observa estas columnas. Al mismo tiempo, el widget de "Disks" te mostrará un gráfico con la actividad total del disco. Esto te permite cuantificar el impacto del backup y decidir si necesitas limitar su velocidad de I/O (por ejemplo, con `ionice`).
