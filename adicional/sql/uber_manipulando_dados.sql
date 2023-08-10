/*Inserindo dados*/

/*Trocando o formato da data*/
set dateformat ymd --ano(y),mês(m),dia(d)

/* Colocando valores nos campos, se você definir os campos,
você pode colocar menos campos do que os existentes */
insert into Veiculo	(placa, modelo, ano, preco, dataCompra)
		values('PER-2399', 'Honda Civic', 2020, 104000, '2023/01/02')

/* Colocando os valores, sem definir os campos, você coloca na ordem
que criou, tendo que colocar todos os dados */
insert into Veiculo
		values('XRF-0934', 'BMW X1', 2018, 250345.99, '2019/12/30')

/* Inserindo dados de mais de um item por vez, colocando virgula após cada item
utilizando a mesma ordem sempre */
insert into Veiculo
		values	('MIU-9945', 'Volvo XC60', 2014, 134900.00, '2020/12/30'),
				('WIE-6525', 'Eclipse', 1985, 34000.00, '2022/10/23')


--motorista
insert into Motorista
		values	(8748398, 'Elen dos Santos'),
				(9840232, 'Rose Klent'),
				(9458324, 'Paul Stanley'),
				(1234567,'Robson Ferraezi')


select*from Veiculo --seleciona a tabela Veiculo

select*from Motorista --seleciona a tabela Motorista