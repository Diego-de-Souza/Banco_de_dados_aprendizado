create database Comercio
use comercio
create table produto (
	codProduto int primary key,
	descricao varchar(100)
)
go

create table notaFiscal (
	nrNota int primary key,
	dataEmissao smalldatetime,
	destinatario varchar(100)
)
go

create table itensNotaFiscal (
	nrNota int not null,
	codProduto int not null,
	quantidade int,
	valor decimal(10,2),
	primary key (nrNota, codProduto)
)
go
alter table itensNotaFiscal 
add constraint fk_nota foreign key (nrNota) references NotaFiscal,
    constraint fk_Produto foreign key (codProduto) references Produto
go