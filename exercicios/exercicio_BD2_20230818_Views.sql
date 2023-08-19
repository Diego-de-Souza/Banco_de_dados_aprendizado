--trabalhando com Views

--seleção por colunas
create or alter view vw_produtos_tot_estoque as
	select p.ProductID, p.ProductName,
	p.UnitPrice * p.UnitsInStock as financeiro 
	from Products p

--chamada
select * from vw_produtos_tot_estoque

--seleção por registros
--assumindo que o estoque baixo são produtos
--com menos de 50 unidades
create or alter view vw_estoque_zerado as
	select * from Products
	where UnitsInStock = 0

--executando
select * from vw_estoque_zerado

--Ligando tabelas dentro da view
create or alter view vw_produto_fornecedor as
	select s.*,p.ProductID, p.ProductName, p.QuantityPerUnit,
	p.CategoryID, p.UnitsInStock, p.UnitPrice
	from Products p
	inner join Suppliers s on p.SupplierID=s.SupplierID

--a chamada
select * from vw_produto_fornecedor

--fazendo joins com as views
select vw.ProductName, vw.CompanyName, c.CategoryName 
from vw_produto_fornecedor vw
inner join Categories c on vw.CategoryID = c.CategoryID


--transformando o select acima em uma view
create or alter view vw_total_nomes as
	select vw.ProductName, vw.CompanyName, c.CategoryName
	from vw_produto_fornecedor vw
	inner join Categories c on vw.CategoryID = c.CategoryID

--chamada
select * from vw_total_nomes

--------------------------------------------------------------
--recompilando views, caso seja alterado a estrutura
--de alguma tabela
sp_refreshview vw_total_nomes

--como exibir as dependencias de tabelas
select * from sys.sql_expression_dependencies
where referenced_id = OBJECT_ID('Products');
go 

