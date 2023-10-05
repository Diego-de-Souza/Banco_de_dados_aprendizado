use master

IF DB_ID ('DBBecasSantander') IS NOT NULL -- verifica se o banco de dados já existe
DROP DATABASE DBBecasSantander -- se já existir, apaga

CREATE DATABASE DBBecasSantander --criar o banco de dados
ON ( NAME = dbBecasSantander_dados,FILENAME = 'D:DB\dbBecasSantander_dados.mdf') --especifica onde o arquivo de dados será salvo
LOG ON ( NAME = dbBecasSnatander_Log, FILENAME = 'D:\DB\dbBecasSantander_Log.ldf') -- especifica onde o arquivo de log será salvo

use DBBecasSantander

CREATE TABLE usuarios (
	id INT NOT NULL,
	nome VARCHAR(255) NOT NULL, --Nome do usuário,
	email VARCHAR(100) NOT NULL UNIQUE, --COMMENT 'E-mail do usuário'
	endereco VARCHAR(50) NOT NULL, --COMMENT 'Endereço do usuário'
	data_nascimento DATE NOT NULL --COMMENT 'Data de nascimento do usuario'
); 

CREATE TABLE destinos (
	id INT NOT NULL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL UNIQUE, -- nome do destino
	descrição VARCHAR(255) NOT NULL, --descrição do destino
);

CREATE TABLE reservas (
	id INT NOT NULL, --identificador unico da reserva
	id_usuario INT, --referencia ao ID do usuario que fez a reserva
	id_destino INT, --referencia ao ID do destino dareserva
	data DATE, --data da reserva
	status VARCHAR(255) DEFAULT 'pendente' --status da reserva(confirmada, pendente, cacelada, etc)
	);

INSERT INTO usuarios (id,nome, email, data_nascimento, endereco) 
VALUES (1, 'Diego de Souza Lima', 'diegodesouza.souza@gmail.com', '1988-01-17','Claudemir Gomes do Vale,652 - Los Angeles - SBC'),
		(1, 'Emilly Lorrane Alves Lima', 'teste1@gmail.com', '2012-08-24','Apostolos,266 - Los Angeles - SBC'),
		(3, 'Thomas Anderson   de Souza Nobre', 'teste2@gmail.com', '2020-04-20','Apostolos, 266 - Los Angeles - SBC'),
		(4, 'Thais de Assis Correa', 'teste3@gmail.com', '1991-11-15','Claudemir Gomes do Vale,652 - Los Angeles - SBC'),
		(5, 'Otavio de Souza Lima', 'teste4@gmail.com', '2008-07-06','não sei, 00 - Los Angeles - SBC');

INSERT INTO destinos (id, nome,descrição)
VALUES(1,'Mongagua','linda Praia com algumas beldades'),
		(2,'Caraguatatuba','Praia linda com areia branca e limpa'),
		(3,'Ilha bela','Praia maravilhosa'),
		(4,'Dunas','Praia objeto sonhos com areia branquinha'),
		(5,'Praia dos Pelados','Liberdade com beleza');

INSERT INTO reservas (id, id_usuario, id_destino, status, data)
VALUES (1,1,1,'pendente', '2023-10-04'),
		(2,2,1,'pendente', '2023-10-04'),
		(3,3,1,'pendente', '2023-10-04'),
		(4,4,1,'pendente', '2023-10-04');

-- DELETE FROM reservas WHERE id = 1 -> COMANDO PARA DELETAR UMA LINHA
--exluir uma coluna da tabela
ALTER TABLE usuarios DROP COLUMN email;
GO
--exclui a tabela
DROP TABLE destinos;

--COMANDO PARA SELECIONAR TABELAS
SELECT * 
FROM usuarios

SELECT * 
FROM destinos

SELECT * 
FROM reservas

--COMANDO PARA SELECIONAR O USUARIO COM ID 1 USANDO A CONDIÇÃO WHERE
SELECT *
FROM usuarios
WHERE id = 1
--COMANDO PARA SELECIONAR UM DETERMINADO USUARIO COM A CONDIÇÃO LIKE
SELECT *
FROM usuarios
WHERE nome LIKE 'e%'

--comando para atualizar um dado da tabela 
UPDATE usuarios
SET id = 2
WHERE email = 'teste1@gmail.com' 

--COMANDO PARA ALTERAR UM DADO OU TIPO 
ALTER TABLE usuarios
ALTER COLUMN endereco VARCHAR(120)

--COMANDO PARA ALTERAR O TIPO DE DADO NA SELEÇÃO TIPO DE CHAVE PRIMARIA
ALTER TABLE usuarios
--ALTER COLUMN id INT identity(1,1),
ADD constraint pk PRIMARY KEY (id);

--COMANDO QUE INCLUI UM CHAVE ESTRANGEIRA A TABELA
ALTER TABLE reservas
ADD CONSTRAINT fk_reservas_usuarios
FOREIGN KEY(id_usuario) REFERENCES usuarios;


ALTER TABLE reservas
ADD CONSTRAINT fk_reservas_destinos
FOREIGN KEY(id_destino) REFERENCES destinos;

