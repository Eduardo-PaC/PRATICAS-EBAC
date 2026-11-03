-- Active: 1792937300966@@127.0.0.1@3306@restaurante
USE restaurante;

--> N° 01:
--> Produtos: ID, nome e descrição.
--> Info_Produtos: ingredientes.
SELECT
    pd.id_produto AS ID,
    pd.nome AS Produto,
    pd.descricao AS "Descrição",
    ipd.ingredientes AS Ingredientes
FROM produtos AS pd
JOIN info_produtos AS ipd
    ON ipd.id_produto = pd.id_produto
ORDER BY Produto;


--> N° 02:
--> Pedidos: ID, quantidade e data.
--> Clientes: nome e email.
SELECT
    pe.id_pedido AS "ID",
    pe.quantidade AS Quantidade,
    pe.data_pedido AS "Data",
    c.nome AS Nome,
    c.email AS Email
FROM pedidos AS pe
JOIN clientes AS c
    ON  pe.id_cliente = c.id_cliente
ORDER BY Nome;


--> N° 03:
--> Pedidos: ID, quantidade e data.
--> Clientes: nome e email.
--> Funcionarios: nome.
SELECT
    pe.id_pedido AS "ID",
    f.nome AS Funcionario,
    c.nome AS Cliente,
    c.email AS Email,
    pe.quantidade AS Quantidade,
    pe.data_pedido AS "Data"
FROM pedidos AS pe
JOIN clientes AS c
    ON  pe.id_cliente = c.id_cliente
JOIN funcionarios AS f
    ON f.id_funcionario = pe.id_funcionario
ORDER BY Cliente;


--> N° 04:
--> Pedidos: ID, quantidade e data.
--> Clientes: nome e email.
--> Funcionarios: nome.
--> Produtos: nome e preco.
SELECT
    pe.id_pedido AS "ID",
    f.nome AS Funcionario,
    c.nome AS Cliente,
    c.email AS Email,
    pe.quantidade AS Quantidade,
    pe.data_pedido AS "Data",
    pd.nome AS Produto,
    pd.preco AS Preco
FROM pedidos AS pe
JOIN clientes AS c
    ON  pe.id_cliente = c.id_cliente
JOIN funcionarios AS f
    ON f.id_funcionario = pe.id_funcionario
JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
ORDER BY Cliente;


--> N° 05:
--> Clientes: Nome.
--> Pedidos: Status.
--> Filtros: pe.status = 'Pendente' e ORDER BY id_pedido DESC.
SELECT
    c.nome AS Cliente,
    pe.status AS Status
FROM pedidos AS pe
JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
WHERE pe.status = 'Pendente'
ORDER BY pe.id_pedido DESC;


--> N° 06:
--> Clientes: id_cliente, data_cadastro, nome, email 
--> Filtros: WHERE id_pedido IS NULL.
SELECT
    c.id_cliente AS "ID",
    c.data_cadastro AS "Data",
    c.nome AS Cliente,
    c.email AS Email
FROM pedidos AS pe
RIGHT JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
WHERE id_pedido IS NULL;


--> N° 07:
--> Cliente: nome.
--> Pedidos: quantidade.
--> Filtros: GROUP BY nome.
--> Coluna Artificial: SUM(quantidade).
SELECT
    c.nome AS Cliente,
    SUM(pe.quantidade) AS Quantidade_Total
FROM pedidos AS pe
JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
GROUP BY c.nome
ORDER BY Quantidade_Total;


--> N° 08:
--> Pedidos: ID, quantidade.
--> Produtos: preco.
--> Coluna Artificial: quantidade x preco.
SELECT
    pe.id_pedido AS "ID",
    c.nome AS Cliente,
    pd.nome AS Produto,
    pe.quantidade AS Quantidade,
    pd.preco AS "Preço",
    (pe.quantidade*pd.preco) AS "Preço_Total"
FROM pedidos AS pe
JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
ORDER BY ID;

SHOW TABLES;
SELECT * FROM clientes;
SELECT * FROM funcionarios;
SELECT * FROM pedidos;
SELECT * FROM produtos;
SELECT * FROM info_produtos;