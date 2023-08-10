--Uso de Stored Procedures

--criar uma view
create view vw_testeDado as
	select * from funcionarios
	where func_salario > 1500

--chamada
select * from vw_testeDado

--fazendo um SP simples
create procedure sp_testeDado as
begin
	select * from funcionarios
	where func_salario > 1500
end

--chamada
exec sp_testeDado

----------------------------------------------------------
--Stored procedure com parâmetros

create procedure sp_funcSalario (@limite decimal(10,2)) as
begin
	select * from funcionarios
	where func_salario > @limite
end

--chamada
--lista com salarios maiores que 1000
exec sp_funcSalario 1000
--lista com salarios maiores que 500
exec sp_funcSalario 500

-------------------------------------------------
--SP com vários parametros
alter procedure sp_funcSalario2 (@inicio decimal(10,2),
								  @final  decimal(10,2)) as
begin
	if (@final < @inicio) 
		print 'Parametros incorretos!!!!'
		--select 'Parametros incorretos!!!!'
	else
		select * from funcionarios
		where func_salario between @inicio and @final
end

--chamada
--lista com salarios maiores que 1000
exec sp_funcSalario2 1000, 1500
exec sp_funcSalario2 2000, 1500

----------------------------------------------------------
--Stored procedure retornando penas um resultado

--sem parametro output, a SP só pode devolver UM único valor
--e do tipo inteiro
create procedure sp_existeSetor (@setor_id int) as
begin
	if(exists (select setor_nome from setores
			  where setor_id = @setor_id))
		return 1 --indica que o setor existe
	else
		return 0 --indica que o setor não existe
end

--chamada 
exec sp_existeSetor 10 --não capturou o retorno

--vai capturar..
declare @ret int
exec @ret = sp_existeSetor 102
if @ret = 1
	print 'Setor Existente...'
else
	print 'Setor Inexistente...'

--------------------------------------------------------
--SP retornando mais que um resultado, ou retornando um 
--resulta diferente do tipo INT

--com output
--Procedure que recebe o código do funcionario e devolve
--o nome do setor onde trabalha e a somatória de todos os
--salarios dos funcionarios que trabalham neste setor
create procedure sp_setorSalario 
			(@func_id int, 
			 @setor_nome varchar(50) output,
			 @totalSalario decimal(10,2) output) as
begin 
	--descobre o setor que o funcionario trabalha
	declare @setor_id int = (select setor_id from funcionarios
							 where func_id = @func_id)
	--buscar o nome do setor
	set @setor_nome = (select setor_nome from setores
					  where setor_id = @setor_id)
	--somar os salarios deste setor
	set @totalSalario = (select sum(func_salario) from funcionarios
						 where setor_id = @setor_id)
	
	--termina a SP (pode ou nao usar o return)
	return
end

--chamada
declare @A varchar(50)
declare @totalSalario decimal(10,2)
--chama a SP
exec sp_setorSalario 81, @A output, @totalSalario out
--saida dos dados
print 'Nome Setor: ' + isnull(@A, 'Não encontrado')
print 'Total Salário: ' + 
	  isnull(cast(@totalSalario as varchar(15)), '')
