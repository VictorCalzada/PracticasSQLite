------------------------------ Practica 02 ------------------------------
-- Consulta sobre una base de datos
--
-- Author: Victor Calzada
-------------------------------------------------------------------------


--Se trabaja en todo momento sobre la base de datos pizzeria ya proporcionada 


-- 1. Mostrar los datos de los pedidos realizados entre octubre y noviembre de 2018 (0.5 ptos)
select pe.* from Pedidos pe
where pe.fechaHoraPedido between '2018-10-01' and '2018-11-30';

-- 2. Devolver el id, nombre, apellido1, apellido2, fecha de alta y fecha de baja de todos los miembros 
--    del personal que no estén de baja, ordenados descendentemente por fecha de alta y ascendentemente 
--    por nombre (0.75 pto, 0.25 ptos adicionales si la consulta se realiza con el nombre y apellidos concatenados).
select per.idPersonal, per.nombre||' '||per.apellido1||' '||per.apellido2, per.fechaAlta, per.fechaBaja 
from Personal per order by per.fechaAlta desc, per.nombre asc; 

-- 3. Retornar los datos de todos los clientes cuyo nombre comience por G o J y que además tengan observaciones (1 pto).
select cl.* from Clientes cl 
where ((cl.nombre like 'J%') or (cl.nombre like 'G%')) and (cl.observaciones is not null);

-- 4. Devolver el id e importe de las pizzas junto con el id y descripción de todos sus ingredientes, 
--    siempre que el importe de estas pizzas sea mayor de 3 (1 pto).
select pi.idpizza, pi.importeBase, ingr.descripcion from Pizzas pi 
inner join IngredienteDePizza inpi on pi.idpizza = inpi.idpizza
join Ingredientes ingr on inpi.idingrediente = ingr.idingrediente
where pi.importeBase > 3;

-- 5. Mostrar los datos de todas las pizzas que no hayan sido nunca pedidas, ordenados por id ascendentemente (1 pto).
select pi.* from Pizzas pi 
where not exists (select liP.* from LineasPedidos liP where liP.idpizza = pi.idpizza)
order by pi.idpizza asc;

-- 6. Devolver los datos de las bases, junto con los datos de las pizzas en las que están presentes, incluyendo los 
--    datos de las bases que no están en ninguna pizza (0.5 ptos)
select bs.*, pi.* from Bases bs
left join Pizzas pi on bs.idbase = pi.idbase;


-- 7. Retornar los datos de los pedidos realizados por el cliente con id 1, junto con los datos de sus líneas 
--    y de las pizzas pedidas, siempre que el precio unitario en la línea sea menor que el importe base de la pizza. (1.5 ptos)
select ped.*, liP.*, pi.* from Pedidos pe 
inner join Clientes cl on pe.idcliente = cl.idcliente 
join LineasPedidos liP on pe.idpedido = liP.idpedido
join Pizzas pi on pi.idpizza = liP.idpizza
where cl.idcliente = 1 and liP.precioUnidad < pi.importeBase;

-- 8. Mostrar el id y nif de todos los clientes, junto con el número total de pedidos realizados (0.75 pto, 
--    0.25 ptos adicionales si sólo se devuelven los datos de los que hayan realizado más de un pedido).
select cl.idcliente, cl.nif, count(*) 
from Pedidos pe join Clientes cl on pe.idcliente = cl.idcliente
group by cl.idcliente, cl.nif
having count(*) > 1; 

-- 9. Sumar 0.5 al importe base de todas las pizzas que contengan el ingrediente con id ‘JAM’ (0.75 pto).
update Pizzas set importeBase = importeBase + 0.5
where idpizza in (select inp.* from IngredienteDePizza inp where inp.idingrediente = 'JAM');

-- 10. Eliminar las líneas de los pedidos anteriores a 2018 (0.75 pto).
delete from LineasPedidos where idpedido in (select pe.idpedido)

-- 11. BONUS para el 10: Realizar una consulta que devuelva el número de pizzas totales pedidas por cada cliente. 
--     En la consulta deberán aparecer el id y nif de los clientes, además de su nombre y apellidos concatenados (1 pto).