/* Andrea Solís Moreno 1ºDAW */

const items = document.querySelectorAll("#listaColores li");
const info = document.getElementById("info");
const btnReset = document.getElementById("btnReset");

/* PASO 1: Interacción con la lista */
items.forEach(function(item) {
    item.addEventListener("click", function() {
        // Obtenemos el texto del color
        let colorElegido = item.textContent;
        info.textContent = "Color: " + colorElegido;
        // Cambiamos el fondo del body
        document.body.style.backgroundColor = colorElegido;
    });

    /* PASO 2: Eventos mouseover y mouseout (como el Ejercicio 6) */
    item.addEventListener("mouseover", function() {
        item.style.color = "gray";
    });
    item.addEventListener("mouseout", function() {
        item.style.color = "black";
    });
});

/* PASO 3: Eventos de teclado (como el Ejercicio 8) */
window.addEventListener("keydown", function(event) {
    // Usamos toUpperCase para que funcione con 'r' y 'R'
    let tecla = event.key.toUpperCase();

    if (tecla === "R") {
        document.body.style.backgroundColor = "red";
        info.textContent = "Fondo rojo por teclado";
    } else if (tecla === "G") {
        document.body.style.backgroundColor = "green";
        info.textContent = "Fondo verde por teclado";
    } else if (tecla === "B") {
        document.body.style.backgroundColor = "blue";
        info.textContent = "Fondo azul por teclado";
    }
});

/* PASO 4: Botón Reset */
btnReset.addEventListener("click", function() {
    document.body.style.backgroundColor = "white";
    info.textContent = "";
});