
-- a clausula 'where' serve para fazer restrições -- 
select func_salario
from funcionarios
where func_salario >= 5000

--==================================================================================================
-- operador like faz comparação de uma parte literal--
-- procurando todos os nomes que começam com a letra 'a' --
Select func_nome
From funcionarios
where func_nome like 'a%'

--procurando todos os nomes que terminam com a letra 'o' --
select func_nome
from funcionarios
where func_nome like '%o'

--procurando todos os nomes que tenham a letra 'e' dentro do nome --
select func_nome
from funcionarios
where func_nome like '%e%'

-- todos os nome que tenham as letras'el' juntas --
select func_nome
from funcionarios
where func_nome like '%el%'

--todos que tem a 2° letra 'a'
select * from funcionarios
where func_nome like '_a%'

--todos que o penultimo caracter é 'i'
select * from funcionarios
where func_nome like '%i_'

--=======================================================================================================
-- o operador TOP indica o primeiro conjunto ou porcentagem de linhas especificado --

--mostrar os 5 primeiros funcionários
select top 5 * from funcionarios

--junto a ultilização do operador 'order by'
-- seleciona os 5 primeiros salario em ordem ascendente
select top 5 *
from funcionarios
order by func_salario asc

-- seleciona o 7 primeiors salario em ordem descedente
select top 7 *
from funcionarios
order by func_salario desc

--mostrar os 5 funcionarios mais novos que entraram depois de 1980
select top 7 *
from funcionarios
where year(func_dataNasc) > 1980
order by func_dataNasc

--=====================================================================================================
-- o operador between determina uma faixa de valores
-- de 200 a 5000 --
select func_salario
from funcionarios
where func_salario between 200 and 5000

-- valor menor que 500 e maior que 2000 --
select func_salario
from funcionarios
where func_salario not between 500 and 2000

--=====================================================================================================
-- o operador IN determina os valores fixos em uma pesquisa
select func_id
from funcionarios
where func_id in (1,2,5,6,9,12)

-- ===================================================================================================
-- o distinct lista distintamente todos os setores que possuem funcionários
select distinct func_nome
from funcionarios

-- ==================================================================================================
-- a clausula order by ordena uma busca sempre do primeiro para os seguintes
select setor_id, func_nome
from funcionarios
order by setor_id, func_nome		

--====================================================================================================
-- o operador count retorna a quantidade de registros da pesquisa
select count (setor_id)
from funcionarios

-- retorna a quantidade de registro distinto
select count (distinct setor_id)
from funcionarios

--====================================================================================================
-- o operador sum efetua a somatória dos registros da pesquisa
select sum (func_salario) as "Soma de Salários"
from funcionarios 

--====================================================================================================
-- o operador avg retorna a média dos valores do campo
select avg (func_salario) as "media salarial"
from funcionarios

-- retorna a media salarial dividido pela quantidade de registros
select avg (func_salario) / count(*) as "media salarial"
from funcionarios

--=====================================================================================================
-- o operador min retorna o menor valor da pesquisa
select min(func_id)
from funcionarios

-- o operador max retorna o maior valor da pesquisa
select max(func_id)
from funcionarios

-- retorna o menor valor e o maior valor da pesquisa em duas colunas
select min(func_salario) as "Menor salario",
		max(func_salario) as "Maior salario"
from funcionarios

--==================================================================================================
-- a clausula alias dá um apelido para o campo, mas não altera o registro original
select func_id as matricula, func_nome nome
from funcionarios