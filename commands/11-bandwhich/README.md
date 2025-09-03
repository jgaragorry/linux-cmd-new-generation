# 📡 bandwhich — Monitor de Red por Proceso, Conexión y Dirección Remota

`bandwhich` es una herramienta CLI escrita en Rust que permite visualizar en tiempo real el uso de red por proceso, conexión y dirección remota.  
Ideal para entornos Linux donde se requiere visibilidad granular del tráfico, especialmente en servidores Ubuntu Server 20.04 y 24.04 LTS.

---

## ⚙️ Instalación paso a paso

### 1️⃣ Instalar Rust y Cargo

Rust es necesario para compilar `bandwhich`. Cargo es su gestor de paquetes.

```bash
sudo apt update
sudo apt install -y curl build-essential
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
```

🔍 *Este paso instala Rust y configura el entorno para compilar herramientas como `bandwhich`.*

---

### 2️⃣ Clonar el repositorio oficial

```bash
git clone https://github.com/imsnif/bandwhich.git
cd bandwhich
```

🔍 *Usamos el repositorio oficial porque contiene el archivo `Cargo.toml` necesario para compilar.*

---

### 3️⃣ Compilar el binario en modo release

```bash
cargo build --release
```

🔍 *Esto genera el ejecutable optimizado en `./target/release/bandwhich`.*

---

### 4️⃣ Otorgar permisos de captura sin sudo

```bash
sudo setcap cap_net_raw,cap_net_admin=eip ./target/release/bandwhich
```

🔍 *Permite que `bandwhich` acceda a sockets de red sin requerir `sudo` en cada ejecución.*

---

## 🚀 Ejecución básica

```bash
./target/release/bandwhich
```

🔍 *Esto inicia el monitoreo en tiempo real sobre la interfaz de red predeterminada.*

---

## 🧩 Opciones disponibles

| Opción                  | Descripción técnica                                                       | Uso recomendado por rol técnico                                               |
|-------------------------|---------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| `--interface <iface>`   | Monitorea una interfaz específica (ej. `eth0`, `ens160`)                  | NetOps, SRE: para auditar tráfico por VLAN o túnel                            |
| `--no-resolve`          | Evita resolución DNS de IPs remotas                                       | SecOps, SRE: para evitar fugas de privacidad y mejorar rendimiento            |
| `--raw`                 | Muestra salida sin formato interactivo                                    | SysOps, DevOps: para exportar a logs o procesar con scripts                   |
| `--filter <regex>`      | Filtra procesos por nombre usando expresiones regulares                   | SecOps, DevOps: para focalizar en servicios críticos o sospechosos            |
| `--help`                | Muestra ayuda integrada                                                   | Todos los roles: referencia rápida                                            |

---

## 🖥️ Interfaz de salida en tiempo real

Al ejecutar `bandwhich`, se despliega una pantalla dividida en tres paneles clave:

### 1️⃣ Process Name

📌 **Qué muestra:**  
Lista de procesos locales que están generando o recibiendo tráfico de red.

🔍 **Campos típicos:**
- Nombre del proceso (`nginx`, `sshd`, `curl`)
- PID (identificador del proceso)
- Bytes enviados y recibidos

🧠 **Interpretación por rol:**
- **DevOps:** Detecta procesos que generan tráfico inesperado tras despliegues.
- **SecOps:** Identifica procesos sospechosos que comunican con IPs externas.
- **SysOps:** Audita servicios activos y su consumo de red.

---

### 2️⃣ Remote Address

📌 **Qué muestra:**  
Direcciones IP remotas con las que los procesos locales están comunicando.

🔍 **Campos típicos:**
- IP remota (IPv4/IPv6)
- Puerto remoto
- Bytes enviados/recibidos

🧠 **Interpretación por rol:**
- **NetOps:** Correlaciona tráfico con logs de firewall y NAT.
- **SecOps:** Detecta conexiones a dominios no autorizados o sospechosos.
- **SRE:** Valida que servicios se comuniquen solo con endpoints esperados.

---

### 3️⃣ Utilization by Connection

📌 **Qué muestra:**  
Resumen de cada conexión activa, combinando proceso + IP remota + puerto.

🔍 **Campos típicos:**
- Proceso ↔ IP remota:puerto
- Bytes enviados/recibidos
- Protocolo (TCP/UDP)

🧠 **Interpretación por rol:**
- **DevOps:** Verifica que microservicios se comuniquen correctamente.
- **SysOps:** Detecta conexiones persistentes que podrían indicar fugas de recursos.
- **SRE:** Monitorea patrones de tráfico para detectar regresiones o picos.

---

## 🧪 Ejemplo de uso avanzado

```bash
./target/release/bandwhich --interface eth0 --no-resolve --filter nginx
```

🔍 *Monitorea solo la interfaz `eth0`, sin resolver DNS, y muestra tráfico generado por procesos que contienen "nginx".*

---

## 📊 ¿Se pueden obtener más paneles?

Actualmente, `bandwhich` muestra tres paneles fijos.  
Para obtener más granularidad o exportar datos:

- Usa `--raw` para salida sin formato.
- Redirige a archivo: `bandwhich --raw > log.txt`
- Procesa con herramientas como `awk`, `grep`, `jq` o `Python`.

🔍 *Esto permite crear dashboards personalizados o integraciones con Prometheus/Grafana.*

---

## 🧠 Segmentación por rol técnico

| Rol     | Aplicaciones clave |
|---------|---------------------|
| **DevOps**  | Validar tráfico por proceso tras despliegues. Detectar servicios mal configurados. |
| **SecOps**  | Auditar conexiones sospechosas. Detectar procesos que comunican con IPs externas. |
| **NetOps**  | Monitorear interfaces específicas. Correlacionar tráfico con logs de red. |
| **SysOps**  | Automatizar auditorías de red. Detectar procesos que consumen ancho de banda excesivo. |
| **SRE**     | Validar patrones de tráfico. Detectar regresiones o picos tras cambios en infraestructura. |

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
  <strong>🔎 Visibilidad en tiempo real. Precisión por proceso. Control por conexión. Ideal para entornos Linux críticos.</strong>
</p>
