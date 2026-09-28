/*Andrea Solís Moreno 1ºDAW. 09/02/2026. T4.Actividad6*/



--1.Creo las secuencias para los ID de cada tabla.
CREATE SEQUENCE seq_asm_sucursal;
CREATE SEQUENCE seq_asm_empleado;
CREATE SEQUENCE seq_asm_revista;
CREATE SEQUENCE seq_asm_periodista;
CREATE SEQUENCE seq_asm_seccion;
CREATE SEQUENCE seq_asm_ejemplar;

-- 2. CREACIÓN DE TABLAS (SIN RESTRICCIONES)
--El orden sería, primero creamos las tablas que no dependan de otras, luegos las que si y por último, 
--las relaciones de muchos a muchos, ya que generan tabla.

--TABLAS INDEPENDIENTES
CREATE TABLE ASM_sucursal (
    id_sucursal INT PRIMARY KEY,
    codigo CHAR(3),
    direccion VARCHAR2(100),
    telefono VARCHAR2(15),
    ciudad VARCHAR2(50),
    provincia VARCHAR2(50)
);


CREATE TABLE ASM_periodista (
    id_periodista INT PRIMARY KEY,
    nombre VARCHAR2(50),
    apellido1 VARCHAR2(50),
    apellido2 VARCHAR2(50),
    especialidad VARCHAR2(50)
);

CREATE TABLE ASM_revista (
    id_revista INT PRIMARY KEY,
    titulo VARCHAR2(100),
    tipo VARCHAR2(30),
    periodicidad VARCHAR2(20) DEFAULT 'mensual'
);

-- Tablas con dependencia de datos
CREATE TABLE ASM_empleado (
    id_empleado INT PRIMARY KEY,
    nif CHAR(9),
    nombre VARCHAR2(50),
    apellido1 VARCHAR2(50),
    apellido2 VARCHAR2(50),
    telefono VARCHAR2(15),
    id_sucursal INT 
);

-- Entidades débiles y relaciones N:N
CREATE TABLE ASM_seccion (
    id_seccion INT,
    id_revista INT,
    titulo VARCHAR2(100),
    descripcion VARCHAR2(255),
    PRIMARY KEY (id_seccion, id_revista)
);

CREATE TABLE ASM_ejemplar (
    id_ejemplar INT,
    id_revista INT,
    fecha DATE,
    num_paginas INT,
    num_ejemplares INT,
    PRIMARY KEY (id_ejemplar, id_revista)
);

CREATE TABLE ASM_publica (
    id_sucursal INT,
    id_revista INT,
    PRIMARY KEY (id_sucursal, id_revista)
);

CREATE TABLE ASM_escribe (
    id_periodista INT,
    id_revista INT,
    PRIMARY KEY (id_periodista, id_revista)
);

--Tabla para el atributo multivaluado
CREATE TABLE ASM_telefono_periodista (
    id_periodista INT,
    telefono VARCHAR2(15),
    PRIMARY KEY (id_periodista, telefono)
);



--He creado primero las tablas que no tienen FOREIGN KEY (Sucursal, Periodista, Revista) para evitar errores de referencia.  
-- Entidades Débiles: Sección y Ejemplar son dependientes de Revista, usando claves primarias compuestas y borrado en cascada.  
--Relaciones N:N: Las relaciones "Publica" y "Escribe"
-- Multivaluados: El teléfono del periodista se ha extraído a una tabla aparte para cumplir con la 1NF 



--REESTRICCIONES
--Las llaves foráneas se han de actualizar en cascada. Determina tú cuando el
--borrado de las foráneas es en cascada o que ponga SET NULL. Coméntame con
--un comentario tu decisión a implementar.

--? Los campos id deben ser autoincrementables. Debes definir la correspondiente
--secuencia .Añádele el nombre de la tabla para luego identificarlos mejor. Por
--ejemplo id_sección, id_ejemplar, ...

--? En código sucursal se almacenarán los valores s01, s02, s03, ...

--? No pueden ser nulos los siguientes campos: Nombre de empleado, nombre de
--periodista, título de revista

--? La periodicidad toma uno de los siguientes valores: semanal, quincenal, mensual,
--trimestral o anual, siendo el valor por defecto mensual.

--? número_páginas debe ser mayor que 0.

--? número_ejemplares no puede ser un número negativo.
      
--NOT NULL en nombres y títulos.  
-- CHECK para que el número de páginas sea > 0 y ejemplares \geq 0.  
--DEFAULT para la periodicidad mensual.  
---CHAR para códigos de longitud fija y VARCHAR2 para textos.  


--Campos obligatorios
ALTER TABLE ASM_empleado MODIFY nombre NOT NULL;
ALTER TABLE ASM_periodista MODIFY nombre NOT NULL;
ALTER TABLE ASM_revista MODIFY titulo NOT NULL;

-- Reglas de validación (CHECK)
ALTER TABLE ASM_sucursal ADD CONSTRAINT ck_ASM_codigo_sucursal 
    CHECK (codigo LIKE 's%'); 

ALTER TABLE ASM_revista ADD CONSTRAINT ck_periodicidad 
 CHECK (periodicidad IN ('semanal', 'quincenal', 'mensual', 'trimestral', 'anual'));

ALTER TABLE ASM_ejemplar ADD CONSTRAINT ck_paginas 
 CHECK (num_paginas > 0);

ALTER TABLE ASM_ejemplar ADD CONSTRAINT ck_ejemplares 
CHECK (num_ejemplares >= 0);



-- Relación Trabaja (Sucursal - Empleado)
--SET NULL. Si borramos la sucursal, el empleado sigue existiendo.
ALTER TABLE ASM_empleado ADD CONSTRAINT fk_emp_sucursal 
    FOREIGN KEY (id_sucursal) REFERENCES ASM_sucursal(id_sucursal) 
    ON UPDATE CASCADE ON DELETE SET NULL;

-- Relación Tiene (Revista - Sección)
--CASCADE. Si se borra la revista, sus secciones no tienen sentido.
ALTER TABLE ASM_seccion ADD CONSTRAINT fk_sec_revista 
    FOREIGN KEY (id_revista) REFERENCES ASM_revista(id_revista) 
    ON UPDATE CASCADE ON DELETE CASCADE;

-- Relación Publica N:N (Sucursal - Revista)
ALTER TABLE ASM_publica ADD CONSTRAINT fk_pub_sucursal 
    FOREIGN KEY (id_sucursal) REFERENCES ASM_sucursal(id_sucursal) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ASM_publica ADD CONSTRAINT fk_pub_revista 
    FOREIGN KEY (id_revista) REFERENCES ASM_revista(id_revista) ON UPDATE CASCADE ON DELETE CASCADE;

-- Atributo multivaluado
ALTER TABLE ASM_telefono_periodista ADD CONSTRAINT fk_telefono_periodista 
    FOREIGN KEY (id_periodista) REFERENCES ASM_periodista(id_periodista) ON UPDATE CASCADE ON DELETE CASCADE;
