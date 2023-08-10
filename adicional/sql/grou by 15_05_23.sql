use funcionarios

--group by

--Utilizando o group by, para poder mostrar o menor salário de cada setor
select min(func_salario) menor, setor_id
from funcionarios
group by setor_id

--O mesmo de cima, mas ordenando pelo min(func_salario)
select min(func_salario) menor, setor_id
from funcionarios
group by setor_id
order by menor
--sendo ordenado pelo menor order by

--podemos mostrar também com o nome do setor, fazendo um join
select min(func_salario) menor, 
		s.setor_nome
from funcionarios f
inner join setores s on f.setor_id=s.setor_id
group by s.setor_nome
order by menor


--quantos funcionarios tem em cada setor

select s.setor_nome,count(func_id) as quant
from funcionarios f
inner join setores s on f.setor_id=s.setor_id
group by s.setor_nome


--fazendo o mesmo, mas com right join
select s.setor_nome,count(func_id) as quant
from funcionarios f
right join setores s on f.setor_id=s.setor_id
group by s.setor_nome



------------------------------------------------------------------------------------------------------------------------------------------------------
/*exiba a somatoria dos salarios dos funcionarios,
exibindo esse valor por ano de nascimento*/

select sum(func_salario) somatoria, year(f.func_dataNasc) data_nasc
from funcionarios f
group by year(f.func_dataNasc)
order by somatoria asc
/*
RESULTADO

somatoria      data_nasc
------------- -----------
NULL			NULL
300.00          1991
350.00          1989
422.00          1982
700.00          1949
800.63          1957
890.00          1963
1000.00         1985
1301.00         1981
1521.00         1977
3550.00         1984
4780.00         1971
12000.00        1974
*/

------------------------------------------------------------------



--listar todos os setores que não possuem funcionários
select s.*
	from setores s
	left join funcionarios f
		on s.setor_id = f.setor_id
			where f.func_id is null
/*
setor_id    setor_nome
----------- --------------------
4           Compras
5           Estoque
6           Farmácia
7           Recepção
8           Desenvolvimento
9           Engenharia
10          CAD
11          11
*/

--fazendo da forma...
select s.*,f.func_id
	from funcionarios f
	right join setores s
		on s.setor_id = f.setor_id
			where f.func_id is null
--..., é igual, usamos Right ao inves do Left,
--Porém mudamos as ordens das tabelas
/*
setor_id    setor_nome
----------- --------------------
4           Compras
5           Estoque
6           Farmácia
7           Recepção
8           Desenvolvimento
9           Engenharia
10          CAD
11          11
*/
-------------------------------------




SET dateformat dmy
select * from funcionarios
select * from setores