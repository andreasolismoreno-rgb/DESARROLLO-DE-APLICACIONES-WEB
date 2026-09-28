/* ================================================================
   EJERCICIO 6: EDITORIAL DE REVISTAS
   Esquema: C##ASMA6 | Contraseña: "123456"
   ================================================================ */

-- 1. TABLA SUCURSAL (Maestra)
CREATE TABLE SUCURSAL (
    CODIGO NUMBER(5),
    DIRECCION VARCHAR2(100),
    TELEFONO VARCHAR2(15),
    CONSTRAINT PK_SUCURSAL PRIMARY KEY (CODIGO)
);
DESC SUCURSAL;

-- 2. TABLA EMPLEADO (Relación 1:N con Sucursal)
-- Muchos empleados trabajan en una sucursal.
CREATE TABLE EMPLEADO (
    DNI VARCHAR2(9),
    NOMBRE VARCHAR2(60) NOT NULL, -- Obligatorio por enunciado
    DIRECCION VARCHAR2(100),
    TELEFONO VARCHAR2(15),
    SUCURSAL NUMBER(5),
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (DNI),
    CONSTRAINT FK_EMP_SUC FOREIGN KEY (SUCURSAL) REFERENCES SUCURSAL(CODIGO)
);
DESC EMPLEADO;

-- 3. TABLA REVISTA (Relación 1:N con Sucursal)
-- Una sucursal publica muchas revistas.
CREATE TABLE REVISTA (
    NUMREG NUMBER(10),
    TITULO VARCHAR2(100) NOT NULL, -- Obligatorio por enunciado
    -- DEFAULT 'Mensual': Si no se pone nada, Oracle pone Mensual automáticamente.
    -- CHECK: Solo permite los valores de la lista.
    PERIODICIDAD VARCHAR2(15) DEFAULT 'Mensual',
    TIPO VARCHAR2(30),
    SUCURSAL NUMBER(5),
    CONSTRAINT PK_REVISTA PRIMARY KEY (NUMREG),
    CONSTRAINT FK_REV_SUC FOREIGN KEY (SUCURSAL) REFERENCES SUCURSAL(CODIGO),
    CONSTRAINT CK_PERIODICIDAD CHECK (PERIODICIDAD IN ('Semanal', 'Quincenal', 'Mensual', 'Trimestral', 'Anual'))
);
DESC REVISTA;

-- 4. TABLA NUMREVISTA (Relación 1:N con Revista)
-- Una revista tiene muchos números (ej. Revista nº1, nº2...).
CREATE TABLE NUMREVISTA (
    NUMREG NUMBER(10),
    NUMERO NUMBER(5),
    -- CHECK: Asegura que las páginas sean siempre positivas.
    NUMPAGINAS NUMBER(4) CONSTRAINT CK_PAGINAS CHECK (NUMPAGINAS > 0),
    FECHA DATE,
    CANTVENDIDAS NUMBER(10),
    -- PK Compuesta: Identifica de qué revista y qué número hablamos.
    CONSTRAINT PK_NUMREVISTA PRIMARY KEY (NUMREG, NUMERO),
    CONSTRAINT FK_NUM_REV FOREIGN KEY (NUMREG) REFERENCES REVISTA(NUMREG)
);
DESC NUMREVISTA;

-- 5. TABLA PERIODISTA (Maestra)
CREATE TABLE PERIODISTA (
    DNI VARCHAR2(9),
    NOMBRE VARCHAR2(60) NOT NULL, -- Obligatorio por enunciado
    DIRECCION VARCHAR2(100),
    TELEFONO VARCHAR2(15),
    ESPECIALISTA VARCHAR2(50),
    CONSTRAINT PK_PERIODISTA PRIMARY KEY (DNI)
);
DESC PERIODISTA;

-- 6. TABLA ESCRIBE (Relación N:M entre Revista y Periodista)
-- Un periodista escribe en muchas revistas y una revista tiene muchos periodistas.
CREATE TABLE ESCRIBE (
    NUMREG NUMBER(10),
    DNI_PER VARCHAR2(9),
    CONSTRAINT PK_ESCRIBE PRIMARY KEY (NUMREG, DNI_PER),
    CONSTRAINT FK_ESC_REV FOREIGN KEY (NUMREG) REFERENCES REVISTA(NUMREG),
    CONSTRAINT FK_ESC_PER FOREIGN KEY (DNI_PER) REFERENCES PERIODISTA(DNI)
);
DESC ESCRIBE;