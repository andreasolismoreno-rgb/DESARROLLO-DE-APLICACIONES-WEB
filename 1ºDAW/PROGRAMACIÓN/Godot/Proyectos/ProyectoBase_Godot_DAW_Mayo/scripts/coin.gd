extends Area2D

@export var valor: int = 1

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body.is_in_group("player"):
        GameManager.sumar_monedas(valor)
        queue_free()