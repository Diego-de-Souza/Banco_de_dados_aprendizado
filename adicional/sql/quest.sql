--Selecionando BD - Locadora
USE LOCADORA
-----------------------------------------------------------------------------------------------
-- Questão 1) exiba a quantidade de filmes que cada genero possui
select g.descricao,count(m.CodMidia) qnt
from Midias m 
	right join genero g
	on m.codGenero=g.Codgenero
		group by g.descricao
/*
Resultado
descricao                                qnt
---------------------------------------- -----------
Comedia                                  3
Comédia Romantica                        0
Desenho                                  5
Drama                                    1
Ficção                                   4
Guerra                                   1
Infantil                                 0
Romance                                  0
Show                                     0
Terror                                   5
Terror Pastelão                          0
*/

-----------------------------------------------------------------------------------------------------------------------
-- Questão 2)Exiba os genero que possuem mais do que 4 filmes cadastrados para ele
select g.descricao,count(m.CodMidia) qnt
from Midias m 
	right join genero g
	on m.codGenero=g.Codgenero
		group by g.descricao
		having count(m.CodMidia) > 4
/*Resultado
descricao                                qnt
---------------------------------------- -----------
Desenho                                  5
Terror                                   5
*/

-----------------------------------------------------------------------------------------------------------------------
-- Questão 3)Exiba a somatoria dos valores unitarios das midias seperados por genero
select g.descricao,sum(m.ValorUnit) soma_valor
from Midias m 
	inner join genero g
	on m.codGenero=g.Codgenero
		group by g.descricao
/*Resultado
descricao                                soma_valor
---------------------------------------- ---------------------------------------
Comedia                                  18.31
Desenho                                  18.95
Drama                                    4.98
Ficção                                   16.60
Guerra                                   1.54
Terror                                   35.76
*/


-----------------------------------------------------------------------------------------------------------------------
-- Questão 4)Mostre quantas locacoes cada cliente fez

select c.Cliente,count(l.CodLocacao) qnt 
from cliente c
	left join Locacao l
	on c.CodCli=l.CodCli
		group by c.Cliente
/*Resultado
Cliente                                            qnt
-------------------------------------------------- -----------
Ana maria braga                                    3
Antonio dos Santos                                 4
Eduardo Maleta                                     0
Joao cleber                                        3
Marcotti                                           2
Penelope Cruz                                      4
Silvio Santos                                      1
*/
		
-----------------------------------------------------------------------------------------------------------------------
--Questão 5)Mostre quantas locacoes foram feitas em cada mes

select month(l.DataLoc) mes, count(CodLocacao) qnt
from Locacao l
	group by month(l.DataLoc)
/*Resposta
mes         qnt
----------- -----------
1           2
2           5
3           2
5           1
7           3
8           1
9           1
11          1
12          1
*/

-----------------------------------------------------------------------------------------------------------------------
--Questão 6) Qual o valor total gasto com locacoes que cada cliente possui

select c.Cliente,sum(l.ValorTotalLoc) Valor_total_cliente
from cliente c
	left join Locacao l
	on c.CodCli=l.CodCli
		group by c.Cliente
/*Resultado
Cliente                                            Valor_total_cliente
-------------------------------------------------- ---------------------------------------
Ana maria braga                                    45.72
Antonio dos Santos                                 71.57
Eduardo Maleta                                     NULL
Joao cleber                                        22.89
Marcotti                                           34.57
Penelope Cruz                                      40.01
Silvio Santos                                      10.76
*/

-----------------------------------------------------------------------------------------------------------------------
--Questão 7)Mostre somente as locacoes que possuem mais do que 3 filmes cada uma

select l.CodLocacao,count(i.CodMidia) qnt
from Locacao l
	inner join ItensLocacao i
	on l.CodLocacao=i.CodLocacao
		group by l.CodLocacao
		having count(i.CodMidia) > 3
/*
CodLocacao qnt
---------- -----------
9          4
*/

-----------------------------------------------------------------------------------------------------------------------
--Questão 8)Qual a quantidade de filmes foram alugados por mes e quantas locacoes cada mes possui
select * from ItensLocacao