SET GLOBAL local_infile =1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET SQL_SAFE_UPDATES=0;

START TRANSACTION;

DELETE FROM pedidos;
DELETE FROM clientes;

ALTER TABLE clientes
DROP INDEX uq_email;

COMMIT;

SET SQL_SAFE_UPDATES=1;

-- Importando Dados CSV - Por COMANDO {clientes}
LOAD DATA LOCAL INFILE '/home/ikaelsama/projetos/analise-de-dados/PRATICAS-EBAC/M14_MODULE/importation_archives/cliente_informatica.csv'
INTO TABLE clientes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Importando Dados CSV - Por COMANDO {produtos}
LOAD DATA LOCAL INFILE '/home/ikaelsama/projetos/analise-de-dados/PRATICAS-EBAC/M14_MODULE/importation_archives/produto_informatica.csv'
INTO TABLE produtos
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Importando Dados CSV - Por COMANDO {pedidos}
LOAD DATA LOCAL INFILE '/home/ikaelsama/projetos/analise-de-dados/PRATICAS-EBAC/M14_MODULE/importation_archives/pedido_informatica.csv'
INTO TABLE pedidos
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;