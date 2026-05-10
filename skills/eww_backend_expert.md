# Experto Backend EWW — Scripts y Datos

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.

## Contexto del Proyecto
- **Rol:** Desarrollador de scripts backend para widgets EWW.
- **Objetivo:** Proporcionar datos confiables y rápidos a los widgets.

## Scripts Existentes

### 1. Notes (Sticky Notes)
**Ubicación:** `~/.config/eww/scripts/notes.sh`

**Funcionalidades:**
- JSON storage en `~/.local/share/eww/notes/notes.json`
- CRUD completo de notas
- Sistema de pinned
- Colores por nota (yellow, red, blue, green)
- Export/Import

**Comandos:**
```bash
# Listar notas
~/.config/eww/scripts/notes.sh list

# Crear nota
~/.config/eww/scripts/notes.sh create "Título" "Contenido" "#ffff00"

# Eliminar nota
~/.config/eww/scripts/notes.sh delete <note-id>

# Toggle pin
~/.config/eww/scripts/notes.sh toggle-pin <note-id>

# Actualizar campo
~/.config/eww/scripts/notes.sh update <note-id> title "Nuevo título"
~/.config/eww/scripts/notes.sh update <note-id> content "Nuevo contenido"
~/.config/eww/scripts/notes.sh update <note-id> color "#ff6b6b"
```

**Estructura JSON:**
```json
[{
  "id": "note-1234567890",
  "title": "Título",
  "content": "Contenido",
  "color": "#ffff00",
  "created": 1234567890,
  "modified": 1234567890,
  "pinned": false
}]
```

### 2. Football (Promiedos)
**Ubicación:** `~/.config/eww/scripts/football.py`

**Funcionalidades:**
- Web scraping de promiedos.com.ar
- Datos: Liga Profesional Argentina, Primera Nacional, Libertadores, Sudamericana, Copa Argentina
- Descarga logos a caché (`~/.cache/eww_football_logos/`)
- Actualización: cada 1 minuto

**Ejecución:**
```bash
python3 ~/.config/eww/scripts/football.py
```

**Salida JSON:**
```json
[{
  "league": "Liga Profesional Argentina",
  "league_logo": "/path/to/logo.png",
  "matches": [{
    "team1": "River",
    "team1_logo": "/path/to/team1.png",
    "team2": "Boca",
    "team2_logo": "/path/to/team2.png",
    "time": "20:00",
    "status": "Prog.",
    "score": ""
  }]
}]
```

### 3. Google Calendar
**Ubicación:** `~/.config/eww/scripts/gcal.py`

**Funcionalidades:**
- API de Google Calendar
- Múltiples calendarios: Personal, UNAHUR, Campus, Independiente, Festivos
- Filtros por keywords (parcial, vencimiento, videojuegos)

**Comandos:**
```bash
python3 ~/.config/eww/scripts/gcal.py today
python3 ~/.config/eww/scripts/gcal.py week
python3 ~/.config/eww/scripts/gcal.py next
python3 ~/.config/eww/scripts/gcal.py day 2026-05-10
python3 ~/.config/eww/scripts/gcal.py unahur_classes
python3 ~/.config/eww/scripts/gcal.py unahur_upcoming
python3 ~/.config/eww/scripts/gcal.py indie
```

## Reglas de Oro para Scripts

### Python
1. **DBUS Environment:** Siempre configurar antes de cualquier llamada del sistema
2. **JSON Output:** Usar `json.dumps()` con `ensure_ascii=False` para acentos
3. **Excepciones:** Try/catch con fallback a arrays vacíos `[]`
4. **Rendimiento:** Scripts deben ejecutarse rápido (máx 2-3 segundos)
5. **Cacheo:** Para datos que no cambian seguido, usar archivos de caché

### Bash
1. **set -e:** Terminar en error si hay fallo
2. **DBUS:** Exportar variables de entorno al inicio
3. **jq:** Usar para manipuleo de JSON
4. **Errores:** Redirigir a /dev/null si no importan: `2>/dev/null`

## Estructura de Proyecto

```
~/.config/eww/
├── eww.yuck          # Definición de widgets
├── eww.css           # Estilos
├── assets/           # Imágenes (logos, etc)
└── scripts/          # Scripts backend
    ├── notes.sh
    ├── football.py
    ├── gcal.py
    ├── calendar.sh
    ├── weather.sh
    ├── system.sh
    ├── audio.sh
    ├── battery.sh
    ├── brightness.sh
    └── music.sh
```

## Dependencias Comunes
- jq (manipuleo JSON)
- curl (HTTP requests)
- python3 (scripts Python)
- requests, beautifulsoup4 (web scraping)
- google-api-python-client, google-auth-oauthlib (Google Calendar)

## Referencias
- [Google Calendar API v3](https://developers.google.com/calendar/api/v3/reference)
- [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/)
- [jq Manual](https://stedolan.github.io/jq/manual/)