--Atividade N1 – EC 3 – Diego de Souza Lima – Gabriel Carpi Rodrigues .sql


--1)
create or alter view vw_ExibeTragetos as
	SELECT     T.trajetoID,
				CD.nome AS cidade_origem,
				CO.nome AS cidade_destino
	FROM trajeto T
	join cidade CD  on CD.cidadeID = T.cidade_origem
	join cidade CO on CO.cidadeID = T.cidade_destino

	
select * from vw_ExibeTragetos

--2)
create or alter view vw_QuantidadeEstrada as
	select t.trajetoID, sg.ordem 
	from trajeto t
	join segmento sg on t.trajetoID = sg.trajetoID
	
select * from vw_QuantidadeEstrada

--3)
SELECT C.nome AS nome_da_cidade,
		COUNT(E.estradaID) AS quantidade_de_estradas
FROM Cidade C
LEFT JOIN Estrada E ON C.cidadeID = E.cidade_origem
GROUP BY C.nome;

--4) 
SELECT C.nome AS nome_da_cidade
FROM Cidade C
WHERE C.cidadeID 
NOT IN (SELECT DISTINCT cidade_destino FROM Estrada);


--5)
SELECT T.trajetoID AS codigo_do_trajeto,
    CO.nome AS cidade_origem,
	E.nome AS estradas_do_trajeto
FROM Trajeto T
JOIN Cidade CO ON T.cidade_origem = CO.cidadeID
LEFT JOIN Estrada E ON T.trajetoID = E.estradaID
GROUP BY T.trajetoID, CO.nome, E.nome

--6)
SELECT T.trajetoID,
    (SELECT CO.nome FROM cidade CO WHERE CO.cidadeID = t.cidade_origem) AS cidade_origem,
	(select CO.nome from cidade CO where CO.cidadeID = t.cidade_destino) as cidade_destino
FROM trajeto t


--7)
select t.trajetoID,
	(select sg.ordem 		
	from segmento sg where sg.trajetoID = t.trajetoID and sg.ordem > 2) as qtd_segmentos
from trajeto t
where t.trajetoID != 2


--8)
SELECT t.trajetoID,
	(select et.nome from estrada et 
	where t.trajetoID = et.estradaID) AS nome_estrada,
	(select CD.nome from cidade CD where cd.cidadeID = t.trajetoID) as cidade_origem
from trajeto t


