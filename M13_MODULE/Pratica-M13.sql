-- N° 1.
USE restaurante;

-- N° 2.
SELECT * FROM pedidos
WHERE id_funcionario = 4 AND status = 'Pendente';

-- N° 3.
SELECT * FROM pedidos
WHERE status <> 'Concluído';

-- N° 4.
SELECT * FROM pedidos
WHERE id_produto IN (1,3,5,7,8);

-- N° 5.
SELECT nome, cpf, email, data_cadastro
FROM clientes
WHERE nome LIKE 'C%';

-- N° 6.
SELECT * FROM produtos
WHERE (descricao LIKE '%frango%'
OR descricao LIKE '%carne%');

-- N° 7.
SELECT * FROM produtos
WHERE preco BETWEEN 20 AND 30;

-- Iniciando alterações em ambiente controlado.
SET SQL_SAFE_UPDATES=0;

START TRANSACTION;

-- N° 8.
UPDATE pedidos
SET status = NULL
WHERE id_pedido = 6;

COMMIT;

SET SQL_SAFE_UPDATES=1;

-- N° 9.
SELECT * FROM pedidos
WHERE status IS NULL;

-- N° 10.
SELECT id_pedido, IFNULL(status, 'Cancelado') AS status
FROM pedidos;

-- Confirmando que o comando anterior funcionou.
SELECT id_pedido, IFNULL(status, 'Cancelado') AS status
FROM pedidos
WHERE status IS NULL;

-- N° 11.
SELECT nome, cargo, salario, 
CASE
    WHEN salario > 3000 THEN 'Acima da Média'
    ELSE 'Abaixo da Média'
END AS media_salario
FROM funcionarios;

-- N° Extra [Apenas a título de estudo]
SELECT nome, cargo, salario,
CASE
    WHEN salario > AVG(salario) OVER () THEN 'Acima da Média'
    ELSE 'Abaixo da Média'
END AS media_salario
FROM funcionarios;



-- Gabarito para analise das colunas de todas as tabelas.
SELECT * FROM clientes;
SELECT * FROM funcionarios;
SELECT * FROM info_produtos;
SELECT * FROM pedidos;
SELECT * FROM produtos;