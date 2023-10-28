--
create or alter trigger trg_funcionario_alt on funcionarios
for update as
begin
	--mostra os dados antigos
	select * from deleted

	--mostra os dados novos
	select * from inserted
end

--chamada
update funcionarios set func_nome = 'Cristo',
						func_salario = '5690',
						setor_id = 5
where func_id = 4
select * from funcionarios

--------------------------------------------------------------------------------------
----Não permite que o salário do funcionário seja aumentado
--em mais de que 10%
create or alter trigger trg_funcionario_alt on funcionarios
for update as
begin
	declare @sal_Antigo decimal(10,2)
	declare @sal_Novo decimal(10,2)

	--buscar os dados
	set @sal_Antigo = (select func_salario from deleted)
	set @sal_Novo = (select func_salario from inserted)

	--comparar os dois salarios
	if(@sal_Antigo *1.1) < @sal_Novo
	begin
		raiserror('Não é permitido aumento de mais de 10 porcento',16,1)
		rollback transaction
	end
end

--chamada
update funcionarios set func_salario = 1000
	where func_id = 5 or func_id = 6