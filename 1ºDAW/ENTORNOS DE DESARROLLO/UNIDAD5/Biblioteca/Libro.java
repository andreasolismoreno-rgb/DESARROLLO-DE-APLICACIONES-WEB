public class Libro {

	private String isbn;
	private String titulo;
	private String autor;
	private boolean disponible;

	/**
	 * 
	 * @param estado
	 */
	public void cambiarDisponibilidad(boolean estado) {
		// TODO - implement Libro.cambiarDisponibilidad
		throw new UnsupportedOperationException();
	}

	public String getTitulo() {
		return this.titulo;
	}

	public boolean isDisponible() {
		return this.disponible;
	}

}