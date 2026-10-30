USE loja_informatica;

SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM produtos;

-- Agregação:

--> Contagem:
SELECT 
    COUNT(nome_produto) AS qtd_produtos
FROM produtos;

--> Utilizando [DISTINCT] (ignora valores repetidos)
SELECT
    COUNT(DISTINCT nome_produto) AS qtd_produtos
FROM produtos;

--> SOMA
SELECT
    SUM(quantidade) AS qtd_total
FROM pedidos;

--> Utilizando [DISTINCT] (ignora valores repetidos)
SELECT
    SUM(DISTINCT quantidade) AS qtd_total
FROM pedidos;

--> MAX (Maior Valor)
SELECT
    MAX(preco) AS Maximum
FROM produtos;

--> MIN (Menor Valor)
SELECT
    MIN(preco) AS Minimum
FROM produtos;

--> AVG (Média dos Valores)
SELECT
    ROUND(AVG(preco), 2) AS Media
FROM produtos;

--> VAR_POP (Variância Populacional)
SELECT
    VAR_POP(preco) AS Variancia_Pop
FROM produtos;

--> VAR_SAMP (Variância de Amostragem)
SELECT
    VAR_SAMP(preco) AS Variancia_Amostra
FROM produtos;

--> STDDEV (Desvio Padrão)
SELECT
    STDDEV(preco) AS Desvio_Padrao
FROM produtos;

--> Cálculo de Coeficiente de Variancia Padrão
SELECT
    STDDEV(preco) / AVG(preco) AS CVP
FROM produtos;

--> Agrupamento de linhas em célula
SELECT
    GROUP_CONCAT(nome_produto) AS nomes
FROM produtos;

--> Ranqueamento Padrão [No caso de empate, deixa furos na numeração]
SELECT
    nome_produto,
    RANK() OVER(ORDER BY preco DESC) AS rnk_produto
FROM produtos;

--> Ranqueamento Per Row [Nunca empata]
SELECT
    nome_produto,
    ROW_NUMBER() OVER(ORDER BY preco DESC) AS rnk_produto
FROM produtos;

--> Ranqueamento Denso [No caso de empate, segue a sequência]
SELECT
    nome_produto,
    DENSE_RANK() OVER(ORDER BY preco DESC) AS rnk_produto
FROM produtos;

--> Utilizando [DISTINCT] (ignora valores repetidos)
SELECT DISTINCT
    nome_produto,
    DENSE_RANK() OVER(ORDER BY preco DESC) AS rnk_produto
FROM produtos;