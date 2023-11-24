--Atividade proposta para avalia��o de nota N1 do 2� bimestre do 3�semestre de EC 2023
------------------------------------------------------------------------------------------
--Faculdade Engenheiro Salvador Arena
--Curso => Engenharia da Computa��o EC3
--Autor => Diego de Souza L.
--R.A. => 0892220042
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
use master
go

use pedidos
go

SELECT *
	FROM EX2_Pedido

CREATE OR ALTER TRIGGER TRG_EX2_ItemPedido_Insert
ON EX2_ITEMPEDIDO
AFTER INSERT AS
BEGIN
  
	DECLARE @CodPedido INT;
	DECLARE @CodProduto INT;
	DECLARE @QuantidadePedido INT;
	DECLARE @QuantidadeEstoque INT;

	-- Obtenha o PedidoID e ProdutoID do novo item inserido
	SELECT @CodPedido = codpedido, @CodProduto = codproduto, @QuantidadePedido = quantidade
	FROM inserted;

	-- Verifique se o c�digo do pedido existe na tabela de Pedido
	IF NOT EXISTS (SELECT 1 
					FROM EX2_Pedido 
					WHERE codpedido = @CodPedido)
	BEGIN
		raiserror('O c�digo do pedido n�o existe na tabela de Pedido.', 16, 1);
		ROLLBACK transaction;
	END;

	-- Verifique se a quantidade dos produtos n�o � maior do que a quantidade em estoque
	SELECT @QuantidadeEstoque = quantidade
	FROM EX2_Produto
	WHERE codproduto = @CodProduto;

	IF @QuantidadePedido > @QuantidadeEstoque
	BEGIN
		raiserror('A quantidade dos produtos � maior do que a quantidade em estoque.', 16, 1);
		ROLLBACK transaction;
	END;

	-- Atualize a quantidade em estoque
	UPDATE EX2_Produto
	SET quantidade = @QuantidadeEstoque - @QuantidadePedido
	WHERE codproduto = @CodProduto;

	-- Verifique se a quantidade em estoque � menor que 5 e gere um registro para "EX2_Requisicao_Compra"
	IF @QuantidadeEstoque < 5
	BEGIN
		-- Calcule a quantidade de compra
		DECLARE @QuantidadeCompra INT;
		SET @QuantidadeCompra = @QuantidadeEstoque * 2.5;

		-- Insira um registro na tabela "EX2_Requisicao_Compra"
		INSERT INTO EX2_REQUISICAO_COMPRA(codproduto, quantidade)
		VALUES (@CodProduto, @QuantidadeCompra);
	END;
END;

select * 
from EX2_ITEMPEDIDO

select * from EX2_PRODUTO

select * from EX2_PEDIDO

--inserindo valor na tabela de itempedidos
insert into EX2_ITEMPEDIDO (codpedido,numeroitem,valorunitario,quantidade,codproduto)
	values(6, 3, CAST(20.90 AS Decimal(10, 2)), 14, 1)


-- Trigger de Altera��o
CREATE or alter TRIGGER TRG_EX2_ItemPedido_Update ON EX2_ItemPedido
for INSERT, UPDATE as
BEGIN
	-- verifica se h� alguma altera��o e gera mensagem
	IF exists (SELECT * from inserted)
	begin
		raiserror('A altera��o de registros n�o � permitida.', 16, 1);
		ROLLBACK transaction;
		return;
	end
END;

select *
from EX2_ITEMPEDIDO
--tentando alterar um valor na tabelaitem pedido
alter table EX2_ITEMPEDIDO add email varchar (20);
alter table EX2_ITEMPEDIDO drop column email;
DELETE FROM EX2_ITEMPEDIDO
WHERE codpedido =1;

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER TRG_EX2_Pedido_Insert ON EX2_PEDIDO
AFTER INSERT AS
BEGIN
	DECLARE @DataPedido DATE;
	DECLARE @DataSistema DATE;

	-- Obtenha a data do pedido
	SELECT @DataPedido = datapedido FROM inserted;

	-- Obtenha a data do sistema operacional
	SELECT @DataSistema = getDate();

	-- Verifique se a data do pedido � igual � data do sistema operacional
	IF @DataPedido <> @DataSistema
	BEGIN
		raiserror('A data do pedido n�o pode ser diferente da data do sistema operacional.', 16, 1);
		ROLLBACK TRANSACTION;
  END;
END;

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

CREATE TRIGGER TRG_All_Tables_Operations ON DATABASE
AFTER INSERT, UPDATE, DELETE AS
BEGIN
	DECLARE @TableName NVARCHAR(128);
	DECLARE @OperationType NVARCHAR(20);
	DECLARE @LogDescription NVARCHAR(100);

	-- Obtenha o nome da tabela onde a opera��o ocorreu
	SET @TableName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(128)');
	 
	-- Verifique o tipo de opera��o
	IF EXISTS (SELECT * FROM  inserted)
	BEGIN
		SET @OperationType = 'Inclus�o';
	END
	ELSE IF EXISTS (SELECT * FROM deleted)
	BEGIN
		SET @OperationType = 'Exclus�o';
	END
	ELSE
	BEGIN
		SET @OperationType = 'Altera��o';
	END;

	-- Crie a descri��o para o registro de log
	SET @LogDescription = @OperationType + ' em ' + @TableName;

	-- Insira o registro de log na tabela 'EX2_Log'
	INSERT INTO EX2_LOG(data, descricao)
	VALUES (getDate(), @LogDescription);
END;

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- Trigger de Inclus�o
CREATE TRIGGER TRG_EX2_Cliente_Insert ON EX2_CLIENTE
AFTER INSERT AS
BEGIN
	DECLARE @CPF CHAR(11);
    DECLARE @Validacao INT;

    -- Obtenha o CPF do cliente
    SELECT @CPF = cpf FROM inserted;

	--fun��o verificadora do cpf
	CREATE FUNCTION VerificarCPF (@cpf VARCHAR(11))
	RETURNS INT AS
	BEGIN
		DECLARE @soma INT = 0;
		DECLARE @resto INT = 0;
		DECLARE @i INT = 1;
		DECLARE @digito INT;
  
		WHILE @i <= 9
		BEGIN
			SET @soma = @soma + CAST(SUBSTRING(@cpf, @i, 1) AS INT) * (11 - @i);
			SET @i = @i + 1;
		END;
		SET @resto = (@soma * 10) % 11;
  
		IF @resto = 10 OR @resto = 11
			SET @digito = 0;
		ELSE
			SET @digito = @resto;
  
		IF @digito = CAST(SUBSTRING(@cpf, 10, 1) AS INT)
		BEGIN
			SET @soma = 0;
			SET @i = 1;
    
		WHILE @i <= 10
		BEGIN
			SET @soma = @soma + CAST(SUBSTRING(@cpf, @i, 1) AS INT) * (12 - @i);
			SET @i = @i + 1;
		END;
    
		SET @resto = (@soma * 10) % 11;
    
		IF @resto = 10 OR @resto = 11
			SET @digito = 0;
		ELSE
			SET @digito = @resto;
    
		IF @digito = CAST(SUBSTRING(@cpf, 11, 1) AS INT)
			RETURN 1; -- CPF v�lido
		ELSE
			RETURN 0; -- CPF inv�lido
		END;
  
		RETURN 0; -- CPF inv�lido
	END;
    -- Execute a rotina de verifica��o de CPF
    EXEC @Validacao = VerificarCPF @CPF;

    -- Verifique se o CPF � v�lido
    IF @Validacao = 0
    BEGIN
        raiserror('CPF inv�lido. A inclus�o do cliente n�o � permitida.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

