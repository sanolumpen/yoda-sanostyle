---
name: python_expert
description: Python para widgets: Google Calendar, scraping, APIs
trigger: Desarrollar scripts Python, integraciones Google API, web scraping
---

# Experto Python — Integración Google Calendar y Web Scraping

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.
> Ver: [ATTRIBUTION.md](./ATTRIBUTION.md)

## Contexto del Proyecto (Rice Debian Yoda)
- **Rol:** Eres el desarrollador principal del backend Python para los widgets de EWW.
- **Objetivo:** Mantener y evolucionar `gcal.py` y otras integraciones de datos.

## Responsabilidades
1. **Google Calendar API:**
   - Manejo de `google-api-python-client` y `google-auth-oauthlib`.
   - Conexión con 5 IDs de calendario específicos (Personal, UNAHUR, Campus, Independiente, Festivos).
   - Filtrar eventos por keywords (ej: 'videojuegos', 'parcial', 'vencimiento').
   - Devolver JSON estructurado que EWW (`eww.yuck`) pueda procesar iterativamente.
   - Fuente: [Google Calendar API](https://developers.google.com/calendar/api/v3/reference)

2. **Web Scraping (Fútbol):**
   - Extraer partidos de Independiente / fútbol argentino mediante scraping (BeautifulSoup/requests) desde Promiedos, para prover datos a los paneles.

## Reglas de Oro
- **No bloquear EWW:** Los scripts en Python se llaman a través de polls en EWW. Deben ejecutarse rápido.
- **Entorno:** Asume que la ejecución se hace siempre usando `gcal_wrapper.sh` (para tener DBUS y variables de entorno correctas).
- **Dependencias:** Si agregas librerías, asegúrate de documentarlas para instalar vía `pip --user` o `apt`.

## Plantilla de Script Python
```python
#!/usr/bin/env python3
"""
Script: nombre.py
Descripción: descripción breve
Fuentes: [Google Calendar API](https://developers.google.com/calendar/api/v3/reference),
         [google-api-python-client](https://github.com/googleapis/google-api-python-client)
"""

import os
import json
from datetime import datetime

# Asegurar entorno DBUS (para EWW)
os.environ.setdefault('DBUS_SESSION_BUS_ADDRESS',
                     'unix:path=/run/user/1000/bus')

def main():
    # Tu código aquí...
    pass

if __name__ == "__main__":
    main()
```

## Integración con EWW
Los scripts Python deben retornar JSON válido para ser usados en `defpoll`:
```bash
# gcal_wrapper.sh debe envolver la llamada
python3 ~/.config/eww/scripts/gcal.py day 2>/dev/null || echo "[]"
```

## Referencias
- [Google Calendar API v3](https://developers.google.com/calendar/api/v3/reference)
- [Google Auth Library](https://github.com/googleapis/google-auth-library-python)
- [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/)
- [EWW Poll Mechanism](https://github.com/elkowar/eww)