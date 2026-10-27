USE informatica;

-- IN
SELECT * FROM cliente
WHERE id_cliente IN (1,2,4,6);

SELECT * FROM cliente
WHERE year(data_nascimento) IN (1991, 1995);



-- BETWEEN
SELECT * FROM cliente
WHERE data_nascimento BETWEEN '1990-01-01' AND '2000-12-31';

SELECT * FROM cliente
WHERE limite_credito BETWEEN 6000 AND 10000;


-- LIKE
SELECT * FROM cliente
WHERE info_adicionais LIKE 'revisao%';

SELECT * FROM cliente
WHERE info_adicionais LIKE '%cadastro';

SELECT * FROM cliente
WHERE (nome LIKE 'A%' OR nome LIKE 'P%' OR nome LIKE 'M%') AND cadastro_ativo = TRUE;

-- NULL
SELECT * FROM cliente
WHERE info_adicionais IS NULL;

SELECT * FROM cliente
WHERE info_adicionais IS NOT NULL;

SELECT nome, limite_credito, ROUND(limite_credito*1.012, 2) AS limite_atualizado
FROM cliente;

SELECT nome,
    COALESCE(cidade, 'X') AS endereço
FROM cliente
WHERE cidade IS NULL;


SELECT nome, limite_credito, IFNULL(cidade, 'Não Informado') AS cidade
FROM cliente;

SELECT nome, limite_credito, NULLIF(cidade, 'Não Informado') AS cidade
FROM cliente;


-- IF & CASE

SELECT nome, limite_credito, 
IF (limite_credito > 6000, 'Alto', 'Baixo') AS categoria_limite
FROM cliente;

SELECT nome, limite_credito,
    CASE
        WHEN limite_credito > 6000 THEN 'Alto'
        ELSE 'Baixo'
    END AS categoria_limite
FROM cliente;

SELECT id_cliente, nome, limite_credito,
    IF (limite_credito > 9000, 'Premium', 
        IF (limite_credito BETWEEN 5000 AND 9000, 'Gold', 'Silver')) AS categoria_credito
FROM cliente;

SELECT id_cliente, nome, limite_credito,
CASE
    WHEN limite_credito > 9000 THEN 'Premium'
    WHEN limite_credito BETWEEN 5000 AND 9000 THEN 'Gold'
    ELSE 'Silver'
END AS categoria_credito
FROM cliente;



-- Consulta Completa
SELECT * FROM cliente;
DESC cliente;
USE informatica;