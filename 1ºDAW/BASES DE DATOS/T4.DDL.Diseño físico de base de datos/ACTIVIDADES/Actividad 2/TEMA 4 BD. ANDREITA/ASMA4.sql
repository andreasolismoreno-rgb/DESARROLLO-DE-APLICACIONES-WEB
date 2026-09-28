   EJERCICIO 4: CLIENTES, DORMITORIOS Y MONTADORES
   Esquema: C##ASMA4 | Contraseña: "123456"

-- 1. TABLA CLIENTE (Tabla Maestra)
-- No depende de nadie, se crea de las primeras.
CREATE TABLE CLIENTE (
    -- VARCHAR2(9): Para el NIF (8 números y 1 letra).
    NIF VARCHAR2(9),
    -- VARCHAR2(60): Espacio suficiente para nombre y apellidos.
    NOMBRE VARCHAR2(60) NOT NULL,
    -- VARCHAR2(100): Las direcciones suelen ser largas.
    DIRECCION VARCHAR2(100),
    -- VARCHAR2(15): Para teléfonos con prefijos opcionales.
    TELEFONO VARCHAR2(15),
    CONSTRAINT PK_CLIENTE PRIMARY KEY (NIF)
);
DESC CLIENTE;

-- 2. TABLA MODELODORMITORIO (Tabla Maestra)
CREATE TABLE MODELODORMITORIO (
    -- VARCHAR2(10): Códigos de producto tipo 'DORM-001'.
    COD VARCHAR2(10),
    CONSTRAINT PK_MODELO PRIMARY KEY (COD)
);
DESC MODELODORMITORIO;

-- 3. TABLA MONTADOR (Tabla Maestra)
CREATE TABLE MONTADOR (
    NIF VARCHAR2(9),
    NOMBRE VARCHAR2(60) NOT NULL,
    DIRECCION VARCHAR2(100),
    TELEFONO VARCHAR2(15),
    CONSTRAINT PK_MONTADOR PRIMARY KEY (NIF)
);
DESC MONTADOR;

-- 4. TABLA COMPRA (Relación N:M entre Cliente y Modelo)
-- Un cliente compra muchos modelos y un modelo es comprado por muchos clientes.
CREATE TABLE COMPRA (
    NIF_C VARCHAR2(9),
    MODELO VARCHAR2(10),
    -- DATE: Registra el día exacto de la venta.
    FECHACOMPRA DATE,
    -- CLAVE PRIMARIA COMPUESTA: Los tres campos juntos identifican la venta.
    -- Esto permite que un cliente compre el mismo modelo en fechas distintas.
    CONSTRAINT PK_COMPRA PRIMARY KEY (NIF_C, MODELO, FECHACOMPRA),
    -- RELACIONES (FK):
    CONSTRAINT FK_COMPRA_CLI FOREIGN KEY (NIF_C) REFERENCES CLIENTE(NIF),
    CONSTRAINT FK_COMPRA_MOD FOREIGN KEY (MODELO) REFERENCES MODELODORMITORIO(COD)
);
DESC COMPRA;

-- 5. TABLA MONTA (Relación N:M entre Modelo y Montador)
-- Un montador monta muchos modelos y un modelo es montado por varios montadores.
CREATE TABLE MONTA (
    MODELO VARCHAR2(10),
    NIF_M VARCHAR2(9),
    FECHAMONTAJE DATE,
    -- CLAVE PRIMARIA COMPUESTA: Identifica el trabajo realizado.
    CONSTRAINT PK_MONTA PRIMARY KEY (MODELO, NIF_M, FECHAMONTAJE),
    -- RELACIONES (FK):
    CONSTRAINT FK_MONTA_MOD FOREIGN KEY (MODELO) REFERENCES MODELODORMITORIO(COD),
    CONSTRAINT FK_MONTA_MON FOREIGN KEY (NIF_M) REFERENCES MONTADOR(NIF)
);
DESC MONTA;