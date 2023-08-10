create database [EC2_Teste]
go

USE [EC2_Teste]
GO
/****** Object:  Table [dbo].[cidade]    Script Date: 03/10/2022 19:35:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cidade](
	[codCidade] [int] NOT NULL,
	[descricao] [varchar](100) NOT NULL,
	[populacao] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[codCidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 03/10/2022 19:35:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[codCliente] [int] NOT NULL,
	[nome] [varchar](100) NULL,
	[codCidade] [int] NULL,
	[telefone] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[codCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[cidade] ([codCidade], [descricao], [populacao]) VALUES (1, N'Mauá', 400000)
GO
INSERT [dbo].[cidade] ([codCidade], [descricao], [populacao]) VALUES (2, N'SBC', 350000)
GO
INSERT [dbo].[cidade] ([codCidade], [descricao], [populacao]) VALUES (3, N'SCS', -1)
GO
INSERT [dbo].[cliente] ([codCliente], [nome], [codCidade], [telefone]) VALUES (1, N'Gustavo', 3, N'91234-0099')
GO
INSERT [dbo].[cliente] ([codCliente], [nome], [codCidade], [telefone]) VALUES (2, N'Paulo', 1, N'--SEM TELEFONE--')
GO
INSERT [dbo].[cliente] ([codCliente], [nome], [codCidade], [telefone]) VALUES (3, N'Anderson', 3, N'--SEM TELEFONE--')
GO
INSERT [dbo].[cliente] ([codCliente], [nome], [codCidade], [telefone]) VALUES (4, N'Cristiano', 1, N'--SEM TELEFONE--')
GO
ALTER TABLE [dbo].[cidade] ADD  DEFAULT ((-1)) FOR [populacao]
GO
ALTER TABLE [dbo].[cliente] ADD  DEFAULT ('--SEM TELEFONE--') FOR [telefone]
GO
ALTER TABLE [dbo].[cliente]  WITH CHECK ADD  CONSTRAINT [FK_cliente_cidade] FOREIGN KEY([codCidade])
REFERENCES [dbo].[cidade] ([codCidade])
GO
ALTER TABLE [dbo].[cliente] CHECK CONSTRAINT [FK_cliente_cidade]
GO
