USE informatica;

CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    limite_credito DECIMAL(10,2) NOT NULL,
    info_adicionais TEXT,
    cadastro_ativo BOOLEAN DEFAULT 1,
    id_produto INT,
    UNIQUE (email),
    PRIMARY KEY (id_cliente)
);

-- Alterações básicas de adição e remoção de coluna
ALTER TABLE cliente 
ADD endereco VARCHAR(255),
ADD cidade VARCHAR(255);

ALTER TABLE cliente
DROP endereco;

-- Alterações de coluna existente
ALTER TABLE cliente
CHANGE nome_completo nome VARCHAR(255) NOT NULL,
ALTER cidade SET DEFAULT 'Não Informado';

-- Alterações de chave [ CUIDADO ]
ALTER TABLE cliente
MODIFY id_cliente INT;

ALTER TABLE cliente
DROP PRIMARY KEY;

ALTER TABLE cliente
MODIFY id_cliente INT AUTO_INCREMENT,
ADD PRIMARY KEY (id_cliente);

CREATE TABLE produto(
    id_produto INT AUTO_INCREMENT,
    PRIMARY KEY (id_produto)
);

ALTER TABLE cliente
ADD CONSTRAINT cliente_produto
FOREIGN KEY (id_produto) REFERENCES produto(id_produto);

SELECT * FROM cliente;

SET SQL_SAFE_UPDATES=0;
START TRANSACTION;

-- Atualizar multiplos campos
UPDATE cliente
SET data_nascimento = '1975-04-10', limite_credito = 10000
WHERE id_cliente = 4;

-- Atualizar com operadores matemáticos
UPDATE cliente
SET limite_credito = limite_credito + 500
WHERE id_cliente = 2;

-- Atualizar com condições complexas
UPDATE cliente
SET cadastro_ativo = FALSE
WHERE limite_credito <= 10000 AND data_nascimento < '1980-01-01';

UPDATE cliente
SET info_adicionais = 'Inativo'
WHERE cadastro_ativo = FALSE;

-- Atualizar todos os registros de uma coluna
UPDATE cliente
SET info_adicionais = 'Revisão de Cadastro';

DESC cliente;
SELECT * FROM cliente;

COMMIT;

SET SQL_SAFE_UPDATES=1;