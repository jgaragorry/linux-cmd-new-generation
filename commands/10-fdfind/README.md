## ⚙️ Características Principales

A continuación se presentan comandos clave de `fd`, cada uno con una explicación detallada de su propósito y sintaxis.

---

### 🔄 Comparación de velocidad entre `fd` y `find`

```bash
time fd "*.conf" . /etc
```
- **Qué hace**: Mide el tiempo que tarda `fd` en buscar archivos con extensión `.conf` dentro de `/etc`.
- **Opciones**:
  - `"*.conf"`: patrón de búsqueda para archivos `.conf`.
  - `.`: directorio actual como punto de partida.
  - `/etc`: directorio objetivo.
- **Cuándo usarlo**: Para comparar rendimiento entre herramientas de búsqueda.

```bash
time find /etc -name "*.conf"
```
- **Qué hace**: Mide el tiempo que tarda `find` en buscar archivos `.conf` en `/etc`.
- **Comparación**: `fd` suele ser más rápido y más legible.

---

### 📋 Listar archivos con detalles

```bash
fd -e conf . /etc --list-details
```
- **Qué hace**: Busca archivos con extensión `.conf` en `/etc` y muestra detalles como permisos, tamaño y fecha.
- **Opciones**:
  - `-e conf`: filtra por extensión `.conf`.
  - `.`: punto de partida.
  - `/etc`: directorio objetivo.
  - `--list-details`: muestra metadatos del archivo.
- **Cuándo usarlo**: Para inspeccionar configuraciones del sistema.

---

### 📦 Buscar archivos grandes

```bash
fd --size +100M . /home --list-details
```
- **Qué hace**: Busca archivos mayores a 100 MB en `/home` y muestra sus detalles.
- **Opciones**:
  - `--size +100M`: archivos mayores a 100 megabytes.
  - `.`: punto de partida.
  - `/home`: directorio objetivo.
  - `--list-details`: muestra información adicional.
- **Cuándo usarlo**: Para identificar archivos que ocupan mucho espacio.

---

### 🔍 Búsqueda insensible a mayúsculas

```bash
fd -i "database" .
```
- **Qué hace**: Busca archivos o carpetas que contengan la palabra "database", sin importar mayúsculas/minúsculas.
- **Opciones**:
  - `-i`: búsqueda insensible a mayúsculas.
  - `"database"`: patrón de búsqueda.
  - `.`: directorio actual.
- **Cuándo usarlo**: Cuando no estás seguro de la capitalización exacta.

---

### 🚫 Excluir directorios

```bash
fd --exclude node_modules --exclude vendor .
```
- **Qué hace**: Busca archivos en el directorio actual, excluyendo `node_modules` y `vendor`.
- **Opciones**:
  - `--exclude`: omite directorios o archivos que coincidan con el patrón.
  - `.`: punto de partida.
- **Cuándo usarlo**: Para evitar resultados irrelevantes o pesados.

---

### 📁 Limitar profundidad de búsqueda

```bash
fd --max-depth 2 "*.conf" /etc
```
- **Qué hace**: Busca archivos `.conf` en `/etc`, pero solo hasta dos niveles de subdirectorios.
- **Opciones**:
  - `--max-depth 2`: limita la profundidad de búsqueda.
  - `"*.conf"`: patrón de archivo.
  - `/etc`: directorio objetivo.
- **Cuándo usarlo**: Para evitar búsquedas profundas que tarden mucho.

---

### 🧹 Buscar archivos temporales

```bash
fd "*.tmp" .
```
- **Qué hace**: Busca archivos con extensión `.tmp` en el directorio actual.
- **Opciones**:
  - `"*.tmp"`: patrón de archivo temporal.
  - `.`: punto de partida.
- **Cuándo usarlo**: Para limpieza de archivos temporales.

---

### 🔤 Soporte para caracteres especiales

```bash
fd "café|naïve" .
```
- **Qué hace**: Busca archivos que contengan las palabras "café" o "naïve".
- **Opciones**:
  - `"café|naïve"`: expresión regular con alternativas.
  - `.`: punto de partida.
- **Cuándo usarlo**: Para búsquedas con acentos o caracteres Unicode.

---

### 🧪 Uso de expresiones regulares

```bash
fd "^config.*\.json$" .
```
- **Qué hace**: Busca archivos que comiencen con "config" y terminen en `.json`.
- **Opciones**:
  - `"^config.*\.json$"`: expresión regular.
  - `.`: punto de partida.
- **Cuándo usarlo**: Para búsquedas avanzadas con patrones precisos.

---

¿Te gustaría que también reescriba las secciones de Integraciones, Configuración Personalizada y Flujos de Trabajo con este mismo nivel de detalle?
