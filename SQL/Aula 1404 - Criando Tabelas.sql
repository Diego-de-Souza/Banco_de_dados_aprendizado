--Criar um banco de Uber
create database uber


--utilizar o banco
use uber

--criar as tabelas
create table Veiculo
(
	placa	varchar(8) primary key, --definindo a PK
	modelo	varchar(40) not null, --não aceita nulo
	ano		int null,
	preco	decimal(10,2), -- 8 inteiros com 2 decimais
	dataCompra	smalldatetime
)

create table Motorista 
(
	CNH		int not null, --será nossa PK, por isso not null
	nome	varchar(80),
	primary key (CNH) --definie a PK 
)

create table Permissao
(
	placa	varchar(8) not null,
	CNH		int not null,
	primary key (placa, CNH) --cria PK composta
)
go
--adicionando chaves estrangeiras
alter table Permissao
	add 
	constraint FK_Permissao_Veiculo 
		foreign key (placa) references Veiculo,
	constraint FK_Permissao_Motorista
		foreign key (CNH) references Motorista

--criando tabela com PK e FK
create table Permissao
(
	placa	varchar(8) not null
		foreign key references Veiculo,
	CNH		int not null
		foreign key references Motorista,
	primary key (placa, CNH) --cria PK composta
)

drop table permissao

