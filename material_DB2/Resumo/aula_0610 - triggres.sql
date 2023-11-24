--exemplo de triggers
create database Mercado
go

use mercado
go

create table Produto (
    codProduto int primary key,
    descricao  varchar(60),
    preco      decimal(10,2),
    qtdEstoque int
)
go

create table Movimentacao (
    lancamento int identity(1,1) primary key,
	codProduto int foreign key references Produto,
    tipo       varchar(1), --[E]ntrada [S]aida
    qtd        int
)
go

--------------------------------------------------------------------

INSERT INTO Produto (codProduto, descricao, preco, qtdEstoque)
VALUES  (1, 'Macarrão', 4.87, 60),
		(2, 'Azeitona preta', 27.88, 20),
		(3, 'Sal', 1.88, 10),
		(4, 'Tomate seco', 29.00, 15)

--fOI VENDIDO 5 PACOTES DE MACARRÃO, O QUE LANÇAR NO db??
INSERT INTO Movimentacao(codProduto, tipo, qtd)
	VALUES (1,'S', 5)
--ATUALIZAR O ESTOQUE
UPDATE Produto SET qtdEstoque -= 5
	WHERE codProduto = 1

--------------------------------------------------------------------
--criando trigger
/*
	FOR: EXECUTA O COMANDO QUE DISPAROU A TRIGGERS
		E DEPOIS É EXECUTADO A TRIGGER
	INSTEAD OF: EXECUTA A TRIGGER SOMENTE, FICANDO A 
		CARGO DO PRGRAMADOR REALIZAR O COMANDO CHAMADOR DA TRIGGERS
*/

create or alter trigger trg_inclui_movimento on Movimentacao
for insert as 
begin
    --descobrir os dados da tabela Movimentacao
    --que estão sendo inseridos
    declare @codProduto int
    declare @tipo       varchar(1)
    declare @qtd        int
    
    select @codProduto = codProduto,
           @tipo       = tipo,
           @qtd        = qtd
    from inserted
    
    --efetuar as atualizações na tabela de Produto
    --É entrada ou é saída??
    if @tipo = 'S' or @tipo = 's' begin
        --verificando qtd em estoque
        declare @quantidade int
        
        select @quantidade = qtdEstoque 
        from Produto
        where codProduto = @codProduto

        if @quantidade < @qtd begin
            print 'Quantidade em estoque insuficiente...'
            rollback tran
            return --encerra a triggers
        end

        --diminui o estoque
        update produto set qtdEstoque -= @qtd
            where codProduto = @codProduto
    end
    else 
        if @tipo = 'E' or @tipo = 'e'
            --aumenta o estoque
            update produto set qtdEstoque += @qtd
                where codProduto = @codProduto
        else begin
            print 'Tipo de movimento inválido, use [E] para entrada ou [S] para saida'
            rollback tran --aborta a transação
        end
end


-- 2 vidros de azeitona foram vendidos,o que fazer??
--fazendo a movimentação somente com o comando insert
insert into Movimentacao (codProduto, tipo, qtd)
	values (2,'S',2)

insert into Movimentacao (codProduto, tipo, qtd)
	values (3,'E',6)

	--movimento que não tem quantidade em estoque
insert into Movimentacao (codProduto, tipo, qtd)
	values (3,'S',600)

select * from Produto
select * from Movimentacao