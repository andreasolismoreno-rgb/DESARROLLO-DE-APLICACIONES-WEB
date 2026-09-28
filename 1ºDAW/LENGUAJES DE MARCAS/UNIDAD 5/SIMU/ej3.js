
/* Andrea Solís Moreno 1ºDAW */

/* PASO 1: Seleccionamos el formulario y el párrafo de mensajes */
const miForm = document.getElementById("formulario");
const parrafoMensaje = document.getElementById("mensaje");

/* PASO 2: Evento submit con preventDefault  */
miForm.addEventListener("submit", function (event) {
    // Evitamos que la página se recargue
    event.preventDefault();

    // Obtenemos los valores por su ID (usamos .value y .checked)
    let nombre = document.getElementById("nombre").value;
    let edad = document.getElementById("edad").value;
    let email = document.getElementById("email").value;
    let acepto = document.getElementById("condiciones").checked;

    /* PASO 3: Comprobaciones (Validación) */
    // Comprobamos si está vacío o si no cumple las reglas
    if (nombre === "" || edad === "" || email === "" || !email.includes("@") || edad < 18 || !acepto) {

        parrafoMensaje.textContent = "Hay datos incorrectos en el formulario";
        parrafoMensaje.className = "error";

    } else {

        parrafoMensaje.textContent = "Formulario enviado correctamente";
        parrafoMensaje.className = "correcto";
    }
});

