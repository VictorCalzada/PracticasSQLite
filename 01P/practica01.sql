----------------------------------------------------------------
-- Master en Data Science
-- Autores: Sara Lopez, Victor Calzada 
----------------------------------------------------------------

CREATE TABLE Director(
    iddirector int PRIMARY KEY CHECK ( iddirector > 0 ),
    dni char NOT NULL UNIQUE,
    nombre char NOT NULL,
    apellido1 char NOT NULL,
    apellido2 char NULL,
    fechaNacimiento date NOT NULL,
    fechaRegistro date NOT NULL cHECK (fechaRegistro > fechaNacimiento), 
    fechaDeceso date NULL CHECK (fechaDeceso > fechaNacimiento),
    enActivo numeric NOT NULL CHECK (enActivo IN (0,1))    
);

CREATE TABLE Pelicula(
    idpelicula int PRIMARY KEY CHECK (idpelicula > 0),
    titulo char NOT NULL UNIQUE,
    fechaEstreno date NOT NULL,
    duracionMin real NOT NULL CHECK (duracionMin > 0),
    genero char NOT NULL CHECK (genero IN ('terror', 'scfi', 'aventura')),
    iddirector int NOT NULL,
    FOREIGN KEY (iddirector) REFERENCES Director(iddirector)
);

