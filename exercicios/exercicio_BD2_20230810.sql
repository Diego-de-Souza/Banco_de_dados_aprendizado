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