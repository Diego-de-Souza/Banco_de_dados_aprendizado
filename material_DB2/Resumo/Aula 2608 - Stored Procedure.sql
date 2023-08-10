--stored procedures que substituem os comandos 
--INSERT, DELETE E UPDATE

--inserindo na tabela de setores
alter procedure sp_insere_setor (@setor_id int, 
								  @setor_nome varchar(50)) as
begin
	insert into setores (setor_id, setor_nome) values
						(@setor_id, @setor_nome)
	
	--vamos verificar se ocorreu erros
	if @@ERROR > 0 begin
		print 'Ocorreu algum erro na grava��o'
		return -1 --pode retornar qualquer coisa
	end
	else
		return 0
end

--chamada
declare @ret int
exec @ret = sp_insere_setor 51, 'manuten��o'
print @ret

--------------------------------------------------------
--inserindo na tabela de setores 
--definindo automaticamente a PK
alter procedure sp_insere_setor_2 
			(@setor_nome varchar(50)) as
begin
	--descobre qual o pr�ximo numero do setor
	declare @setor_id int = (select isnull(max(setor_id), 0)
							from setores) + 1

	insert into setores (setor_id, setor_nome) values
						(@setor_id, @setor_nome)
	
	--vamos verificar se ocorreu erros
	if @@ERROR > 0 begin
		print 'Ocorreu algum erro na grava��o'
		return -1 --pode retornar qualquer coisa
	end
	else
		return @setor_id
end

--chamada
declare @ret int
exec @ret = sp_insere_setor_2 'manuten��o 2'
print @ret
------------------------------------------------------
--usando campos de autonumera��o

create table setores_2 (
	setor_id int primary key identity (1,1),
	setor_nome varchar(100)
)

--definindo automaticamente a PK com autonumera��o
create procedure sp_insere_setor_3 
			(@setor_nome varchar(50)) as
begin
	insert into setores_2 (setor_nome) values
						(@setor_nome)
	
	--vamos verificar se ocorreu erros
	if @@ERROR > 0 begin
		print 'Ocorreu algum erro na grava��o'
		return -1 --pode retornar qualquer coisa
	end
	else
		return @@identity --ultimo n�mero gerado
end

--chamada
declare @ret int
exec @ret = sp_insere_setor_3 'Compras2'
print @ret


--resetando a autonumera��o
DBCC CHECKIDENT('setores_2', RESEED, 10)

select * from setores_2

delete from setores_2