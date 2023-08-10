--usando subconsulta para trazer um unico campo

--listar o nome do func., o salario dele e o maior
--salario do seu setor

--não eficiente
select top 1 func_salario
from funcionarios 
where setor_id = 3
order by func_salario desc

--eficiente
select max(func_salario)
from funcionarios 
where setor_id = 3

select func_nome, func_salario, 
	(select max(func_salario)
	 from funcionarios 
	 where setor_id = f.setor_id) maior
from funcionarios f
----------------------------------------------------------
-- listar o nome do setor e a quantidade de funcionarios
--que trabalham para esse setor

--com join e group by
select s.setor_nome, count(f.func_id) qtd
from setores s
left join funcionarios f on s.setor_id = f.setor_id
group by s.setor_nome

--com subselect
select s.setor_nome, (select count(f.func_id)
					  from funcionarios f
					  where s.setor_id = f.setor_id) qtd
from setores s
--------------------------------------------------------
--listar o nome do funcionario e o nome do setor

--com join
select f.func_nome, s.setor_nome
from funcionarios f
left join setores s on s.setor_id = f.setor_id

--com subselect
select f.func_nome, (select s.setor_nome 
					 from setores s
					 where s.setor_id = f.setor_id) setNome
from funcionarios f
----------------------------------------------------------------
--listar todos os funcionarios que ganham abaixo da média
--salarial da empresa

select *
from funcionarios f
where f.func_salario < (select avg(func_salario)
					   from funcionarios)

--não funciona
select *
from funcionarios f
where f.func_salario < avg(func_salario)
--------------------------------------------------------
--listar todos os funcionarios que não trabalham em 
--setores que começam com a letra 'C'

select *
from funcionarios f
where f.setor_id not in (select setor_id 
						 from setores s
						 where s.setor_nome like 'C%')

