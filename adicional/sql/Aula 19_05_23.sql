--Aula de 19_05_2023

--selecionando Bando de dados
use funcionarios

--uso da Clausula Having
select f.setor_id,count(f.func_id) qtd
from funcionarios f
	inner join setores s
	on s.setor_id=f.setor_id
		where f.gerente_id=1
		group by f.setor_id
/*
setor_id    qtd
----------- -----------
1           2
2           4
*/

--DUPLICANDO informações, para demonstrar Having
select f.setor_id,count(f.func_id) qtd
from funcionarios f
	inner join setores s
	on s.setor_id=f.setor_id
		group by f.setor_id
/*
Demonstrando sem o Having, e sem o Where
setor_id    qtd
----------- -----------
1           5
2           5
3           4
*/

--Descobrir quais setores possuem mais que 4 funcionarios
select f.setor_id,count(f.func_id) qtd
from funcionarios f
	inner join setores s
	on s.setor_id=f.setor_id
		group by f.setor_id
		having count(f.func_id)>4
/*
setor_id    qtd
----------- -----------
1           5
2           5
*/

--Se eu fosse colocar sem o Count como um campo
select f.setor_id
from funcionarios f
	inner join setores s
	on s.setor_id=f.setor_id
		group by f.setor_id
		having count(f.func_id)>4
/*
setor_id
-----------
1
2
Aparece a informação dos campos que tem mais que 
4 funcionarios, mas não a quantidade*/

/*Descobir quais setores possuem mais que 4 funcionarios
e que a somados salários deles é maior que 3000*/
select f.setor_id,count(f.func_id) qtd,sum(f.func_salario) soma
from funcionarios f
	inner join setores s
	on s.setor_id=f.setor_id
		group by f.setor_id
		having count(f.func_id)>4 
			and sum(f.func_salario)>3000
/*
setor_id    qtd         soma
----------- ----------- ----------
1           5           18480.00
*/
