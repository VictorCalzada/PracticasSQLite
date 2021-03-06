---------------------------------------------------------------------
--
-- Author: Victor Calzada Cabano
--
---------------------------------------------------------------------


-- 1. Crea una nueva tabla para almacenar las temporadas de las series . La primary key
--    ha de ser el par de campos “idSerie, numTemporada”. La descripción de la tabla es
--    la siguiente: (2 ptos)

create table TEMPORADAS_SERIE
(
    numTemporada int not null primary key,
    idSerie int not null unique,
    fechaEstreno date not null,
    fechaRegistro date not null, 
    disponible numeric not null,
    check (fechaEstreno < fechaRegistro),
    foreign key (idSerie) references series(idSerie),
    check (disponible in (0,1))
);

-- 2. Añadir una nueva columna a la tabla " profesiones" para almacenar un campo
--    denominado "descripcion" (0.25 ptos).

alter table PROFESIONES add descripcion char not null default " ";

-- 3. Crea un índice sobre el par de campos “titulo” y “anyoFin” de las series (0.25 ptos)



-- 4. Mostrar el “idserie”, “titulo”, “titulo original” y “sinopsis” de todas las series,
--    ordenadas por título descendentemente (0.5 ptos)
-- 5. Retornar los datos de los usuarios franceses o noruegos (0.5 ptos)
-- 6. Mostrar los datos de los actores junto con los datos de las series en las que actúan
--    (0.75 ptos)
-- 7. Mostrar los datos de los usuarios que no hayan realizado nunca ninguna valoración
--    (0.75 ptos)
-- 8. Mostrar los datos de los usuarios junto con los datos de su profesión, incluyendo las
--    profesiones que no estén asignadas a ningún usuario (0.75 ptos)
-- 9. Retornar los datos de las series que estén en idioma español, y cuyo título comience
--    por E o G (1 pto)
-- 10. Retornar los “ idserie”, “titulo” y “sinopsis” de todas las series junto con la
--     puntuación media, mínima y máxima de sus valoraciones (1 pto)
-- 11. Actualiza al valor 'Sin sinopsis' la sinopsis de todas las series cuya sinopsis sea nula
--     y cuyo idioma sea el inglés (1 pto)
-- 12. Utilizando funciones ventana, muestra los datos de las valoraciones junto al nombre
--     y apellidos (concatenados) de los usuarios que las realizan, y en la misma fila, el
--     valor medio de las puntuaciones realizadas por el usuario (1.25 ptos)
--