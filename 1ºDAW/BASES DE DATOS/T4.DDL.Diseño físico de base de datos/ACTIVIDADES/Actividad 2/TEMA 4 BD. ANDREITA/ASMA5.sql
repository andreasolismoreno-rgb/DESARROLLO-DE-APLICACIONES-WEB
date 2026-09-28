/* ================================================================
   EJERCICIO 5: GESTIÓN DE ALQUILER DE COCHES
   Esquema: C##ASMA5 | Contraseña: "123456"
   ================================================================ */

-- 0. CREACIÓN DE SECUENCIA
-- Se usa para que el Número de Reserva se genere solo (1, 2, 3...).
CREATE SEQUENCE SEQ_NUM_RESERVA START WITH 1 INCREMENT BY 1;

-- 1. TABLA CLIENTE
CREATE TABLE CLIENTE (
    CODCLIENTE NUMBER(10) PRIMARY KEY,
    DNI VARCHAR2(9) NOT NULL CONSTRAINT UQ_DNI_CLI UNIQUE,
    -- NOT NULL: Obligatorio por enunciado.
    NOMBRE VARCHAR2(60) NOT NULL,
    DIRECCION VARCHAR2(100),
    TELEFONO VARCHAR2(15)
);
DESC CLIENTE;

-- 2. TABLA AVALA (Relación Reflexiva N:M)
-- Un cliente puede ser avalado por otro. Es una relación de Cliente consigo mismo.
CREATE TABLE AVALA (
    AVALADO NUMBER(10),
    AVALADOR NUMBER(10),
    -- PK: El cliente avalado es la clave (un cliente solo tiene un avalador principal aquí).
    CONSTRAINT PK_AVALA PRIMARY KEY (AVALADO),
    -- Ambas FK apuntan a la misma tabla: CLIENTE.
    CONSTRAINT FK_AVALADO FOREIGN KEY (AVALADO) REFERENCES CLIENTE(CODCLIENTE),
    CONSTRAINT FK_AVALADOR FOREIGN KEY (AVALADOR) REFERENCES CLIENTE(CODCLIENTE)
);
DESC AVALA;

-- 3. TABLA COCHE (Tabla Maestra)
CREATE TABLE COCHE (
    MATRICULA VARCHAR2(8) PRIMARY KEY,
    -- Marca y Modelo: Obligatorios por enunciado.
    MARCA VARCHAR2(30) NOT NULL,
    MODELO VARCHAR2(30) NOT NULL,
    COLOR VARCHAR2(20),
    -- NUMBER(5,2): Precio por hora con céntimos.
    PRECIOHORA NUMBER(5,2)
);
DESC COCHE;

-- 4. TABLA RESERVA
-- Relación 1:N entre Cliente y Reserva. Un cliente hace muchas reservas.
CREATE TABLE RESERVA (
    -- Usaremos la secuencia aquí al insertar.
    NUMERO NUMBER(10) PRIMARY KEY,
    FECHAINICIO DATE NOT NULL,
    FECHAFIN DATE,
    PRECIOTOTAL NUMBER(10,2),
    CODCLIENTE NUMBER(10),
    CONSTRAINT FK_RES_CLI FOREIGN KEY (CODCLIENTE) REFERENCES CLIENTE(CODCLIENTE)
);
DESC RESERVA;

-- 5. TABLA INCLUYE (Relación N:M entre Reserva y Coche)
-- Una reserva puede incluir varios coches y un coche estar en varias reservas (en fechas distintas).
CREATE TABLE INCLUYE (
    NUMERO NUMBER(10),
    MATRICULA VARCHAR2(8),
    -- Litros de gasolina al devolver el coche.
    LITROSGAS NUMBER(5,2),
    -- PK Compuesta para unir Reserva y Coche.
    CONSTRAINT PK_INCLUYE PRIMARY KEY (NUMERO, MATRICULA),
    CONSTRAINT FK_INC_RES FOREIGN KEY (NUMERO) REFERENCES RESERVA(NUMERO),
    CONSTRAINT FK_INC_COCHE FOREIGN KEY (MATRICULA) REFERENCES COCHE(MATRICULA)
);
DESC INCLUYE;