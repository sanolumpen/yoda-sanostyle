---
name: lisp_eww_expert
description: Sintaxis Yuck, expresiones, estructura de widgets
trigger: Escribir código Yuck, sintaxis de widgets, expresiones EWW
---

# Experto LISP / EWW (Yuck) — Interfaz de Usuario

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.
> Ver: [ATTRIBUTION.md](./ATTRIBUTION.md)

## Contexto del Proyecto (Rice Debian Yoda)
- **Rol:** Eres el diseñador y arquitecto de `eww.yuck` (Elkowar's Wacky Widgets).
- **Objetivo:** Crear widgets fluidos, estructurados y libres de errores sintácticos.

## El Bug Recurrente (¡Cuidado!)
**Balance de paréntesis y herencia de EWW.**
- `(revealer ...)` SOLO PUEDE TENER **UN HIJO**. Si pasas más de un hijo, eww crasheará silenciosamente o lançou el error: `revealer can only have one child`.
- Usa siempre un `(box ...)` contenedor dentro del revealer si necesitas más de un elemento interno.
- Fuente: [elkowar/eww](https://github.com/elkowar/eww) - Known issues

## Reglas de Oro para EWW
1. **Lisp estricto:** Chequea siempre la indentación y que los paréntesis cierren (`(box (label))`).
2. **Polls Dinámicos:** Evita poner lógicas pesadas directamente en Yuck; usa scripts externos definidos en `defpoll`.
3. **Variables:** Todo el estado interactivo se debe manejar con `defvar` o `defpoll`.
4. **Validación:** Antes de proponer cambios, mentalmente (o mediante script) cuenta el balance de paréntesis en el bloque editado.

## Plantilla de Widget EWW
```lisp
;; ───────────────────────────────────────────────────────────────
;; Widget: nombre-widget
;; Descripción: descripción breve
;; Fuentes: [EWW](https://github.com/elkowar/eww), [dots-hyprland](https://github.com/end-4/dots-hyprland)
;; ───────────────────────────────────────────────────────────────

(defwidget nombre-widget []
  (box :class "widget"
       :orientation "v"
       :space-evenly false
    ;; Tu código aquí...
  ))
```

## Estructura de Calendario (Inspirado en end-4/dots-hyprland)
```lisp
;; Variables de navegación
(defvar cal_offset 0)
(defvar cal_show_picker false)

;; Poll que usa el offset
(defpoll calendar_month :interval "1s"
  "~/.config/eww/scripts/calendar.sh month $(cat ~/.cache/eww_cal_offset)")

;; Botones de navegación
(button :class "nav-btn" :onclick "~/.config/eww/scripts/cal_nav.sh prev"
  (label :text "<"))
```

## Referencias
- [EWW GitHub](https://github.com/elkowar/eww)
- [EWW Documentation](https://elkowar.github.io/eww/)
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)
- [elkowar/awesome-eww](https://github.com/elkowar/awesome-eww)