declare @total decimal(10,2)

--atribuir dados para variavel
set @total = 1324.99
--atribuir um subselect para uma variavel
set @total = (select sum(func_salario) from funcionarios)

--exibir dados
print 'Total do sal�rio dos funcion�rios: '+cast(@total as varchar(15))

if @total < 3000
	print 'Seus Funcion�rios est�o economicos'
else begin
	print '---------------------------------------------'
	print 'Voc� tem muito gasto com seus funcionarios'
	print '---------------------------------------------'
end

if exists (select func_nome from funcionarios
			where func_nome = 'maria')
		print 'A funcionaria Maria foi encontrada'
else
	print 'A funcionaria Maria n�o Existe'