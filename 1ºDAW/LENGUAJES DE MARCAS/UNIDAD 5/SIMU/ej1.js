/* Andrea Solís Moreno 1ºDAW */

/* 1. NAVEGACIÓN POR EL DOM */
// Seleccionamos todos los li para recorrerlos
const peliculas = document.querySelectorAll("#listaPeliculas li");
const listaUl = document.getElementById("listaPeliculas");

// Mostrar uno a uno en consola usando forEach
peliculas.forEach(function(pelicula) {
    console.log(pelicula.textContent);
});

// Mostrar el primero y el último usando las propiedades de navegación
console.log("Primer hijo: " + listaUl.firstElementChild.textContent);
console.log("Último hijo: " + listaUl.lastElementChild.textContent);


/* 2, 3 y 4. EVENTOS Y ESTILOS */
const parrafoInfo = document.getElementById("info");

peliculas.forEach(function(pelicula) {
    // PASO 2: Añadimos el evento click a cada li
    pelicula.addEventListener("click", function() {
        
        // PASO 3: Mostramos el nombre en consola y en el párrafo id="info"
        console.log("Película pulsada: " + pelicula.textContent);
        parrafoInfo.textContent = "Película seleccionada: " + pelicula.textContent;

        // PASO 4: Estilo dinámico. Primero quitamos la clase a todas para que no se acumulen
        peliculas.forEach(function(p) {
            p.classList.remove("seleccionada");
        });
        // Añadimos la clase solo a la que hemos pulsado
        pelicula.classList.add("seleccionada");
    });
});