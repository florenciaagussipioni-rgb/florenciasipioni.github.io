SELECT * FROM visita;
SELECT idPunto_venta FROM VISITA WHERE estado_visita = "Finalizado";
SELECT * FROM relevamiento;
SELECT * FROM clientes
SELECT relevamiento.id_cliente FROM relevamiento INNER JOIN relevamiento ON clientes.id_cliente = relevamiento.id_cliente WHERE estado_visita = "Finalizado";
SHOW TABLES auditores;
SELECT c.id_cliente, c.nombre_cliente
FROM clientes c
INNER JOIN relevamiento r ON c.id_cliente = r.id_cliente
INNER JOIN visita v ON r.id_visita = v.id_visita
WHERE v.estado_visita = 'Finalizado';
SELECT * FROM relevamiento