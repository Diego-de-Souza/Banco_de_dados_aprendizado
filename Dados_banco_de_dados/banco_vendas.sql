USE [master]
GO
/****** Object:  Database [Vendas]    Script Date: 05/05/2023 19:39:53 ******/
CREATE DATABASE [Vendas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Vendas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Vendas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Vendas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Vendas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Vendas] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Vendas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Vendas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Vendas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Vendas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Vendas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Vendas] SET ARITHABORT OFF 
GO
ALTER DATABASE [Vendas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Vendas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Vendas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Vendas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Vendas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Vendas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Vendas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Vendas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Vendas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Vendas] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Vendas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Vendas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Vendas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Vendas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Vendas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Vendas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Vendas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Vendas] SET RECOVERY FULL 
GO
ALTER DATABASE [Vendas] SET  MULTI_USER 
GO
ALTER DATABASE [Vendas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Vendas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Vendas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Vendas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Vendas] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Vendas] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Vendas', N'ON'
GO
ALTER DATABASE [Vendas] SET QUERY_STORE = OFF
GO
USE [Vendas]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[codCategoria] [int] NULL,
	[descricao] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[codCliente] [int] NOT NULL,
	[nome] [varchar](100) NULL,
	[dtCadastro] [smalldatetime] NULL,
	[eMail] [varchar](100) NULL,
	[estado] [varchar](2) NULL,
	[cpf] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[codCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[estado] [varchar](2) NOT NULL,
	[descricao] [varchar](50) NULL,
	[regiao] [varchar](10) NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItensVenda]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItensVenda](
	[codVenda] [int] NOT NULL,
	[codProduto] [int] NOT NULL,
	[quantidade] [int] NULL,
	[preco] [decimal](10, 2) NULL,
 CONSTRAINT [PK_ItensVenda] PRIMARY KEY CLUSTERED 
(
	[codVenda] ASC,
	[codProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produto](
	[codProduto] [int] NOT NULL,
	[descricao] [varchar](50) NULL,
	[codCategoria] [int] NULL,
	[preco] [decimal](10, 2) NULL,
	[cor] [varchar](20) NULL,
	[qtdEstoque] [int] NULL,
	[qtdReservado] [int] NULL,
 CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED 
(
	[codProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Regiao]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regiao](
	[regiao] [varchar](10) NOT NULL,
	[descricao] [varchar](100) NULL,
 CONSTRAINT [PK_Regiao] PRIMARY KEY CLUSTERED 
(
	[regiao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venda]    Script Date: 05/05/2023 19:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venda](
	[codVenda] [int] NOT NULL,
	[dtVenda] [smalldatetime] NULL,
	[codCliente] [int] NULL,
	[reserva] [bit] NULL,
	[dtEntrega] [smalldatetime] NULL,
	[estadoCompra] [varchar](2) NULL,
	[estadoEntrega] [varchar](2) NULL,
 CONSTRAINT [PK_Venda] PRIMARY KEY CLUSTERED 
(
	[codVenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Categoria] ([codCategoria], [descricao]) VALUES (1, N'Linha Branca')
GO
INSERT [dbo].[Categoria] ([codCategoria], [descricao]) VALUES (2, N'Audio e Video')
GO
INSERT [dbo].[Categoria] ([codCategoria], [descricao]) VALUES (3, N'Telefonia')
GO
INSERT [dbo].[Categoria] ([codCategoria], [descricao]) VALUES (4, N'Cama Mesa e Banho')
GO
INSERT [dbo].[Categoria] ([codCategoria], [descricao]) VALUES (5, N'Calçados')
GO
INSERT [dbo].[Cliente] ([codCliente], [nome], [dtCadastro], [eMail], [estado], [cpf]) VALUES (1, N'Antonio Carlos dos Santos', CAST(N'2000-01-10T00:00:00' AS SmallDateTime), N'ac@uol.com.br', N'SP', N'205.987.824-80')
GO
INSERT [dbo].[Cliente] ([codCliente], [nome], [dtCadastro], [eMail], [estado], [cpf]) VALUES (2, N'Pedro Alves', CAST(N'1998-04-05T00:00:00' AS SmallDateTime), N'pedro@gmail.com', N'MG', N'104.924.966-31')
GO
INSERT [dbo].[Cliente] ([codCliente], [nome], [dtCadastro], [eMail], [estado], [cpf]) VALUES (3, N'Neto Miranda', CAST(N'2014-12-06T00:00:00' AS SmallDateTime), N'miranda.neto@globo.com.br', N'AC', N'001.587.632-22')
GO
INSERT [dbo].[Cliente] ([codCliente], [nome], [dtCadastro], [eMail], [estado], [cpf]) VALUES (4, N'Ana Carla Pacheco', CAST(N'2017-03-03T00:00:00' AS SmallDateTime), N'pachecoc@terra.com.br', N'AL', N'824.965.241-71')
GO
INSERT [dbo].[Cliente] ([codCliente], [nome], [dtCadastro], [eMail], [estado], [cpf]) VALUES (5, N'Priscila de Souza', CAST(N'2009-07-04T00:00:00' AS SmallDateTime), N'priscila.souza@yahoo.com.br', N'MG', N'201.632.998-10')
GO
INSERT [dbo].[Estado] ([estado], [descricao], [regiao]) VALUES (N'AC', N'Acre', N'N')
GO
INSERT [dbo].[Estado] ([estado], [descricao], [regiao]) VALUES (N'AL', N'Alagoas', N'NR')
GO
INSERT [dbo].[Estado] ([estado], [descricao], [regiao]) VALUES (N'BA', N'Bahia', N'NR')
GO
INSERT [dbo].[Estado] ([estado], [descricao], [regiao]) VALUES (N'MG', N'Minas Gerais', N'SD')
GO
INSERT [dbo].[Estado] ([estado], [descricao], [regiao]) VALUES (N'RJ', N'Rio de Janeiro', N'SD')
GO
INSERT [dbo].[Estado] ([estado], [descricao], [regiao]) VALUES (N'SP', N'São Paulo', N'SD')
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (1, 5, 2, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (1, 8, 5, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (1, 10, 10, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (2, 9, 10, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (2, 10, 7, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (2, 13, 6, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (2, 15, 7, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (3, 1, 1, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (3, 4, 11, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (3, 7, 2, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (3, 8, 3, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (4, 1, 24, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (4, 2, 7, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (4, 8, 1, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (4, 11, 16, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (4, 12, 8, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (5, 1, 15, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (5, 3, 1, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (5, 4, 7, NULL)
GO
INSERT [dbo].[ItensVenda] ([codVenda], [codProduto], [quantidade], [preco]) VALUES (5, 7, 6, NULL)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (1, N'Fogao brastemp 4 bocas', 1, CAST(649.00 AS Decimal(10, 2)), N'branco', 100, 30)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (2, N'Geladeira duplex 440 Litros', 1, CAST(2075.92 AS Decimal(10, 2)), N'branco', 69, 10)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (3, N'Máquina de Lavar Eletrolux 18Kg', 1, CAST(1545.67 AS Decimal(10, 2)), N'amarela', 74, 25)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (4, N'Fogao DAKO 6 bocas', 1, CAST(531.00 AS Decimal(10, 2)), N'azul', 36, 5)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (5, N'Frigobar 100L', 1, CAST(712.00 AS Decimal(10, 2)), N'verde', 85, 14)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (6, N'TV LG 50" OLED', 2, CAST(1699.99 AS Decimal(10, 2)), N'preto', 74, 6)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (7, N'Home-Theater Pioneer 1500W', 2, CAST(949.00 AS Decimal(10, 2)), NULL, 36, 19)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (8, N'DVD Player Sony', 2, CAST(328.35 AS Decimal(10, 2)), N'preto', 98, 47)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (9, N'Blue Ray LG', 2, CAST(449.10 AS Decimal(10, 2)), NULL, 21, 15)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (10, N'Mini System 1500W', 2, CAST(597.55 AS Decimal(10, 2)), NULL, 53, 24)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (11, N'Toalha de Rosto Canester', 4, CAST(3.90 AS Decimal(10, 2)), N'rosa', 14, 7)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (12, N'Roupão feminino estampado', 4, CAST(69.90 AS Decimal(10, 2)), N'lilas', 85, 0)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (13, N'Jogo de lençol King Size', 4, CAST(108.00 AS Decimal(10, 2)), N'azul', 79, 0)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (14, N'Travesseiro Pluma de Ganso (2 Unidades)', 4, CAST(399.99 AS Decimal(10, 2)), NULL, 36, 30)
GO
INSERT [dbo].[Produto] ([codProduto], [descricao], [codCategoria], [preco], [cor], [qtdEstoque], [qtdReservado]) VALUES (15, N'Toalha de Mesa redonda 1mt', 4, CAST(64.80 AS Decimal(10, 2)), N'estampada', 24, 24)
GO
INSERT [dbo].[Regiao] ([regiao], [descricao]) VALUES (N'CO', N'Centro-Oeste')
GO
INSERT [dbo].[Regiao] ([regiao], [descricao]) VALUES (N'N', N'Norte')
GO
INSERT [dbo].[Regiao] ([regiao], [descricao]) VALUES (N'NR', N'Nordeste')
GO
INSERT [dbo].[Regiao] ([regiao], [descricao]) VALUES (N'S', N'Sul')
GO
INSERT [dbo].[Regiao] ([regiao], [descricao]) VALUES (N'SD', N'Sudeste')
GO
INSERT [dbo].[Venda] ([codVenda], [dtVenda], [codCliente], [reserva], [dtEntrega], [estadoCompra], [estadoEntrega]) VALUES (1, CAST(N'2018-01-10T00:00:00' AS SmallDateTime), 1, 0, CAST(N'2018-02-15T00:00:00' AS SmallDateTime), N'SP', N'RJ')
GO
INSERT [dbo].[Venda] ([codVenda], [dtVenda], [codCliente], [reserva], [dtEntrega], [estadoCompra], [estadoEntrega]) VALUES (2, CAST(N'2017-05-15T00:00:00' AS SmallDateTime), 3, 1, NULL, N'RJ', N'MG')
GO
INSERT [dbo].[Venda] ([codVenda], [dtVenda], [codCliente], [reserva], [dtEntrega], [estadoCompra], [estadoEntrega]) VALUES (3, CAST(N'2017-12-10T00:00:00' AS SmallDateTime), 5, 1, NULL, N'MG', N'AL')
GO
INSERT [dbo].[Venda] ([codVenda], [dtVenda], [codCliente], [reserva], [dtEntrega], [estadoCompra], [estadoEntrega]) VALUES (4, CAST(N'2018-03-15T00:00:00' AS SmallDateTime), 4, 0, CAST(N'2018-04-20T00:00:00' AS SmallDateTime), N'AL', N'BA')
GO
INSERT [dbo].[Venda] ([codVenda], [dtVenda], [codCliente], [reserva], [dtEntrega], [estadoCompra], [estadoEntrega]) VALUES (5, CAST(N'2018-04-30T00:00:00' AS SmallDateTime), 3, 0, CAST(N'2018-05-02T00:00:00' AS SmallDateTime), N'AL', N'SP')
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Estado] FOREIGN KEY([estado])
REFERENCES [dbo].[Estado] ([estado])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Estado]
GO
ALTER TABLE [dbo].[Estado]  WITH CHECK ADD  CONSTRAINT [FK_Estado_Regiao] FOREIGN KEY([regiao])
REFERENCES [dbo].[Regiao] ([regiao])
GO
ALTER TABLE [dbo].[Estado] CHECK CONSTRAINT [FK_Estado_Regiao]
GO
ALTER TABLE [dbo].[ItensVenda]  WITH CHECK ADD  CONSTRAINT [FK_ItensVenda_Produto] FOREIGN KEY([codProduto])
REFERENCES [dbo].[Produto] ([codProduto])
GO
ALTER TABLE [dbo].[ItensVenda] CHECK CONSTRAINT [FK_ItensVenda_Produto]
GO
ALTER TABLE [dbo].[ItensVenda]  WITH CHECK ADD  CONSTRAINT [FK_ItensVenda_Venda] FOREIGN KEY([codVenda])
REFERENCES [dbo].[Venda] ([codVenda])
GO
ALTER TABLE [dbo].[ItensVenda] CHECK CONSTRAINT [FK_ItensVenda_Venda]
GO
ALTER TABLE [dbo].[Venda]  WITH CHECK ADD  CONSTRAINT [FK_Venda_Cliente] FOREIGN KEY([codCliente])
REFERENCES [dbo].[Cliente] ([codCliente])
GO
ALTER TABLE [dbo].[Venda] CHECK CONSTRAINT [FK_Venda_Cliente]
GO
ALTER TABLE [dbo].[Venda]  WITH CHECK ADD  CONSTRAINT [FK_Venda_Estado] FOREIGN KEY([estadoCompra])
REFERENCES [dbo].[Estado] ([estado])
GO
ALTER TABLE [dbo].[Venda] CHECK CONSTRAINT [FK_Venda_Estado]
GO
ALTER TABLE [dbo].[Venda]  WITH CHECK ADD  CONSTRAINT [FK_Venda_Estado1] FOREIGN KEY([estadoEntrega])
REFERENCES [dbo].[Estado] ([estado])
GO
ALTER TABLE [dbo].[Venda] CHECK CONSTRAINT [FK_Venda_Estado1]
GO
USE [master]
GO
ALTER DATABASE [Vendas] SET  READ_WRITE 
GO
