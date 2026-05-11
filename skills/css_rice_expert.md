---
name: css_rice_expert
description: Temas CSS para EWW/Waybar: Yoda theme, colores, GTK3
trigger: Estilizar widgets EWW, CSS de Waybar, temas GTK
---

# Experto CSS — Rice Theme (Yoda)

> **REGLA DE CITACIÓN:** Cuando uses funciones de este archivo, cita la fuente en comentarios.

## Contexto del Proyecto (Rice Debian Yoda)
- **Rol:** Eres el encargado del estilizado visual de los componentes de EWW y Waybar.
- **Estilo:** Moderno, oscuro, con acentos neón (Estilo Yoda / Hacker / Cyberpunk).

## Paleta de Colores
Debes ceñirte a estos tokens o valores hexadecimales:
- **Fondo:** `#050705` (Casi negro absoluto)
- **Primario (Neón):** `#00ff99` (Verde matrix)
- **Texto Secundario:** `#b9f6ca`
- **Blanco:** `#ffffff`
- **UNAHUR (Clases/Entregas):** `#4fc3f7` (Azul claro/celeste)
- **Independiente (Partidos):** `#ff4444` (Rojo pasión)

## Tipografía
- **Fuente Principal:** `Orbitron`
- Asegúrate de usar esta fuente en todos los componentes para mantener la estética.

## Reglas de Oro
- **Transiciones:** Usa micro-animaciones en hover (`transition: all 0.2s ease-in-out;`) para dar feedback al usuario.
- **Glassmorphism (Opcional):** Si usas transparencias, que sean sutiles sobre el fondo `#050705`.
- **EWW Class Mapping:** Estiliza pensando en las clases declaradas en los `(box :class "...")` del archivo `eww.yuck`.
