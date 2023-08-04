/*
Exercico de Revisão

1) Liste o numero da ordem, sua data de criação e o nome do cliente

2) Liste o nome de todos os empregados que moram no territorio de "Providence"
*/

select o.OrderID, o.OrderDate, c.ContactName
from Orders o
inner join Customers c on (c.CustomerID = o.CustomerID)


select em.FirstName, em.LastName, te.TerritoryDescription
from Employees em
inner join EmployeeTerritories et on (et.EmployeeID = em.EmployeeID)
inner join Territories te on (te.TerritoryID = et.TerritoryID)
where TerritoryDescription = 'Providence'
