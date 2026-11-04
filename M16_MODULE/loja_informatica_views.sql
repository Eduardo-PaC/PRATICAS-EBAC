-- Active: 1792937300966@@127.0.0.1@3306@loja_informatica
USE loja_informatica;


--> VIEW - Simplicando tabelas:
CREATE VIEW cs AS 
SELECT id_cliente, nome, email
FROM clientes;

--> VIEW - Atualizar regras:
CREATE OR REPLACE VIEW cs AS
SELECT id_cliente, nome, cidade
FROM clientes; -- Aqui estamos dizendo que não é mais para mostrar o email dos clientes.


--> VIEW - Deletar visualização:
DROP VIEW cs;


--> VIEW - Simplificando consulta complexa:
--> [Calcular o total de pedidos feitos por cada cliente]
CREATE VIEW cpt AS
SELECT
    c.nome AS Cliente,
    COUNT(*) AS Pedidos_Totais
FROM pedidos AS pe
RIGHT JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
GROUP BY Cliente;

--> VIEW - Filtro dentro da View:
SELECT * FROM cpt
WHERE Pedidos_Totais > 15;


--> VIEW - Simplificando consulta complexa 02:
--> [Listar Detalhes do Cliente e Total Gasto]
CREATE OR REPLACE VIEW dctg AS
SELECT
    c.nome AS Cliente,
    c.email AS Email,
    SUM(pe.quantidade*pd.preco) AS Total_Gasto
FROM pedidos AS pe
JOIN clientes AS c
    ON c.id_cliente = pe.id_cliente
JOIN produtos AS pd
    ON pd.id_produto = pe.id_produto
GROUP BY Cliente, Email
ORDER BY Cliente;


--> VIEW - Filtro dentro da View:
SELECT * FROM dctg
WHERE Total_Gasto > 30000;


--> Consultas Gerais:
SHOW TABLES;
SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM produtos;
SELECT * FROM cs;
SELECT * FROM cpt;
SELECT * FROM dctg;