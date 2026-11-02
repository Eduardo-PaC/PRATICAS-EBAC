USE loja_informatica;


--> Quando eu devo utilizar uma subconsulta?

--> 1. Para chegar no resultado que eu desejo, eu preciso calcular algo em duas etapas, onde a segunda depende do resultado da primeira?
--> a. Se sim, então deve-se utilizar a subconsulta, CTE ou Window Function.
--> b. Se não, então um JOIN + GROUP BY (ou WHERE) deve resolver.

--> 2. Sinais de que precisamos de subconsultas:
--> 2.1 "Agregar sobre uma agregação"
-->     a. Média dos totais.
-->     b. Máximo das somas.
-->     c. Quantos clientes tem mais de X pedidos.

--> 2.2 "Comparar com um valor calculado"
-->     a. Maior que a média.
-->     b. Igual ao máximo.
-->     c. Acima do total geral.
-->     d. O valor de comparação precisa existir antes do filtro.

--> 2.3 "Filtrar pelo resultado de uma agregação"
-->     a. Se você quer mostrar ou comparar dados com outra agregação.


--> SubConsulta [WHERE]: Nome de clientes que fizeram algum pedido.
SELECT nome
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM pedidos
);

--> SubConsulta [SELECT] & [WHERE]: Nome & Email de clientes que fizeram pedidos de 5 ou mais itens:
SELECT
    nome,
    email,
    (
        SELECT COUNT(quantidade) FROM pedidos
        WHERE pedidos.id_cliente = clientes.id_cliente
    ) AS total_pedidos,
    (
        SELECT SUM(quantidade) FROM pedidos
        WHERE pedidos.id_cliente = clientes.id_cliente
    ) AS qtd_total
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM pedidos
    WHERE quantidade > 5
);

--> SubConsulta [SELECT]: Nome, Email e Total Gasto (Por ID)
SELECT
    nome,
    email,
    id_cliente,
    (
        SELECT SUM(pe.quantidade * pd.preco)
        FROM pedidos AS pe
        JOIN produtos AS pd
        ON pe.id_produto = pd.id_produto
        WHERE pe.id_cliente = c.id_cliente
    ) AS total_gasto
FROM clientes AS c
ORDER BY total_gasto DESC;

--> JOIN: Nome, Email e Total Gasto (Por Nome)
SELECT
    c.nome,
    c.email,
    SUM(pe.quantidade * pd.preco) AS total_gasto
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
LEFTJOIN produtos AS pd
ON pd.id_produto = pe.id_produto
GROUP BY c.nome, c.email;

--> Subconsulta [HAVING]:
SELECT
    categoria,
    AVG(preco) AS media_preco
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > (
    SELECT AVG(preco) FROM produtos
);


--> Subconsulta [FROM]:
--> Exemplo 01:
SELECT
    AVG(soma_qtd) AS media_por_cliente
FROM (
    SELECT
        c.nome,
        SUM(pe.quantidade) AS soma_qtd
    FROM clientes AS c
    JOIN pedidos AS pe
    ON c.id_cliente = pe.id_cliente
    GROUP BY nome
) AS totais;


--> Exemplo 02:
SELECT
    c.nome,
    pa.total_pedidos,
    pa.soma_quantidade
FROM clientes AS c
JOIN (
    SELECT
        id_cliente,
        COUNT(*) AS total_pedidos,
        SUM(quantidade) AS soma_quantidade
    FROM pedidos
    GROUP BY id_cliente
) AS pa
ON c.id_cliente = pa.id_cliente;


--> Liste os clientes cujo total de pedidos é maior que a média,
--> mostrando nome e email.
SELECT
    id_cliente,
    nome,
    email,
    qtd_total
FROM (
    SELECT
        c.id_cliente,
        c.nome,
        c.email,
        SUM(pe.quantidade) AS qtd_total,
        AVG(SUM(pe.quantidade)) OVER() AS media
    FROM clientes As c
    JOIN pedidos AS pe
    ON c.id_cliente = pe.id_cliente
    GROUP BY c.id_cliente, c.nome, c.email
) AS t
WHERE qtd_total > media
ORDER BY nome;


--> SubConsulta [ORDER BY]:
SELECT
    c.nome,
    c.email
FROM clientes AS c
ORDER BY (
    SELECT SUM(pe.quantidade * pd.preco) AS total_gasto
    FROM pedidos AS pe
    JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
) DESC;


SELECIONAR
    produtos,
    cliente com maior compras desse produto,
    quantidade comparada

SELECT
    c.nome AS clientes,
    pd.nome_produto AS produtos,
    SUM(pe.quantidade) AS qtd_por_produto
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
LEFT JOIN produtos AS pd
ON pd.id_produto = pe.id_produto
GROUP BY clientes, produtos;


SELECT
    c.nome AS clientes,
    pd.nome_produto AS produtos,
    SUM(pe.quantidade) AS qtd_por_produto
FROM clientes AS c
LEFT JOIN pedidos AS pe
ON c.id_cliente = pe.id_cliente
LEFT JOIN produtos AS pd
ON pd.id_produto = pe.id_produto
GROUP BY clientes, produtos


SELECT
    pd.id_produto AS id,
    pd.nome_produto AS produto
FROM produtos AS pd
LEFT JOIN pedidos AS pe
ON pd.id_produto = pe.id_produto
WHERE pe.id_produto IS


SELECT
    produto,
    cliente,
    qtd_por_produto
FROM(
    SELECT
        c.nome AS cliente,
        pd.nome_produto AS produto,
        SUM(pe.quantidade) AS qtd_por_produto,
        MAX(SUM(pe.quantidade)) OVER(PARTITION BY pd.nome_produto) AS max_total
    FROM clientes AS c
    LEFT JOIN pedidos AS pe
    ON c.id_cliente = pe.id_cliente
    RIGHT JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
    GROUP BY cliente, produto
) AS t
WHERE qtd_por_produto >= max_total
OR qtd_por_produto IS NULL;


SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;