# 📡 11-bandwhich: Monitor de Ancho de Banda por Proceso y Conexión

`11-bandwhich` es una herramienta CLI avanzada para monitorear el uso de red en tiempo real por proceso, conexión y dirección remota.  
Ideal para entornos Linux donde se requiere visibilidad granular del tráfico, especialmente en servidores Ubuntu 20.04/24.04 LTS.

---

## ⚙️ Instalación en Ubuntu Server

### 1. Instalar Rust y Cargo (requerido para compilar)

```bash
sudo apt update
sudo apt install -y curl build-essential
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
```

### 2. Clonar y compilar el repositorio

```bash
git clone https://github.com/ZeinNoureddin/Bandwhich-Network-Monitoring-Tool.git
cd Bandwhich-Network-Monitoring-Tool
cargo build --release
```

### 3. Dar permisos de captura a la herramienta

```bash
sudo setcap cap_net_raw,cap_net_admin=eip target/release/bandwhich
```

---

## 🚀 Uso básico

```bash
sudo ./target/release/bandwhich
```

Esto inicia el monitoreo en tiempo real de la interfaz de red predeterminada.

---

## 🧩 Opciones disponibles

| Opción                  | ¿Qué hace?                                                                 | ¿Por qué usarla?                                                                 |
|-------------------------|-----------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| `--interface <iface>`   | Especifica la interfaz de red a monitorear (ej. `eth0`, `ens160`)           | Útil en servidores con múltiples interfaces o VLANs                             |
| `--raw`                 | Muestra salida sin formato, ideal para procesamiento por scripts            | Integración con herramientas de monitoreo personalizado                         |
| `--no-resolve`          | Evita resolución DNS de IPs remotas                                         | Mejora rendimiento y evita fugas de privacidad                                  |
| `--filter <regex>`      | Filtra procesos por nombre usando expresiones regulares                     | Focaliza el análisis en servicios críticos o sospechosos                        |
| `--help`                | Muestra ayuda integrada                                                     | Referencia rápida para operadores                                               |

---

## 🧠 Segmentación por Rol Técnico

### 🛠️ DevOps

- Integrar `bandwhich` en pipelines para validar consumo de red por servicio.
- Detectar procesos que generan tráfico inesperado tras despliegues.

### 🔐 SecOps

- Identificar procesos que comunican con IPs externas sin autorización.
- Usar `--no-resolve` para evitar que el monitoreo revele nombres DNS.

### 🌐 NetOps

- Auditar interfaces específicas con `--interface` para detectar congestión.
- Filtrar por procesos con `--filter` para correlacionar con logs de red.

### 🖥️ SysOps

- Monitorear en tiempo real el uso de red por daemon o servicio.
- Automatizar reportes con `--raw` y herramientas como `awk`, `jq`, `cron`.

### ⚙️ SRE

- Validar que servicios en producción no excedan límites de ancho de banda.
- Detectar regresiones de tráfico tras cambios en infraestructura.

---

## 📈 Ejemplo de uso avanzado

```bash
sudo ./target/release/bandwhich --interface eth0 --no-resolve --filter nginx
```

🔍 Esto monitorea solo la interfaz `eth0`, sin resolver DNS, y muestra tráfico generado por procesos que contienen "nginx".

---

## 📜 Licencia

Este proyecto está bajo la licencia MIT.  
Consulta el archivo `LICENSE.md` para más detalles.

---

## 🤝 Contribuciones

¿Quieres extender el soporte a más protocolos o agregar exportación a JSON?  
¡Tus PRs son bienvenidos!

---

<p align="center">
  <strong>🔎 Visibilidad total del tráfico. Precisión por proceso. Control por interfaz. Ideal para equipos técnicos que no se conforman con lo superficial.</strong>
</p>
