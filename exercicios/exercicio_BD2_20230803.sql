/*
Exercico de Revisão

1) Liste o numero da ordem, sua data de criação e o nome do cliente

2) Liste o nome de todos os empregados que moram no territorio de "Providence"

3) Quantos empregados residem em cada cidade

4)Exiba o nome do cliente (costumer) e a quantidade de pedidos
(orders) que cada um póssui. Faça isso ordenado
pela quantidade decrescente

5) Liste o nome de todos os produtos que nunca foram vendidos
*/

--1)
select o.OrderID, o.OrderDate, c.ContactName
from Orders o
inner join Customers c on (c.CustomerID = o.CustomerID)

--2)
select em.FirstName, em.LastName, te.TerritoryDescription
from Employees em
inner join EmployeeTerritories et on (et.EmployeeID = em.EmployeeID)
inner join Territories te on (te.TerritoryID = et.TerritoryID)
where TerritoryDescription = 'Providence'

--3)
select COUNT(*) Qtd, City
from Employees
group by City

--4)
select Cu.ContactName, COUNT(o.OrderID)Qtd
from Customers Cu
left join Orders o on (o.CustomerID = Cu.CustomerID)
group by Cu.ContactName
order by Qtd desc

--5)
select p.ProductName
from Products p
left join [Order Details] od 
	on (od.ProductID = p.ProductID)
where od.OrderID is null 
