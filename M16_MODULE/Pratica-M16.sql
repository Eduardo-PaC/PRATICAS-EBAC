-- Active: 1792937300966@@127.0.0.1@3306@restaurante

-- > N° 01 - Use o banco de dados [restaurante]:
USE restaurante;


-- > N° 02 - Crie uma VIEW chamada {resumo_pedido} do `JOIN` entre essas tabelas:
-- > [Pedidos: id, quantidade e data.
-- > Clientes: nome e email.
-- > Funcionarios: nome.
-- > Produtos: nome e preco.]:
CREATE VIEW resumo_pedido AS
SELECT
    pe.data_pedido AS Data_Pedido,
    pe.id_pedido AS ID,
    c.nome AS Cliente,
    c.email AS Email_Cliente,
    pd.nome AS Produto,
    pd.preco AS Preço,
    pe.quantidade AS Quantidade,
    f.nome AS Responsavel_Atendimento
FROM pedidos AS pe
JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
JOIN funcionarios AS f
    ON f.id_funcionario = pe.id_funcionario;

-- > Confirmando Resultado (N° 02):
SELECT * FROM resumo_pedido;


-- > N° 03 - Selecione:
-- > [ID do Pedido,
-- > Nome do Cliente,
-- > Total (quantidade * preco) de cada pedido] da VIEW {resumo_pedido}:
SELECT
    ID,
    Cliente,
    Quantidade * Preço AS Total
FROM resumo_pedido;


-- > N° 04 - Atualize a VIEW {resumo_pedido} adicionando a coluna
-- > [Total]:
CREATE OR REPLACE VIEW resumo_pedido AS
SELECT
    pe.data_pedido AS Data_Pedido,
    pe.id_pedido AS ID,
    c.nome AS Cliente,
    c.email AS Email_Cliente,
    pd.nome AS Produto,
    pd.preco AS Preço,
    pe.quantidade AS Quantidade,
    pe.quantidade * pd.preco AS Total,
    f.nome AS Responsavel_Atendimento
FROM pedidos AS pe
JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
JOIN funcionarios AS f
    ON f.id_funcionario = pe.id_funcionario;


-- > Confirmando Resultado (N° 04):
SELECT * FROM resumo_pedido;


-- > N° 05 - Repita a consulta da (N° 03), agora com a coluna
-- > [Total]:
SELECT
    ID,
    Cliente,
    Total
FROM resumo_pedido;


-- > N° 06 - Repita a consulta da (N° 05), utilizando `EXPLAIN` para 
-- > verificar e compreender o `JOIN` que está oculto na nossa Query:
EXPLAIN SELECT
    ID,
    Cliente,
    Total
FROM resumo_pedido;


-- > N° 07 - Crie uma Função chamada {BuscaIngredientesProdutos} que irá
-- > Retornar os Ingredientes de x Produto
-- > De [info_produtos]
-- > Quando receber [id_produto] como <entrada> da função:

DROP FUNCTION IF EXISTS BuscaIngredientesProdutos;

DELIMITER //
CREATE FUNCTION BuscaIngredientesProdutos(produtoID INT)
RETURNS TEXT
READS SQL DATA
BEGIN
    DECLARE v_ingredientes TEXT;
    
    SELECT ingredientes INTO v_ingredientes
    FROM info_produtos
    WHERE id_produto = produtoID;

    RETURN v_ingredientes;

END //
DELIMITER ;


-- > Confirmando Resultado (N° 07):
SELECT 
    nome AS Produto,
    descricao AS Descrição,
    BuscaIngredientesProdutos(id_produto) AS Ingredientes,
    preco AS Preço
FROM produtos;


-- > N° 08 - Execute a Função {BuscaIngredientesProdutos}
-- > Utilizando [id_produto] = 10:
SELECT
    nome AS Produto,
    descricao AS Descrição,
    BuscaIngredientesProdutos(10) AS Ingredientes,
    preco AS Preço
FROM produtos
WHERE id_produto = 10;


-- > N° 09 - Crie uma Função chamada {mediaPedido} que irá
-- > Retornar x mensagem, 
-- >     Sendo x = 'Acima da Média', 'Igual à Média', 'Abaixo da Média' ou 'Pedido Não Encontrado'.
-- > De [resumo_pedido]
-- > Quando receber [ID] como <entrada> da função:

DROP FUNCTION IF EXISTS mediaPedido;

DELIMITER //
CREATE FUNCTION mediaPedido(pedidoID INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN

    DECLARE v_total DECIMAL(10, 2);
    DECLARE v_media DECIMAL(10, 2);
    DECLARE v_resultado VARCHAR(100);

    SELECT Total INTO v_total
    FROM resumo_pedido
    WHERE ID = pedidoID;

    SELECT AVG(Total) INTO v_media
    FROM resumo_pedido;

    SET v_resultado =
    CASE
        WHEN v_total IS NULL THEN 'Pedido Não Encontrado'
        WHEN v_media IS NULL THEN 'Pedido Não Encontrado'
        WHEN v_total > v_media THEN 'Acima da Média'
        WHEN v_total = v_media THEN 'Igual à Média'
        WHEN v_total < v_media THEN 'Abaixo da Média'
    END;

    RETURN v_resultado;
END //
DELIMITER ;


-- > Confirmando Resultado (N° 09):
SELECT 
    Cliente,
    Produto,
    Preço,
    Quantidade,
    Total,
    mediaPedido(ID) AS Comparacao_Media
FROM resumo_pedido;


-- > N° 10 - Execute a Função {mediaPedido}
-- > Utilizando [ID] = 5
-- > E [ID] = 6:

-- > ID = 5:
SELECT 
    Cliente,
    Produto,
    Preço,
    Quantidade,
    Total,
    mediaPedido(5) AS Comparacao_Media
FROM resumo_pedido
WHERE ID = 5;

-- > ID = 6:
SELECT 
    Cliente,
    Produto,
    Preço,
    Quantidade,
    Total,
    mediaPedido(6) AS Comparacao_Media
FROM resumo_pedido
WHERE ID = 6;




-- > Consultas Gerais:
SHOW TABLES;
SELECT * FROM clientes LIMIT 5;
SELECT * FROM funcionarios LIMIT 5;
SELECT * FROM info_produtos LIMIT 5;
SELECT * FROM pedidos LIMIT 5;
SELECT * FROM produtos LIMIT 5;
SELECT * FROM resumo_pedido LIMIT 5;