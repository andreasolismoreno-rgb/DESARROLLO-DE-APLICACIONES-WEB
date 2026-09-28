extends Node

signal datos_actualizados(monedas: int)
var monedas: int = 0
func sumar_monedas(cantidad: int) -> void:
	monedas+=cantidad
	emitir_actualizacion()

func emitir_actualizacion() -> void:
	datos_actualizados.emit(monedas)
