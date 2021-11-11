----------------------------------------------------------------
-- Master en Data Science
-- Autores: Sara López, Victor Calzada 
----------------------------------------------------------------

-- APARTADO 1
CREATE TABLE Director(
    iddirector int PRIMARY KEY CHECK ( iddirector > 0 ),
    dni char NOT NULL UNIQUE,
    nombre char NOT NULL,
    apellido1 char NOT NULL,
    apellido2 char NULL,
    fechaNacimiento date NOT NULL,
    fechaRegistro date NOT NULL CHECK (fechaRegistro > fechaNacimiento), 
    fechaDeceso date NULL CHECK (fechaDeceso > fechaNacimiento),
    enActivo numeric NOT NULL CHECK (enActivo IN (0,1))    
);

-- APARTADO 2
CREATE TABLE Pelicula(
    idpelicula int PRIMARY KEY CHECK (idpelicula > 0),
    titulo char NOT NULL UNIQUE,
    fechaEstreno date NOT NULL,
    duracionMin real NOT NULL CHECK (duracionMin > 0),
    genero char NOT NULL CHECK (genero IN ('Terror', 'Scifi', 'Aventura')),
    iddirector int NOT NULL,
    FOREIGN KEY (iddirector) REFERENCES Director(iddirector)
);

-- APARTADO 3
-- Inserción de datos en la tabla Director
INSERT INTO Director (iddirector, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (1, '72123489A', 'Pablo', 'García', 'Gómez', '1992-12-23', '2017-04-05', null, 1);
INSERT INTO Director (iddirector, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (2, '72122567G', 'John', 'Smith', null, '1962-11-13', '1981-03-04', '2015-09-12', 0);
INSERT INTO Director (iddirector, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (3, '72137890J', 'Marta', 'González', 'Pérez', '1985-03-22', '2003-07-15', null, 1);
INSERT INTO Director (iddirector, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (4, '72111096V', 'Paul', 'Williams', null, '1971-11-01', '1995-05-25', '2004-12-11', 0);

-- Inserción de datos en la tabla Pelicula
INSERT INTO Pelicula (idpelicula, titulo, fechaEstreno, duracionMin, genero, iddirector)
    VALUES (1, 'Título 1', '2019-04-10', 112.5, 'Terror', 1);
INSERT INTO Pelicula (idpelicula, titulo, fechaEstreno, duracionMin, genero, iddirector)
    VALUES (2, 'Título 2', '2021-10-11', 101, 'Aventura', 1);
INSERT INTO Pelicula (idpelicula, titulo, fechaEstreno, duracionMin, genero, iddirector)
    VALUES (3, 'Título 3', '1990-10-17', 98.5, 'Scifi', 2);
INSERT INTO Pelicula (idpelicula, titulo, fechaEstreno, duracionMin, genero, iddirector)
    VALUES (4, 'Título 4', '2019-06-21', 121.5, 'Terror', 3);
INSERT INTO Pelicula (idpelicula, titulo, fechaEstreno, duracionMin, genero, iddirector)
    VALUES (5, 'Título 5', '1995-12-05', 137, 'Scifi', 4);

-- APARTADO 4
ALTER TABLE Pelicula ADD recaudacion real NOT NULL CHECK (recaudacion >= 0) DEFAULT 0; 

-- APARTADO 5
-- Una solución sería tomar el valor de la columna del género como una referencia a la PK
-- de una tabla de géneros de cine.
CREATE TABLE Genero(
    idgenero int PRIMARY KEY,
    nombre char NOT NULL UNIQUE
);

CREATE TABLE PeliculaPunto5(
    idpelicula int PRIMARY KEY CHECK ( idpelicula > 0 ),
    titulo char NOT NULL UNIQUE,
    fechaEstreno date NOT NULL,
    duracionMin real NOT NULL CHECK (duracionMin > 0),
    idgenero int NOT NULL,
    iddirector int NOT NULL,
    FOREIGN KEY (idgenero) REFERENCES Genero(idgenero),
    FOREIGN KEY (iddirector) REFERENCES Director(iddirector)
);

-- Inserción de valores en la tabla Genero
INSERT INTO Genero (idgenero, nombre) VALUES (1, 'Terror');
INSERT INTO Genero (idgenero, nombre) VALUES (2, 'Scifi');
INSERT INTO Genero (idgenero, nombre) VALUES (3, 'Aventura');
INSERT INTO Genero (idgenero, nombre) VALUES (4, 'Misterio');
INSERT INTO Genero (idgenero, nombre) VALUES (5, 'Comedia');

-- Inserción de valores en la tabla PeliculaPunto5
INSERT INTO PeliculaPunto5 (idpelicula, titulo, fechaEstreno, duracionMin, idgenero, iddirector)
    VALUES (1, 'Título 1', '1998-11-15', 106, 2, 4);

-- APARTADO 6
CREATE TABLE Actor(
    idactor int PRIMARY KEY CHECK ( idactor > 0 ),
    dni char NOT NULL UNIQUE,
    nombre char NOT NULL,
    apellido1 char NOT NULL,
    apellido2 char NULL,
    fechaNacimiento date NOT NULL,
    fechaRegistro date NOT NULL CHECK (fechaRegistro > fechaNacimiento),
    fechaDeceso date NULL CHECK (fechaDeceso > fechaNacimiento),
    enActivo numeric NOT NULL CHECK (enActivo IN (0, 1))
);

CREATE TABLE ActorPelicula(
    idactor int NOT NULL,
    idpelicula int NOT NULL,
    FOREIGN KEY (idactor) REFERENCES Actor(idactor),
    FOREIGN KEY (idpelicula) REFERENCES Pelicula(idpelicula),
    PRIMARY KEY (idactor, idpelicula)
);

-- Inserción de valores en la tabla Actor
INSERT INTO Actor (idactor, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (1, '72133567D', 'Marcos', 'López', 'Blanco', '1972-05-01', '2003-04-16', null, 1);
INSERT INTO Actor (idactor, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (2, '72190765J', 'Mike', 'Jones', null, '1956-10-03', '1981-09-14', '2013-01-12', 0);
INSERT INTO Actor (idactor, dni, nombre, apellido1, apellido2, fechaNacimiento, fechaRegistro, fechaDeceso, enActivo)
    VALUES (3, '72137119L', 'Irene', 'González', 'Villanueva', '1991-03-25', '2013-07-01', null, 1);

-- Inserción de valores en la tabla INTERMEDIA ActorPelicula
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(1, 1);
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(1, 4);
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(2, 1);
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(2, 2);
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(2, 3);
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(3, 3);
INSERT INTO ActorPelicula(idactor, idpelicula) VALUES(3, 5);