# EWW - Análisis Completo
# Fecha: 2026-05-11
# Estado: En revisión

---

## 1. estado ACTUAL

### ✅ Scripts Funcionando (100%)

| Script | Estado | Notas |
|--------|--------|-------|
| weather.sh | ✅ OK | Devuelve temp, condition, icon, humidity |
| music.sh | ✅ OK | status, title, artist, cover |
| system.sh | ✅ OK | cpu, memory, disk, temp |
| audio.sh | ✅ OK | volume, icon (devuelve 50 por defecto sin hardware) |
| battery.sh | ✅ OK | percent, status, icon (0% por ser desktop) |
| network.sh | ✅ OK | upload, download, speeds |
| calendar.sh | ✅ OK | year, month, week0-5 |
| cal_nav.sh | ✅ OK | prev, next, reset, day, hide_day |
| cal_lang.sh | ✅ OK | toggle, get |
| date_lang.sh | ✅ OK | month, weekday, time |
| football.sh | ✅ OK | json, live (usa ESPN API) |
| football_wrapper.sh | ✅ OK | wrapper con fallback |
| gcal_wrapper.sh | ✅ OK | today, week, unahur_classes, unahur_upcoming, indie |
| gcal_auth.py | ✅ OK | Autenticación Google OAuth |
| gcal.py | ✅ OK | API de Google Calendar |
| toggle-calendar.sh | ✅ OK | Toggle calendar_window |
| toggle-dashboard.sh | ✅ OK | Toggle dashboard_window |
| toggle-all-widgets.sh | ✅ OK | Toggle multiple widgets |
| toggle_lang.sh | ✅ OK | Cambia idioma ES/EN |
| dashboard-status.sh | ✅ OK | Estado del dashboard |
| active-workspace.sh | ⚠️ OK | Funciona pero necesita `socat` |
| network-status.sh | ✅ OK | wifi/ethernet status |
| brightness.sh | ✅ OK | percent, icon (0% por ser desktop) |
| storage.sh | ✅ OK | total, used, free, percent |
| note_write.py | ✅ OK | Escritura de notas |
| note_save.sh | ✅ OK | Guardado de notas |
| save_note.sh | ✅ OK | Guardado con stdin/arg |
| note_wrapper.sh | ✅ OK | Wrapper para notas |
| notes.sh | ✅ OK | list, create, delete, update |

### ⚠️ Scripts con Warnings (No críticos)

| Script | Warning | Severidad |
|--------|---------|-----------|
| active-workspace.sh | socat no instalado | Baja - pierde actualizaciones en tiempo real |
| audio.sh | Devuelve 50% | Baja - sin hardware de audio configurable |
| battery.sh | 0% / "No Battery" | Baja - es desktop sin batería |
| brightness.sh | 0% | Baja - sin panel de brillo |

---

## 2. LO QUE ESTÁ IMPLEMENTADO (según eww.yuck)

### ✅ Widgets Definidos

1. **Dashboard Window** - weather, media, system stats, controls
2. **Date Window** - fecha, calendario, Google Calendar
3. **Football Window** - partidos de Promiedos
4. **Notes Window** - notas sticky
5. **Settings Window** - panel de toggles

### ✅ Polls Implementados

- Weather: temp, condition, icon, humidity
- Media: status, title, artist, cover
- System: cpu, cpu_percent, memory, cpu_temp, storage_percent
- Audio: volume, icon
- Date: day, month, year, weekday, time
- Calendar: month_num, year, month, week0-5
- Google Calendar: today, week, next, indie, unahur_classes, unahur_upcoming
- Football: data
- Notes: list

---

## 3. LO QUE FALTA / CORRECCIONES NECESARIAS

### 🔴 Correcciones Críticas

| Item | Problema | Solución |
|------|----------|----------|
| active-workspace.sh | socat no está instalado | Instalar `socat` o usar alternativa |

### 🟡 Mejoras Sugeridas

| Item | Problema | Sugerencia |
|------|----------|------------|
| Quick Launcher | Usa `blender`, `google-chrome-stable`, `thunar` que pueden no existir | Revisar botones o hacerlos condicionales |
| Config hardcodeada | paths como `/home/sanodesu/` en vez de `$HOME` | Usar variables de entorno |
| Intervalos | Algunos polls tienen intervalos muy cortos (1s) | Ajustar para rendimiento |

### 🟢 Funcionalidades que Podrían Agregarse

| Funcionalidad | Descripción |
|---------------|--------------|
| Network speed graphs | Graficar uso de red histórico |
| CPU/Memory history | Histórico de uso del sistema |
| Custom colors per widget | Paletas de color configurables |
| Theme toggle | Cambiar entre tema claro/oscuro |
| Music controls | Play/Pause/Next/Prev desde EWW |

---

## 4. COBERTURA DE TESTS ACTUAL

| Script | Tests BATS | Tests Pytest |
|--------|------------|--------------|
| weather.sh | 15 | 0 |
| music.sh | 13 | 0 |
| system.sh | 10 | 0 |
| audio.sh | 10 | 0 |
| battery.sh | 13 | 0 |
| network.sh | 13 | 0 |
| calendar.sh | 14 | 0 |
| cal_nav.sh | 11 | 0 |
| cal_lang.sh | 6 | 0 |
| date_lang.sh | 8 | 0 |
| football.sh | 11 | 0 |
| football_wrapper.sh | 5 | 0 |
| gcal_wrapper.sh | 8 | 0 |
| gcal_auth.py | 12 | 0 |
| toggle-*.sh | 31 | 0 |
| note_*.sh | 29 | 0 |
| storage.sh | 9 | 0 |
| network-status.sh | 12 | 0 |
| brightness.sh | 8 | 0 |
| dashboard-status.sh | 7 | 0 |
| active-workspace.sh | 7 | 0 |

---

## 5. RECOMENDACIONES INMEDIATAS

### Para Hoy
1. ⬜ Instalar `socat` para active-workspace.sh
2. ⬜ Revisar quick launcher buttons

### Para Esta Semana
3. ⬜ Reemplazar paths hardcodeados con `$HOME`
4. ⬜ Agregar verificación de existencia de apps en quick launcher
5. ⬜ Optimizar intervalos de polls

### Para Este Mes
6. ⬜ Agregar integración con más APIs ( opcional)
7. ⬜ Crear más tests de integración
8. ⬜ Documentar configuración

---

**Documento creado:** 2026-05-11
**Última actualización:** 2026-05-11