extends CanvasLayer

@onready var label_monedas: Label = $Panel/VBoxContainer/LabelMonedas
@onready var label_ayuda: Label = $Panel/VBoxContainer/LabelAyuda

func _ready() -> void:
	GameManager.datos_actualizados.connect(actualizar_ui)
	actualizar_ui(GameManager.monedas)

func actualizar_ui(monedas : int) -> void:
	label_monedas.text = "Monedas: " + str(monedas)

	label_ayuda.text = "A/D para moverse, ESPACIO para saltar."
