USE informatica;

INSERT INTO cliente(
    nome_completo,
    email,
    data_nascimento,
    limite_credito
)VALUES
('Marcos', 'marcos@email.com', '1991-01-05', 8000),
('Ana', 'ana@email.com', '1980-05-28', 10000),
('João', 'joao@email.com', '1995-10-14', 5500),
('Pedro', 'pedro@email.com', '1994-05-25', 6000);

INSERT INTO cliente VALUES
(NULL, 'Thiago', 'thiago@email.com', '1995-08-20', 4600, NULL, TRUE, NULL, NULL);


SELECT * FROM cliente;
DESC cliente;