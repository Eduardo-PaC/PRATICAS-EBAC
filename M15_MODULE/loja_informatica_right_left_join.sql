USE loja_informatica;

--> LEFT JOIN: Visualizar todos os clientes, incluindo aqueles sem pedidos.
SELECT 
    c.nome, 
    pe.id_pedido
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente;


--> RIGHT JOIN: Visualizar todos os pedidos, incluindo aqueles sem clientes.
SELECT
    c.nome,
    pe.id_pedido
FROM clientes AS c
RIGHT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente;


--> LEFT JOIN: Visualizar apenas clientes sem pedidos:
SELECT
    c.*
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
WHERE pe.id_cliente IS NULL;

--> LEFT JOIN: Visualizar todos os clientes, produtos e pedidos, incluindo aqueles sem pedidos e produtos.
SELECT 
    c.nome AS cliente, 
    pd.nome_produto AS produto, 
    pe.id_pedido AS pedido, 
    pe.data
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
LEFT JOIN produtos AS pd
ON pd.id_produto = pe.id_produto;


--> Calcule o total gasto por cada cliente em seus pedidos:
SELECT
    c.nome,
    SUM(pd.preco * pe.quantidade) AS total_gasto
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
JOIN produtos AS pd
ON pd.id_produto = pe.id_produto
GROUP BY c.nome
ORDER BY total_gasto;

--> Visualize quais clientes não gastaram em seus pedidos (erro):
SELECT
    c.nome AS cliente,
    SUM(pd.preco * pe.quantidade) AS total_gasto
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
LEFT JOIN produtos AS pd
ON pd.id_produto = pe.id_produto
WHERE pd.preco IS NULL
GROUP BY c.nome;


--> Consultas Gerais:
SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;