USE loja_informatica;

--> FULL JOIN: Visualiza todas as linhas de todas as tabelas selecionadas:
--> O MySQL não possui um comando direto, logo... Vamos de Gambiarra:
--> Exemplo 01:
SELECT
    c.nome AS cliente, 
    pe.id_pedido AS pedido
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
WHERE pe.id_pedido IS NULL
UNION
SELECT
    c.nome AS cliente, 
    pe.id_pedido AS pedido
FROM clientes AS c
RIGHT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
WHERE pe.id_pedido IS NULL


--> Exemplo 02:
SELECT
    c.nome AS cliente,
    pd.nome_produto AS produto,
    pe.quantidade
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
LEFT JOIN produtos AS pd
ON pd.id_produto = pe.id_produto
UNION
SELECT
    c.nome AS cliente,
    pd.nome_produto AS produto,
    pe.quantidade
FROM clientes AS c
RIGHT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
RIGHT JOIN produtos AS pd
ON pd.id_produto = pe.id_produto;

--> SELF JOIN: Compara a tabela selecionada com ela mesma (confuso):
SELECT
    c1.nome AS cliente_1, c1.id_cliente AS ID1,
    c2.nome AS cliente_2, c2.id_cliente AS ID2,
    c1.cidade AS cidade_em_comum
FROM clientes AS c1
JOIN clientes AS c2
ON c1.cidade = c2.cidade AND c1.id_cliente < c2.id_cliente
ORDER BY c1.cidade, c1.nome, c2.nome;




SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;