--Continuação de Stored Procedures

/*
Itens:
1: Retorno de inteiro da SP
2: Geração de identificadores (PK) nas SP de inserção
*/
-----------------------------------------------------------------------------------------------------
--Exemplo Item 1
create procedure sp_insereSetor_3(
	@codigo int,
	@descricao varchar(50))
as
begin
	if not exists(select setor_id from setores
				where setor_id = @codigo)
	begin
		insert into setores (setor_id, setor_nome)
			values(@codigo, @descricao)
		return 1 --gravado com sucesso!
	end
	else
		return 0 --erro ao gravar! registro já existe
end

--chamada
declare @ret int
exec @ret = sp_insereSetor_3 11, 'Carpintaria'
if @ret = 1
print 'Setor gravado om sucesso'
else
print 'Ocorreu erro na gravação'


select * from setores

-----------------------------------------------------------------------------------------------------------------------

/*
modelo com procedure gerando um numero de registro com base no numero de registros já existentes
INSERINDO UM SETOR QUE ENUMERA AUTOMATICAMENTE
*/
--Exemplo Item 2
create procedure sp_insereSetorAutomatico(
	@descricao varchar(50))
as
begin
	--descobre o proximo codigo livre
	declare @proximo int = (select ISNULL(max(setor_id),0)
							from setores ) +1
	
		insert into setores (setor_id, setor_nome)
			values(@proximo, @descricao)

		if @@ERROR = 0
			return 1 --gravado com sucesso!
	else
		return 0 --erro ao gravar! 
end

--chamada
declare @ret1 int
exec @ret1 = sp_insereSetorAutomatico 'Peixaria'
if @ret1 = 1
print 'Setor gravado om sucesso'
else
print 'Ocorreu erro na gravação'

select * from setores


--exemplos de isnull
declare @num int = null
print isnull(@num, 0)+1
print @num + 1

select ISNULL(max(setor_id),0) + 1 from setores
		where setor_nome = ''

---------------------------------------------------------------------------------------------------------------

/*
modelo com procedure gerando um numero de registro com base no numero de registros já existentes
de forma automatica
*/
--Exemplo Item 3
create procedure sp_insereSetorAutomaticoComRetorno(
	@descricao varchar(50),
	@proximo int output)
as
begin
	--descobre o proximo codigo livre
	set @proximo = (select ISNULL(max(setor_id),0)
							from setores ) +1
	
		insert into setores (setor_id, setor_nome)
			values(@proximo, @descricao)

		if @@ERROR = 0
			return 1 --gravado com sucesso!
	else
		return 0 --erro ao gravar! 
end

--chamada
declare @ret1 int
declare @codigo int
exec @ret1 = sp_insereSetorAutomaticoComRetorno'Decapagem', @codigo out
if @ret1 = 1 begin
	print 'Setor gravado com sucesso'
	print concat('Codigo gerado : ',@codigo)
end
else
	print 'Ocorreu erro na gravação'

select * from setores

--------------------------------------------------------------------------------------------------------------------

--criando uma tabela com campo autonumerado
create table setores_auto (
	--numeração começa do 1 e incrementa de 1 em 1
	setor_id int identity(1,1) primary key,
	setor_name varchar(50)
)

insert into setores_auto values(1,'Compras') --erro - forma errada, vai gerar um erro, pois o auto incremento não permite inserir um codigo manual 

insert into setores_auto (setor_name)
		values('Compras') --ok, este vai funcionar normalmente

select * from setores_auto

-------------------------------------------------------------------------------------------------------------

--criando uma sp que insere dados na tabela com autonumeração
create or alter procedure sp_incluiAuto (
	@descricao varchar(50),
	@codigoGerado int out ) as
begin
	insert into setores_auto (setor_name)
				values (@descricao)
	--descobre quem foi inserido
	set @codigoGerado = @@IDENTITY
end

--chamada
declare @codigo int
exec sp_incluiAuto 'Carpintaria', @codigo out
print concat('codigo gerado: ',@codigo)

select * from setores_auto