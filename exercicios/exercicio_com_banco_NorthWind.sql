--procura dos exercicios

select * from Products

/*
Tabela: Products
1) Liste o nome produto com unidades em estoque entre 20 e 50
2) Liste o nome do produto, coloque apelido para ele "Produto" e
	seu numero de categoria, coloque um apelido também "categoria
3) Liste o numero do Produtoe seu nome dos produtos com categoria 2, 6 ou 8
4) Liste o nome do produto onde o preço não está entre 30 e 90


abrir o banco NorthWind
*/
--1)
select p.ProductName
from Products p
where p.UnitsInStock between 20 and 50

--2)
select p.ProductName Produto, p.CategoryID as Categoria from Products p

--3)
select p.ProductID, p.ProductName
from Products p
where p.CategoryID in (2,6,8)

--4)
select p.ProductName, p.UnitPrice
from Products p
where p.UnitPrice not between 30 and 90

