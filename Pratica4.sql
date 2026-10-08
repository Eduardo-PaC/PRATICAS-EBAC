CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;

CREATE TABLE IF NOT EXISTS funcionarios (
id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
cpf VARCHAR(14),
data_nascimento DATE,
endereco VARCHAR(255),
telefone VARCHAR(15),
email VARCHAR(100),
cargo VARCHAR(100),
salario DECIMAL(10,2),
data_admissao DATE
);

CREATE TABLE IF NOT EXISTS clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
cpf VARCHAR(14),
data_nascimento DATE,
endereco VARCHAR(255),
telefone VARCHAR(15),
email VARCHAR(100),
data_cadastro DATE
);

CREATE TABLE IF NOT EXISTS produtos (
id_produto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
descricao TEXT,
preco DECIMAL(10,2),
categoria VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS  pedidos (
id_pedido INT PRIMARY KEY AUTO_INCREMENT,
id_cliente INT,
id_funcionario INT,
id_produto INT,
quantidade INT,
preco DECIMAL(10,2),
data_pedido DATE,
status VARCHAR(50),
CONSTRAINT cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
CONSTRAINT funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
CONSTRAINT produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE IF NOT EXISTS info_produtos (
id_info INT PRIMARY KEY AUTO_INCREMENT,
id_produto INT,
ingredientes TEXT,
fornecedor VARCHAR(255),
CONSTRAINT produto_info FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
