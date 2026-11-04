USE loja_informatica;


--> Criar Procedimentos Armazenados - Listar todos os clientes:
CREATE PROCEDURE ListarClientes()
    SELECT * FROM clientes;


--> Chamar o Procedimento Armazenado:
CALL ListarClientes();


--> Criar Procedimentos Armazenados Complexos:
--> [Para inserir um novo pedido]
DELIMITER // --> Muda o delimitador para '//' afim de finalizar o código sem cortar o processo.
CREATE PROCEDURE AdicionarPedido(
    IN pedidoID INT, IN clienteID INT, IN produtoID INT, IN qtd INT, IN dataPedido DATE)
BEGIN
    INSERT INTO pedidos (id_pedido, id_cliente, id_produto, quantidade, data) VALUES
    (pedidoID, clienteID, produtoID, qtd, dataPedido);
    INSERT INTO backup_pedidos(id_pedido, id_cliente, id_produto, quantidade, data) VALUES
    (pedidoID, clienteID, produtoID, qtd, dataPedido);
END //
DELIMITER ; --> Devolve o delimitador para ';'.

--> Comandos de Correção:
DROP PROCEDURE AdicionarPedido;
DELETE FROM pedidos
WHERE id_pedido = 201
LIMIT 1;

--> Chamar o Procedimento Armazenado:
CALL AdicionarPedido(201, 1, 2, 10, '2024-03-01');


--> Visualizar os dados inseridos:
SELECT * FROM pedidos
WHERE id_pedido = 201;


--> Criar Procedimentos Armazenados Complexos:
--> [Visualizar novos preços sem alterar a tabela produto]
--> [Visualizar a quantidade de registros]
DELIMITER //
CREATE PROCEDURE PromoProdutos(IN desconto FLOAT, OUT totalProdutos INT)
BEGIN
    DECLARE fator_desconto FLOAT;
    SET fator_desconto = (1 - (desconto/100));

    SELECT COUNT(*) INTO totalProdutos
    FROM produtos;

    SELECT id_produto, nome_produto, preco AS preco_original, ROUND(preco * fator_desconto, 2) AS preco_com_desconto
    FROM produtos;
END //
DELIMITER ;

DROP PROCEDURE PromoProdutos;

--> Chamar o Procedimento Armazenado:
CALL PromoProdutos(5, @totalProdutos);
SELECT @totalProdutos AS TPA;


--> Mostrar todos os procedimentos:
SHOW PROCEDURE STATUS;


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
