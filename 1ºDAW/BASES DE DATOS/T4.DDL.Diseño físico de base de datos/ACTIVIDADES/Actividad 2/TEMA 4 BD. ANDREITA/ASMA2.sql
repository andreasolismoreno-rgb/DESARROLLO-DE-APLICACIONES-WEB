/* ================================================================
   EJERCICIO 2: MODELO GEOGRÁFICO DE EMPLEADOS
   Esquema: C##ASMA2 | Contraseña: "123456"
   ================================================================ */

-- 1. CREACIÓN DEL USUARIO (Para tus apuntes)
-- 
CREATE USER C##ASMA2 IDENTIFIED BY "123456";
-- 
GRANT CONNECT, RESOURCE TO C##ASMA2;

-- 2. TABLA REGIÓN (La base de la jerarquía)
CREATE TABLE REGION (
    -- VARCHAR2(3): Para códigos tipo 'AR', 'AND', 'MAD'.
    CODREGION VARCHAR2(3),
    -- VARCHAR2(50): Nombre de la comunidad o región.
    NOMBRE VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_REGION PRIMARY KEY (CODREGION)
);
describe region;

-- 3. TABLA PROVINCIA (Depende de Región)
CREATE TABLE PROVINCIA (
    -- VARCHAR2(5): Códigos postales iniciales o IDs de provincia.
    CODPROVINCIA VARCHAR2(5),
    NOMBRE VARCHAR2(50) NOT NULL,
    CODREGION VARCHAR2(3),
    CONSTRAINT PK_PROVINCIA PRIMARY KEY (CODPROVINCIA),
    -- Relación con Región
    CONSTRAINT FK_PROV_REG FOREIGN KEY (CODREGION) 
        REFERENCES REGION(CODREGION)
);
describe provincia;

-- 4. TABLA LOCALIDAD (Depende de Provincia)
CREATE TABLE LOCALIDAD (
    -- VARCHAR2(10): Códigos de municipio.
    CODLOCALIDAD VARCHAR2(10),
    NOMBRE VARCHAR2(50) NOT NULL,
    CODPROVINCIA VARCHAR2(5),
    CONSTRAINT PK_LOCALIDAD PRIMARY KEY (CODLOCALIDAD),
    -- Relación con Provincia
    CONSTRAINT FK_LOC_PROV FOREIGN KEY (CODPROVINCIA) 
        REFERENCES PROVINCIA(CODPROVINCIA)
);

-- 5. TABLA EMPLEADO (La tabla principal)
CREATE TABLE EMPLEADO (
    -- NUMBER(8): Un ID numérico suele ser más eficiente para empleados.
    ID NUMBER(8),
    -- VARCHAR2(9): 8 números y 1 letra (Estándar DNI).
    -- UQ1: El diagrama pide que sea Único.
    DNI VARCHAR2(9) NOT NULL CONSTRAINT UQ_DNI UNIQUE,
    NOMBRE VARCHAR2(50) NOT NULL,
    FECHANAC DATE,
    TELEFONO VARCHAR2(15),
    -- NUMBER(10,2): El salario lleva decimales (ej: 1500.50).
    SALARIO NUMBER(10,2),
    CODLOCALIDAD VARCHAR2(10),
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (ID),
    -- Relación con Localidad
    CONSTRAINT FK_EMP_LOC FOREIGN KEY (CODLOCALIDAD) 
        REFERENCES LOCALIDAD(CODLOCALIDAD)
);

-- 6. COMPROBACIÓN
DESC REGION;
DESC PROVINCIA;
DESC LOCALIDAD;
DESC EMPLEADO;