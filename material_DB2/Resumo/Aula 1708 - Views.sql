--Uso de views simples

--criando a view, selecionando colunas
create view vw_ListaFunc as
	select func_id, func_nome, setor_id
	from funcionarios

--chamando a view
select * from vw_ListaFunc
order by func_nome

--ligando uma VIEW com outra tabela
select vw.*, s.setor_nome from vw_ListaFunc vw
inner join setores s on s.setor_id = vw.setor_id

--criando uma view, selecionando linhas
create view vw_ListaFunc_2 as
	select * from funcionarios
	where func_salario > 1500

--Criar uma view que exiba tudo dos funcionarios
-- e tudos dos setores

create view vw_teste as
	select *	--vai dar erro pois aparece 2x o campo setor_id
	from funcionarios f
	inner join setores s on f.setor_id = s.setor_id

create view vw_teste as
	select f.*, s.setor_nome	--agora funciona
	from funcionarios f
	inner join setores s on f.setor_id = s.setor_id

--Criando uma view baseada em outra view
create view vw_ListaFuncSetor as
	select vw.*, s.setor_nome
	from vw_ListaFunc_2 vw
	inner join setores s on s.setor_id = vw.setor_id
	where s.setor_nome like '%o'

--apagar uma view
drop view vw_ListaFuncSetor

--alterar uma view
alter view vw_ListaFuncSetor as
	--novo select

sp_helptext vw_ListaFuncSetor	