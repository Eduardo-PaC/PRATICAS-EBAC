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
OR qtd_por_produto IS NULL
ORDER BY qtd_por_produto;


--> SubQuery no [SELECT]:
--> SubConsulta Escalar, retorna um único valor (uma célula: 1 linha e 1 coluna) para aparecer
--> como uma "coluna extra" calculada ao lado de cada linha do resultado principal.

--> Quando usar: Quando você quer exibir uma informação geral (como média de preço de todos
--> os produtos ou o total de vendas) lado a lado com os detalhes de cada linha.

--> Exemplo Mental: "Para cada produto que eu listar, traga o nome dele e, em uma coluna ao lado
--> traga o preço médio geral de todos os produtos do estoque"

--> Exemplo 01:
SELECT
    c.nome,
    (
        SELECT COUNT(*)
        FROM pedidos AS pe
        WHERE pe.id_cliente = c.id_cliente) AS total_pedidos
FROM clientes AS c;


--> Exemplo 02:
SELECT
    id_pedido,
    quantidade,
    (SELECT AVG(quantidade) FROM pedidos) AS media
FROM pedidos;


--> SubQuery no [FROM]:
--> Tabela Derivada ou Inline View, cria uma tabela temporária na memória que você pode consultar,
--> filtrar e fazer 'JOIN' logo em seguida. Regra de ouro: ela {SEMPRE} precisa de um apelido (alias)
--> no final.

--> Quando usar: Quando você precisa fazer um cálculo complexo (como agrupar, somar ou usar funções
--> de janela) primeiro, e depoois usar esse resultado como se fosse uma tabela física real. É aqui
--> que as CTEs (WITH)*¹ brilham muito, pois deixam o código limpo.

--> Exemplo Mental: "Primeiro, calcule o total vendido por produto. Depois, faça um JOIN dessa
--> tabela temporária com a tabela de clientes."

--> *¹: CTEs: São subconsultas organizadas no topo da Query.


--> SubQuery no [WHERE/HAVING]:
--> SubConsulta de Filtro, funciona como um critério de comparação. O banco roda a subconsulta
--> para descobrir um valor (ou uma lista de valores) e usa isso para decidir quem entra na
--> resposta final.

--> Quando usar: Quando o filtro depende de um dado dinâmico que precisa ser calculado na hora.

--> Exemplo Mental: "Traga os clientes cujas compras tenham um valor maior do que a média de
--> todas as compras da empresa." (O banco primeiro vai descobrir a média, depois vai filtrar
--> os clientes).



--> Apresente o nome do produto e o nome do cliente que comprou a maior quantidade
--> de cada produto.

--> 1. O que queremos ver?
--> R: nome_produto, nome_cliente.

--> 2. Quantas tabelas são? Como elas se conectam?
--> R: São três tabelas ao todo: [clientes], [pedidos], [produtos].
--> R: Elas se conectam através de JOINs, onde [clientes] -> [pedidos] <- [produtos].
--> R: (A tabela [pedidos]concentra os IDs das outras duas).

--> 3. Qual é a regra de negócio?
--> R: Deve-se trazer apenas os nomes dos clientes que compraram a maior quantidade de cada produto.


WITH mqp AS (
    SELECT
        c.nome AS cliente,
        pd.nome_produto AS produto,
        SUM(pe.quantidade) AS qpp,
        MAX(SUM(pe.quantidade)) OVER(PARTITION BY pd.nome_produto) AS mqtd
    FROM pedidos AS pe
    LEFT JOIN produtos AS pd
        ON pd.id_produto = pe.id_produto
    LEFT JOIN clientes AS c
        ON c.id_cliente = pe.id_cliente
    GROUP BY cliente, produto
    ORDER BY mqtd
)
SELECT
    produto,
    cliente,
    qpp
FROM mqp
WHERE qpp = mqtd
OR qpp IS NULL
ORDER BY qpp;







SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;