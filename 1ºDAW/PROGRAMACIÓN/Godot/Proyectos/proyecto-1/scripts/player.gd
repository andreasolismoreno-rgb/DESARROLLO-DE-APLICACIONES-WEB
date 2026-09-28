extends CharacterBody2D
@export var speed: float = 300.0
@export var jump_force: float = -500.0
@export var gravity: float = 980.0
#var cont:int = 0
@onready var screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	#print ("contador -> ", cont)
	#cont+=1
	aplicar_gravedad(delta)
	mover_horizontalmente()
	saltar_si_puede()
	salir_por_el_otro_lado()
	move_and_slide()

func salir_por_el_otro_lado() -> void:

	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	if position.y > screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_size.y

func aplicar_gravedad(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func mover_horizontalmente() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

func saltar_si_puede() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
