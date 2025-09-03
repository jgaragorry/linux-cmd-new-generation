# 🐶 `dog` — Cliente DNS moderno y legible para humanos

`dog` es una alternativa moderna a `dig`, diseñada para ofrecer una experiencia más clara, segura y amigable en la línea de comandos. Ideal para troubleshooting de redes, despliegues, seguridad y diagnósticos DNS.

---

## 🚀 ¿Por qué usar `dog` en vez de `dig`?

- ✅ **Salida legible y coloreada**: formato tabular, fácil de interpretar.
- ✅ **Sintaxis intuitiva**: `dog ejemplo.com MX` es más natural que `dig ejemplo.com MX`.
- ✅ **Soporte para DNS seguros**: incluye DNS-over-TLS (DoT) y DNS-over-HTTPS (DoH).
- ✅ **Detección automática de IP vs dominio**: simplifica búsquedas inversas.

---

## 📦 Instalación en Ubuntu Server 24.04 LTS (mínima)

```bash
# Instalar Rust y Cargo si no están presentes
sudo apt update
sudo apt install curl build-essential -y
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"

# Instalar dog (el paquete se llama dogdns)
cargo install dogdns
```

> 🧠 `dog` no está en los repos oficiales de Ubuntu, pero se instala fácilmente con `cargo`.

---

## 🔗 Alias recomendado para transición desde `dig`

```bash
# Alias temporal
alias dig='dog'

# Alias permanente en ~/.bashrc
echo "alias dig='dog'" >> ~/.bashrc
source ~/.bashrc
```

---

## 🧑‍💻 Segmentación por rol técnico

### 🖥️ SysOps / NetOps — Diagnóstico básico de DNS

```bash
# Verificar si un dominio existe
dog github.com @1.1.1.1

# Diagnóstico de dominio inexistente
dog mi-servicio-web.com @1.1.1.1
# Resultado esperado: Status: NXDomain
```

### 📬 SysAdmin — Diagnóstico de correo electrónico

```bash
# Verificar registros MX (correo)
dog gmail.com MX

# Verificar registros TXT (SPF, DKIM)
dog gmail.com TXT
```

### 🔧 DevOps / DevSecOps — Verificación post-despliegue

```bash
# Confirmar propagación de DNS en múltiples servidores
dog api.mi-app.com @1.1.1.1   # Cloudflare
dog api.mi-app.com @8.8.8.8   # Google
```

> ✅ Si ambos devuelven las mismas IPs, el cambio se ha propagado correctamente.

### 🛡️ SecOps — Consultas privadas y forenses

```bash
# Consulta segura usando DNS-over-TLS
dog -T google.com @1.1.1.1

# Búsqueda inversa de IP sospechosa
dog 8.8.4.4
# Resultado esperado: PTR ... dns.google.
```

---

## ⚙️ Uso básico

```bash
# Consulta A (dirección IP)
dog ejemplo.com

# Consulta MX (correo)
dog ejemplo.com MX

# Consulta TXT (SPF, DKIM, etc.)
dog ejemplo.com TXT

# Consulta segura con TLS
dog -T ejemplo.com @1.1.1.1

# Búsqueda inversa de IP
dog 8.8.8.8
```

---

## 🧪 Ejemplos reproducibles en sistemas recién instalados

```bash
# Verificar DNS de Google
dog google.com

# Verificar DNS de GitHub
dog github.com

# Verificar registros MX de Gmail
dog gmail.com MX

# Verificar registros TXT de Gmail
dog gmail.com TXT

# Consulta segura (DoT)
dog -T github.com @1.1.1.1

# Búsqueda inversa de IP pública
dog 8.8.8.8
```

> 🧠 Todos estos ejemplos funcionan sin configuración adicional en Ubuntu Server recién instalado con `dog` vía `cargo`.

---

## ✅ Ventajas clave

- 🔥 Salida clara y coloreada
- 🔒 Soporte para DNS seguros (DoT, DoH)
- 🧠 Inteligencia para detectar tipo de consulta
- 🧩 Ideal para scripts, auditorías y troubleshooting
- 🧵 Compatible con entornos minimalistas y TTY

---

## 📚 Recursos adicionales

- [Repositorio oficial del comando dog](https://github.com/jgaragorry/linux-cmd-new-generation/tree/main/commands/13-dog)
- [Crate dogdns en crates.io](https://crates.io/crates/dogdns)
- [Documentación extendida de dog](https://github.com/ogham/dog)

---

> 🧠 Este README está diseñado para onboarding técnico, defensibilidad en auditorías y enseñanza por rol. Puedes clonarlo como plantilla para tu biblioteca de documentación reproducible.
