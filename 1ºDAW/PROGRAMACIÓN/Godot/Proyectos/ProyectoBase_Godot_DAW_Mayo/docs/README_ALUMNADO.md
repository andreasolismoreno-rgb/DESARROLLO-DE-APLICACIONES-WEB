# Proyecto base Godot - Programación 1º DAW

## Objetivo

Crear un minijuego 2D sencillo donde el jugador se mueve, recoge monedas y llega a una meta. Al terminar la partida, el juego genera un fichero JSON con datos que posteriormente se podrán importar desde Java a una base de datos MySQL.

## Controles

- A: mover a la izquierda
- D: mover a la derecha
- Espacio: saltar

## Estructura

```text
scenes/
  main.tscn       Escena principal del juego
  player.tscn     Personaje
  coin.tscn       Moneda recogible
  goal.tscn       Meta
  ui.tscn         Interfaz

scripts/
  main.gd         Inicio de partida y temporizador
  player.gd       Movimiento del jugador
  coin.gd         Lógica de las monedas
  goal.gd         Lógica de la meta
  game_manager.gd Puntuación, tiempo y guardado JSON
  ui.gd           Actualización de la interfaz
```

## Qué debe modificar el equipo

1. Cambiar el nombre del juego.
2. Añadir más monedas u objetos.
3. Crear un nivel propio.
4. Cambiar la puntuación.
5. Añadir una condición de victoria más interesante.
6. Explicar qué datos se guardan en JSON.
7. Preparar la futura importación a MySQL desde Java.

## Ruta del JSON

Godot guarda el fichero en `user://partida.json`.

Para ver la ruta real en el ordenador, al terminar la partida mira la consola de Godot. El juego imprime algo parecido a:

```text
Partida guardada en: C:/Users/.../AppData/Roaming/Godot/app_userdata/ProyectoBase_DAW_Godot/partida.json
```

## Ejemplo de JSON generado

```json
{
    "jugador": "Alumno",
    "monedas": 4,
    "tiempo_segundos": 32,
    "puntuacion": 336,
    "estado": "Partida finalizada"
}
```