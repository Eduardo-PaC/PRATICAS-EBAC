USE loja_informatica;

CREATE TABLE IF NOT EXISTS backup_pedidos LIKE pedidos;
CREATE TABLE IF NOT EXISTS backup_produtos LIKE produtos;
CREATE TABLE IF NOT EXISTS backup_clientes LIKE clientes;