CREATE DATABASE IF NOT EXISTS juego_daw;
USE juego_daw;

CREATE TABLE jugadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE partidas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jugador_id INT NOT NULL,
    monedas INT NOT NULL,
    tiempo_segundos INT NOT NULL,
    puntuacion INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_partidas_jugadores
        FOREIGN KEY (jugador_id) REFERENCES jugadores(id)
);

-- Ranking básico:
SELECT j.nombre, p.puntuacion, p.monedas, p.tiempo_segundos, p.fecha
FROM partidas p
JOIN jugadores j ON p.jugador_id = j.id
ORDER BY p.puntuacion DESC
LIMIT 10;