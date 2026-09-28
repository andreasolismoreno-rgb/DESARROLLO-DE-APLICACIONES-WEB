extends CanvasLayer

@onready var label_monedas: Label = $Panel/VBoxContainer/LabelMonedas
@onready var label_tiempo: Label = $Panel/VBoxContainer/LabelTiempo
@onready var label_estado: Label = $Panel/VBoxContainer/LabelEstado
@onready var label_ayuda: Label = $Panel/VBoxContainer/LabelAyuda

func _ready() -> void:
    GameManager.datos_actualizados.connect(actualizar_ui)
    actualizar_ui(GameManager.monedas, GameManager.tiempo_segundos, GameManager.estado)

func actualizar_ui(monedas: int, tiempo: int, estado: String) -> void:
    label_monedas.text = "Monedas: " + str(monedas)
    label_tiempo.text = "Tiempo: " + str(tiempo) + " s"
    label_estado.text = "Estado: " + estado

    if estado == "Partida finalizada":
        label_ayuda.text = "JSON generado. Luego se importará desde Java a MySQL."
    else:
        label_ayuda.text = "Controles: A/D para moverse, ESPACIO para saltar."