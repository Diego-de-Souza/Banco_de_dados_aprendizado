--Para uma revisão (usando banco Funcionarios)
--1) Listar o nome do funcionario e o nome do setor onde trabalha
--todos os funcionarios
select f.func_nome, s.setor_nome
from funcionarios f
left join setores s on f.setor_id = s.setor_id

--só quem tem setor
select f.func_nome, s.setor_nome
from funcionarios f
inner join setores s on f.setor_id = s.setor_id

--2) Listar a quantidade de funcionarios para cada setor
select s.setor_nome, count(f.func_id) qtd
from funcionarios f
right join setores s on f.setor_id = s.setor_id
group by s.setor_nome

--3) Listar todos os setores com sua qtd de funcionarios alocados a ele
--   somente dos setores que possuem funcionarios
--com inner
select s.setor_nome, count(f.func_id) qtd
from funcionarios f
inner join setores s on f.setor_id = s.setor_id
group by s.setor_nome

--com having
select s.setor_nome, count(f.func_id) qtd
from funcionarios f
right join setores s on f.setor_id = s.setor_id
group by s.setor_nome
having count(f.func_id) > 0

--4) listar todos os funcionarios que trabalham no setor que possui a letra 
--'o'
select f.func_nome
from funcionarios f
inner join setores s on f.setor_id = s.setor_id
where s.setor_nome like '%o%'







