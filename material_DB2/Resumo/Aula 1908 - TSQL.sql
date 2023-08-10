--Exemplos de TSQL

--criando uma variável
declare @contador int = 0

--atribui um valor para variavel
set @contador = 1

--abre um laço de repetição
while (@contador <= 10) begin --uso do begin/end para identificar
							  --um bloco de comando
	--escreve na tela
	print 'Valor: ' + cast(@contador as varchar(4))

	--incremento
	set @contador += 1
end
------------------------------------------------------------
--usando programa para gerar registros

create table teste (
	codigo int primary key,
	descricao varchar(40)
)

--criando uma variável
declare @contador int = 0
declare @sql varchar(200) --para conter o comando insert

--atribui um valor para variavel
set @contador = 1
--abre um laço de repetição
while (@contador <= 10) begin --uso do begin/end para identificar
							  --um bloco de comando
	set @sql = 'INSERT INTO Teste values (' + 
			   cast(@contador as varchar(2)) + 
			   ', ' + char(39) + 'Texto qualquer' + char(39)
			   + ')'

	--executa o comando
	exec(@sql)
	--incremento
	set @contador += 1
end

select * from teste

---------------------------------------------------------
--listando os funcionarios que possuem o salario
-- menor que a média de todos os salarios

declare @media decimal(10,2)
--calcula a media salarial
set @media = (select avg(func_salario) 
			  from funcionarios)
--lista os funcionarios
select * 
from funcionarios
where func_salario < @media

------------------------------------------------------------
--Exemplo do CASE 'Simplecase'

select f.func_nome, case f.gerente_id
						when 1 then 'Este é o gerente 1'
						when 2 then 'Este é o gerente 2'
						when 3 then 'Este é o gerente 3'
						else 'Não possui gerente'
					end as tipoGerente
from funcionarios f

------------------------------------------------------------
--Exemplo do CASE 'Searchedcase'

declare @media decimal(10,2)
--calcula a media salarial
set @media = (select avg(func_salario) 
			  from funcionarios)
--lista os funcionarios
select *, case
			when func_salario < @media then 'Abaixo Média'
			when func_salario > @media then 'Acima Média'
			when func_salario = @media then 'Na Média'
			else 'Sem Salário'
		  end tipoSalario
from funcionarios

-----------------------------------------------------------

--mostra metadados da tabela
sp_help funcionarios
