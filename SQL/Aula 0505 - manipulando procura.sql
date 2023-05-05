--Uso do Like
--todos os funcionários que começam com a letra 'B'

select * from funcionarios
where func_nome like 'b%'

--todos os funcionários que o nome termina com 'o'
select * from funcionarios
where func_nome like '%o'

--todos os funcionários que o nome que não termina com 'o'
select * from funcionarios
where func_nome not like '%o'

--todos os funcionarios que o nome possui 'ir' em qualquer lugar
select *  from funcionarios
where func_nome like '%ir%'

--todos que tem a 2° letra 'a'
select * from funcionarios
where func_nome like '_a%'

--todos que o penultimo caracter é 'i'
select * from funcionarios
where func_nome like '%i_'

--=====================================================================

--uso do Distinct
--listar distintamente todos os setores que possuem funcionários
select distinct setor_id
from funcionarios

--====================================================================
--uso do TOP
--mostrar os 5 primeiros funcionários
select top 5 * from funcionarios

--mostrar os 3 funcionarios mais novos
select top 3 *
from funcionarios
order by func_dataNasc desc

--mostrar os 7 funcionarios que ganham mais
select top 7 *
from funcionarios
order by func_salario desc

--mostrar os 5 funcionarios mais novos que entraram depois de 1980
select top 7 *
from funcionarios
where year(func_dataNasc) > 1980
order by func_dataNasc