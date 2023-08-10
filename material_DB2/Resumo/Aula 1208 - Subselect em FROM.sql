--usando subselect na clausula FROM
-- neste caso o subselect pode trazer mais que um registro
-- e mais que um campo

--exemplo simples
--irá trazer somente os campos nome e id de TODOS os funcionarios
select *
from (select f.func_nome, f.func_id
	  from funcionarios f) as tabTeste

--selecionando registros com salario > 10000
select *
from (select f.func_nome, f.func_id, f.setor_id
      from funcionarios f
	  where f.func_salario > 10000) tabFunc
inner join setores s on s.setor_id = tabFunc.setor_id

--sem subselect
select *
from funcionarios f
inner join setores s on s.setor_id = f.setor_id
where f.func_salario > 10000
