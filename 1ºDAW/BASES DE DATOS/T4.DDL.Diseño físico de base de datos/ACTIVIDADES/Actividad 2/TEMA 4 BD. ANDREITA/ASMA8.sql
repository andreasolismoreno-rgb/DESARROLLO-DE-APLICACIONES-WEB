/* ================================================================
   EJERCICIO 8: SISTEMA DE CENSO Y PROPIEDADES
   Esquema: C##ASMA8 | Contraseña: "123456"
   ================================================================ */

-- 1. TABLA MUNICIPIO (Maestra)
CREATE TABLE MUNICIPIO (
    ID NUMBER(5),
    -- NOT NULL: Obligatorio por enunciado.
    NOMBRE VARCHAR2(50) NOT NULL,
    CODPOSTAL VARCHAR2(5),
    PROVINCIA VARCHAR2(40),
    CONSTRAINT PK_MUNICIPIO PRIMARY KEY (ID)
);
DESC MUNICIPIO;

-- 2. TABLA VIVIENDA (Depende de Municipio)
CREATE TABLE VIVIENDA (
    ID NUMBER(10),
    -- DEFAULT 'Calle': Si no se indica nada, se asigna este valor.
    TIPOVIA VARCHAR2(20) DEFAULT 'Calle',
    -- NOT NULL: Obligatorios por enunciado.
    NOMBREVIA VARCHAR2(100) NOT NULL,
    NUMERO NUMBER(4) NOT NULL,
    IDMUNICIPIO NUMBER(5),
    CONSTRAINT PK_VIVIENDA PRIMARY KEY (ID),
    -- RELACIÓN 1:N: Un municipio tiene muchas viviendas.
    CONSTRAINT FK_VIV_MUN FOREIGN KEY (IDMUNICIPIO) REFERENCES MUNICIPIO(ID)
);
DESC VIVIENDA;

-- 3. TABLA PERSONA (Depende de Vivienda para el empadronamiento)
CREATE TABLE PERSONA (
    DNI VARCHAR2(9),
    NOMBRE VARCHAR2(60) NOT NULL, -- Obligatorio por enunciado
    FECHANAC DATE,
    -- CHECK: Solo permite H o M.
    SEXO CHAR(1) CONSTRAINT CK_SEXO_PER CHECK (SEXO IN ('H', 'M')),
    IDVIVIENDA NUMBER(10),
    CONSTRAINT PK_PERSONA PRIMARY KEY (DNI),
    -- RELACIÓN 1:N: En una vivienda pueden estar empadronadas muchas personas.
    CONSTRAINT FK_PER_VIV FOREIGN KEY (IDVIVIENDA) REFERENCES VIVIENDA(ID)
);
DESC PERSONA;

-- 4. TABLA CABEZAFAMILIA (Relación 1:1 entre Persona y Vivienda)
CREATE TABLE CABEZAFAMILIA (
    DNI VARCHAR2(9),
    IDVIVIENDA NUMBER(10),
    CONSTRAINT PK_CABEZAFAMILIA PRIMARY KEY (DNI),
    -- RELACIÓN 1:1: Una persona es cabeza de una familia en una vivienda.
    -- El UNIQUE en IDVIVIENDA asegura que una casa solo tenga un jefe/a.
    CONSTRAINT FK_CAB_PER FOREIGN KEY (DNI) REFERENCES PERSONA(DNI),
    CONSTRAINT FK_CAB_VIV FOREIGN KEY (IDVIVIENDA) REFERENCES VIVIENDA(ID),
    CONSTRAINT UQ_VIV_JEFE UNIQUE (IDVIVIENDA)
);
DESC CABEZAFAMILIA;

-- 5. TABLA POSEE (Relación N:M entre Persona y Vivienda)
-- Una persona puede ser dueña de varias casas y una casa tener varios dueños.
CREATE TABLE POSEE (
    DNI VARCHAR2(9),
    IDVIVIENDA NUMBER(10),
    -- PK Compuesta: Identifica la propiedad.
    CONSTRAINT PK_POSEE PRIMARY KEY (DNI, IDVIVIENDA),
    CONSTRAINT FK_POS_PER FOREIGN KEY (DNI) REFERENCES PERSONA(DNI),
    CONSTRAINT FK_POS_VIV FOREIGN KEY (IDVIVIENDA) REFERENCES VIVIENDA(ID)
);
DESC POSEE;