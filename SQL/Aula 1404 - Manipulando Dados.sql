--inserir dados
insert into Veiculo(placa, modelo, ano, preco, dataCompra)
	values ('PER-2399','Honda Civic',2020,104000,'2023/01/02')

insert into Veiculo
	values ('XRF-0934', 'BMW X1', 2018, 250345.99, '2019/12/30')

insert into Veiculo
	values ('MIU-9945','Volvo XC60', 2014,134900.00,'2020/12/30'),
			('WIE-6525','Eclipse',1985,340020.00,'2022/10/23')

--motorista
insert into Motorista values (8748398,'Elen dos Santos'),
							(9840232,'Rose klent'),
							(9458321, 'Pauley Stanley'),
							(842342, 'Genne Smon')
--troca formato da data
set dateformat ymd

select * from Veiculo