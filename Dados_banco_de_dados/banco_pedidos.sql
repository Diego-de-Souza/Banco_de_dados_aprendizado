USE [master]
GO
/****** Object:  Database [pedidos]    Script Date: 05/05/2023 19:37:31 ******/
CREATE DATABASE [pedidos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pedidos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\pedidos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'pedidos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\pedidos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [pedidos] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [pedidos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [pedidos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [pedidos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [pedidos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [pedidos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [pedidos] SET ARITHABORT OFF 
GO
ALTER DATABASE [pedidos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [pedidos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [pedidos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [pedidos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [pedidos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [pedidos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [pedidos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [pedidos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [pedidos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [pedidos] SET  ENABLE_BROKER 
GO
ALTER DATABASE [pedidos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [pedidos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [pedidos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [pedidos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [pedidos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [pedidos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [pedidos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [pedidos] SET RECOVERY FULL 
GO
ALTER DATABASE [pedidos] SET  MULTI_USER 
GO
ALTER DATABASE [pedidos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [pedidos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [pedidos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [pedidos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [pedidos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [pedidos] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'pedidos', N'ON'
GO
ALTER DATABASE [pedidos] SET QUERY_STORE = OFF
GO
USE [pedidos]
GO
/****** Object:  Table [dbo].[EX2_CLIENTE]    Script Date: 05/05/2023 19:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX2_CLIENTE](
	[codcliente] [int] NOT NULL,
	[nome] [varchar](60) NULL,
	[datanascimento] [date] NULL,
	[cpf] [varchar](11) NULL,
 CONSTRAINT [pk2_EX2_cliente] PRIMARY KEY CLUSTERED 
(
	[codcliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EX2_ITEMPEDIDO]    Script Date: 05/05/2023 19:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX2_ITEMPEDIDO](
	[codpedido] [int] NOT NULL,
	[numeroitem] [int] NOT NULL,
	[valorunitario] [decimal](10, 2) NULL,
	[quantidade] [int] NULL,
	[codproduto] [int] NULL,
 CONSTRAINT [pk2_itempedido] PRIMARY KEY CLUSTERED 
(
	[codpedido] ASC,
	[numeroitem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EX2_LOG]    Script Date: 05/05/2023 19:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX2_LOG](
	[codlog] [int] IDENTITY(1,1) NOT NULL,
	[data] [date] NULL,
	[descricao] [varchar](255) NULL,
 CONSTRAINT [pk2_ex2_log] PRIMARY KEY CLUSTERED 
(
	[codlog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EX2_PEDIDO]    Script Date: 05/05/2023 19:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX2_PEDIDO](
	[codpedido] [int] NOT NULL,
	[codcliente] [int] NULL,
	[datapedido] [date] NULL,
	[nf] [varchar](12) NULL,
	[valortotal] [decimal](10, 2) NULL,
 CONSTRAINT [pk2_EX2_pedido] PRIMARY KEY CLUSTERED 
(
	[codpedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EX2_PRODUTO]    Script Date: 05/05/2023 19:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX2_PRODUTO](
	[codproduto] [int] NOT NULL,
	[descricao] [varchar](100) NULL,
	[quantidade] [int] NULL,
 CONSTRAINT [pk2_EX2_produto] PRIMARY KEY CLUSTERED 
(
	[codproduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EX2_REQUISICAO_COMPRA]    Script Date: 05/05/2023 19:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX2_REQUISICAO_COMPRA](
	[codrequisicaocompra] [int] NOT NULL,
	[codproduto] [int] NULL,
	[data] [date] NULL,
	[quantidade] [int] NULL,
 CONSTRAINT [pk2_ex2_reqcompra] PRIMARY KEY CLUSTERED 
(
	[codrequisicaocompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (1, N'Sylvio Barbon', CAST(N'1984-12-05' AS Date), N'12315541212')
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (2, N'Antonio Carlos da Silva', CAST(N'1970-11-01' AS Date), N'12313345512')
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (3, N'Thiago Ribeiro', CAST(N'1964-11-15' AS Date), N'12315544411')
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (4, N'Carlos Eduardo', CAST(N'1924-10-25' AS Date), N'42515541212')
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (5, N'Maria Cristina Goes', CAST(N'1981-11-03' AS Date), N'67715541212')
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (6, N'Ruan Manoel Fanjo', CAST(N'1983-12-06' AS Date), N'32415541212')
GO
INSERT [dbo].[EX2_CLIENTE] ([codcliente], [nome], [datanascimento], [cpf]) VALUES (7, N'Patrícia Marques', CAST(N'1944-02-01' AS Date), N'77715541212')
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (1, 1, CAST(10.90 AS Decimal(10, 2)), 1, 1)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (1, 2, CAST(389.10 AS Decimal(10, 2)), 1, 3)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (2, 1, CAST(10.90 AS Decimal(10, 2)), 1, 1)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (3, 1, CAST(10.90 AS Decimal(10, 2)), 1, 1)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (4, 1, CAST(10.90 AS Decimal(10, 2)), 1, 1)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (4, 2, CAST(15.90 AS Decimal(10, 2)), 2, 2)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (4, 3, CAST(25.50 AS Decimal(10, 2)), 1, 4)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (4, 4, CAST(100.90 AS Decimal(10, 2)), 1, 5)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (5, 1, CAST(100.90 AS Decimal(10, 2)), 1, 5)
GO
INSERT [dbo].[EX2_ITEMPEDIDO] ([codpedido], [numeroitem], [valorunitario], [quantidade], [codproduto]) VALUES (6, 1, CAST(25.50 AS Decimal(10, 2)), 2, 4)
GO
INSERT [dbo].[EX2_PEDIDO] ([codpedido], [codcliente], [datapedido], [nf], [valortotal]) VALUES (1, 1, CAST(N'2012-04-01' AS Date), N'00001', CAST(400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[EX2_PEDIDO] ([codpedido], [codcliente], [datapedido], [nf], [valortotal]) VALUES (2, 2, CAST(N'2012-04-01' AS Date), N'00002', CAST(10.90 AS Decimal(10, 2)))
GO
INSERT [dbo].[EX2_PEDIDO] ([codpedido], [codcliente], [datapedido], [nf], [valortotal]) VALUES (3, 2, CAST(N'2012-04-01' AS Date), N'00003', CAST(21.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[EX2_PEDIDO] ([codpedido], [codcliente], [datapedido], [nf], [valortotal]) VALUES (4, 3, CAST(N'2012-05-01' AS Date), N'00004', CAST(169.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[EX2_PEDIDO] ([codpedido], [codcliente], [datapedido], [nf], [valortotal]) VALUES (5, 4, CAST(N'2012-05-01' AS Date), N'00005', CAST(100.90 AS Decimal(10, 2)))
GO
INSERT [dbo].[EX2_PEDIDO] ([codpedido], [codcliente], [datapedido], [nf], [valortotal]) VALUES (6, 6, CAST(N'2012-05-02' AS Date), N'00006', CAST(51.35 AS Decimal(10, 2)))
GO
INSERT [dbo].[EX2_PRODUTO] ([codproduto], [descricao], [quantidade]) VALUES (1, N'Mouse', 10)
GO
INSERT [dbo].[EX2_PRODUTO] ([codproduto], [descricao], [quantidade]) VALUES (2, N'Teclado', 10)
GO
INSERT [dbo].[EX2_PRODUTO] ([codproduto], [descricao], [quantidade]) VALUES (3, N'Monitor LCD', 10)
GO
INSERT [dbo].[EX2_PRODUTO] ([codproduto], [descricao], [quantidade]) VALUES (4, N'Caixas Acústicas', 10)
GO
INSERT [dbo].[EX2_PRODUTO] ([codproduto], [descricao], [quantidade]) VALUES (5, N'Scanner de Mesa', 10)
GO
ALTER TABLE [dbo].[EX2_ITEMPEDIDO]  WITH CHECK ADD  CONSTRAINT [fk2_codpedido] FOREIGN KEY([codpedido])
REFERENCES [dbo].[EX2_PEDIDO] ([codpedido])
GO
ALTER TABLE [dbo].[EX2_ITEMPEDIDO] CHECK CONSTRAINT [fk2_codpedido]
GO
ALTER TABLE [dbo].[EX2_ITEMPEDIDO]  WITH CHECK ADD  CONSTRAINT [fk2_itempedido_produto] FOREIGN KEY([codproduto])
REFERENCES [dbo].[EX2_PRODUTO] ([codproduto])
GO
ALTER TABLE [dbo].[EX2_ITEMPEDIDO] CHECK CONSTRAINT [fk2_itempedido_produto]
GO
ALTER TABLE [dbo].[EX2_PEDIDO]  WITH CHECK ADD  CONSTRAINT [pk2_EX2_pedido_cliente] FOREIGN KEY([codcliente])
REFERENCES [dbo].[EX2_CLIENTE] ([codcliente])
GO
ALTER TABLE [dbo].[EX2_PEDIDO] CHECK CONSTRAINT [pk2_EX2_pedido_cliente]
GO
ALTER TABLE [dbo].[EX2_REQUISICAO_COMPRA]  WITH CHECK ADD  CONSTRAINT [fk2_ex2_reqcompra_produto] FOREIGN KEY([codproduto])
REFERENCES [dbo].[EX2_PRODUTO] ([codproduto])
GO
ALTER TABLE [dbo].[EX2_REQUISICAO_COMPRA] CHECK CONSTRAINT [fk2_ex2_reqcompra_produto]
GO
USE [master]
GO
ALTER DATABASE [pedidos] SET  READ_WRITE 
GO
