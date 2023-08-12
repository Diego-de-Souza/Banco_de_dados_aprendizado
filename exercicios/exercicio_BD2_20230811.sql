--Exercícios

--Rescreva o comando sem o utilização do JOIN
--1)
select e.FirstName empregado, e1.FirstName supervisor
from Employees e
left join Employees e1 on e1.EmployeeID = e.ReportsTo

select e.FirstName empregado ,
	(select e1.FirstName supervisor from Employees e1
	where e1.EmployeeID = e.ReportsTo) 
from Employees e
	

--2)
select p.ProductName, od.OrderID, od.Quantity
from Products p
inner join [Order Details] od on p.ProductID = od.ProductID

select p.ProductName,
	(select od.OrderID from [Order Details] od
	where od.ProductID = p.ProductID)

from Products p


--3)
select s.ContactName, count(p.ProductID) qtd
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID
group by s.ContactName

--4)
select s.ContactName, count(p.ProductID) qtd
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID
group by s.ContactName
having count(p.ProductID) > 2

--escreva os comandos para trazer os seguintes dados, escreva
--utilizando join e utilizando subselect

--5) traga o nome do territorio (territory) e o nome da região (region)

--6) exiba o nome de todos os funcionarios que a descrição do terrirorio
--desse funcionario começa com a letra 'w'