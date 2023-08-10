--Criar um banco de uber
create database UBER

--utilizar o banco
use uber

--criar as tabelas, abre e fecha parenteses para colocar os campos
--coloca virgula ap�s os campos, se for colocar mais algum campo depois

--primeira tabela
create table Veiculo
(
	placa	varchar (8) primary key, --definindo a PK(Chave prim�ria)
	modelo	varchar(40) not null, --n�o aceita nulo
	ano		int,
	preco	decimal(10,2), --8 inteiros com 2 decimais
	dataCompra	smalldatetime
)

--segunda tabela
create table Motorista
(
	CNH		int not null, --ser� nosso PK, por isso not null
	nome	varchar(80),
	primary key (CNH) --define a PK, se for chave composta, � s� colocar virgula e a outra chave
)

--terceira tabela
create table Permissao
(
	placa	varchar(8) not null,
	CNH		int not null,
	primary key (placa, CNH) --cria chave primaria composta

)
--fim das tabelas

--adicionando chave estrangeiras
alter table Permissao --alterando a tabela
	add --adicionando
	constraint FK_Permissao_Veiculo --resti��o e o nome da retri��o
		foreign key (placa) references Veiculo, --o tipo de restricao, nesse caso estamos criando uma chave
												--estrangeira, nomeamos a chave, e em qual tabela vai se conectar
	constraint FK_Permissao_Motorista
		foreign key (CNH) references Motorista


/*criando tabela com chaves primarias e estrangeiras
create table Permissao
(
	placa	varchar(8) not null
		foreign key references Veiculo,
	CNH		int not null
		foreign key references Motorista,
	primary key (placa, CNH) --cria chave primaria composta
)
*/

