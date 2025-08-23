# comando `glances`

## 🚀 La Alternativa Moderna a `top`, `iotop`, `nethogs` y más

`glances` es la navaja suiza de la monitorización en terminal. Su objetivo es presentar la máxima cantidad de información del sistema en una sola pantalla, de forma dinámica y en múltiples modos, incluyendo una potente interfaz web.

### ¿Qué es y por qué es mejor?

-   **Todo en Uno:** Combina la funcionalidad de `top` (procesos), `htop` (procesos mejorado), `iotop` (I/O de disco), y `nethogs` (uso de red) en una sola interfaz cohesiva.
-   **Multi-Modo:** Funciona en tres modalidades principales: como una aplicación de terminal local (estándar), como un servidor web con una interfaz gráfica, y en modo cliente/servidor para monitorización remota de terminal a terminal.
-   **Alertas Configurables:** Resalta los valores que superan umbrales predefinidos (ej: CPU > 90%) en colores de advertencia o críticos, permitiéndote ver problemas de un vistazo.
-   **Extensible:** Puede monitorizar un ecosistema enorme gracias a sus plugins: contenedores Docker, sensores de temperatura, GPUs NVIDIA, y mucho más.

### Instalación en Ubuntu 24.04 LTS

`glances` está disponible en los repositorios de Ubuntu. Para funcionalidades extra como la interfaz web, se recomiendan paquetes adicionales.

```bash
# Instalación básica
sudo apt update
sudo apt install -y glances

# Para la interfaz web (muy recomendado)
sudo apt install -y python3-bottle
```

### Sintaxis Básica

`glances` se puede invocar de varias maneras dependiendo del modo que desees utilizar:

```bash
# 1. Modo Estándar (en la terminal local)
glances
```

### ¿Quién puede ejecutarlo?

Cualquier usuario. Se recomienda ejecutarlo con `sudo glances` para poder ver detalles de todos los procesos y discos del sistema.

---

#### Ejercicio 1: Diagnóstico Rápido en la Terminal (Modo Estándar)

**Tarea:** El rendimiento de tu servidor es lento. Sospechas que un proceso está escribiendo o leyendo excesivamente del disco, pero no sabes cuál.

**Comando:**
```bash
sudo glances
```
**Procedimiento:**
1.  Una vez dentro de la interfaz de `glances`, observa la sección de procesos.
2.  Presiona la tecla `d` para mostrar/ocultar las estadísticas de I/O de disco.
3.  Presiona la tecla `i` para ordenar la lista de procesos por su actividad de I/O (lectura/escritura).
**Utilidad:** El proceso que esté en la cima de la lista es el culpable de la alta actividad de disco. `glances` te muestra al instante cuántos bytes por segundo está utilizando, permitiéndote diagnosticar cuellos de botella de I/O en segundos sin necesidad de otra herramienta.

---
