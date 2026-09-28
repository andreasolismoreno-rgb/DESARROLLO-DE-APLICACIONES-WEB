-- Creamos el usuario con tus iniciales (ejemplo: ASMA1)
CREATE USER C##ASMA1 IDENTIFIED BY "123456";

-- Le damos permisos para que pueda conectarse y crear cosas
GRANT CONNECT, RESOURCE TO C##ASMA1;
-- Cuota ilimitada en el tablespace para que no de error al insertar datos
ALTER USER C##ASMA1 QUOTA UNLIMITED ON USERS;


/* EJERCICIO 1. ACTIVIDAD 2 - Diseño Físico */


-- 1. TABLA ALUMNO
-- Es una tabla maestra. No tiene dependencias de otras tablas.
CREATE TABLE ALUMNO (
    -- VARCHAR2(10): Los códigos de matrícula suelen mezclar letras y números. 
    -- 10 es un estándar suficiente para este tipo de identificadores.
    NUM_MATRICULA VARCHAR2(10), 
    
    -- VARCHAR2(50): Un nombre con apellidos puede ser largo. 20 se queda corto.
    -- NOT NULL: Se añade porque un alumno no puede existir sin nombre.
    NOMBRE VARCHAR2(50) NOT NULL, 
    
    FECHA_NACIMIENTO DATE, 
    
    -- VARCHAR2(15): Los teléfonos no se operan matemáticamente, así que son texto.
    -- Usamos 15 por si se incluyen prefijos internacionales (ej: +34).
    TELEFONO VARCHAR2(15), 
    
    -- Definimos la Clave Primaria para asegurar que no haya matrículas repetidas.
    CONSTRAINT PK_ALUMNO PRIMARY KEY (NUM_MATRICULA)
);
describe ALUMNO;

-- 2. TABLA PROFESOR
CREATE TABLE PROFESOR (
    ID_PROFESOR VARCHAR2(4), 
    
    -- VARCHAR2(9): El NIF en España tiene exactamente 9 caracteres.
    -- CONSTRAINT UNIQUE: Esto es el "UQ1" del diagrama. El NIF no se puede repetir.
    NIF_P VARCHAR2(9) NOT NULL CONSTRAINT UQ_NIF_PROF UNIQUE,
    
    NOMBRE VARCHAR2(50) NOT NULL,
    
    -- VARCHAR2(30): Suficiente para poner "Informática" o "Matemáticas".
    ESPECIALIDAD VARCHAR2(30),
    
    TELEFONO VARCHAR2(15),
    
    CONSTRAINT PK_PROFESOR PRIMARY KEY (ID_PROFESOR)
);

describe PROFESOR;

-- 3. TABLA ASIGNATURA
-- Esta tabla depende de PROFESOR (Relación 1:N).
CREATE TABLE ASIGNATURA (
    -- VARCHAR2(6): Para códigos tipo 'ALG001'. 
    COD_ASIGNATURA VARCHAR2(6),
    
    NOMBRE VARCHAR2(50) NOT NULL,
    
    -- Esta columna debe ser del MISMO TIPO que en la tabla PROFESOR.
    ID_PROFESOR VARCHAR2(4), 
    
    CONSTRAINT PK_ASIGNATURA PRIMARY KEY (COD_ASIGNATURA),
    
    -- FOREIGN KEY: Une esta tabla con PROFESOR. 
    -- Si el profesor no existe en la tabla PROFESOR, no puedes asignarlo aquí.
    CONSTRAINT FK_ASIG_PROF FOREIGN KEY (ID_PROFESOR) 
        REFERENCES PROFESOR(ID_PROFESOR)
);


describe ASIGNATURA;

-- 4. TABLA RECIBE
-- Tabla intermedia que une ALUMNO y ASIGNATURA (Relación N:M).
CREATE TABLE RECIBE (
    NUM_MATRICULA VARCHAR2(10),
    COD_ASIGNATURA VARCHAR2(6),
    
    -- VARCHAR2(9): Para formatos tipo '2025/2026' (9 caracteres exactos).
    CURSO_ESCOLAR VARCHAR2(9), 
    
    -- PRIMARY KEY COMPUESTA: El diagrama marca PK en los tres campos.
    -- Esto significa que la combinación de Alumno + Asignatura + Año es única.
    CONSTRAINT PK_RECIBE PRIMARY KEY (NUM_MATRICULA, COD_ASIGNATURA, CURSO_ESCOLAR),
    
    -- FOREIGN KEYS: Aseguran que el alumno y la asignatura existan de verdad.
    CONSTRAINT FK_RECIBE_ALUM FOREIGN KEY (NUM_MATRICULA) 
        REFERENCES ALUMNO(NUM_MATRICULA),
    CONSTRAINT FK_RECIBE_ASIG FOREIGN KEY (COD_ASIGNATURA) 
        REFERENCES ASIGNATURA(COD_ASIGNATURA)
);

describe RECIBE;