--AULA DE TABELA TEMPORARIA
-- aula dia 05/10/2023 - banco de daos II
sp_who -- comando abre conexões do SQL na master

--Uso de tabelas temporárias
--Criando um tabela local
CREATE TABLE #minhaTbalea(
	cod INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50)
);

INSERT INTO #minhaTbalea (nome) VALUES ('Pedro'), ('Carlos');

SELECT * FROM #minhaTbalea

----------------------------------------------------------------------------
--criando uma tabela temporaria global
CREATE TABLE ##tag_global (
	placa VARCHAR(10) PRIMARY KEY,
	modelo VARCHAR(100)
);

INSERT INTO ##tag_global VALUES ('ABC-1122', 'Fusca');

SELECT * FROM ##tag_global

----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_lista_Func_aumento AS
BEGIN
	--CRIA UMA TABELA TEMPORARIA A PARTIR DE FUNCIONÁRIOS
	SELECT * INTO #tabTemp FROM funcionarios

	UPDATE #tabTemp SET func_salario *= 1.10

	--DEVOLVE OS DADOS SIMULADOS
	SELECT * FROM #tabTemp
END

--LISTANDO A TABELA DE FUNCIONÁRIOS COM 10% DE AUMENTO
EXEC sp_lista_Func_aumento
