--Usando subconsultas

/*
Listar o numero do produto, sua descrição e o nome
da sua categoria
*/
--com join, buscando 1 campo de categoria
select p.ProductID, p.ProductName, c.CategoryName
from Products p
inner join Categories c
	on p.CategoryID=c.CategoryID

--com subselect, buscando 1 campo de categoria
select p.ProductID, p.ProductName,
	(select c.CategoryName from Categories c
	where p.CategoryID = c.CategoryID) NomeCategoria
from Products p

----------------------------------------------------
--com join, buscando 2 campo de categoria
select p.ProductID, p.ProductName, c.CategoryName, c.Description
from Products p
inner join Categories c
	on p.CategoryID=c.CategoryID

--com subselect, buscando 1 campo de categoria
select p.ProductID, p.ProductName,
	(select c.CategoryName from Categories c
	where p.CategoryID = c.CategoryID) NomeCategoria,
	(select c.Description from Categories c
	where p.CategoryID = c.CategoryID) Descricao
from Products p

------------------------------------------------------
--com join
select c.CategoryName, COUNT(p.ProductID) qtd
from Categories c
left join Products p
	on c.CategoryID = p.CategoryID
group by c.CategoryName

--com select
select c.CategoryName,
	(select COUNT(*)
	from Products p 
	where p.CategoryID = c.CategoryID) qtd
from Categories c

---------------------------------------------------------------------------
--usando subselect para restrição
--Listar todas as categorias que possuem mais de 10 produtos

--com join
select c.CategoryName, COUNT(p.ProductID) qtd
from Categories c
left join Products p
	on c.CategoryID = p.CategoryID
group by c.CategoryName
having count(p.ProductID)>10

--com subselect
select c.CategoryName,
	(select COUNT(*) from Products p
	where p.CategoryID = c.CategoryID) qtd
from Categories c
where (select COUNT(*) from Products p
		where p.CategoryID = c.CategoryID)>10
