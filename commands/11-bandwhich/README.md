# 🛡️ Linux Privilege Escalation Toolkit - README

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/3/3f/TuxFlat.svg" alt="Linux Security" width="100"/>
</p>

Este repositorio contiene un conjunto de scripts y herramientas para simular, detectar y mitigar técnicas comunes de escalada de privilegios en sistemas Linux.  
Está diseñado para ser instalado en entornos **Ubuntu Server 24.04 LTS** y **20.04 LTS**, y puede ser utilizado por equipos de:

- 🛠️ DevOps: para validar configuraciones seguras antes del despliegue.
- 🔐 SecOps: para realizar auditorías de seguridad y pruebas de hardening.
- 🌐 NetOps: para verificar accesos y privilegios en servicios expuestos.
- 🖥️ SysOps: para mantener la integridad del sistema operativo.
- ⚙️ SRE: para automatizar validaciones de seguridad en pipelines CI/CD.

---

## 📦 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/tuusuario/linux-escalada-privilegios.git
cd linux-escalada-privilegios
```

### 2. Dar permisos de ejecución

```bash
chmod +x */*.sh
```

### 3. Instalar dependencias (si aplica)

```bash
sudo apt update
sudo apt install -y curl net-tools lsof
```

---

## 🚀 Uso por Rol Técnico

### 🛠️ DevOps

- Validar que los binarios SUID no estén mal configurados (`lab1_suid_path`)
- Verificar tareas cron inseguras (`lab2_insecure_cron`)
- Integrar scripts de verificación en pipelines

### 🔐 SecOps

- Simular ataques de escalada para evaluar defensas
- Usar `verify_exploit.sh` para comprobar si un sistema es vulnerable
- Aplicar `revert_fix.sh` como parte de políticas de remediación

### 🌐 NetOps

- Revisar servicios que ejecutan con privilegios innecesarios
- Detectar configuraciones de red que permiten acceso a recursos root

### 🖥️ SysOps

- Automatizar auditorías de permisos y tareas programadas
- Usar `setup_lab.sh` para crear entornos de prueba controlados

### ⚙️ SRE

- Integrar pruebas de seguridad en entornos de staging
- Validar que los cambios no introduzcan vectores de escalada

---

## 🔍 Explicación de Scripts

Cada laboratorio contiene 4 scripts clave:

| Script               | ¿Qué hace?                                                                 | ¿Por qué usarlo?                                                                 |
|----------------------|-----------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| `00_setup_lab.sh`    | Crea el entorno vulnerable (SUID o cron inseguro)                          | Simula condiciones reales para pruebas de seguridad                             |
| `01_exploit.sh`      | Ejecuta la técnica de escalada de privilegios                              | Permite validar si el sistema es explotable                                     |
| `02_verify_exploit.sh` | Comprueba si se obtuvo acceso root o privilegios elevados                 | Confirma el éxito del ataque y permite documentar el resultado                  |
| `03_revert_fix.sh`   | Elimina el entorno vulnerable y aplica mitigaciones                        | Restaura el sistema y enseña buenas prácticas de hardening                      |

---

## 🧪 Ejemplo de Ejecución

```bash
cd lab1_suid_path
bash 00_setup_lab.sh       # Crea el binario vulnerable
bash 01_exploit.sh         # Ejecuta el exploit
bash 02_verify_exploit.sh  # Verifica si se obtuvo root
bash 03_revert_fix.sh      # Limpia y mitiga
```

---

## 📘 Recomendaciones por Rol

| Rol     | Recomendación clave |
|---------|---------------------|
| DevOps  | Integrar `verify_exploit.sh` en pruebas de integración |
| SecOps  | Ejecutar `exploit.sh` en entornos aislados para evaluar riesgos |
| NetOps  | Auditar tareas cron y binarios SUID en servidores expuestos |
| SysOps  | Usar `revert_fix.sh` como parte de procedimientos de mantenimiento |
| SRE     | Automatizar `setup_lab.sh` y `verify_exploit.sh` en pipelines CI/CD |

---

## 📜 Licencia

Este proyecto está bajo la licencia MIT.  
Consulta el archivo `LICENSE` para más detalles.

---

## 🤝 Contribuciones

¿Tienes ideas para nuevos laboratorios o mejoras?  
¡Abre un issue o envía un pull request!

---

<p align="center">
  <strong>💡 Seguridad real para entornos reales. Simula, explota, verifica y fortalece tu infraestructura Linux.</strong>
</p>
