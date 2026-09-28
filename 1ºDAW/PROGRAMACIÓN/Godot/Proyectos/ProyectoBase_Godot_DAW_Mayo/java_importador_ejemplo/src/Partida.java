public class Partida {
    private String jugador;
    private int monedas;
    private int tiempoSegundos;
    private int puntuacion;

    public Partida(String jugador, int monedas, int tiempoSegundos, int puntuacion) {
        this.jugador = jugador;
        this.monedas = monedas;
        this.tiempoSegundos = tiempoSegundos;
        this.puntuacion = puntuacion;
    }

    public String getJugador() {
        return jugador;
    }

    public int getMonedas() {
        return monedas;
    }

    public int getTiempoSegundos() {
        return tiempoSegundos;
    }

    public int getPuntuacion() {
        return puntuacion;
    }

    @Override
    public String toString() {
        return jugador + " - " + puntuacion + " puntos";
    }
}