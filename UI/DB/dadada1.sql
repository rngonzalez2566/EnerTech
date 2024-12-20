USE [master]
GO
/****** Object:  Database [EnerTech]    Script Date: 27/11/2024 08:06:31 ******/
CREATE DATABASE [EnerTech]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnerTech', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EnerTech.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EnerTech_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EnerTech_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EnerTech] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EnerTech].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EnerTech] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EnerTech] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EnerTech] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EnerTech] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EnerTech] SET ARITHABORT OFF 
GO
ALTER DATABASE [EnerTech] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EnerTech] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EnerTech] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EnerTech] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EnerTech] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EnerTech] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EnerTech] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EnerTech] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EnerTech] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EnerTech] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EnerTech] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EnerTech] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EnerTech] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EnerTech] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EnerTech] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EnerTech] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EnerTech] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EnerTech] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EnerTech] SET  MULTI_USER 
GO
ALTER DATABASE [EnerTech] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EnerTech] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EnerTech] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EnerTech] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EnerTech] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EnerTech] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EnerTech] SET QUERY_STORE = ON
GO
ALTER DATABASE [EnerTech] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EnerTech]
GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora](
	[id_bitacora] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[Detalle] [nvarchar](200) NOT NULL,
	[Criticidad] [nvarchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[id_bitacora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[id_carrito] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Carrito] PRIMARY KEY CLUSTERED 
(
	[id_carrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Venta]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Venta](
	[id_detalle_venta] [int] IDENTITY(1,1) NOT NULL,
	[id_venta] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[Codigo] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](300) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[IVA] [float] NOT NULL,
	[CodigoIVA] [int] NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Detalle_Venta] PRIMARY KEY CLUSTERED 
(
	[id_detalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DigitoVerificador]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DigitoVerificador](
	[nombre_tabla] [nvarchar](50) NOT NULL,
	[valorDVV] [bigint] NULL,
	[id_DV] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_DigitoVerificador] PRIMARY KEY CLUSTERED 
(
	[id_DV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FamiliaPatente]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FamiliaPatente](
	[Id_Padre] [int] NOT NULL,
	[Id_Hijo] [int] NOT NULL,
	[DVH] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marca]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marca](
	[id_marca] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Marca] PRIMARY KEY CLUSTERED 
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permiso]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permiso](
	[Id_Permiso] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Permiso] [nvarchar](200) NULL,
	[DVH] [nvarchar](500) NULL,
 CONSTRAINT [PK_Permiso] PRIMARY KEY CLUSTERED 
(
	[Id_Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](300) NOT NULL,
	[id_marca] [int] NOT NULL,
	[id_categoria] [int] NOT NULL,
	[Catalogo] [bit] NOT NULL,
	[Imagen] [nvarchar](500) NULL,
	[Cantidad] [int] NOT NULL,
	[Precio] [float] NULL,
	[codigo_iva] [int] NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelatedTaxes]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelatedTaxes](
	[id_relatedtaxes] [int] IDENTITY(1,1) NOT NULL,
	[codigoIVA] [int] NOT NULL,
	[TasaIVA] [float] NOT NULL,
	[BaseImponible] [float] NOT NULL,
	[TotalIVA] [float] NOT NULL,
	[id_venta] [int] NOT NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_RelatedTaxes] PRIMARY KEY CLUSTERED 
(
	[id_relatedtaxes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tokenAFIP]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tokenAFIP](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sign] [nvarchar](1000) NOT NULL,
	[token] [nvarchar](1000) NOT NULL,
	[FechaExpiracion] [datetime] NOT NULL,
	[codigo] [int] NOT NULL,
	[FechaGeneracion] [datetime] NULL,
 CONSTRAINT [PK_tokenAFIP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RazonSocial] [nvarchar](200) NULL,
	[Identificacion] [int] NOT NULL,
	[Contador] [int] NOT NULL,
	[Estado] [nvarchar](50) NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Apellido] [nvarchar](50) NOT NULL,
	[TipoDocumento] [nvarchar](50) NULL,
	[TipoCliente] [nvarchar](50) NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioPermiso]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioPermiso](
	[Id_Usuario_Permiso] [int] IDENTITY(1,1) NOT NULL,
	[Id_usuario] [int] NOT NULL,
	[Id_Patente] [int] NOT NULL,
	[DVH] [nvarchar](500) NULL,
 CONSTRAINT [PK_UsuarioPermiso] PRIMARY KEY CLUSTERED 
(
	[Id_Usuario_Permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 27/11/2024 08:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[id_venta] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Detalle] [nvarchar](300) NOT NULL,
	[CodigoAutorizacion] [bigint] NULL,
	[FechaVtoCae] [datetime] NULL,
	[PuntoDeVenta] [int] NULL,
	[NumeroVenta] [int] NULL,
	[id_usuario] [int] NOT NULL,
	[TipoComprobante] [nvarchar](50) NULL,
	[Total] [float] NOT NULL,
	[IVA] [float] NOT NULL,
	[TotalGravado] [float] NOT NULL,
	[TipoAutorizacion] [nvarchar](50) NULL,
	[Estado] [nvarchar](5) NULL,
	[Observaciones] [nvarchar](500) NULL,
	[Facturado] [bit] NULL,
	[QRData] [nvarchar](1000) NULL,
	[DVH] [bigint] NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58063, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:55:36.140' AS DateTime), 110468)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58064, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:56:37.677' AS DateTime), 109176)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58065, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:56:44.010' AS DateTime), 109137)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58066, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:57:01.787' AS DateTime), 110351)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58067, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:57:16.850' AS DateTime), 110464)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58068, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:57:39.453' AS DateTime), 109230)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58069, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:58:02.400' AS DateTime), 109059)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58070, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:58:03.580' AS DateTime), 109078)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58071, 3, N'UAC@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T18:58:04.403' AS DateTime), 71328)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58072, 3, N'UAC@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T18:58:06.293' AS DateTime), 71366)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58073, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:58:25.807' AS DateTime), 137567)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58074, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T18:58:25.810' AS DateTime), 185301)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58075, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:58:39.747' AS DateTime), 137661)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58076, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T18:58:39.753' AS DateTime), 185395)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58077, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:59:16.667' AS DateTime), 109169)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58078, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:59:26.800' AS DateTime), 109187)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58079, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:59:31.467' AS DateTime), 110437)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58080, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T18:59:44.757' AS DateTime), 109185)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58081, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T18:59:53.567' AS DateTime), 128138)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58082, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T18:59:53.573' AS DateTime), 185333)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58083, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:07:59.780' AS DateTime), 110531)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58084, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:08:12.900' AS DateTime), 110342)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58085, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:08:18.187' AS DateTime), 109129)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58086, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:08:25.183' AS DateTime), 128044)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58087, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:08:25.190' AS DateTime), 185239)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58088, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:09:33.167' AS DateTime), 137501)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58089, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:09:33.173' AS DateTime), 185235)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58090, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:09:42.367' AS DateTime), 110412)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58091, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:09:42.373' AS DateTime), 185234)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58092, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:09:52.097' AS DateTime), 137518)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58093, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:09:52.103' AS DateTime), 185252)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58094, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:10:22.843' AS DateTime), 135558)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58095, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:10:29.830' AS DateTime), 137468)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58096, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:10:29.837' AS DateTime), 185202)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58097, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:10:50.727' AS DateTime), 137351)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58098, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:11:03.080' AS DateTime), 110246)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58099, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:11:13.297' AS DateTime), 110264)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58100, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:12:01.413' AS DateTime), 108897)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58101, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:15:27.957' AS DateTime), 110422)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58102, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:15:35.420' AS DateTime), 109075)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58103, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:15:44.587' AS DateTime), 128028)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58104, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:15:44.593' AS DateTime), 185223)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58105, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:16:05.430' AS DateTime), 110364)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58106, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:16:32.723' AS DateTime), 109034)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58107, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:21:17.643' AS DateTime), 110355)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58108, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:21:24.893' AS DateTime), 108989)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58109, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:21:39.450' AS DateTime), 128056)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58110, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:21:47.913' AS DateTime), 109082)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58111, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:21:56.323' AS DateTime), 109081)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58112, 3, N'UAC@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T19:22:04.257' AS DateTime), 71200)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58113, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:22:12.817' AS DateTime), 127903)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58114, 3, N'UAC@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T19:22:19.567' AS DateTime), 71313)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58115, 3, N'UAC@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T19:22:22.817' AS DateTime), 71198)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58116, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:22:34.930' AS DateTime), 127977)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58117, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:22:43.643' AS DateTime), 137437)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58118, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:23:18.090' AS DateTime), 128033)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58119, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:23:18.097' AS DateTime), 185228)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58120, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:23:25.737' AS DateTime), 137455)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58121, 1, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:23:25.743' AS DateTime), 185189)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58122, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:23:37.027' AS DateTime), 110423)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58123, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T19:45:15.410' AS DateTime), 109084)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58124, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:45:20.227' AS DateTime), 110334)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58125, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:45:27.963' AS DateTime), 137555)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58126, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:45:48.863' AS DateTime), 110522)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58127, 1, N'El registro con id = 2 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:45:48.870' AS DateTime), 185322)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58128, 2, N'webmaster@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T19:45:54.380' AS DateTime), 92384)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58129, 2, N'webmaster@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-11-26T19:46:00.753' AS DateTime), 92234)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58130, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:46:20.930' AS DateTime), 137438)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58131, 1, N'El registro con id = 1 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T19:46:20.933' AS DateTime), 185128)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58132, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:46:34.147' AS DateTime), 110444)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58133, 0, N'123414 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-11-26T19:47:07.507' AS DateTime), 149792)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58134, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:47:13.317' AS DateTime), 110405)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58135, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T19:59:18.937' AS DateTime), 128174)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58136, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:00:15.193' AS DateTime), 110166)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58137, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:02:57.023' AS DateTime), 137396)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58138, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:03:14.390' AS DateTime), 110195)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58139, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:03:40.513' AS DateTime), 110173)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58140, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:07:41.133' AS DateTime), 110256)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58141, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:07:59.947' AS DateTime), 128053)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58142, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:08:13.837' AS DateTime), 110256)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58143, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:08:23.503' AS DateTime), 127901)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58144, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:08:43.230' AS DateTime), 110310)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58145, 1, N'Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: Carrito', N'ALTA', CAST(N'2024-11-26T20:08:43.230' AS DateTime), 492266)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58146, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:14:42.673' AS DateTime), 137330)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58147, 1, N'Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: Carrito', N'ALTA', CAST(N'2024-11-26T20:14:42.683' AS DateTime), 492198)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58148, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:15:45.853' AS DateTime), 137403)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58149, 1, N'Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: Carrito', N'ALTA', CAST(N'2024-11-26T20:15:45.857' AS DateTime), 492271)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58150, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:15:54.977' AS DateTime), 127941)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58151, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:16:23.180' AS DateTime), 110257)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58152, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:43:44.153' AS DateTime), 127936)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58153, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:44:49.270' AS DateTime), 128047)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58154, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:45:38.330' AS DateTime), 128026)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58155, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:46:36.317' AS DateTime), 128004)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58156, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:47:14.563' AS DateTime), 127946)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58157, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:48:44.073' AS DateTime), 128016)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58158, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:49:55.330' AS DateTime), 128069)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58159, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:50:35.523' AS DateTime), 127904)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58160, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T20:54:12.850' AS DateTime), 126248)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58161, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T20:54:17.147' AS DateTime), 126343)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58162, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:54:25.787' AS DateTime), 127950)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58163, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:54:44.817' AS DateTime), 110340)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58164, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T20:55:59.333' AS DateTime), 135780)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58165, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:56:07.123' AS DateTime), 137445)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58166, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:57:14.027' AS DateTime), 137422)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58167, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:58:29.277' AS DateTime), 137551)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58168, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:59:44.590' AS DateTime), 137508)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58169, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T20:59:56.657' AS DateTime), 128103)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58170, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:00:04.870' AS DateTime), 137230)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58171, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:01:21.817' AS DateTime), 127764)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58172, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:14:28.610' AS DateTime), 127960)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58173, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:25:06.433' AS DateTime), 110290)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58174, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:26:05.133' AS DateTime), 110287)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58175, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T21:26:52.260' AS DateTime), 108993)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58176, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:26:57.310' AS DateTime), 110415)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58177, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T21:27:18.253' AS DateTime), 109051)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58178, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:27:25.940' AS DateTime), 110339)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58179, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T21:28:27.857' AS DateTime), 109066)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58180, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:28:32.487' AS DateTime), 110316)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58181, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:29:07.210' AS DateTime), 110373)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58182, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:32:57.927' AS DateTime), 110366)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58183, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:34:30.703' AS DateTime), 110229)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58184, 1, N'El registro con id = 53 de la tabla Carrito no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:30.770' AS DateTime), 187876)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58185, 1, N'El registro con id = 6 de la tabla Detalle Venta no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:30.870' AS DateTime), 217093)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58186, 1, N'El registro con id = 4 de la tabla Taxes no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:30.873' AS DateTime), 171242)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58187, 1, N'El registro con id = 8 de la tabla Producto no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:30.883' AS DateTime), 190198)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58188, 1, N'El registro con id = 1 de la tabla Marcas no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:30.887' AS DateTime), 176273)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58189, 1, N'El registro con id = 1 de la tabla Categoria no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:30.890' AS DateTime), 194694)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58190, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:34:37.590' AS DateTime), 137450)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58191, 1, N'El registro con id = 53 de la tabla Carrito no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:37.630' AS DateTime), 188009)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58192, 1, N'El registro con id = 6 de la tabla Detalle Venta no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:37.720' AS DateTime), 217226)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58193, 1, N'El registro con id = 4 de la tabla Taxes no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:37.723' AS DateTime), 171375)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58194, 1, N'El registro con id = 8 de la tabla Producto no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:37.733' AS DateTime), 190331)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58195, 1, N'El registro con id = 1 de la tabla Marcas no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:37.733' AS DateTime), 176406)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58196, 1, N'El registro con id = 1 de la tabla Categoria no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:34:37.737' AS DateTime), 194827)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58197, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:35:20.123' AS DateTime), 127854)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58198, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:36:23.030' AS DateTime), 110300)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58199, 1, N'El registro con id = 53 de la tabla Carrito no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:23.093' AS DateTime), 187947)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58200, 1, N'El registro con id = 6 de la tabla Detalle Venta no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:23.190' AS DateTime), 217164)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58201, 1, N'El registro con id = 4 de la tabla Taxes no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:23.193' AS DateTime), 171313)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58202, 1, N'El registro con id = 8 de la tabla Producto no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:23.203' AS DateTime), 190269)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58203, 1, N'El registro con id = 1 de la tabla Marcas no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:23.203' AS DateTime), 176344)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58204, 1, N'El registro con id = 1 de la tabla Categoria no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:23.207' AS DateTime), 194765)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58205, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:36:28.750' AS DateTime), 137483)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58206, 1, N'El registro con id = 53 de la tabla Carrito no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:28.793' AS DateTime), 188042)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58207, 1, N'El registro con id = 6 de la tabla Detalle Venta no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:28.890' AS DateTime), 217259)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58208, 1, N'El registro con id = 4 de la tabla Taxes no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:28.893' AS DateTime), 171408)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58209, 1, N'El registro con id = 8 de la tabla Producto no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:28.900' AS DateTime), 190364)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58210, 1, N'El registro con id = 1 de la tabla Marcas no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:28.900' AS DateTime), 176439)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58211, 1, N'El registro con id = 1 de la tabla Categoria no es válido su DVH', N'ALTA', CAST(N'2024-11-26T21:36:28.903' AS DateTime), 194860)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58212, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:36:40.853' AS DateTime), 110279)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58213, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:37:28.207' AS DateTime), 110411)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58214, 1, N'Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: Producto', N'ALTA', CAST(N'2024-11-26T21:37:28.210' AS DateTime), 504886)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58215, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:37:34.683' AS DateTime), 137441)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58216, 1, N'Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: Producto', N'ALTA', CAST(N'2024-11-26T21:37:34.687' AS DateTime), 504828)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58217, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:38:33.407' AS DateTime), 137438)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58218, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T21:39:41.807' AS DateTime), 110346)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58219, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T22:13:03.447' AS DateTime), 110199)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58220, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T22:44:30.633' AS DateTime), 110257)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58221, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T23:23:02.573' AS DateTime), 110208)
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Carrito] ON 

INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad], [DVH]) VALUES (53, 9, 3, 1, 15703)
INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad], [DVH]) VALUES (54, 10, 3, 1, 15703)
INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad], [DVH]) VALUES (55, 11, 3, 1, 15703)
INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad], [DVH]) VALUES (66, 8, 3, 1, 15703)
SET IDENTITY_INSERT [dbo].[Carrito] OFF
GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([id_categoria], [Nombre], [DVH]) VALUES (1, N'Sensores', 3941)
INSERT [dbo].[Categoria] ([id_categoria], [Nombre], [DVH]) VALUES (2, N'PLC', 433)
INSERT [dbo].[Categoria] ([id_categoria], [Nombre], [DVH]) VALUES (3, N'Cables', 2182)
INSERT [dbo].[Categoria] ([id_categoria], [Nombre], [DVH]) VALUES (4, N'CNC', 424)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Detalle_Venta] ON 

INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (6, 4, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (7, 4, 11, N'S004', N'Sensor 4', 4, 12000, 48000, 8330.58, 5, 32523)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (8, 4, 15, N'P003', N'PLC 3', 3, 58000, 174000, 30198.35, 5, 31104)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (9, 5, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4, 32516)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (10, 5, 9, N'S002', N'Sensor 2', 2, 25000, 50000, 8677.69, 5, 32548)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (11, 5, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5, 30393)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (12, 6, 9, N'S002', N'Sensor 2', 4, 25000, 100000, 17355.37, 5, 33194)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (13, 6, 21, N'CNC003', N'CNC 3', 1, 550000, 550000, 95454.55, 5, 32004)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (14, 7, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (15, 7, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (16, 7, 13, N'P001', N'PLC 1', 3, 95000, 285000, 49462.81, 5, 31079)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (17, 8, 13, N'P001', N'PLC 1', 3, 95000, 285000, 49462.81, 5, 31079)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (18, 8, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5, 32494)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (19, 12, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4, 32516)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (20, 12, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (21, 12, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (22, 12, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5, 30393)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (23, 13, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4, 32516)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (24, 13, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (25, 13, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (26, 13, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5, 32494)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (27, 13, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5, 31307)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (28, 14, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4, 32516)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (29, 14, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5, 30393)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (30, 14, 18, N'C001', N'Cable 1', 1, 12000, 12000, 2082.64, 5, 31539)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (31, 14, 15, N'P003', N'PLC 3', 1, 58000, 58000, 10066.12, 5, 30743)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (32, 15, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (33, 15, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (34, 15, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5, 31307)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (35, 15, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5, 30393)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (36, 15, 16, N'P004', N'PLC 4', 1, 45000, 45000, 7809.92, 5, 30405)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (37, 16, 20, N'CNC002', N'CNC 2', 1, 450000, 450000, 78099.17, 5, 32012)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (38, 16, 21, N'CNC003', N'CNC 3', 1, 550000, 550000, 95454.55, 5, 32004)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (39, 16, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5, 31307)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (40, 17, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (41, 17, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (42, 17, 17, N'P005', N'PLC 5', 1, 90000, 90000, 15619.83, 5, 30817)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (43, 18, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (44, 18, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (45, 18, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5, 32494)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (46, 18, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5, 30393)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (47, 19, 9, N'S002', N'Sensor 2', 3, 25000, 75000, 13016.53, 5, 32875)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (48, 19, 10, N'S003', N'Sensor 3', 2, 54000, 108000, 18743.8, 5, 32824)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (49, 19, 11, N'S004', N'Sensor 4', 2, 12000, 24000, 4165.29, 5, 32521)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (50, 20, 9, N'S002', N'Sensor 2', 3, 25000, 75000, 13016.53, 5, 32875)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (51, 20, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (52, 20, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5, 32494)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (53, 21, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (54, 21, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4, 32516)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (55, 22, 8, N'S001', N'Sensor 1', 3, 35000, 105000, 9977.38, 4, 32819)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (56, 22, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (57, 22, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5, 31307)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (58, 23, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 6074.38, 5, 32493)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (59, 23, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5, 32513)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (60, 23, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (61, 24, 9, N'S002', N'Sensor 2', 5, 25000, 125000, 21694.21, 5, 33168)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (62, 24, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5, 32158)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (63, 24, 11, N'S004', N'Sensor 4', 4, 12000, 48000, 8330.58, 5, 32523)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (64, 25, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 6074.38, 5, 32493)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (65, 25, 10, N'S003', N'Sensor 3', 4, 54000, 216000, 37487.6, 5, 32836)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (82, 34, 10, N'S003', N'Sensor 3', 4, 54000, 216000, 37487.6, 5, 32836)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA], [DVH]) VALUES (83, 34, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5, 32494)
SET IDENTITY_INSERT [dbo].[Detalle_Venta] OFF
GO
SET IDENTITY_INSERT [dbo].[DigitoVerificador] ON 

INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Usuario', 1327226, 2)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Bitacora', 23243127, 7)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Carrito', 62812, 8)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Venta', 70566838, 12)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Detalle_Venta', 1987754, 13)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'RelatedTaxes', 109162, 14)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Producto', 737601, 15)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Marca', 13817, 16)
INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Categoria', 6980, 17)
SET IDENTITY_INSERT [dbo].[DigitoVerificador] OFF
GO
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3015, 2, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3015, 3, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (4008, 2, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (4008, 3, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 1, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 2, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 3, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 5, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 6, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 7, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 8, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4002, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4003, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4004, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4005, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4006, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3013, 4007, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3015, 4007, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (3014, 1, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (4008, 4, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (4009, 4, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (4009, 5, NULL)
INSERT [dbo].[FamiliaPatente] ([Id_Padre], [Id_Hijo], [DVH]) VALUES (4009, 6, NULL)
GO
SET IDENTITY_INSERT [dbo].[Marca] ON 

INSERT [dbo].[Marca] ([id_marca], [Nombre], [DVH]) VALUES (1, N'Samsung', 3030)
INSERT [dbo].[Marca] ([id_marca], [Nombre], [DVH]) VALUES (2, N'Siemens', 3002)
INSERT [dbo].[Marca] ([id_marca], [Nombre], [DVH]) VALUES (3, N'Keyence', 2895)
INSERT [dbo].[Marca] ([id_marca], [Nombre], [DVH]) VALUES (4, N'Honeywell', 4890)
SET IDENTITY_INSERT [dbo].[Marca] OFF
GO
SET IDENTITY_INSERT [dbo].[Permiso] ON 

INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (1, N'Administración de Familias', N'AdministracionFamilias', N'NkYKEpPCTlBJh7koORIR9w==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (2, N'Alta de Familia', N'AltaFamilia', N'VKrGJmnlEZnGxI6FEaSXtg==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (3, N'Modificación de Familia', N'ModificarFamilia', N'BGypysiCmUzGqgMzaTwrgA==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4, N'Baja de Familia', N'BajaFamilia', N'6FIhoFyDbINJQB1JAd+faw==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (5, N'Asignación de Familias', N'AsignarFamilias', N'oXFVhn328ANyjfiUT+pB6Q==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (6, N'Asignación de Patentes', N'AsignarPatentes', N'cqx/N3jiVcBr0D8c9jyCMg==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (7, N'Desasignación de Familias', N'DesasignarFamilias', N'd2bWbNYYK7FWdDl2f2NzyQ==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (8, N'Desasignación de Patentes', N'DesasignarPatentes', N'gUdUkF2AcwFtalnzJuzu3w==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (3013, N'Webmaster', NULL, N'tHGeMoy+oNkXISIeKjJGRQ==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (3014, N'Administrador Financiero Contable', NULL, N'M1i9wYXoSqWsebYpjj7L4g==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (3015, N'Cliente', NULL, N'tlwjAhHKLgdU6JIhE+mp4Q==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4002, N'Visualizar Bitacora', N'VisualizarBitacora', N'eOzIhzc+l3q2zKlqAnrM8Q==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4003, N'Administración de Usuarios', N'AdministracionUsuarios', N'xHScjTRI3Fs2NG9dGBJ2RQ==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4004, N'Alta de Usuario', N'AltaUsuario', N'5xqJkxYpG6t3X4qmYbsK6w==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4005, N'Modificación de Usuario', N'ModificacionUsuario', N'AneHXrjLfhiP6LEI+4xpRQ==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4006, N'Baja de Usuario', N'BajaUsuario', N'qkzaXe2Vo7PstayMRoo98A==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4007, N'Administración de Base de Datos', N'AdministracionBaseDeDatos', N'+nXlFpJMylclWdhe1+hkaw==')
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4008, N'FamiliaPrueba', NULL, NULL)
INSERT [dbo].[Permiso] ([Id_Permiso], [Nombre], [Permiso], [DVH]) VALUES (4009, N'Pepe', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Permiso] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (8, N'S001', N'Sensor 1', 2, 1, 1, N'~/Images/S001.jpg', 45, 35000, 5, 44819)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (9, N'S002', N'Sensor 2', 2, 1, 1, N'~/Images/S002.jpg', 6, 25000, 5, 44739)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (10, N'S003', N'Sensor 3', 3, 1, 1, N'~/Images/S003.jpg', 21, 54000, 5, 44859)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (11, N'S004', N'Sensor 4', 1, 1, 1, N'~/Images/S004.jpg', 5, 12000, 5, 44781)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (12, N'S005', N'Sensor 5', 4, 1, 1, N'~/Images/S005.jpg', 0, 87000, 5, 44818)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (13, N'P001', N'PLC 1', 1, 2, 1, N'~/Images/P001.jpg', 3, 95000, 5, 42561)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (14, N'P002', N'PLC 2', 2, 2, 1, N'~/Images/P002.jpg', 6, 105000, 5, 42871)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (15, N'P003', N'PLC 3', 4, 2, 1, N'~/Images/P003.jpg', 2, 58000, 5, 42606)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (16, N'P004', N'PLC 4', 1, 2, 1, N'~/Images/P004.jpg', 21, 45000, 5, 42719)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (17, N'P005', N'PLC 5', 1, 2, 1, N'~/Images/P005.jpg', 3, 90000, 5, 42639)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (18, N'C001', N'Cable 1', 3, 3, 1, N'~/Images/C001.jpg', 90, 12000, 5, 43727)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (19, N'CNC001', N'CNC 1', 1, 4, 1, N'~/Images/CN001.jpg', 3, 300000, 5, 44698)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (20, N'CNC002', N'CNC 2', 4, 4, 1, N'~/Images/CN002.jpg', 4, 450000, 5, 44735)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (21, N'CNC003', N'CNC 3', 3, 4, 1, N'~/Images/CN003.jpg', 6, 550000, 5, 44763)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (22, N'CNC004', N'CNC 4', 2, 4, 1, N'~/Images/CN004.jpg', 2, 460000, 5, 44785)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (23, N'CNC005', N'CNC 5', 4, 4, 1, N'~/Images/CN005.jpg', 0, 520000, 5, 44801)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva], [DVH]) VALUES (24, N'S10', N'Sensor 10', 1, 1, 1, N'', 44, 45000, 5, 32680)
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[RelatedTaxes] ON 

INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (4, 5, 21, 228099.17, 47900.83, 4, 4388)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (5, 4, 10.5, 31674.21, 3325.79, 5, 3830)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (6, 5, 21, 119834.71, 25165.29, 5, 4379)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (7, 5, 21, 537190.08, 112809.92, 6, 4831)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (8, 5, 21, 300826.45, 63173.55, 7, 4354)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (9, 5, 21, 245454.55, 51545.45, 8, 4369)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (10, 4, 10.5, 31674.21, 3325.79, 12, 3830)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (11, 5, 21, 143801.65, 30198.35, 12, 4355)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (12, 4, 10.5, 31674.21, 3325.79, 13, 3830)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (13, 5, 21, 161983.47, 34016.53, 13, 4372)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (14, 4, 10.5, 31674.21, 3325.79, 14, 3830)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (15, 5, 21, 136363.64, 28636.36, 14, 4379)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (16, 5, 21, 267768.6, 56231.4, 15, 3504)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (17, 5, 21, 913223.14, 191776.86, 16, 4832)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (18, 5, 21, 139669.42, 29330.58, 17, 4395)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (19, 5, 21, 153719.01, 32280.99, 18, 4359)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (20, 5, 21, 171074.38, 35925.62, 19, 4367)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (21, 5, 21, 116528.93, 24471.07, 20, 4372)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (22, 5, 21, 20661.16, 4338.84, 21, 3482)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (23, 4, 10.5, 31674.21, 3325.79, 21, 3830)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (24, 4, 10.5, 95022.62, 9977.38, 22, 3842)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (25, 5, 21, 107438.02, 22561.98, 22, 4359)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (26, 5, 21, 94214.88, 19785.12, 23, 3920)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (27, 5, 21, 187603.31, 39396.69, 24, 4386)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (28, 5, 21, 207438.02, 43561.98, 25, 4364)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta], [DVH]) VALUES (37, 5, 21, 188429.75, 39570.25, 34, 4403)
SET IDENTITY_INSERT [dbo].[RelatedTaxes] OFF
GO
SET IDENTITY_INSERT [dbo].[tokenAFIP] ON 

INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (3, N'pbaeGF2SmiYdVjWebSQKbewq7Rb//tv+bVTTFlCQRaPCQr+xwH+gZ4n7zs4/5EkWQstLadM0rWwFHA9Ss4OYsrMvDEAXqf3tBESk/Mqk8R3D2sdtUlXd6Lxl5oo7x0D7jDBxIdGZ/AhY/WqpP5Ax1v3Ult7OUVAL2L2k96NXj6Q=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iOTY0MDgwMDg3IiBnZW5fdGltZT0iMTczMTEwMTc1MSIgZXhwX3RpbWU9IjE3MzExNDUwMTEiLz4KICAgIDxvcGVyYXRpb24gdHlwZT0ibG9naW4iIHZhbHVlPSJncmFudGVkIj4KICAgICAgICA8bG9naW4gZW50aXR5PSIzMzY5MzQ1MDIzOSIgc2VydmljZT0id3NmZSIgdWlkPSJTRVJJQUxOVU1CRVI9Q1VJVCAyMDM1ODU0NTQ5MiwgQ049dGZpIiBhdXRobWV0aG9kPSJjbXMiIHJlZ21ldGhvZD0iMjIiPgogICAgICAgICAgICA8cmVsYXRpb25zPgogICAgICAgICAgICAgICAgPHJlbGF0aW9uIGtleT0iMjAzNTg1NDU0OTIiIHJlbHR5cGU9IjQiLz4KICAgICAgICAgICAgPC9yZWxhdGlvbnM+CiAgICAgICAgPC9sb2dpbj4KICAgIDwvb3BlcmF0aW9uPgo8L3Nzbz4K', CAST(N'2024-11-09T06:36:51.960' AS DateTime), 1, CAST(N'2024-11-08T18:36:51.960' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (4, N'XNXDIYHNaiozZBC0sPRoEWkXmYY62IV11QIxaRS/RNpH5xfETgtdGFmvKWIoZvQ4TFEEuXC/4ooQJ+V+JCrVYO2GHn9BbH1tT9QiS3Uj68iSz0diA81r17w8qsYTkWSfoTN+HNAMVAmaF3yWHNhICMpAqb2uklLfaGJNfa0z2FA=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iNzE1NzgxNjAiIGdlbl90aW1lPSIxNzMxMjQ2NjA1IiBleHBfdGltZT0iMTczMTI4OTg2NSIvPgogICAgPG9wZXJhdGlvbiB0eXBlPSJsb2dpbiIgdmFsdWU9ImdyYW50ZWQiPgogICAgICAgIDxsb2dpbiBlbnRpdHk9IjMzNjkzNDUwMjM5IiBzZXJ2aWNlPSJ3c2ZlIiB1aWQ9IlNFUklBTE5VTUJFUj1DVUlUIDIwMzU4NTQ1NDkyLCBDTj10ZmkiIGF1dGhtZXRob2Q9ImNtcyIgcmVnbWV0aG9kPSIyMiI+CiAgICAgICAgICAgIDxyZWxhdGlvbnM+CiAgICAgICAgICAgICAgICA8cmVsYXRpb24ga2V5PSIyMDM1ODU0NTQ5MiIgcmVsdHlwZT0iNCIvPgogICAgICAgICAgICA8L3JlbGF0aW9ucz4KICAgICAgICA8L2xvZ2luPgogICAgPC9vcGVyYXRpb24+Cjwvc3NvPgo=', CAST(N'2024-11-10T22:51:05.837' AS DateTime), 1, CAST(N'2024-11-10T10:51:05.837' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (5, N'BNOmLoBs9Ar1L61wCMnO8d4WbjFAZc3E3DnaWBq1nphS8e9bSElCNJLpR//JIzqUTt2VCbNzskM0CBTBJ/WeWj3n/Qx8xL2uwCQ/ztmXNFMg8cg7/cm7NoGoP1bZyX1wdWWfhzX+JwnbD8EE36uqBaFEFpBIzgpGb9emzt5P7Q0=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iMzE5NDU3NjQ4OSIgZ2VuX3RpbWU9IjE3MzE0MTM4ODUiIGV4cF90aW1lPSIxNzMxNDU3MTQ1Ii8+CiAgICA8b3BlcmF0aW9uIHR5cGU9ImxvZ2luIiB2YWx1ZT0iZ3JhbnRlZCI+CiAgICAgICAgPGxvZ2luIGVudGl0eT0iMzM2OTM0NTAyMzkiIHNlcnZpY2U9IndzZmUiIHVpZD0iU0VSSUFMTlVNQkVSPUNVSVQgMjAzNTg1NDU0OTIsIENOPXRmaSIgYXV0aG1ldGhvZD0iY21zIiByZWdtZXRob2Q9IjIyIj4KICAgICAgICAgICAgPHJlbGF0aW9ucz4KICAgICAgICAgICAgICAgIDxyZWxhdGlvbiBrZXk9IjIwMzU4NTQ1NDkyIiByZWx0eXBlPSI0Ii8+CiAgICAgICAgICAgIDwvcmVsYXRpb25zPgogICAgICAgIDwvbG9naW4+CiAgICA8L29wZXJhdGlvbj4KPC9zc28+Cg==', CAST(N'2024-11-12T21:19:05.157' AS DateTime), 1, CAST(N'2024-11-12T09:19:05.157' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (6, N'fVeiFzJx0VelXxwgWBWIEDGI9Vpz5SccpngNvsKCMPvkt8/BDenIvGHHMZlAxS4Y6dgwX7o/jE7c5Qe4G7nlGre9B+km9a+iu9hG8jKZ73966czkuioYKRAIjUA3tbVjEtomCM/RBx4KN/nOq6XT0UddkcbzX06q3iEXggEspBk=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iMzE2NDQ2NTQ5OSIgZ2VuX3RpbWU9IjE3MzE1MjI4MzUiIGV4cF90aW1lPSIxNzMxNTY2MDk1Ii8+CiAgICA8b3BlcmF0aW9uIHR5cGU9ImxvZ2luIiB2YWx1ZT0iZ3JhbnRlZCI+CiAgICAgICAgPGxvZ2luIGVudGl0eT0iMzM2OTM0NTAyMzkiIHNlcnZpY2U9IndzZmUiIHVpZD0iU0VSSUFMTlVNQkVSPUNVSVQgMjAzNTg1NDU0OTIsIENOPXRmaSIgYXV0aG1ldGhvZD0iY21zIiByZWdtZXRob2Q9IjIyIj4KICAgICAgICAgICAgPHJlbGF0aW9ucz4KICAgICAgICAgICAgICAgIDxyZWxhdGlvbiBrZXk9IjIwMzU4NTQ1NDkyIiByZWx0eXBlPSI0Ii8+CiAgICAgICAgICAgIDwvcmVsYXRpb25zPgogICAgICAgIDwvbG9naW4+CiAgICA8L29wZXJhdGlvbj4KPC9zc28+Cg==', CAST(N'2024-11-14T03:34:55.963' AS DateTime), 1, CAST(N'2024-11-13T15:34:55.963' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (7, N'RA4VKdnj1qWXIq+tPQNLX0be7hBYT0D7wTkqRb3o0VHj81hTX6yhe9P1giu6C+3NQvxw+PLavH9EX1AdwgTNSd+OD2gbp+vZfa/i7RAAbiGiW2aj3WF3i+lai5F9TxJB6D6KB9+XhJyLIM9WYzVyZnmgpnklZr4zb+qywZz0h6M=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iMjcwMTQ1Mzg5NiIgZ2VuX3RpbWU9IjE3MzI1NzQyMzEiIGV4cF90aW1lPSIxNzMyNjE3NDkxIi8+CiAgICA8b3BlcmF0aW9uIHR5cGU9ImxvZ2luIiB2YWx1ZT0iZ3JhbnRlZCI+CiAgICAgICAgPGxvZ2luIGVudGl0eT0iMzM2OTM0NTAyMzkiIHNlcnZpY2U9IndzZmUiIHVpZD0iU0VSSUFMTlVNQkVSPUNVSVQgMjAzNTg1NDU0OTIsIENOPXRmaSIgYXV0aG1ldGhvZD0iY21zIiByZWdtZXRob2Q9IjIyIj4KICAgICAgICAgICAgPHJlbGF0aW9ucz4KICAgICAgICAgICAgICAgIDxyZWxhdGlvbiBrZXk9IjIwMzU4NTQ1NDkyIiByZWx0eXBlPSI0Ii8+CiAgICAgICAgICAgIDwvcmVsYXRpb25zPgogICAgICAgIDwvbG9naW4+CiAgICA8L29wZXJhdGlvbj4KPC9zc28+Cg==', CAST(N'2024-11-26T07:38:11.430' AS DateTime), 1, CAST(N'2024-11-25T19:38:11.430' AS DateTime))
SET IDENTITY_INSERT [dbo].[tokenAFIP] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (1, N'cnJAZ21haWwuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Rodrigo', 1111, 2, N'Activo', N'Um9kcmlnbw==', N'R29uemFsZXo=', N'DNI', N'Consumidor Final', 132210)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (2, N'd2VibWFzdGVyQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'WebMaster', 1111111, 0, N'Activo', N'V2ViTWFzdGVy', N'V2ViTWFzdGVy', N'DNI', N'Consumidor Final', 160166)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (3, N'VUFDQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Usuario Administrador Contable(UAC)', 4114, 0, N'Activo', N'VUFD', N'VUFD', N'DNI', N'Consumidor Final', 179313)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (4, N'Q2xpZW50ZUBnbWFpbC5jb20=', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Cliente', 2131, 0, N'Activo', N'Q2xpZW50ZQ==', N'Q2xpZW50ZQ==', N'DNI', N'Consumidor Final', 141204)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (6, N'ZHZAZHYuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'a', 123, 0, N'Activo', N'YWE=', N'YWE=', N'DNI', N'Consumidor Final', 111145)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (7, N'ZGRAZGQuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asda', 123123, 0, N'Activo', N'YXNkYQ==', N'YXNkYXNk', N'DNI', N'Consumidor Final', 117374)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (8, N'ZGRkZEBkYWQuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asdasd', 24412, 0, N'Activo', N'c2Rh', N'ZGFzZGE=', N'DNI', N'Consumidor Final', 120999)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (9, N'YWFkQGFhLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asda', 41241, 0, N'Activo', N'YXNkYQ==', N'YWRhZA==', N'DNI', N'Consumidor Final', 121415)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (10, N'a2tAa2suY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'erqwr', 99999, 0, N'Activo', N'ZGFzZHM=', N'ZGFzZA==', N'DNI', N'Consumidor Final', 117537)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (11, N'ZHZ2dnZAYWRzYS5jb20=', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asdas', 123414, 0, N'Activo', N'YXNk', N'YXNkYXM=', N'DNI', N'Consumidor Final', 125863)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[UsuarioPermiso] ON 

INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (36, 2, 3013, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (37, 2, 3013, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (43, 4, 1, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (44, 4, 1, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (45, 4, 7, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (46, 4, 3015, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (55, 3, 1, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (56, 3, 2, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (57, 3, 3014, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (58, 3, 3014, N'1')
INSERT [dbo].[UsuarioPermiso] ([Id_Usuario_Permiso], [Id_usuario], [Id_Patente], [DVH]) VALUES (68, 1, 3, N'1')
SET IDENTITY_INSERT [dbo].[UsuarioPermiso] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (4, CAST(N'2024-10-30T15:52:20.000' AS DateTime), N'Venta', 74452204481671, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 14, 4, N'6', 276000, 47900.83, 228099.17, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130706)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (5, CAST(N'2024-10-30T17:01:30.000' AS DateTime), N'Venta', 74452204478641, CAST(N'2024-11-18T00:00:00.000' AS DateTime), 1, 9, 4, N'6', 180000, 28491.08, 151508.92, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130554)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (6, CAST(N'2024-10-30T19:38:19.000' AS DateTime), N'Venta', 74452204479228, CAST(N'2024-11-18T00:00:00.000' AS DateTime), 1, 10, 4, N'6', 650000, 112809.92, 537190.08, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4131455)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (7, CAST(N'2024-10-30T19:40:06.000' AS DateTime), N'Venta', 74452204481537, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 13, 4, N'6', 364000, 63173.55, 300826.45, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130766)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (8, CAST(N'2024-10-30T20:02:46.000' AS DateTime), N'Venta', 74452204481511, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 12, 4, N'6', 297000, 51545.45, 245454.55, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130622)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (12, CAST(N'2024-11-09T02:22:59.000' AS DateTime), N'Venta', 74452204481906, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 15, 3, N'6', 209000, 33524.14, 175475.86, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130862)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (13, CAST(N'2024-11-09T02:24:54.000' AS DateTime), N'Venta', 74452204481951, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 16, 3, N'6', 231000, 37342.32, 193657.68, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130786)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (14, CAST(N'2024-11-09T02:27:12.000' AS DateTime), N'Venta', 74452204481964, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 17, 3, N'6', 200000, 31962.15, 168037.85, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130760)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (15, CAST(N'2024-11-09T02:27:43.000' AS DateTime), N'Venta', 74452204481977, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 18, 3, N'6', 324000, 56231.4, 267768.6, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130032)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (16, CAST(N'2024-11-09T02:31:49.000' AS DateTime), N'Venta', 74452204482363, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 19, 3, N'6', 1105000, 191776.86, 913223.14, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4131605)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (17, CAST(N'2024-11-09T03:25:01.000' AS DateTime), N'Venta', 74452204482787, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 22, 3, N'6', 169000, 29330.58, 139669.42, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=', 4130804)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (18, CAST(N'2024-11-10T10:50:51.000' AS DateTime), N'Venta', 74452204513996, CAST(N'2024-11-20T00:00:00.000' AS DateTime), 1, 23, 3, N'6', 186000, 32280.99, 153719.01, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMCIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMywiaW1wb3J0ZSI6MTg2MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDUxMzk5Nn0=', 4181044)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (19, CAST(N'2024-11-12T09:07:24.000' AS DateTime), N'Venta', 74462204758762, CAST(N'2024-11-22T00:00:00.000' AS DateTime), 1, 24, 3, N'6', 207000, 35925.62, 171074.38, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMiIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyNCwiaW1wb3J0ZSI6MjA3MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDc1ODc2Mn0=', 4137329)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (20, CAST(N'2024-11-13T15:34:21.000' AS DateTime), N'Venta', 74462204866838, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 29, 4, N'6', 141000, 24471.07, 116528.93, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyOSwiaW1wb3J0ZSI6MTQxMDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDg2NjgzOH0=', 4186645)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (21, CAST(N'2024-11-13T15:37:07.000' AS DateTime), N'Venta', 74462204941203, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 30, 4, N'6', 60000, 7664.63, 52335.37, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozMCwiaW1wb3J0ZSI6NjAwMDAuMCwibW9uZWRhIjoiUEVTIiwiY3R6IjoxLjAsInRpcG9Eb2NSZWMiOjk2LCJucm9Eb2NSZWMiOjMzMzMzMywidGlwb0NvZEF1dCI6IkUiLCJjb2RBdXQiOjc0NDYyMjA0OTQxMjAzfQ==', 4194648)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (22, CAST(N'2024-11-13T17:45:21.000' AS DateTime), N'Venta', 74462204941305, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 31, 4, N'6', 235000, 32539.36, 202460.64, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozMSwiaW1wb3J0ZSI6MjM1MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDk0MTMwNX0=', 4166953)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (23, CAST(N'2024-11-25T19:35:13.000' AS DateTime), N'Venta', 74482208760411, CAST(N'2024-12-05T00:00:00.000' AS DateTime), 1, 36, 4, N'6', 114000, 19785.12, 94214.88, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0yNSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozNiwiaW1wb3J0ZSI6MTE0MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ4MjIwODc2MDQxMX0=', 4157780)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (24, CAST(N'2024-11-26T20:08:35.000' AS DateTime), N'Venta', NULL, NULL, NULL, NULL, 4, NULL, 227000, 39396.69, 187603.31, NULL, NULL, NULL, 0, NULL, 34546)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (25, CAST(N'2024-11-26T20:16:11.000' AS DateTime), N'Venta', NULL, NULL, NULL, NULL, 4, NULL, 251000, 43561.98, 207438.02, NULL, NULL, NULL, 0, NULL, 34383)
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData], [DVH]) VALUES (34, CAST(N'2024-11-26T20:54:34.000' AS DateTime), N'Venta', NULL, NULL, NULL, NULL, 4, NULL, 228000, 39570.25, 188429.75, NULL, NULL, NULL, 0, NULL, 34558)
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
USE [master]
GO
ALTER DATABASE [EnerTech] SET  READ_WRITE 
GO
