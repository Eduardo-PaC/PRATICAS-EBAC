SET GLOBAL local_infile =1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- Importando Dados CSV - Por COMANDO {clientes}
LOAD DATA LOCAL INFILE '/home/ikaelsama/projetos/analise-de-dados/PRATICAS-EBAC/cliente_informatica.csv'
INTO TABLE clientes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Importando Dados CSV - Por COMANDO {produtos}
LOAD DATA LOCAL INFILE '/home/ikaelsama/projetos/analise-de-dados/PRATICAS-EBAC/produto_informatica.csv'
INTO TABLE produtos
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Importando Dados CSV - Por COMANDO {pedidos}
LOAD DATA LOCAL INFILE '/home/ikaelsama/projetos/analise-de-dados/PRATICAS-EBAC/pedido_informatica.csv'
INTO TABLE pedidos
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;