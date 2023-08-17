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
order by ProductName

select od.OrderID, od.Quantity,
	(select p.ProductName from Products p
	where p.ProductID = od.ProductID)
from [Order Details] od

--correção com o professor
select od.OrderID, od.Quantity,
	(select p.ProductName 
	from Products p
	where p.ProductID = od.ProductID) ProductName
from [Order Details] od
order by ProductName

GO

--3)
select s.ContactName, count(p.ProductID) qtd
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID
group by s.ContactName

select s.ContactName ,
	(select count(p.ProductID) from Products p
	where s.SupplierID = p.SupplierID) qtd
from Suppliers s
order by s.ContactName



--4)
select s.ContactName, count(p.ProductID) qtd
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID
group by s.ContactName
having count(p.ProductID) > 2

select s.ContactName ,
	(select count(p.ProductID) from Products p
	where p.SupplierID = s.SupplierID) qtd 
from Suppliers s
	where (select count(*) from Products p
		where s.SupplierID = p.SupplierID) > 2
order by s.ContactName


--escreva os comandos para trazer os seguintes dados, escreva
--utilizando join e utilizando subselect

--5) traga o nome do territorio (territory) e o nome da região (region)
select t.TerritoryDescription, r.RegionDescription
from Territories t
inner join Region r on t.RegionID = r.RegionID

select t.TerritoryDescription,
		(select r.RegionDescription from Region r
		where t.RegionID = r.RegionID) RegionDescription
from Territories t

--6) exiba o nome de todos os funcionarios que a descrição do terrirorio
--desse funcionario começa com a letra 'w'
select e.FirstName
from EmployeeTerritories et
inner join Employees e on et.EmployeeID = e.EmployeeID
inner join Territories t on et.TerritoryID = t.TerritoryID
where t.TerritoryDescription like '%w%'

select (select e.FirstName from Employees e
       where e.EmployeeID = et.EmployeeID) nome
from EmployeeTerritories et
where (select t.TerritoryDescription from Territories t
       where t.TerritoryID = et.TerritoryID) in
	   (select t.TerritoryDescription from Territories t
	   where t.TerritoryDescription like '%w%')

select e.FirstName, t.TerritoryID, t.TerritoryDescription
from EmployeeTerritories et
inner join Employees e on e.EmployeeID = et.EmployeeID
inner join Territories t on t.TerritoryID = et.TerritoryID
where t.TerritoryDescription like '%w%'