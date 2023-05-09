USE [master]
GO
/****** Object:  Database [funcionarios]    Script Date: 05/05/2023 19:33:00 ******/
CREATE DATABASE [funcionarios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'funcionarios', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\funcionarios.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'funcionarios_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\funcionarios_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [funcionarios] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [funcionarios].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [funcionarios] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [funcionarios] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [funcionarios] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [funcionarios] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [funcionarios] SET ARITHABORT OFF 
GO
ALTER DATABASE [funcionarios] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [funcionarios] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [funcionarios] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [funcionarios] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [funcionarios] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [funcionarios] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [funcionarios] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [funcionarios] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [funcionarios] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [funcionarios] SET  ENABLE_BROKER 
GO
ALTER DATABASE [funcionarios] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [funcionarios] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [funcionarios] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [funcionarios] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [funcionarios] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [funcionarios] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [funcionarios] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [funcionarios] SET RECOVERY FULL 
GO
ALTER DATABASE [funcionarios] SET  MULTI_USER 
GO
ALTER DATABASE [funcionarios] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [funcionarios] SET DB_CHAINING OFF 
GO
ALTER DATABASE [funcionarios] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [funcionarios] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [funcionarios] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [funcionarios] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'funcionarios', N'ON'
GO
ALTER DATABASE [funcionarios] SET QUERY_STORE = OFF
GO
USE [funcionarios]
GO
/****** Object:  UserDefinedFunction [dbo].[Aumento]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function 
	[dbo].[Aumento](@valor int, @por int) 
	returns decimal(10,2) as
begin 
	return @valor + (@valor * @por / 100)
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_AumentaSalario]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[fnc_AumentaSalario] (@salario decimal(10,2))
Returns decimal(10,2)
as
begin
	declare @salarioFinal decimal(10,2)
	if @salario between 1400.01 and 3000.00
		set @salarioFinal = (@salario * 1.10)
	if @salario > 3000.00
		set @salarioFinal = (@salario * 1.05)
	else
		set @salarioFinal = (@salario * 1.15)
		
	return @salarioFinal 
end
GO
/****** Object:  UserDefinedFunction [dbo].[tamanhoVarchar]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[tamanhoVarchar](@variavel varchar(20))
returns int as
begin
	return len(trim(@variavel))
end
GO
/****** Object:  Table [dbo].[funcionarios]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[funcionarios](
	[func_id] [int] NOT NULL,
	[func_nome] [varchar](30) NULL,
	[gerente_id] [int] NULL,
	[setor_id] [int] NULL,
	[func_salario] [numeric](18, 2) NULL,
	[func_dataNasc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[func_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[setores]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[setores](
	[setor_id] [int] NOT NULL,
	[setor_nome] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[setor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (1, N'Maria', NULL, 1, CAST(5000.00 AS Numeric(18, 2)), CAST(N'1974-10-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (2, N'Ana', NULL, 1, CAST(4780.00 AS Numeric(18, 2)), CAST(N'1971-07-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (3, N'Carla', NULL, 1, CAST(7000.00 AS Numeric(18, 2)), CAST(N'1974-10-10T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (4, N'Antonio', 1, 1, CAST(1000.00 AS Numeric(18, 2)), CAST(N'1985-08-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (5, N'Nestor', 1, 1, CAST(700.00 AS Numeric(18, 2)), CAST(N'1949-11-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (6, N'Eduardo', 1, 2, CAST(300.00 AS Numeric(18, 2)), CAST(N'1991-08-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (7, N'Anderson', 1, 2, CAST(500.00 AS Numeric(18, 2)), CAST(N'1977-07-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (8, N'Fábio', 1, 2, CAST(350.00 AS Numeric(18, 2)), CAST(N'1989-05-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (9, N'João', 1, 2, CAST(980.00 AS Numeric(18, 2)), CAST(N'1981-02-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (10, N'José', 2, 2, CAST(321.00 AS Numeric(18, 2)), CAST(N'1981-01-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (11, N'Ingrid', 2, 3, CAST(422.00 AS Numeric(18, 2)), CAST(N'1982-02-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (12, N'Bruno', 2, 3, CAST(890.00 AS Numeric(18, 2)), CAST(N'1963-05-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (13, N'Bruna', 2, 3, CAST(1021.00 AS Numeric(18, 2)), CAST(N'1977-12-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (14, N'Daniela', 2, 3, CAST(2050.00 AS Numeric(18, 2)), CAST(N'1984-11-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (15, N'Daniel', 3, NULL, CAST(600.00 AS Numeric(18, 2)), CAST(N'1984-12-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (16, N'Valdir', 3, NULL, CAST(900.00 AS Numeric(18, 2)), CAST(N'1984-07-09T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (17, N'Kleber', 3, NULL, CAST(800.63 AS Numeric(18, 2)), CAST(N'1957-02-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[funcionarios] ([func_id], [func_nome], [gerente_id], [setor_id], [func_salario], [func_dataNasc]) VALUES (18, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (1, N'Faturamento')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (2, N'Contabilidade')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (3, N'RH')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (4, N'Compras')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (5, N'Estoque')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (6, N'Farmácia')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (7, N'Recepção')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (8, N'Desenvolvimento')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (9, N'Engenharia')
GO
INSERT [dbo].[setores] ([setor_id], [setor_nome]) VALUES (10, N'CAD')
GO
/****** Object:  StoredProcedure [dbo].[sp_exemplo1]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_exemplo1] as
begin
	select f.setor_id, sum(f.func_salario) as total
	from funcionarios f 
	group by f.setor_id
end
GO
/****** Object:  StoredProcedure [dbo].[SP_exemplo2]    Script Date: 05/05/2023 19:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[SP_exemplo2] (@numSetor int) as
begin
	if @numSetor = -1 begin --vai listar tudo
		select f.setor_id, sum(f.func_salario) as total
		from funcionarios f 
		group by f.setor_id
	end
	else 
	begin --vai listar somente o desejado
		select @numSetor setor_id, sum(f.func_salario) as total
		from funcionarios f 
		where f.setor_id = @numSetor
	end
end
GO
USE [master]
GO
ALTER DATABASE [funcionarios] SET  READ_WRITE 
GO
