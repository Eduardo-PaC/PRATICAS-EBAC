--> N° 01. Use o banco de dados [restaurante]:
USE restaurante;

--> N° 02. Calcule a quantidade de pedidos:
SELECT
    SUM(quantidade) AS qtd_pedidos
FROM pedidos;

--> N° 03. Calcule a quantidade de clientes únicos que realizaram pedidos:
SELECT
    COUNT(DISTINCT id_cliente) qtd_clientes_uniq
FROM pedidos;

--> N° 04. Calcule a média de preço dos produtos:
SELECT
    AVG(preco) AS med_preco
FROM produtos;

--> N° 05. Calcule o mínimo e máximo do preço dos produtos:
SELECT
    MIN(preco) AS min_preco,
    MAX(preco) AS max_preco
FROM produtos;

--> N° 06. Selecione {nome} e {preço} de [produtos] e faça um rank dos 5
--> produtos mais caros:

SELECT
    DENSE_RANK() OVER(ORDER BY preco DESC) AS rnk_preco, 
    nome,
    preco
FROM produtos
LIMIT 5;

--> N° 07. Selecione a (AVG) dos {preços} dos [produtos] agrupados por
--> {categoria}.

SELECT
    categoria,
    ROUND(AVG(preco),2) AS med_preco
FROM produtos
GROUP BY categoria
ORDER BY med_preco DESC;

--> N° 08. Selecionar o {fornecedor} e a quantidade de produtos que vieram
--> daquele {fornecedor} de [info_produtos]:

SELECT
    fornecedor,
    COUNT(fornecedor) AS qtd_produtos
FROM info_produtos
GROUP BY fornecedor
ORDER BY qtd_produtos DESC;

--> N° 09. Selecionar os {fornecedores} que possuem mais de um [produto]
--> cadastrado:
SELECT
    fornecedor,
    COUNT(fornecedor) AS qtd_produtos
FROM info_produtos
GROUP BY fornecedor
HAVING COUNT(fornecedor) > 1
ORDER BY qtd_produtos DESC;

--> N° 10. Selecionar os clientes que realizaram apenas 1 pedido:
SELECT
    id_cliente,
    COUNT(quantidade) AS qtd_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(quantidade) = 1;

--> Consultas Gerais:
SHOW TABLES;
SELECT * FROM clientes;
SELECT * FROM funcionarios;
SELECT * FROM info_produtos;
SELECT * FROM pedidos;
SELECT * FROM produtos;

--> Consultando possíveis NULLs
SELECT * FROM pedidos
WHERE quantidade IS NULL
OR id_produto IS NULL
OR id_funcionario IS NULL
OR id_cliente IS NULL;