/*
Usando ao banco de dados de locadora faça:
1) Crie uma view chamada vw_nuncaLocados, que exiba
o nome, codigo dos filmes e genero que nunca foram alugados

2) Crie uma view chamada vw_ClienteSemLocacao, que exiba
o nome e codigo dos clientes que nunca fizeram uma locação

3) Crie uma view chamada vw_Top5, que exiba
o nome e codigo dos 5 filmes mais alugados

4) Crie uma view chamada vw_LocacaoTOP, que exiba o 
nome dos clientes de maneira distinta que fizeram locações
de algum dos filmes Top5 (use a view do ex_3)

5) Crie uma view chamada vw_genero, que exiba o 
codigo e descrição do genero de todos os filmes que nunca
foram locados (use view do ex_1)

6) Cria uma view chamada vw_ClienteTOP, que exiba
os 5 nomes de clientes com codigo, que fizeram o maior
numero de locações
*/

--1)
create or alter view vw_nuncaLocados as
	select m.DescMidia, il.CodMidia, g.Codgenero
	from Midias m
	left join ItensLocacao il on m.CodMidia = il.CodMidia
	left join Genero g on g.Codgenero = m.codGenero
	left join Locacao l on l.CodLocacao = il.CodLocacao
	where il.CodLocacao is null

--correção do professor
select m.DescMidia, m.CodMidia, g.descricao
from Midias m
left join ItensLocacao itl
on m.CodMidia = itl.CodMidia
left join Genero g on g.Codgenero = m.codGenero
where itl.CodLocacao is null

select * from vw_nuncaLocados

--2)
create or alter view vw_ClienteSemLocacao as
	select c.Cliente, c.CodCli
	from Cliente c
	left join Locacao l on l.CodCli = c.CodCli
	where l.CodLocacao is null

select * from vw_ClienteSemLocacao

--correção do professor
select c.Cliente, c.CodCli
from Cliente c
left join Locacao l on l.CodCli = c.CodCli
where l.CodLocacao is null

--3)correção do professor
create or alter view vw_top5 as
	select top 5 m.DescMidia, m.CodMidia, COUNT(*)qtd
	from Midias m
	inner join ItensLocacao itl on m.CodMidia = itl.CodMidia
	group by m.DescMidia, m.CodMidia
	order by qtd desc
	
select * from vw_top5

--4)
create or alter view vw_locacaoTop as
	select Distinct c.Cliente
	from  Cliente c
	inner join Locacao l on l.CodCli = c.CodCli
	inner join ItensLocacao itl on itl.CodLocacao = l.CodLocacao
	inner join vw_top5 vw on vw.CodMidia = itl.CodMidia

select * from vw_locacaoTop

--5)
create or alter view vw_genero as
	select distinct g.* 
	from vw_nuncaLocados vw
	inner join Genero g on g.Codgenero = vw.Codgenero

select * from vw_genero

--6)
create or alter view vw_CLienteTop as
	select top 5 c.Cliente, c.CodCli
	from Cliente c
	inner join Locacao l on l.CodCli = c.CodCli
	group by c.Cliente, c.CodCli
	order by COUNT(*) desc

select * from vw_CLienteTop