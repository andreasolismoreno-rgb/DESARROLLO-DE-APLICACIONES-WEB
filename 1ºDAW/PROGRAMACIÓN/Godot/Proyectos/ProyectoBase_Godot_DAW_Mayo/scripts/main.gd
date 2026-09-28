extends Node2D

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $Player
@onready var posicion_inicial: Marker2D = $PosicionInicial

func _ready() -> void:
    player.add_to_group("player")
    GameManager.iniciar_partida("Alumno")
    player.reiniciar(posicion_inicial.global_position)
    timer.timeout.connect(_on_timer_timeout)
    timer.start()

func _on_timer_timeout() -> void:
    GameManager.sumar_tiempo()