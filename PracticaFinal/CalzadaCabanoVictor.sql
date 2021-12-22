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
    idSerie int not null,
    numTemporada int not null,
    fechaEstreno date not null,
    fechaRegistro date not null, 
    disponible numeric not null,
    primary key (idSerie, numTemporada)
    check (fechaEstreno < fechaRegistro),
    foreign key (idSerie) references series(idSerie),
    check (disponible in (0,1))
);

-- 2. Añadir una nueva columna a la tabla " profesiones" para almacenar un campo
--    denominado "descripcion" (0.25 ptos).

alter table PROFESIONES add descripcion char null default null;

-- 3. Crea un índice sobre el par de campos “titulo” y “anyoFin” de las series (0.25 ptos)

create index idx_titulo_Fin on SERIES(titulo, anyoFin);

-- 4. Mostrar el “idserie”, “titulo”, “titulo original” y “sinopsis” de todas las series,
--    ordenadas por título descendentemente (0.5 ptos)

select s.idSerie, s.titulo, s.tituloOriginal, s.sinopsis 
from SERIES s order by s.titulo desc;
--Aqui hay un error y es que coge como primera una pelicula que tiene tilde 

-- 5. Retornar los datos de los usuarios franceses o noruegos (0.5 ptos)

select us.* from USUARIOS us where us.pais in ("Francia", "Noruega");

-- 6. Mostrar los datos de los actores junto con los datos de las series en las que actúan
--    (0.75 ptos)

select a.*, s.* from ACTORES a 
join REPARTO r on a.idActor = r.idActor 
join SERIES s on r.idSerie = s.idSerie; 

-- 7. Mostrar los datos de los usuarios que no hayan realizado nunca ninguna valoración
--    (0.75 ptos)

select us.* from USUARIOS us 
where not exists (select * from VALORACIONES v where v.idUsuario = us.idUsuario);

select us.* from USUARIOS us 
where us.idUsuario not in (select v.idUsuario from VALORACIONES v)

-- 8. Mostrar los datos de los usuarios junto con los datos de su profesión, incluyendo las
--    profesiones que no estén asignadas a ningún usuario (0.75 ptos)

select us.*, p.* from PROFESIONES p 
left join USUARIOS us on us.idProfesion = p.idProfesion;

-- 9. Retornar los datos de las series que estén en idioma español, y cuyo título comience
--    por E o G (1 pto)

select s.* from SERIES s 
join IDIOMAS i on s.idIdioma = i.idIdioma 
where (s.titulo like "E%" or s.titulo like "G%") and (i.idioma = "Español") ; 

-- 10. Retornar los “ idserie”, “titulo” y “sinopsis” de todas las series junto con la
--     puntuación media, mínima y máxima de sus valoraciones (1 pto)

select  s.idSerie, s.titulo, s.sinopsis, min(puntuacion), max(puntuacion), avg(puntuacion) media 
from VALORACIONES v left join SERIES s on v.idSerie = s.idSerie 
group by s.idSerie, s.titulo, s.sinopsis;


-- 11. Actualiza al valor 'Sin sinopsis' la sinopsis de todas las series cuya sinopsis sea nula
--     y cuyo idioma sea el inglés (1 pto)

update SERIES set sinopsis = "Sin sinopsis" 
where (sinopsis is null) and 
(idIdioma in (select i.idIdioma from IDIOMAS i where i.idioma = "Ingles"));

-- 12. Utilizando funciones ventana, muestra los datos de las valoraciones junto al nombre
--     y apellidos (concatenados) de los usuarios que las realizan, y en la misma fila, el
--     valor medio de las puntuaciones realizadas por el usuario (1.25 ptos)



select us.nombre || " " || us.apellido1 || " " || us.apellido2 as nomCompleto,
v.*,  AVG(v.puntuacion) over (partition by v.idUsuario) as PunMedia
                      from USUARIOS us join VALORACIONES v on v.idUsuario = us.idUsuario;

