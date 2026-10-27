CREATE DATABASE IF NOT EXISTS loja_informatica;
USE loja_informatica;

-- Criando Tabela: clientes.
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT,
    nome VARCHAR(50),
    email VARCHAR(100),
    cidade VARCHAR(50),
    PRIMARY KEY(id_cliente),
    CONSTRAINT uq_email
    UNIQUE(email)
) CHARACTER SET utf8mb4;

-- Criando Tabela: produtos.
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT,
    nome_produto VARCHAR(50),
    categoria VARCHAR(30),
    preco DECIMAL(10,2),
    PRIMARY KEY(id_produto)
) CHARACTER SET utf8mb4;

-- Criando Tabela: pedidos.
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT,
    id_cliente INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT,
    data DATE,
    CONSTRAINT cliente_pedido
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT produto_pedido
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
) CHARACTER SET utf8mb4;