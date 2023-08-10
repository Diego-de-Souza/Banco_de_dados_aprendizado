/*
Exercício subselect - Utilize para a solução o banco
de dados de locadora
Para cada exercício resolva-o com JOIN e depois com 
SubSelect

1) Liste todos os dados dos filmes e o nome do genero (join)
2) Liste o nome do cliente e a quantidade de locações
feitas por ele (join e group)
3) Resolva o exercicio anterior mostrando somente os 
clientes que possuem mais que 2 locações (join, group e having)
4)Liste para cada locação a data da locação, o nome do 
filme e o nome do cliente (join)
5)Faça a soma de todos os valores unitários de todos
os filmes locados para cada locação. Mostrando o numero 
da locação e sua somatoria só JOINs
*/


--1)
select m.*, g.descricao
from midias m
left join genero g on m.codGenero = g.Codgenero

select m.*, (select g.descricao from genero g 
		     where g.Codgenero = m.codGenero) descricao
from midias m

--fazendo com INNER
select m.*, g.descricao
from midias m
inner join genero g on m.codGenero = g.Codgenero

select m.*, (select g.descricao from genero g 
		     where g.Codgenero = m.codGenero) descricao
from midias m
where exists (select g.Codgenero from genero g 
			  where g.Codgenero = m.codGenero)

select m.*, (select g.descricao from genero g 
		     where g.Codgenero = m.codGenero) descricao
from midias m
where (select count(*) from genero g 
			  where g.Codgenero = m.codGenero) > 0

--2)
select c.Cliente, count(l.CodLocacao) qtd
from Cliente c
left join Locacao l on l.CodCli = c.CodCli
group by c.Cliente
order by c.cliente

select c.Cliente, (select count(*) from locacao l
				   where l.CodCli = c.CodCli) qtd
from Cliente c
order by c.cliente

--3)
select c.Cliente, count(l.CodLocacao) qtd
from Cliente c
inner join Locacao l on l.CodCli = c.CodCli
group by c.Cliente
having count(l.CodLocacao) > 2

select c.Cliente, (select count(*) from locacao l
				   where l.CodCli = c.CodCli) qtd
from Cliente c
where (select count(*) from locacao l
				   where l.CodCli = c.CodCli) > 2

--4)
select l.DataLoc, c.Cliente, m.DescMidia
from Locacao l
inner join ItensLocacao itl on itl.CodLocacao = l.CodLocacao
inner join midias m on m.CodMidia = itl.CodMidia
inner join cliente c on c.CodCli = l.CodCli

--isso não funciona
select l.DataLoc, (select c.cliente from cliente c
				   where c.CodCli = l.CodCli) cliente,
				  (select m.descMidia from Midias m
				  where m.CodMidia = (select itl.codMidia from ItensLocacao itl
									  where m.CodMidia = itl.CodMidia
									  and itl.CodLocacao = l.CodLocacao))
from Locacao l

--isso funciona
select   (select m.descMidia from Midias m
				  where m.CodMidia = itl.CodMidia) midia,
		 (select l.dataLoc from Locacao l
				 where l.CodLocacao = itl.codLocacao) data,
		 (select c.cliente from cliente c
				   where c.CodCli = (select l.codcli from locacao l
							         where l.CodLocacao = itl.CodLocacao)) cliente
from ItensLocacao itl

--5)
select l.CodLocacao, sum(m.ValorUnit) soma
from Locacao L
inner join ItensLocacao itl on l.CodLocacao = itl.CodLocacao
inner join Midias m on itl.CodMidia = m.CodMidia
group by l.CodLocacao




