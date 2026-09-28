/* EJERCICIO 3: Relaciones 1:N y 1:1 */

-- 1. TABLA DEPARTAMENTO
-- Es la tabla maestra independiente. Debe crearse primero.
CREATE TABLE DEPARTAMENTO (
    -- NUMBER(3): Suficiente para hasta 999 departamentos.
    ID NUMBER(3),
    -- VARCHAR2(40): Nombres como "Recursos Humanos" o "I+D".
    NOMBRE VARCHAR2(40) NOT NULL,
    -- VARCHAR2(50): Ciudad o planta donde se encuentra.
    UBICACION VARCHAR2(50),
    CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (ID)
);
DESC DEPARTAMENTO;

-- En este modelo, el Jefe se define de forma separada al empleado.
CREATE TABLE JEFE (
    -- NUMBER(5): Un ID numérico único.
    ID NUMBER(5),
    -- VARCHAR2(9): DNI con letra. 
    -- UQ1: Restricción de unicidad, no puede haber dos jefes con mismo DNI.
    DNI VARCHAR2(9) NOT NULL CONSTRAINT UQ_DNI_JEFE UNIQUE,
    NOMBRE VARCHAR2(50) NOT NULL,
    -- NUMBER(10,2): Para salarios con céntimos.
    SALARIO NUMBER(10,2),
    TELEFONO VARCHAR2(15),
    -- FK1: Referencia al departamento que dirige.
    -- UQ: El diagrama marca UQ en IdDep para Jefes (indica que un jefe dirige un solo departamento).
    IDDEP NUMBER(3) NOT NULL CONSTRAINT UQ_DEP_JEFE UNIQUE,
    -- RELACIÓN 1:1 (Uno a Uno): Un Departamento tiene UN solo Jefe
    -- y un Jefe dirige UN solo Departamento. 
    -- El "UNIQUE" en la FK (IDDEP) es lo que obliga a que sea 1:1.
    CONSTRAINT PK_JEFE PRIMARY KEY (ID),
    CONSTRAINT FK_JEFE_DEP FOREIGN KEY (IDDEP) REFERENCES DEPARTAMENTO(ID)
);
DESC JEFE;

-- 3. TABLA EMPLEADO
CREATE TABLE EMPLEADO (
    ID NUMBER(5),
    DNI VARCHAR2(9) NOT NULL CONSTRAINT UQ_DNI_EMP UNIQUE,
    NOMBRE VARCHAR2(50) NOT NULL,
    SALARIO NUMBER(10,2),
    TELEFONO VARCHAR2(15),
    -- FK1: Departamento al que pertenece el empleado.
    IDDEP NUMBER(3),
     -- RELACIÓN 1:N (Uno a Muchos): Un Departamento tiene muchos Empleados.
    -- Aquí NO ponemos UNIQUE en IDDEP porque muchos empleados pueden 
    -- compartir el mismo código de departamento.
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (ID),
    CONSTRAINT FK_EMP_DEP FOREIGN KEY (IDDEP) REFERENCES DEPARTAMENTO(ID)
);
DESC EMPLEADO;