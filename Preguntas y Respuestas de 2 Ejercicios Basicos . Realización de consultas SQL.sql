/*Consultas sobre una tabla*/
/*Devuelve un listado con todos los pedidos que se han realizado, ordenados por la fecha de realización de forma descendente.*/
SELECT * FROM pedido ORDER BY fecha DESC;
/*Devuelve todos los datos de los dos pedidos de mayor valor.*/
SELECT * FROM pedido ORDER BY total DESC LIMIT 2;
/*Devuelve un listado con los identificadores de los clientes que han realizado algún pedido, sin repetidos.*/
SELECT DISTINCT id_cliente FROM pedido;
/*Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500.*/
SELECT * FROM pedido WHERE YEAR(fecha) = 2017 AND total > 500;
/*Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.*/
SELECT nombre, apellido1, apellido2 FROM comercial WHERE comision BETWEEN 0.05 AND 0.11;
/*Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.*/
SELECT MAX(comision) FROM comercial;
/*Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL, ordenados alfabéticamente por apellidos y nombre.*/
SELECT id, nombre, apellido1 FROM cliente WHERE apellido2 IS NOT NULL ORDER BY apellido1, apellido2, nombre;
/*Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n, así como los nombres que empiezan por P, ordenados alfabéticamente.*/
SELECT nombre FROM cliente WHERE nombre LIKE 'A%n' OR nombre LIKE 'P%' ORDER BY nombre;
/*Devuelve un listado de los nombres de los clientes que no empiezan por A, ordenados alfabéticamente.*/
SELECT nombre FROM cliente WHERE nombre NOT LIKE 'A%' ORDER BY nombre;
/*Devuelve un listado con los nombres de los comerciales que terminan por la letra "el" o por la letra "o", sin nombres repetidos.*/
SELECT DISTINCT nombre FROM comercial WHERE nombre LIKE '%el' OR nombre LIKE '%o';



/*Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.*/

/*¿Cuál es la consulta SQL correcta para devolver un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido, sin repetidos y ordenado alfabéticamente?
A) SELECT DISTINCT id, nombre, apellido1, apellido2 FROM cliente ORDER BY nombre, apellido1;
B) SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2 FROM cliente c JOIN pedido p ON c.id = p.id_cliente ORDER BY c.nombre, c.apellido1;
C) SELECT * FROM cliente WHERE id IN (SELECT id_cliente FROM pedido);
D) SELECT id, nombre FROM cliente;

Respuesta correcta: B)*/
SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2 FROM cliente c JOIN pedido p ON c.id = p.id_cliente ORDER BY c.nombre, c.apellido1;

/*¿Qué consulta SQL1 y SQL2 muestra todos los pedidos que ha realizado cada cliente, incluyendo todos los datos de los pedidos y del cliente, con los clientes ordenados alfabéticamente?
A) SELECT * FROM cliente, pedido WHERE cliente.id = pedido.id_cliente ORDER BY nombre;
B) SELECT * FROM cliente INNER JOIN pedido ON cliente.id = pedido.id_cliente;
C) SELECT * FROM pedido ORDER BY fecha;
D) SELECT cliente.*, pedido.* FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente ORDER BY cliente.nombre, cliente.apellido1;

Respuesta correcta: D)*/
SELECT cliente.*, pedido.* FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente ORDER BY cliente.nombre, cliente.apellido1;

/*Seleccione la consulta SQL que muestra todos los pedidos en los que ha participado un comercial, incluyendo todos los datos de los pedidos y de los comerciales, ordenados alfabéticamente por el nombre del comercial.
A) SELECT * FROM pedido, comercial WHERE pedido.id_comercial = comercial.id ORDER BY comercial.nombre;
B) SELECT pedido.*, comercial.* FROM pedido INNER JOIN comercial ON pedido.id_comercial = comercial.id;
C) SELECT * FROM comercial;
D) SELECT comercial.nombre, pedido.id FROM comercial JOIN pedido ON comercial.id = pedido.id_comercial ORDER BY comercial.nombre;

Respuesta correcta: A)*/
SELECT * FROM pedido, comercial WHERE pedido.id_comercial = comercial.id ORDER BY comercial.nombre;

/*¿Qué consulta SQL entrega un listado completo de todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido?
A) SELECT * FROM cliente, pedido, comercial WHERE cliente.id = pedido.id_cliente AND comercial.id = pedido.id_comercial;
B) SELECT cliente.nombre, pedido.id, comercial.nombre FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente JOIN comercial ON comercial.id = pedido.id_comercial;
C) SELECT cliente.nombre FROM cliente;
D) SELECT pedido.id FROM pedido;

Respuesta correcta: A)*/
SELECT * FROM cliente, pedido, comercial WHERE cliente.id = pedido.id_cliente AND comercial.id = pedido.id_comercial;

/* ¿Cuál es la consulta correcta para obtener un listado de todos los clientes que realizaron un pedido durante el año 2017 y cuya cantidad esté entre 300 y 1000?
A) SELECT cliente.nombre FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente WHERE YEAR(pedido.fecha) = 2017;
B) SELECT cliente.nombre FROM cliente WHERE id IN (SELECT id_cliente FROM pedido WHERE total BETWEEN 300 AND 1000);
C) SELECT cliente.nombre FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente WHERE YEAR(pedido.fecha) = 2017 AND pedido.total BETWEEN 300 AND 1000;
D) SELECT * FROM pedido WHERE total BETWEEN 300 AND 1000;

Respuesta correcta: C)*/
SELECT cliente.nombre FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente WHERE YEAR(pedido.fecha) = 2017 AND pedido.total BETWEEN 300 AND 1000;

/*¿Qué consulta SQL devuelve el nombre y los apellidos de todos los comerciales que han participado en algún pedido realizado por María Santana Moreno?
A) SELECT comercial.nombre, comercial.apellido1 FROM comercial JOIN pedido ON comercial.id = pedido.id_comercial JOIN cliente ON pedido.id_cliente = cliente.id WHERE cliente.nombre = 'María' AND cliente.apellido2 = 'Moreno';
B) SELECT comercial.nombre FROM comercial;
C) SELECT cliente.nombre FROM cliente WHERE nombre = 'María' AND apellido2 = 'Moreno';
D) SELECT cliente.nombre, pedido.id FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente;

Respuesta correcta: A)*/
SELECT comercial.nombre, comercial.apellido1 FROM comercial JOIN pedido ON comercial.id = pedido.id_comercial JOIN cliente ON pedido.id_cliente = cliente.id WHERE cliente.nombre = 'María' AND cliente.apellido2 = 'Moreno';

/*¿Cómo se obtiene el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega?
Opciones:
A) SELECT cliente.nombre FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente JOIN comercial ON pedido.id_comercial = comercial.id WHERE comercial.nombre = 'Daniel' AND comercial.apellido1 = 'Sáez';
B) SELECT cliente.nombre FROM cliente;
C) SELECT comercial.nombre FROM comercial WHERE nombre = 'Daniel' AND apellido1 = 'Sáez';
D) SELECT pedido.total FROM pedido JOIN comercial ON pedido.id_comercial = comercial.id WHERE comercial.nombre = 'Daniel' AND apellido1 = 'Sáez';

Respuesta correcta: A)*/
SELECT cliente.nombre FROM cliente JOIN pedido ON cliente.id = pedido.id_cliente JOIN comercial ON pedido.id_comercial = comercial.id WHERE comercial.nombre = 'Daniel' AND comercial.apellido1 = 'Sáez';




/*Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.*/

/*Listado de todos los clientes junto con los datos de los pedidos realizados, incluyendo a los que no han realizado ningún pedido, ordenados alfabéticamente por apellidos y nombre:*/
SELECT cliente.nombre, cliente.apellido1, cliente.apellido2, pedido.* FROM cliente LEFT JOIN pedido ON cliente.id = pedido.id_cliente ORDER BY cliente.apellido1, cliente.apellido2, cliente.nombre;

/*Listado de todos los comerciales junto con los datos de los pedidos realizados, incluyendo a los que no han realizado ningún pedido, ordenados alfabéticamente por apellidos y nombre:*/
SELECT comercial.nombre, comercial.apellido1, comercial.apellido2, pedido.* FROM comercial LEFT JOIN pedido ON comercial.id = pedido.id_comercial ORDER BY comercial.apellido1, comercial.apellido2, comercial.nombre;

/*Listado que muestre solo los clientes que no han realizado ningún pedido:*/
SELECT cliente.* FROM cliente LEFT JOIN pedido ON cliente.id = pedido.id_cliente WHERE pedido.id IS NULL;

/*Listado de clientes y comerciales que no han realizado ningún pedido, ordenados alfabéticamente, diferenciando clientes y comerciales:*/
SELECT 'Cliente' AS Tipo, cliente.nombre, cliente.apellido1, cliente.apellido2 FROM cliente 
LEFT JOIN pedido ON cliente.id = pedido.id_cliente
WHERE pedido.id IS NULL
UNION
SELECT 'Comercial' AS Tipo, comercial.nombre, comercial.apellido1, comercial.apellido2
FROM comercial
LEFT JOIN pedido ON comercial.id = pedido.id_comercial
WHERE pedido.id IS NULL
ORDER BY apellido1, apellido2, nombre;

/*¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? dos de ellas son incorrectas y una es verdadera:
Falsa: Se pueden usar NATURAL LEFT JOIN o NATURAL RIGHT JOIN para unir tablas basadas en claves primarias y claves ajenas definidas explícitamente. (Incorrecto porque NATURAL JOIN no utiliza las claves primarias o claves ajenas definidas, sino que une las tablas automáticamente utilizando columnas con el mismo nombre entre las tablas).

Verdadera: NATURAL LEFT JOIN o NATURAL RIGHT JOIN podrían usarse si las columnas en las que se basa la unión tienen el mismo nombre en ambas tablas. Sin embargo, este enfoque no es recomendado porque reduce la claridad y podría provocar errores si se agregan nuevas columnas a las tablas que coincidentemente comparten el mismo nombre. (Es la justificación verdadera, aunque advierte sobre los riesgos del uso de NATURAL JOIN).

Falsa: NATURAL LEFT JOIN y NATURAL RIGHT JOIN son más eficientes en cuanto a rendimiento que LEFT JOIN y RIGHT JOIN porque omiten la necesidad de escribir condiciones de unión explícitas, lo que simplifica el plan de ejecución de la consulta. (Incorrecto ya que la omisión de condiciones de unión no mejora necesariamente el rendimiento; el plan de ejecución depende del optimizador de la base de datos y de otros factores como los índices disponibles).
*/


/*Consultas resumen*/
/*Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.*/
SELECT SUM(total) FROM pedido;
/*Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.*/
SELECT AVG(total) FROM pedido;
/*Calcula el número total de comerciales distintos que aparecen en la tabla pedido.*/
SELECT COUNT(DISTINCT id_comercial) FROM pedido;
/*Calcula el número total de clientes que aparecen en la tabla cliente.*/
SELECT COUNT(*) FROM cliente;
/*Calcula cuál es la mayor cantidad que aparece en la tabla pedido.*/
SELECT MAX(total) FROM pedido;
/*Calcula cuál es la menor cantidad que aparece en la tabla pedido.*/
SELECT MIN(total) FROM pedido;
/*Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.*/
SELECT ciudad, MAX(categoria) FROM cliente GROUP BY ciudad;
/*Calcula el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes.*/
SELECT id_cliente, nombre, apellido1, apellido2, fecha, MAX(total) FROM pedido JOIN cliente ON pedido.id_cliente = cliente.id GROUP BY id_cliente, fecha;
/*Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, solo para pedidos que superen la cantidad de 2000.*/
SELECT id_cliente, fecha, MAX(total) FROM pedido WHERE total > 2000 GROUP BY id_cliente, fecha;

/*Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17.*/
SELECT id_comercial, nombre, apellido1, apellido2, MAX(total) AS max_pedido FROM pedido JOIN comercial ON pedido.id_comercial = comercial.id WHERE fecha = '2016-08-17' GROUP BY id_comercial;

/*Listado con identificador de cliente, nombre, apellidos y el número total de pedidos realizados, incluyendo a los clientes con 0 pedidos.*/
SELECT c.id, c.nombre, c.apellido1, c.apellido2, COALESCE(p.num_pedidos, 0) AS total_pedidos
FROM cliente c
LEFT JOIN (
    SELECT id_cliente, COUNT(*) as num_pedidos
    FROM pedido
    GROUP BY id_cliente
) p ON c.id = p.id_cliente;

/*Listado con identificador de cliente, nombre, apellidos y el número total de pedidos realizados durante el año 2017.*/
SELECT c.id, c.nombre, c.apellido1, c.apellido2, COUNT(p.id) AS total_pedidos_2017 FROM cliente c LEFT JOIN pedido p ON c.id = p.id_cliente AND YEAR(p.fecha) = 2017 GROUP BY c.id;

/*Listado con identificador de cliente, nombre, primer apellido y el valor del pedido más alto realizado por cada uno, mostrando 0 para quienes no han realizado pedidos.*/
SELECT c.id, c.nombre, c.apellido1, IFNULL(MAX(p.total), 0) AS max_pedido FROM cliente c LEFT JOIN pedido p ON c.id = p.id_cliente GROUP BY c.id;

/*Consulta para devolver el pedido de máximo valor realizado cada año.*/
SELECT YEAR(fecha) AS año, MAX(total) AS max_total FROM pedido GROUP BY YEAR(fecha);

/*Número total de pedidos realizados cada año.*/
SELECT YEAR(fecha) AS año, COUNT(*) AS num_pedidos FROM pedido GROUP BY YEAR(fecha);




/*Subconsultas
Con operadores básicos de comparación*/

/*Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz.*/
SELECT * FROM pedido WHERE id_cliente = (SELECT id FROM cliente WHERE nombre = 'Adela' AND apellido1 = 'Salas' AND apellido2 = 'Díaz');

/*Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega.*/
SELECT COUNT(*) FROM pedido WHERE id_comercial = (SELECT id FROM comercial WHERE nombre = 'Daniel' AND apellido1 = 'Sáez' AND apellido2 = 'Vega');

/*Devuelve los datos del cliente que realizó el pedido más caro en el año 2019.*/
SELECT * FROM cliente WHERE id = (SELECT id_cliente FROM pedido WHERE YEAR(fecha) = 2019 ORDER BY total DESC LIMIT 1);

/*Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.*/
SELECT fecha, total FROM pedido WHERE id_cliente = (SELECT id FROM cliente WHERE nombre = 'Pepe' AND apellido1 = 'Ruiz' AND apellido2 = 'Santana') ORDER BY total ASC LIMIT 1;

/*Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.*/
SELECT * FROM cliente WHERE id IN (SELECT id_cliente FROM pedido WHERE YEAR(fecha) = 2017 AND total >= (SELECT AVG(total) FROM pedido WHERE YEAR(fecha) = 2017));

/*Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT * FROM pedido WHERE total >= ALL (SELECT total FROM pedido);

/*Devuelve un listado de los clientes que no han realizado ningún pedido.*/
SELECT * FROM cliente WHERE id NOT IN (SELECT id_cliente FROM pedido);

/*Devuelve un listado de los comerciales que no han realizado ningún pedido.*/
SELECT * FROM comercial WHERE id NOT IN (SELECT id_comercial FROM pedido);

/*Devuelve un listado de los clientes que no han realizado ningún pedido.*/
SELECT * FROM cliente c WHERE NOT EXISTS (SELECT 1 FROM pedido p WHERE p.id_cliente = c.id);
