/*
Exercico de Revisão

1) Liste o numero da ordem, sua data de criação e o nome do cliente

2) Liste o nome de todos os empregados que moram no territorio de "Providence"
*/

select o.OrderID, o.OrderDate, c.ContactName
from Orders o
inner join Customers c on (c.CustomerID = o.CustomerID)


select t.TerritoryDescription as providence
from Territories t
inner join EmployeeTerritories e on(e.TerritoryID = t.TerritoryID)
inner join Employees em on (em.EmployeeID = e.EmployeeID)