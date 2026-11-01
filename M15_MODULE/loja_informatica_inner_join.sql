USE loja_informatica;

--> INNER JOIN

--> Clientes x Pedidos
SELECT c.nome, c.email, p.id_pedido
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente;

--> Clientes x Produtos
SELECT p.id_pedido, pd.nome_produto, pd.preco, p.quantidade
FROM produtos AS pd
INNER JOIN pedidos AS p
ON pd.id_produto = p.id_produto

--> Clientes x Pedidos x Produtos
SELECT
    c.nome AS cliente, 
    pd.nome_produto AS produto, 
    pd.preco, 
    p.quantidade,
    p.data
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente
INNER JOIN produtos AS pd
ON pd.id_produto = p.id_produto;

--> Clientes x Pedidos x Produtos com Filtro
SELECT
    c.nome AS cliente,
    pd.nome_produto AS produto,
    pd.preco,
    p.quantidade,
    p.data
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente
INNER JOIN produtos AS pd
ON pd.id_produto = p.id_produto
WHERE pd.preco > 1000
AND c.nome LIKE 'Pa%'
ORDER BY p.data;

--> Clientes x Pedidos com Group By
SELECT
    c.nome AS cliente,
    SUM(p.quantidade)
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente
WHERE quantidade IS NOT NULL
GROUP BY c.nome;


SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;