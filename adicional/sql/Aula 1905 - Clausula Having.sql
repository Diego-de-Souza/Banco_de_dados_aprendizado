--uso da clausula Having
select f.setor_id, count(f.func_id) qtd
from funcionarios f
inner join setores s on s.setor_id = f.setor_id
where f.gerente_id = 1
group by f.setor_id

--descobrir quais setores possume mais que 4 funcionarios
select f.setor_id, count(f.func_id) qtd
from funcionarios f
inner join setores s on s.setor_id = f.setor_id
group by f.setor_id
having count(f.func_id) > 4

--descobrir quais setores possume mais que 4 funcionarios e
--que a soma dos salarios deles é maior que 3000
select f.setor_id, count(f.func_id) qtd
from funcionarios f
inner join setores s on s.setor_id = f.setor_id
group by f.setor_id
having count(f.func_id) > 4 and
	   sum(f.func_salario) > 3000