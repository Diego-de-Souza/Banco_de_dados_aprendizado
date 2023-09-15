--Atividade N1 – EC 3 – Nome1 – Nome2.sql


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
	from trajeto 
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
SELECT T.trajetoID, CO.nome AS cidade_destino,
    (SELECT CO.nome FROM Cidade CO WHERE CO.cidadeID = T.cidade_origem) AS cidade_origem
FROM Trajeto T
join Cidade CO on CO.cidadeID = T.cidade_destino


--7)
SELECT T.trajetoID,
    (SELECT COUNT(S2.estradaID) FROM Segmento S2 WHERE S2.trajetoID = T.trajetoID) AS quantidade_de_segmentos
FROM Trajeto T
WHERE (SELECT COUNT(S1.estradaID) FROM Segmento S1 WHERE S1.trajetoID = T.trajetoID) > 2;


--8)
SELECT t.trajetoID, CD.nome,
	(select et.nome from estrada et 
	where t.trajetoID = et.estradaID) AS nome_estrada
from trajeto t
inner join cidade CD on t.trajetoID = CD.cidadeID