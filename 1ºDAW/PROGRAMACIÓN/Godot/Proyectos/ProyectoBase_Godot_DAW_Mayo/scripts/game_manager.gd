extends Node

signal datos_actualizados(monedas: int, tiempo: int, estado: String)

var nombre_jugador: String = "Alumno"
var monedas: int = 0
var tiempo_segundos: int = 0
var partida_finalizada: bool = false
var estado: String = "Jugando"

func iniciar_partida(nombre: String = "Alumno") -> void:
    nombre_jugador = nombre
    monedas = 0
    tiempo_segundos = 0
    partida_finalizada = false
    estado = "Jugando"
    emitir_actualizacion()

func sumar_monedas(cantidad: int) -> void:
    if partida_finalizada:
        return
    monedas += cantidad
    emitir_actualizacion()

func sumar_tiempo() -> void:
    if partida_finalizada:
        return
    tiempo_segundos += 1
    emitir_actualizacion()

func finalizar_partida() -> void:
    if partida_finalizada:
        return
    partida_finalizada = true
    estado = "Partida finalizada"
    emitir_actualizacion()
    guardar_partida_json()

func calcular_puntuacion() -> int:
    # Fórmula sencilla: las monedas suman, el tiempo penaliza un poco.
    return max(0, monedas * 100 - tiempo_segundos * 2)

func guardar_partida_json() -> void:
    var datos := {
        "jugador": nombre_jugador,
        "monedas": monedas,
        "tiempo_segundos": tiempo_segundos,
        "puntuacion": calcular_puntuacion(),
        "estado": estado
    }

    var texto_json := JSON.stringify(datos, "\t")
    var archivo := FileAccess.open("user://partida.json", FileAccess.WRITE)

    if archivo == null:
        print("No se pudo crear el fichero JSON.")
        return

    archivo.store_string(texto_json)
    archivo.close()
    print("Partida guardada en: ", ProjectSettings.globalize_path("user://partida.json"))

func emitir_actualizacion() -> void:
    datos_actualizados.emit(monedas, tiempo_segundos, estado)