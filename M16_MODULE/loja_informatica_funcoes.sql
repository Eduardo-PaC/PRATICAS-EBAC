USE loja_informatica;


--> Criando Função:
--> [Retornar o nome de um cliente com base no seu ID]
DELIMITER //
CREATE FUNCTION BCN(idCliente INT)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
    DECLARE nomeCliente VARCHAR(200);
    SELECT nome INTO nomeCliente
    FROM clientes
    WHERE id_cliente = idCliente;
    RETURN nomeCliente;
END //
DELIMITER ;

--> Utilizar a Função criada em uma consulta:
SELECT BCN(76);


--> Criando Função:
--> [Retornar o nome de um cliente com base no seu ID]
DELIMITER //
CREATE FUNCTION TotalVendas(produtoID INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(pd.preco * pe.quantidade) INTO total
    FROM pedidos AS pe
    JOIN produtos AS pd
        ON pd.id_produto = pe.id_produto
    WHERE pd.id_produto = produtoID;
    RETURN total;
END //
DELIMITER ;

DROP FUNCTION TotalVendas;

--> Utilizar a Função criada em uma consulta:
SELECT nome_produto, TotalVendas(id_produto) AS total_vendas FROM produtos;



--> Criando Função:
--> [Classificar o desempenho de vendas de um produto]
DELIMITER //
CREATE FUNCTION CDV(produtoID INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE totalVendas DECIMAL(10, 2);
    DECLARE desempenho VARCHAR(100);

    SELECT COALESCE(SUM(pd.preco*pe.quantidade), 0) INTO totalVendas
    FROM produtos AS pd
    LEFT JOIN pedidos AS pe
        ON pd.id_produto = pe.id_produto
    WHERE pd.id_produto = produtoID;

    SET desempenho =
    CASE
        WHEN totalVendas = 0 THEN 'Sem Vendas'
        WHEN totalVendas <= 1000 THEN 'Baixo'
        WHEN totalVendas <= 5000 THEN 'Médio'
        ELSE 'Alto'
    END;

    RETURN desempenho;
END //
DELIMITER ;

--> Utilizar Função criada em uma consulta:
SELECT
    nome_produto,
    CDV(id_produto) AS desempenho_vendas
FROM produtos;



--> Criando Função:
--> [Calcular Desconto em cima de um valor digitado]
DELIMITER //
CREATE FUNCTION CalcDescont(valor DECIMAL(10, 2), percentualDesconto DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
NO SQL
BEGIN
    DECLARE resultado DECIMAL(10, 2);
    DECLARE desconto DECIMAL(10, 2);

    SET desconto = valor * (percentualDesconto / 100);

    SET resultado = valor - desconto;
    RETURN resultado;
END //
DELIMITER ;


--> Utilizar Função criada em uma consulta:
SELECT nome_produto, preco, CalcDescont(preco, 20) AS preco_final
FROM produtos;


--> Mostrar todas as fuções disponíveis:
SHOW FUNCTION STATUS;


--> Consultas Gerais:
SHOW TABLES;
SELECT * FROM pedidos;
SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM backup_pedidos;
SELECT * FROM backup_clientes;
SELECT * FROM backup_produtos;
SELECT * FROM cs;
SELECT * FROM cpt;
SELECT * FROM dctg;