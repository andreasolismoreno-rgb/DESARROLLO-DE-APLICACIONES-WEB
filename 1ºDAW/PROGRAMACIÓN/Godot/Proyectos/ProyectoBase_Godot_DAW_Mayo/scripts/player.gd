extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_force: float = -500.0
@export var gravity: float = 980.0

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	aplicar_gravedad(delta)
	mover_horizontalmente()
	saltar_si_puede()
	actualizar_direccion_visual()
	move_and_slide()

func aplicar_gravedad(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func mover_horizontalmente() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

func saltar_si_puede() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

func actualizar_direccion_visual() -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

func reiniciar(posicion_inicial: Vector2) -> void:
	global_position = posicion_inicial
	velocity = Vector2.ZERO
