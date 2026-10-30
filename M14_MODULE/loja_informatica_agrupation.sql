USE loja_informatica;

-- GROUP BY [Agrupamento]

-- Em um agrupamento, tudo que está no [SELECT] precisa ser:
--> 1. Uma coluna listada no GROUP BY.
--> 2; Uma função de agregação (COUNT, SUM, AVG, STDDEV...)

--> Exemplo 01:
SELECT DISTINCT
    nome_produto,
    ROUND(SUM(preco),2) AS preco_total,
    COUNT(*) AS qtd_produtos
FROM produtos
GROUP BY nome_produto;

--> Exemplo 02:
SELECT
    DENSE_RANK() OVER(ORDER BY SUM(preco)) AS rnk_categoria,
    categoria,
    COUNT(nome_produto) AS qtd_produtos,
    ROUND(SUM(preco),2) AS preco_categoria,
    MIN(preco) AS min_categoria,
    MAX(preco) AS max_categoria,
    AVG(preco) AS media_categiria,
    STDDEV(preco) AS dp_categoria,
    STDDEV(preco) / AVG(preco) AS cdv_categoria
FROM (
    SELECT DISTINCT nome_produto, categoria, preco
    FROM produtos
    WHERE nome_produto IS NOT NULL
) AS p
GROUP BY categoria
ORDER BY preco_categoria;


--> HAVING [Filtro após agrupamento]

--> Sem filtros:
SELECT 
    categoria,
    COUNT(*) AS qtd
FROM produtos
GROUP BY categoria;

--> Com WHERE:
SELECT
    categoria,
    COUNT(*) AS qtd
FROM produtos
WHERE categoria <> 'Componentes'
GROUP BY categoria;

--> Com HAVING:
SELECT
    categoria,
    COUNT(*) AS qtd
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 10;

--> Com WHERE & HAVING:
SELECT
    categoria,
    COUNT(*) AS qtd
FROM produtos
WHERE categoria <> 'Componentes'
GROUP BY categoria
HAVING COUNT(*) > 10;

--> Apenas com o HAVING:
SELECT
    categoria,
    COUNT(*) AS qtd
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 10
AND categoria <> 'Componentes';


--> Lembrete:
--> O ideal é sempre usar o WHERE se possível,
--> pois resume a consulta antes de agrupá-la.

SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;