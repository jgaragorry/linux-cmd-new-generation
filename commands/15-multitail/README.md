# 🧠 Comando `multitail` — Monitorización en Tiempo Real

## 📌 Descripción General
`multitail` es una versión avanzada del clásico `tail -f`. Permite visualizar múltiples archivos de log o salidas de comandos en una sola pantalla de terminal, dividida en ventanas, con resaltado de patrones y fusión de fuentes. Es ideal para correlación de eventos en tiempo real.

---

## 🧰 Instalación en Ubuntu Server 20.04 / 24.04 LTS

```bash
sudo apt update
sudo apt install -y multitail
```

✅ Disponible en los repositorios oficiales. No requiere entorno gráfico.

---

## 🧑‍💻 Fundamento Clave

| Herramienta | Cuándo usarla | Propósito |
|------------|----------------|-----------|
| `multitail` | Durante eventos en vivo | Monitorización activa, causa-efecto inmediata |
| `lnav`      | Post-mortem o análisis histórico | Navegación, búsqueda y consultas SQL sobre logs |

---

## 🧭 Navegación Básica

- `q`: Salir
- `PgUp` / `PgDn`: Desplazamiento por ventana
- `TAB`: Cambiar de ventana activa
- `Ctrl-C`: Detener comando en ejecución

---

## 🔍 Segmentación por Rol Técnico

### 🖥️ SysOps — Diagnóstico de Causa y Efecto del Sistema

```bash
sudo multitail /var/log/syslog -i /var/log/auth.log
```

🔧 **Qué hace**: Divide la pantalla en dos ventanas horizontales. La superior muestra `syslog`, la inferior `auth.log`.

🎯 **Cuándo usarlo**: Cuando necesitas correlacionar acciones de autenticación con respuestas del sistema.

📊 **Resultado esperado**: Verás eventos simultáneos en ambas ventanas. Ideal para reproducir problemas reportados por usuarios.

---

### 🔧 DevOps — Depuración Full-Stack en Tiempo Real

```bash
sudo multitail /var/log/nginx/access.log -cS apache_combined \
  -i /var/log/mi_app/app.log -cT syslog \
  -e "ERROR|TRACEBACK" -c red
```

🔧 **Qué hace**:
- Ventana 1: Log de Nginx con esquema de colores web.
- Ventana 2: Log de aplicación con resaltado de errores en rojo.

🎯 **Cuándo usarlo**: Durante despliegues, pruebas o cuando se reportan errores HTTP 500.

📊 **Resultado esperado**: Verás la petición fallida en Nginx y la traza del error en tu app, sincronizadas en tiempo real.

---

### 🧪 NetOps — Dashboard de Salud de Red

```bash
sudo multitail -s 2 -l "ping 8.8.8.8" -i /var/log/syslog
```

🔧 **Qué hace**: Divide la pantalla en dos columnas verticales. A la izquierda, salida de `ping`; a la derecha, `syslog`.

🎯 **Cuándo usarlo**: Para correlacionar caídas de red con eventos del sistema.

📊 **Resultado esperado**: Si ves un `Request timeout` junto a errores de conexión en `syslog`, puedes confirmar la causa.

---

### 🛡️ SecOps — Panel de Seguridad Activo

```bash
sudo multitail -M 0 /var/log/ufw.log /var/log/auth.log \
  -e "Failed password" -c red,bold \
  -e "UFW BLOCK" -c yellow
```

🔧 **Qué hace**:
- Fusiona ambos logs en una sola ventana.
- Resalta intentos fallidos de login en rojo y bloqueos de firewall en amarillo.

🎯 **Cuándo usarlo**: Para detectar patrones de ataque en tiempo real.

📊 **Resultado esperado**: Un ticker de eventos de seguridad que permite respuesta inmediata.

---

## 🧪 Ejemplos Reproducibles Validados

### ✅ Ejemplo 1: Monitorizar logs del sistema y autenticación

```bash
sudo multitail /var/log/syslog -i /var/log/auth.log
```

🔧 **Uso**: Diagnóstico de eventos del sistema relacionados con autenticación.

🎯 **Resultado**: Vista dividida con eventos sincronizados. Ideal para reproducir problemas reportados.

---

### ✅ Ejemplo 2: Simular monitoreo de red sin dependencias externas

```bash
sudo multitail -s 2 -l "ping 8.8.8.8" -i /var/log/syslog
```

🔧 **Uso**: Dashboard de conectividad y sistema.

🎯 **Resultado**: Latencia en tiempo real + eventos del sistema. Útil para NetOps y troubleshooting de red.

---

### ✅ Ejemplo 3: Panel de seguridad con logs fusionados

```bash
sudo multitail -M 0 /var/log/auth.log /var/log/syslog \
  -e "Failed password" -c red,bold \
  -e "error" -c yellow
```

🔧 **Uso**: Detección de intentos de acceso fallidos y errores del sistema.

🎯 **Resultado**: Vista consolidada con eventos resaltados. Ideal para monitoreo pasivo en entornos sensibles.

---

## 🧩 Comparación con Herramientas Tradicionales

| Herramienta     | Limitación                  | Ventaja de `multitail`               |
|------------------|-----------------------------|--------------------------------------|
| `tail -f`        | Solo un archivo, sin color  | Multiventana, resaltado, comandos    |
| `watch`          | No correlaciona             | Fusión de fuentes + color            |
| `tmux` + `tail`  | Requiere configuración      | `multitail` es plug-and-play         |

---

## ✅ Ventajas Clave

- 🧵 Multiventana en una sola terminal
- 🎨 Resaltado de patrones con colores
- 🔗 Fusión de múltiples logs en tiempo real
- 🧪 Ejecución de comandos como fuente de datos
- 🧠 Ideal para monitoreo activo y respuesta inmediata

---

## 📚 Recursos Adicionales

- [Repositorio oficial del comando multitail](https://github.com/jgaragorry/linux-cmd-new-generation/blob/main/commands/15-multitail/README.md)
- [Sitio oficial del proyecto multitail](https://www.vanheusden.com/multitail/)
- [Documentación extendida y ejemplos](https://linux.die.net/man/1/multitail)

---

> 🧠 Este README está diseñado para onboarding técnico, defensibilidad en auditorías y enseñanza por rol. Puedes clonarlo como plantilla para tu biblioteca de documentación reproducible.
