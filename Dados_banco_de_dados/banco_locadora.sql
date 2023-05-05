USE [master]
GO
/****** Object:  Database [Locadora]    Script Date: 05/05/2023 19:36:34 ******/
CREATE DATABASE [Locadora]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Locadora', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Locadora.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Locadora_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Locadora_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Locadora] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Locadora].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Locadora] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Locadora] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Locadora] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Locadora] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Locadora] SET ARITHABORT OFF 
GO
ALTER DATABASE [Locadora] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Locadora] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Locadora] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Locadora] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Locadora] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Locadora] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Locadora] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Locadora] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Locadora] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Locadora] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Locadora] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Locadora] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Locadora] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Locadora] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Locadora] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Locadora] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Locadora] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Locadora] SET RECOVERY FULL 
GO
ALTER DATABASE [Locadora] SET  MULTI_USER 
GO
ALTER DATABASE [Locadora] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Locadora] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Locadora] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Locadora] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Locadora] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Locadora] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Locadora', N'ON'
GO
ALTER DATABASE [Locadora] SET QUERY_STORE = OFF
GO
USE [Locadora]
GO
/****** Object:  UserDefinedFunction [dbo].[AplicaAumento]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AplicaAumento]
(
	@p_valor decimal(10,2),
	@porcentagem_aumento decimal(10,2)
)
Returns decimal(10,2)
As
Begin
	return @p_valor + ( @p_valor * @porcentagem_aumento/100)
end
GO
/****** Object:  Table [dbo].[Midias]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Midias](
	[CodMidia] [smallint] NOT NULL,
	[DescMidia] [varchar](70) NOT NULL,
	[ValorUnit] [decimal](7, 2) NOT NULL,
	[codGenero] [smallint] NULL,
	[quantidade] [int] NULL,
 CONSTRAINT [PK_Midias] PRIMARY KEY CLUSTERED 
(
	[CodMidia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItensLocacao]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItensLocacao](
	[CodLocacao] [smallint] NOT NULL,
	[CodMidia] [smallint] NOT NULL,
	[DataDev] [smalldatetime] NULL,
 CONSTRAINT [PK_CodLocacao_CodMidia] PRIMARY KEY CLUSTERED 
(
	[CodLocacao] ASC,
	[CodMidia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ruim]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_ruim] as
	select m.DescMidia
	from Midias m
	left join ItensLocacao itl on (itl.CodMidia = m.CodMidia)
	where itl.CodMidia is null
GO
/****** Object:  View [dbo].[vw_Top5]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_Top5] as
	select top 5 count(il.CodMidia) qtd, m.CodMidia Código, m.DescMidia Título
	from Midias m
	left outer join ItensLocacao il on (m.CodMidia = il.CodMidia)
	group by m.CodMidia, m.DescMidia
	order by qtd desc
GO
/****** Object:  View [dbo].[vw_nuncaLocados]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_nuncaLocados] as
	select m.CodMidia Código, m.DescMidia Título
	from Midias m
	left outer join ItensLocacao il on (m.CodMidia = il.CodMidia)
	where il.CodLocacao is null
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[CodCli] [smallint] NOT NULL,
	[Cliente] [varchar](50) NOT NULL,
	[EnderecoCli] [varchar](100) NOT NULL,
	[TelCli] [varchar](9) NOT NULL,
 CONSTRAINT [PK_CodCli] PRIMARY KEY CLUSTERED 
(
	[CodCli] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locacao]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locacao](
	[CodLocacao] [smallint] NOT NULL,
	[CodCli] [smallint] NOT NULL,
	[DataLoc] [smalldatetime] NULL,
	[ValorTotalLoc] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_CodLocacao] PRIMARY KEY CLUSTERED 
(
	[CodLocacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ClienteSemLocacao]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_ClienteSemLocacao] as
	select c.CodCli Código, c.Cliente Nome 
	from Cliente c
	left outer join Locacao l on (c.CodCli = l.CodCli)
	where l.CodLocacao is null
GO
/****** Object:  View [dbo].[vw_LocacaoTOP]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_LocacaoTOP] as
	select t.Código, t.Título, c.Cliente
	from Cliente c
	inner join Locacao l on (c.CodCli = l.CodCli)
	inner join ItensLocacao il on (l.CodLocacao = il.CodLocacao)
	inner join vw_Top5 t on (t.Código = il.CodMidia)
GO
/****** Object:  View [dbo].[vw_ClienteTOP]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_ClienteTOP] as
	select top 5 c.CodCli Código, c.Cliente Nome
	from Cliente c
	inner join Locacao l on (c.CodCli = l.CodCli)
	group by c.CodCli, c.Cliente
	order by COUNT(*) desc
GO
/****** Object:  Table [dbo].[Genero]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genero](
	[Codgenero] [smallint] NOT NULL,
	[descricao] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Codgenero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_genero]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_genero] as
	select g.Codgenero Código, g.descricao Genero
	from Midias m
	inner join Genero g on (g.Codgenero = m.codGenero)
	inner join vw_nuncaLocados nl on (nl.Código = m.CodMidia)
GO
/****** Object:  Table [dbo].[resumo]    Script Date: 05/05/2023 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resumo](
	[codCli] [int] NOT NULL,
	[valorTotal] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[codCli] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (1, N'Antonio dos Santos', N'Rua dos Javalis, 123', N'4909-1198')
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (2, N'Penelope Cruz', N'Rua das Rosas, 254', N'4909-1198')
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (3, N'Joao cleber', N'Rua 123, 098', N'254-8825')
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (4, N'Ana maria braga', N'Rua dos morangos, 23', N'9987-8571')
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (5, N'Silvio Santos', N'Rua tatui, 23', N'3254-9825')
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (6, N'Eduardo Maleta', N'Rua juba S/N', N'1457-8825')
GO
INSERT [dbo].[Cliente] ([CodCli], [Cliente], [EnderecoCli], [TelCli]) VALUES (7, N'Marcotti', N'Rua da TM, 123', N'4997-5874')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (1, N'Terror')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (2, N'Drama')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (3, N'Comedia')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (4, N'Desenho')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (5, N'Ficção')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (6, N'Guerra')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (7, N'Romance')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (8, N'Infantil')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (13, N'Show')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (14, N'Comédia Romantica')
GO
INSERT [dbo].[Genero] ([Codgenero], [descricao]) VALUES (15, N'Terror Pastelão')
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (1, 1, CAST(N'2011-01-01T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (1, 3, CAST(N'2011-10-01T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (1, 4, CAST(N'2011-06-03T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (2, 3, CAST(N'2011-10-20T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (3, 2, CAST(N'2011-06-20T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (4, 1, CAST(N'2010-05-11T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (5, 2, CAST(N'2011-09-01T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (5, 3, CAST(N'2011-07-11T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (5, 5, CAST(N'2011-06-22T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (7, 4, CAST(N'2011-07-19T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (7, 6, CAST(N'2011-05-30T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (8, 1, CAST(N'2011-07-22T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (9, 1, CAST(N'2011-12-10T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (9, 11, NULL)
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (9, 12, CAST(N'2011-11-12T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (9, 15, CAST(N'2011-11-12T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (10, 19, CAST(N'2011-12-23T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (10, 20, NULL)
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (11, 10, CAST(N'2011-10-23T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (11, 18, CAST(N'2011-12-22T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (11, 19, CAST(N'2011-10-20T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (12, 19, CAST(N'2011-12-01T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (13, 13, CAST(N'2011-10-05T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[ItensLocacao] ([CodLocacao], [CodMidia], [DataDev]) VALUES (14, 12, CAST(N'2011-11-09T00:00:00' AS SmallDateTime))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (1, 1, CAST(N'2011-01-10T00:00:00' AS SmallDateTime), CAST(15.33 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (2, 2, CAST(N'2011-09-29T00:00:00' AS SmallDateTime), CAST(6.90 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (3, 4, CAST(N'2010-07-20T00:00:00' AS SmallDateTime), CAST(14.65 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (4, 2, CAST(N'2011-03-10T00:00:00' AS SmallDateTime), CAST(6.03 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (5, 7, CAST(N'2011-03-24T00:00:00' AS SmallDateTime), CAST(18.71 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (6, 3, CAST(N'2011-01-13T00:00:00' AS SmallDateTime), CAST(3.98 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (7, 4, CAST(N'2011-07-28T00:00:00' AS SmallDateTime), CAST(7.98 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (8, 2, CAST(N'2011-11-11T00:00:00' AS SmallDateTime), CAST(8.65 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (9, 3, CAST(N'2011-02-01T00:00:00' AS SmallDateTime), CAST(5.98 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (10, 5, CAST(N'2011-02-10T00:00:00' AS SmallDateTime), CAST(10.76 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (11, 4, CAST(N'2010-12-15T00:00:00' AS SmallDateTime), CAST(23.09 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (12, 1, CAST(N'2011-05-22T00:00:00' AS SmallDateTime), CAST(33.23 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (13, 7, CAST(N'2010-02-18T00:00:00' AS SmallDateTime), CAST(15.86 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (14, 2, CAST(N'2011-07-20T00:00:00' AS SmallDateTime), CAST(18.43 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (15, 1, CAST(N'2012-02-23T00:00:00' AS SmallDateTime), CAST(6.98 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (16, 3, CAST(N'2012-02-23T00:00:00' AS SmallDateTime), CAST(12.93 AS Decimal(6, 2)))
GO
INSERT [dbo].[Locacao] ([CodLocacao], [CodCli], [DataLoc], [ValorTotalLoc]) VALUES (110, 1, CAST(N'2012-08-16T21:52:00' AS SmallDateTime), CAST(16.03 AS Decimal(6, 2)))
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (1, N'Piratas do Caribe 3', CAST(6.03 AS Decimal(7, 2)), 1, 0)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (2, N'Piratas do Caribe 2', CAST(6.33 AS Decimal(7, 2)), 3, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (3, N'BrokeBack Mountain', CAST(10.00 AS Decimal(7, 2)), 1, 1)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (4, N'Gaiola das Loucas', CAST(10.00 AS Decimal(7, 2)), 3, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (5, N'Homem de Ferro', CAST(5.48 AS Decimal(7, 2)), 1, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (6, N'Homem de Ferro 2', CAST(6.84 AS Decimal(7, 2)), 4, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (8, N'X-Men 2', CAST(4.38 AS Decimal(7, 2)), 4, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (10, N'X-Men', CAST(3.28 AS Decimal(7, 2)), 4, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (11, N'Peter Pan', CAST(2.33 AS Decimal(7, 2)), 4, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (12, N'Velozes e Furiosos 1', CAST(3.87 AS Decimal(7, 2)), 5, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (13, N'O Santuario', CAST(5.21 AS Decimal(7, 2)), 5, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (14, N'Esta chovendo Hamburguer', CAST(2.12 AS Decimal(7, 2)), 4, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (15, N'O Mentiroso', CAST(1.98 AS Decimal(7, 2)), 3, 0)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (16, N'Lagrimas de Sol', CAST(4.98 AS Decimal(7, 2)), 2, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (17, N'Velozes e Furiosos 6', CAST(10.50 AS Decimal(7, 2)), 1, 5)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (18, N'Premonição 2', CAST(3.75 AS Decimal(7, 2)), 1, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (19, N'O Brinquedo Assassino', CAST(2.65 AS Decimal(7, 2)), 5, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (20, N'Platon', CAST(1.54 AS Decimal(7, 2)), 6, 2)
GO
INSERT [dbo].[Midias] ([CodMidia], [DescMidia], [ValorUnit], [codGenero], [quantidade]) VALUES (21, N'As Cronicas de Narnia', CAST(4.87 AS Decimal(7, 2)), 5, 2)
GO
INSERT [dbo].[resumo] ([codCli], [valorTotal]) VALUES (1, CAST(20.00 AS Decimal(10, 2)))
GO
ALTER TABLE [dbo].[Locacao] ADD  DEFAULT ((0)) FOR [ValorTotalLoc]
GO
ALTER TABLE [dbo].[Midias] ADD  DEFAULT ((0)) FOR [ValorUnit]
GO
ALTER TABLE [dbo].[ItensLocacao]  WITH CHECK ADD  CONSTRAINT [FK_ItensLocacao_Locacao] FOREIGN KEY([CodLocacao])
REFERENCES [dbo].[Locacao] ([CodLocacao])
GO
ALTER TABLE [dbo].[ItensLocacao] CHECK CONSTRAINT [FK_ItensLocacao_Locacao]
GO
ALTER TABLE [dbo].[ItensLocacao]  WITH CHECK ADD  CONSTRAINT [FK_ItensLocacao_Midias] FOREIGN KEY([CodMidia])
REFERENCES [dbo].[Midias] ([CodMidia])
GO
ALTER TABLE [dbo].[ItensLocacao] CHECK CONSTRAINT [FK_ItensLocacao_Midias]
GO
ALTER TABLE [dbo].[Locacao]  WITH CHECK ADD  CONSTRAINT [FK_Locacao_Cliente] FOREIGN KEY([CodCli])
REFERENCES [dbo].[Cliente] ([CodCli])
GO
ALTER TABLE [dbo].[Locacao] CHECK CONSTRAINT [FK_Locacao_Cliente]
GO
USE [master]
GO
ALTER DATABASE [Locadora] SET  READ_WRITE 
GO
