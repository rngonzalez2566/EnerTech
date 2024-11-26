USE [master]
GO
/****** Object:  Database [EnerTech]    Script Date: 26/11/2024 12:42:31 ******/
CREATE DATABASE [EnerTech]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnerTech', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS04\MSSQL\DATA\EnerTech.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EnerTech_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS04\MSSQL\DATA\EnerTech_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 26/11/2024 12:42:31 ******/
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
	[DVH] [int] NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[id_bitacora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 26/11/2024 12:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[id_carrito] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_Carrito] PRIMARY KEY CLUSTERED 
(
	[id_carrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 26/11/2024 12:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Venta]    Script Date: 26/11/2024 12:42:31 ******/
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
 CONSTRAINT [PK_Detalle_Venta] PRIMARY KEY CLUSTERED 
(
	[id_detalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DigitoVerificador]    Script Date: 26/11/2024 12:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DigitoVerificador](
	[nombre_tabla] [nvarchar](50) NOT NULL,
	[valorDVV] [int] NULL,
	[id_DV] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_DigitoVerificador] PRIMARY KEY CLUSTERED 
(
	[id_DV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FamiliaPatente]    Script Date: 26/11/2024 12:42:31 ******/
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
/****** Object:  Table [dbo].[Marca]    Script Date: 26/11/2024 12:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marca](
	[id_marca] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Marca] PRIMARY KEY CLUSTERED 
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permiso]    Script Date: 26/11/2024 12:42:31 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 26/11/2024 12:42:31 ******/
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
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelatedTaxes]    Script Date: 26/11/2024 12:42:31 ******/
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
 CONSTRAINT [PK_RelatedTaxes] PRIMARY KEY CLUSTERED 
(
	[id_relatedtaxes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tokenAFIP]    Script Date: 26/11/2024 12:42:31 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 26/11/2024 12:42:31 ******/
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
	[DVH] [int] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioPermiso]    Script Date: 26/11/2024 12:42:31 ******/
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
/****** Object:  Table [dbo].[Venta]    Script Date: 26/11/2024 12:42:31 ******/
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
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (1, 0, N'1111 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T16:44:44.793' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (2, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T16:44:51.633' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (3, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T17:31:11.433' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (4, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T17:32:59.963' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (5, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T17:38:19.513' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (6, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T17:38:25.727' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (7, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T21:01:14.957' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (8, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T21:01:16.480' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (9, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T21:01:18.460' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (10, 1, N'rr@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-10-01T21:01:19.883' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (11, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:09:27.883' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (12, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:12:24.020' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (13, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:15:50.427' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (14, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:17:13.057' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (15, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:18:30.980' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (16, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:43:10.887' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (17, 0, N'1111111 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T21:44:29.443' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (18, 0, N'222222 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T21:45:01.940' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (19, 0, N'333333 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T21:45:24.523' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (20, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:45:31.083' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (21, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:46:04.297' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (22, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:47:06.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (23, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:47:31.043' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (24, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:53:07.587' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (25, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:53:45.373' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (26, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:55:47.640' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (27, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:57:05.637' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (28, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:59:09.587' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (29, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:01:23.157' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (30, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:02:36.893' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (31, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:03:15.257' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (32, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:03:30.307' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (33, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:03:50.693' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (34, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:11:21.430' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (35, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:13:21.570' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (36, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:14:22.390' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (37, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T22:15:05.893' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (38, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:15:10.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (39, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:16:07.193' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (40, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:18:23.887' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (41, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:21:22.653' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (42, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:28:11.070' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (43, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:28:21.320' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (44, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T22:28:33.617' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (45, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:28:37.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (46, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:29:53.543' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (47, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:31:20.300' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (48, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:33:18.930' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (49, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:33:29.823' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (50, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:33:38.973' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (51, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:45:18.213' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (52, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:46:02.590' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (53, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:47:52.397' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (54, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:48:12.757' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (55, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:48:30.493' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (56, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:54:25.757' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (57, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:55:04.743' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (58, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-12T09:22:54.853' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (59, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-12T09:23:11.093' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (60, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-12T20:08:00.380' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (61, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T20:08:51.387' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (62, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T20:14:46.753' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (63, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:11:41.010' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (64, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:11:55.330' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (65, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:12:01.003' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (66, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:12:40.987' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (67, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:15:29.120' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (68, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:15:48.993' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (69, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:16:10.557' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (70, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:16:16.823' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (71, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:16.553' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (72, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:18.693' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (73, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:57.723' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (74, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:59.983' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (75, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:41:00.987' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (76, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:41:05.660' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (77, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:41:11.360' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (78, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:02:41.403' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (79, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:03:12.720' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (80, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:03:51.407' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (81, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:03:55.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (82, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:33.437' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (83, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:40.663' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (84, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:42.310' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (85, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:42.993' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (86, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:55.907' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (87, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:56.647' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (88, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:57.433' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (89, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:05:05.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (90, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:05:38.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (91, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:09.733' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (92, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:12.037' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (93, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:28.667' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (94, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:48.490' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (95, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:51.113' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (96, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:53.397' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (97, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:54.447' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (98, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:54.850' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (99, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:55.560' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (100, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:57.807' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (101, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:25.400' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (102, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:27.230' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (103, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:27.940' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (104, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:28.523' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (105, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:29.223' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (106, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:31.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (107, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:33.450' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (108, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:33.767' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (109, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:33.923' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (110, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.127' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (111, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.297' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (112, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.477' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (113, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.660' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (114, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.833' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (115, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.043' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (116, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.223' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (117, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.420' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (118, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.613' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (119, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:36.157' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (120, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:40.007' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (121, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:14:09.310' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (122, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:14:33.613' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (123, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:15:08.487' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (124, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:15:14.253' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (125, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:04.397' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (126, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:07.223' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (127, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:11.900' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (128, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:12.657' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (129, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:12.933' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (130, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:14.020' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (131, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:54.317' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (132, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:55.103' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (133, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:55.743' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (134, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:56.503' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (135, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:05.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (136, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:08.087' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (137, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:08.843' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (138, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:09.417' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (139, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:09.720' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (140, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:11.023' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (141, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:11.773' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (142, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:12.150' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (143, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:13.200' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (144, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:13.507' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (145, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:14.987' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (146, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:16.243' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (147, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:17.017' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (148, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:18.660' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (149, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:19.487' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (150, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:20.400' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (151, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:21.023' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (152, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:21.703' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (153, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:22.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (154, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:23.377' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (155, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:23.853' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (156, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:24.377' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (157, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:24.717' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (158, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:30.497' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (159, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:32.247' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (160, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:27:32.710' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (161, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:27:35.140' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (162, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:30:43.703' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (163, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:35:30.860' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (164, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:37:39.547' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (165, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:38:16.613' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (166, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:40:33.050' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (167, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:45:30.110' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (168, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:20.767' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (169, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:21.697' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (170, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:22.337' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (171, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:23.103' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (172, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:23.900' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (173, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:33.130' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (174, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:39.287' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (175, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:40.867' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (176, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:06:24.350' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (177, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:06:31.977' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (178, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:14:53.230' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (179, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:15:00.480' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (180, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:17:52.193' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (181, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:17:53.523' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (182, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:20.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (183, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:22.663' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (184, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:54.940' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (185, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:56.810' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (186, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:52:15.907' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (187, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:53:00.470' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (188, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:53:13.993' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (189, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:12.010' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (190, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:14.527' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (191, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:17.030' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (192, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:45.097' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (193, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:47.020' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (194, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:51.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (195, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:56:56.683' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (196, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:56:59.433' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (197, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T21:23:30.303' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (198, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T21:23:35.120' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (199, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T09:47:56.853' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (200, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-30T09:51:29.340' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (201, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T09:51:37.780' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (202, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T10:08:20.910' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (203, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T10:13:07.550' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (204, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T10:20:04.500' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (205, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T15:51:35.280' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (206, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T16:59:44.027' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (207, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T17:00:50.187' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (208, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T18:50:01.090' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (209, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T18:50:53.803' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (210, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T18:53:37.227' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (211, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:12:33.887' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (212, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:23:38.877' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (213, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:24:09.423' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (214, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:25:40.940' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (215, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:29:06.813' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (216, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:36:44.353' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (217, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:37:51.917' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (218, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:39:27.577' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (219, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:40:47.587' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (220, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T20:00:50.927' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (221, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T20:02:00.723' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (222, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-01T18:32:34.817' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (223, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:44:45.623' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (224, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:57:46.720' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (225, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:58:14.303' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (226, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:58:48.663' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (227, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:01:41.207' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (228, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:02:23.193' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (229, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:04:23.300' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (230, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:05:57.630' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (231, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:07:43.533' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (232, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:07:56.470' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (233, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:08:02.540' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (234, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:09:14.213' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (235, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:09:54.477' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (236, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:11:29.033' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (237, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:11:45.323' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (238, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:17:40.553' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (239, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:21:06.317' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (240, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:23:22.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (241, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:24:50.450' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (242, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:57:20.177' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (243, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:03:23.910' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (244, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:03:30.197' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (245, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:04:12.110' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (246, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:04:17.397' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (247, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:04:51.803' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (248, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:05:33.397' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (249, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:06:10.053' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (250, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:06:17.897' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (251, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:08:53.367' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (252, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:08:57.067' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (253, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:09:39.200' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (254, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:09:44.860' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (255, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:10:17.167' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (256, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:10:22.533' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (257, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:01.217' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (258, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:02.613' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (259, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:18.177' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (260, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:29.500' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (261, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:39.897' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (262, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:49:02.097' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (263, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:49:22.060' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (264, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:49:23.423' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (265, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:23.537' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (266, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:24.730' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (267, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:50.337' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (268, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:51.483' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (269, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:51:20.637' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (270, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:51:22.057' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (271, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:53:50.973' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (272, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:53:51.003' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (273, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:54:55.143' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (274, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:57:54.677' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (275, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:02:57.220' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (276, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:02:58.253' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (277, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:03:50.330' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (278, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:16.420' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (279, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:17.990' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (280, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:21.513' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (281, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:37.953' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (282, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:39.030' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (283, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:05:57.157' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (284, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:07.587' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (285, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:08.697' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (286, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:11.177' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (287, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:12.913' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (288, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:30.913' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (289, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:50.473' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (290, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:10.953' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (291, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:13.390' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (292, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:22.740' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (293, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:27.537' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (294, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:29.337' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (295, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:34.120' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (296, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:37.583' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (297, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:41.053' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (298, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:41.620' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (299, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:50.550' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (300, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:51.383' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (301, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:52.190' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (302, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:52.810' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (303, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:07.543' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (304, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:28.103' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (305, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:34.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (306, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:42.163' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (307, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:43.780' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (308, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:45.213' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (309, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:46.443' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (310, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:47.890' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (311, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:43.083' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (312, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:44.873' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (313, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:45.483' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (314, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:45.983' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (315, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:46.430' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (316, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:47.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (317, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:02.970' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (318, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:04.607' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (319, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:05.693' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (320, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:07.397' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (321, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:08.223' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (322, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:33.490' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (323, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:35.127' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (324, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:35.690' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (325, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:36.303' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (326, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:36.867' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (327, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:37.917' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (328, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:45.180' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (329, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:55.230' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (330, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:57.513' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (331, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:28:02.203' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (332, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:28:04.040' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (333, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:30:04.950' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (334, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:30:16.733' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (335, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:30:52.500' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (336, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:40.587' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (337, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:43.003' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (338, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:44.487' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (339, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:45.670' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (340, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:51.813' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (341, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:32:03.403' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (342, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:02.673' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (343, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:04.163' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (344, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:36.427' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (345, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:37.857' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (346, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:57:09.953' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (347, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:57:12.093' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (348, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:57:35.070' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (349, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:00:12.670' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (350, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:00:15.737' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (351, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:01:59.627' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (352, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:00.817' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (353, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:05.893' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (354, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:07.173' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (355, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:09.280' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (356, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:10.817' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (357, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:12.200' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (358, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:13.297' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (359, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:42.817' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (360, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:53.150' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (361, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:54.570' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (362, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:55.317' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (363, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:56.790' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (364, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:01.703' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (365, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:09.550' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (366, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:11.103' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (367, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:36.527' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (368, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:27:05.340' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (369, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:27:24.243' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (370, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:28:46.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (371, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:28:48.360' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (372, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:31:50.417' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (373, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:31:51.667' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (374, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:33:13.967' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (375, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:33:14.833' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (376, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:35:43.790' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (377, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:35:44.790' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (378, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:36:56.820' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (379, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:36:57.927' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (380, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:40:00.520' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (381, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:40:01.673' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (382, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:22:33.553' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (383, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:22:34.810' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (384, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:35.993' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (385, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:37.607' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (386, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:53.077' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (387, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:55.633' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (388, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:29:58.580' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (389, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:29:59.627' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (390, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:30:56.187' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (391, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:30:58.707' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (392, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:32:18.253' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (393, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:32:19.347' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (394, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:34:19.380' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (395, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:34:20.760' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (396, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:59:25.183' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (397, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T10:12:39.067' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (398, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:07:21.367' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (399, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:07:22.810' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (400, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:08:44.227' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (401, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:08:45.643' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (402, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:27:17.830' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (403, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:27:19.023' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (404, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:30:50.170' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (405, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:30:51.617' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (406, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:32:28.197' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (407, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:32:29.277' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (408, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:33:24.127' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (409, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:33:25.150' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (410, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:35:35.303' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (411, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:35:36.563' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (412, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:17:04.383' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (413, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:17:06.190' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (414, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:18:49.883' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (415, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:18:56.917' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (416, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:23:30.480' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (417, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:23:31.493' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (418, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:25:03.003' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (419, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:25:04.170' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (420, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:31:04.223' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (421, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:31:05.293' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (422, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:32:56.837' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (423, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:32:58.057' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (424, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:33:47.923' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (425, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:33:49.110' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (426, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:35:49.410' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (427, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:35:50.370' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (428, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:36:20.823' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (429, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:36:24.543' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (430, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:37:57.823' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (431, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:37:58.697' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (432, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:40:42.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (433, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:40:43.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (434, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:41:10.703' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (435, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:41:22.213' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (436, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:41:23.803' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (437, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:17:24.283' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (438, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:17:32.297' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (439, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:02.923' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (440, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:04.823' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (441, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:10.580' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (442, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:11.733' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (443, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:25.930' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (444, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:28:10.220' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (445, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:28:12.063' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (446, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:28:40.063' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (447, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:30:52.500' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (448, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:30:53.360' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (449, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:32:09.183' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (450, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:32:10.130' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (451, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:33:55.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (452, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:33:55.860' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (453, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:24.207' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (454, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:25.227' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (455, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:40.863' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (456, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:47.900' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (457, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:35:36.477' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (458, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:35:37.343' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (459, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:51.193' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (460, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:52.600' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (461, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:55.037' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (462, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:55.747' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (463, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:56.960' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (464, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:14.960' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (465, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:15.740' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (466, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:56.630' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (467, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:57.330' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (468, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:41:14.850' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (469, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:41:15.877' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (470, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:42:00.080' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (471, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:42:00.933' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (472, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:43:05.803' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (473, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:43:06.513' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (474, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:44:09.867' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (475, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:44:10.757' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (476, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:53:43.907' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (477, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:55:08.693' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (478, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-10T10:05:54.573' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (479, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-10T10:06:46.193' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (480, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:07:25.100' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (481, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:09:34.680' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (482, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:09:55.167' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (483, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:11:20.067' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (484, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:29:03.670' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (485, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:30:08.137' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (486, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:30:36.307' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (487, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:34:53.217' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (488, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:37:27.900' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (489, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:40:05.737' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (490, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-10T10:40:43.213' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (491, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:40:47.490' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (492, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:43:08.090' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (493, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:43:47.067' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (494, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:45:43.033' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (495, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:46:04.227' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (496, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:50:19.957' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (497, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:50:53.513' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (498, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:51:00.970' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (499, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:51:13.150' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (500, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:52:13.993' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (501, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:53:28.627' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (502, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T11:54:40.013' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (503, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T09:06:30.223' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (504, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T09:06:36.527' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (505, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:06:47.203' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (506, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:13:13.293' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (507, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:18:56.153' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (508, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:23:27.327' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (509, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:25:48.893' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (510, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:28:19.263' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (511, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:31:15.863' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (512, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:34:38.440' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (513, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:42:27.603' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (514, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:43:16.207' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (515, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:44:05.513' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (516, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T09:44:28.517' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (517, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:44:34.040' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (518, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:48:35.873' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (519, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:55:26.907' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (520, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:56:33.393' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (521, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:58:02.817' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (522, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:59:33.287' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (523, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:15:19.960' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (524, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T10:20:35.487' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (525, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:20:41.217' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (526, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:22:11.850' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (527, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:26:33.560' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (528, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:28:07.070' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (529, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:29:36.947' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (530, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T10:32:05.757' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (531, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:32:09.997' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (532, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:32:55.990' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (533, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:34:35.230' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (534, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:37:48.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (535, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:40:53.060' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (536, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:44:47.500' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (537, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:47:48.843' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (538, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:00:05.720' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (539, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T11:05:41.690' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (540, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:05:47.497' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (541, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:08:12.227' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (542, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T11:12:02.797' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (543, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:12:08.273' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (544, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:17:39.220' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (545, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:24:48.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (546, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:28:47.260' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (547, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:32:10.653' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (548, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:34:09.007' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (549, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:43:19.550' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (550, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:44:09.547' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (551, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:49:44.000' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (552, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:50:42.627' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (553, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:52:02.277' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (554, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:53:48.857' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (555, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:58:51.480' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (556, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:01:38.197' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (557, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:02:47.943' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (558, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:04:43.667' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (559, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:05:30.520' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (560, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:08:14.343' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (561, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:09:15.420' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (562, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:28:00.787' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (563, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:28:56.930' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (564, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:29:22.837' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (565, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:31:22.303' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (566, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:36:02.810' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (567, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:37:22.517' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (568, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:38:28.290' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (569, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:44:24.657' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (570, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:46:16.757' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (571, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:55:46.720' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (572, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:57:37.323' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (573, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:59:34.057' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (574, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T09:08:36.277' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (575, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T09:10:34.690' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (576, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T09:10:39.910' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (577, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T14:58:07.593' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (578, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T14:59:21.610' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (579, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:00:26.030' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (580, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:16:45.300' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (581, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T15:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (582, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:17:55.527' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (583, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:20:02.177' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (584, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T15:23:43.243' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (585, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:23:47.133' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (586, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:26:49.460' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (587, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:27:25.137' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (588, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:30:55.273' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (589, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:31:13.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (590, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:31:48.570' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (591, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T15:33:22.857' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (592, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:33:28.607' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (593, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:33:55.650' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (594, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:34:43.890' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (595, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:36:46.830' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (596, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:37:19.467' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (597, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:52:55.313' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (598, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:54:15.783' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (599, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:55:02.213' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (600, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:55:45.377' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (601, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:57:20.130' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (602, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:58:07.083' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (603, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:01:34.890' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (604, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:02:10.617' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (605, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:20:52.810' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (606, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:22:35.763' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (607, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:35:11.417' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (608, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:44:11.267' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (609, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:45:49.923' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (610, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:54:02.897' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (611, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:54:37.110' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (612, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:10:53.267' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (613, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:12:13.593' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (614, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:14:24.747' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (615, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:14:41.747' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (616, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:16:17.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (617, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:16:49.187' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (618, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:19:00.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (619, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:20:53.950' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (620, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:23:01.133' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (621, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:23:26.407' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (622, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:24:34.850' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (623, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:26:16.773' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (624, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:28:10.330' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (625, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:30:37.893' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (626, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:32:16.193' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (627, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:33:53.860' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (628, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:35:36.823' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (629, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:35:58.723' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (630, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:36:29.350' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (631, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:37:49.183' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (632, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:38:56.090' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (633, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:39:24.957' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (634, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:40:29.607' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (635, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T17:40:59.150' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (636, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:41:02.787' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (637, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:42:17.887' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (638, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:43:07.170' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (639, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:44:29.413' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (640, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:45:01.853' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (641, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:45:47.537' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (642, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:30:09.690' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (643, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:31:57.757' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (644, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:32:12.390' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (645, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:51:31.887' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (646, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:53:52.797' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (647, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:55:26.233' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (648, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:57:01.527' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (649, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:58:37.900' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (650, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-23T23:59:38.197' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (651, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:24:34.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (652, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:25:44.457' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (653, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:27:08.333' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (654, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:28:33.130' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (655, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:30:10.960' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (656, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:31:28.790' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (657, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:32:05.127' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (658, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:35:44.163' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (659, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:39:25.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (660, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:42:21.620' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (661, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:49:38.107' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (662, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:50:15.330' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (663, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:53:43.517' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (664, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:58:00.683' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (665, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T01:59:36.483' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (666, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:08:15.253' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (667, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:09:46.680' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (668, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:12:27.283' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (669, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:14:29.383' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (670, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:16:25.357' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (671, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:18:23.130' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (672, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:21:25.603' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (673, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:23:57.633' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (674, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:24:55.367' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (675, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:27:56.057' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (676, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-24T02:28:43.413' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (677, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:17:18.537' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (678, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-25T18:17:57.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (679, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:18:01.613' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (680, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:18:33.527' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (681, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:54:51.050' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (682, 0, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:55:09.667' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (683, 0, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:56:55.780' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (684, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T18:59:13.640' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (685, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:04:59.263' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (686, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:06:09.277' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (687, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:09:58.380' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (688, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:13:47.407' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (689, 0, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:14:17.030' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (690, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:19:26.253' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (691, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:21:03.390' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (692, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:21:28.947' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (693, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:22:43.440' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (694, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:24:40.877' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (695, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-25T19:25:35.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (696, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:25:39.107' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (697, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:27:58.197' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (698, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:28:51.140' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (699, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:30:49.297' AS DateTime), NULL)
GO
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (700, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:32:11.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (701, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:33:22.007' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (702, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-25T19:34:06.103' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (703, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:34:10.383' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (704, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:34:54.287' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (705, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:35:03.557' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (706, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:35:36.107' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (707, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:36:27.047' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (708, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:37:09.877' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (709, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:37:36.283' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (710, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:38:08.963' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (711, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:38:32.113' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (712, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-25T19:41:49.270' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (713, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T08:38:19.207' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (717, 0, N'123 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-11-26T09:25:20.160' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (718, 0, N'123123 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-11-26T09:28:00.767' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (719, 0, N'24412 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-11-26T09:30:14.437' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (720, 1, N'Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: Usuario', N'ALTA', CAST(N'2024-11-26T09:48:29.237' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (721, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T09:48:49.920' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (722, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T10:01:56.417' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (723, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T10:03:34.753' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (724, 0, N'41241 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-11-26T10:39:39.367' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (725, 0, N'99999 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-11-26T10:40:34.243' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (726, 1, N'El registro con id = 1 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.100' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (727, 2, N'El registro con id = 2 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.107' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (728, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.110' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (729, 4, N'El registro con id = 4 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.113' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (730, 6, N'El registro con id = 6 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.113' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (731, 7, N'El registro con id = 7 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (732, 8, N'El registro con id = 8 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.117' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (733, 9, N'El registro con id = 9 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.120' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (734, 10, N'El registro con id = 10 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:03:50.120' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (735, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T11:04:05.357' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (736, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-26T11:08:57.687' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (737, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T11:09:02.417' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (738, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T11:09:48.913' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (739, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T11:09:57.233' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (740, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:08:29.703' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (741, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:08:34.343' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (742, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:08:52.103' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (743, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:08:52.127' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (744, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:09:56.150' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (745, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:09:56.197' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (746, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:10:04.310' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (747, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:10:04.343' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (748, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:12:52.800' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (749, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:12:52.887' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (750, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:13:26.977' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (751, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:13:27.043' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (752, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:14:11.910' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (753, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:14:11.990' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (754, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:15:20.843' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (755, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:15:20.903' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (756, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:16:20.570' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (757, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:16:20.617' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (758, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:20:40.343' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (759, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:20:40.387' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (760, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:33:21.127' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (761, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:33:21.200' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (762, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:33:48.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (763, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:37:00.040' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (764, 3, N'El registro con id = 3 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:37:00.123' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (765, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-26T12:38:52.983' AS DateTime), NULL)
INSERT [dbo].[Bitacora] ([id_bitacora], [id_usuario], [Detalle], [Criticidad], [Fecha], [DVH]) VALUES (766, 4, N'El registro con id = 4 de la tabla usuario no es válido su DVH', N'ALTA', CAST(N'2024-11-26T12:38:53.020' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Carrito] ON 

INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad]) VALUES (53, 9, 3, 1)
INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad]) VALUES (54, 10, 3, 1)
INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad]) VALUES (55, 11, 3, 1)
INSERT [dbo].[Carrito] ([id_carrito], [id_producto], [id_usuario], [cantidad]) VALUES (66, 8, 3, 1)
SET IDENTITY_INSERT [dbo].[Carrito] OFF
GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([id_categoria], [Nombre]) VALUES (1, N'Sensores')
INSERT [dbo].[Categoria] ([id_categoria], [Nombre]) VALUES (2, N'PLC')
INSERT [dbo].[Categoria] ([id_categoria], [Nombre]) VALUES (3, N'Cables')
INSERT [dbo].[Categoria] ([id_categoria], [Nombre]) VALUES (4, N'CNC')
SET IDENTITY_INSERT [dbo].[Categoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Detalle_Venta] ON 

INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (6, 4, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (7, 4, 11, N'S004', N'Sensor 4', 4, 12000, 48000, 8330.58, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (8, 4, 15, N'P003', N'PLC 3', 3, 58000, 174000, 30198.35, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (9, 5, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (10, 5, 9, N'S002', N'Sensor 2', 2, 25000, 50000, 8677.69, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (11, 5, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (12, 6, 9, N'S002', N'Sensor 2', 4, 25000, 100000, 17355.37, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (13, 6, 21, N'CNC003', N'CNC 3', 1, 550000, 550000, 95454.55, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (14, 7, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (15, 7, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (16, 7, 13, N'P001', N'PLC 1', 3, 95000, 285000, 49462.81, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (17, 8, 13, N'P001', N'PLC 1', 3, 95000, 285000, 49462.81, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (18, 8, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (19, 12, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (20, 12, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (21, 12, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (22, 12, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (23, 13, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (24, 13, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (25, 13, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (26, 13, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (27, 13, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (28, 14, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (29, 14, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (30, 14, 18, N'C001', N'Cable 1', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (31, 14, 15, N'P003', N'PLC 3', 1, 58000, 58000, 10066.12, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (32, 15, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (33, 15, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (34, 15, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (35, 15, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (36, 15, 16, N'P004', N'PLC 4', 1, 45000, 45000, 7809.92, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (37, 16, 20, N'CNC002', N'CNC 2', 1, 450000, 450000, 78099.17, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (38, 16, 21, N'CNC003', N'CNC 3', 1, 550000, 550000, 95454.55, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (39, 16, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (40, 17, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (41, 17, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (42, 17, 17, N'P005', N'PLC 5', 1, 90000, 90000, 15619.83, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (43, 18, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (44, 18, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (45, 18, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (46, 18, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (47, 19, 9, N'S002', N'Sensor 2', 3, 25000, 75000, 13016.53, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (48, 19, 10, N'S003', N'Sensor 3', 2, 54000, 108000, 18743.8, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (49, 19, 11, N'S004', N'Sensor 4', 2, 12000, 24000, 4165.29, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (50, 20, 9, N'S002', N'Sensor 2', 3, 25000, 75000, 13016.53, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (51, 20, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (52, 20, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (53, 21, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (54, 21, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (55, 22, 8, N'S001', N'Sensor 1', 3, 35000, 105000, 9977.38, 4)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (56, 22, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (57, 22, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (58, 23, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 6074.38, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (59, 23, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([id_detalle_venta], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (60, 23, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
SET IDENTITY_INSERT [dbo].[Detalle_Venta] OFF
GO
SET IDENTITY_INSERT [dbo].[DigitoVerificador] ON 

INSERT [dbo].[DigitoVerificador] ([nombre_tabla], [valorDVV], [id_DV]) VALUES (N'Usuario', 1201361, 2)
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

INSERT [dbo].[Marca] ([id_marca], [Nombre]) VALUES (1, N'Samsung')
INSERT [dbo].[Marca] ([id_marca], [Nombre]) VALUES (2, N'Siemens')
INSERT [dbo].[Marca] ([id_marca], [Nombre]) VALUES (3, N'Keyence')
INSERT [dbo].[Marca] ([id_marca], [Nombre]) VALUES (4, N'Honeywell')
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

INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (8, N'S001', N'Sensor 1', 1, 1, 1, N'~/Images/S001.jpg', 45, 35000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (9, N'S002', N'Sensor 2', 2, 1, 1, N'~/Images/S002.jpg', 6, 25000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (10, N'S003', N'Sensor 3', 3, 1, 1, N'~/Images/S003.jpg', 21, 54000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (11, N'S004', N'Sensor 4', 1, 1, 1, N'~/Images/S004.jpg', 5, 12000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (12, N'S005', N'Sensor 5', 4, 1, 1, N'~/Images/S005.jpg', 0, 87000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (13, N'P001', N'PLC 1', 1, 2, 1, N'~/Images/P001.jpg', 3, 95000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (14, N'P002', N'PLC 2', 2, 2, 1, N'~/Images/P002.jpg', 6, 105000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (15, N'P003', N'PLC 3', 4, 2, 1, N'~/Images/P003.jpg', 2, 58000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (16, N'P004', N'PLC 4', 1, 2, 1, N'~/Images/P004.jpg', 21, 45000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (17, N'P005', N'PLC 5', 1, 2, 1, N'~/Images/P005.jpg', 3, 90000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (18, N'C001', N'Cable 1', 3, 3, 1, N'~/Images/C001.jpg', 90, 12000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (19, N'CNC001', N'CNC 1', 1, 4, 1, N'~/Images/CN001.jpg', 3, 300000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (20, N'CNC002', N'CNC 2', 4, 4, 1, N'~/Images/CN002.jpg', 4, 450000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (21, N'CNC003', N'CNC 3', 3, 4, 1, N'~/Images/CN003.jpg', 6, 550000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (22, N'CNC004', N'CNC 4', 2, 4, 1, N'~/Images/CN004.jpg', 2, 460000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (23, N'CNC005', N'CNC 5', 4, 4, 1, N'~/Images/CN005.jpg', 0, 520000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (24, N'S10', N'Sensor 10', 1, 1, 1, N'', 44, 45000, 5)
INSERT [dbo].[Producto] ([id_producto], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (25, N'S011', N'Sensor 11', 2, 1, 1, N'', 44, 56000, 4)
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[RelatedTaxes] ON 

INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (4, 5, 21, 228099.17, 47900.83, 4)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (5, 4, 10.5, 31674.21, 3325.79, 5)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (6, 5, 21, 119834.71, 25165.29, 5)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (7, 5, 21, 537190.08, 112809.92, 6)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (8, 5, 21, 300826.45, 63173.55, 7)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (9, 5, 21, 245454.55, 51545.45, 8)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (10, 4, 10.5, 31674.21, 3325.79, 12)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (11, 5, 21, 143801.65, 30198.35, 12)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (12, 4, 10.5, 31674.21, 3325.79, 13)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (13, 5, 21, 161983.47, 34016.53, 13)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (14, 4, 10.5, 31674.21, 3325.79, 14)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (15, 5, 21, 136363.64, 28636.36, 14)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (16, 5, 21, 267768.6, 56231.4, 15)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (17, 5, 21, 913223.14, 191776.86, 16)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (18, 5, 21, 139669.42, 29330.58, 17)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (19, 5, 21, 153719.01, 32280.99, 18)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (20, 5, 21, 171074.38, 35925.62, 19)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (21, 5, 21, 116528.93, 24471.07, 20)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (22, 5, 21, 20661.16, 4338.84, 21)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (23, 4, 10.5, 31674.21, 3325.79, 21)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (24, 4, 10.5, 95022.62, 9977.38, 22)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (25, 5, 21, 107438.02, 22561.98, 22)
INSERT [dbo].[RelatedTaxes] ([id_relatedtaxes], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (26, 5, 21, 94214.88, 19785.12, 23)
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

INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (1, N'cnJAZ21haWwuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Rodrigo', 1111, 0, N'Activo', N'Um9kcmlnbw==', N'R29uemFsZXo=', N'DNI', N'Consumidor Final', 132208)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (2, N'd2VibWFzdGVyQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'WebMaster', 1111111, 0, N'Activo', N'V2ViTWFzdGVy', N'V2ViTWFzdGVy', N'DNI', N'Consumidor Final', 160166)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (3, N'VUFDQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Usuario Administrador Contable(UAC)', 4114, 0, N'Activo', N'VUFD', N'VUFD', N'DNI', N'Consumidor Final', 179313)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (4, N'Q2xpZW50ZUBnbWFpbC5jb20=', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Cliente', 2131, 0, N'Activo', N'Q2xpZW50ZQ==', N'Q2xpZW50ZQ==', N'DNI', N'Consumidor Final', 141204)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (6, N'ZHZAZHYuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'a', 123, 0, N'Activo', N'YWE=', N'YWE=', N'DNI', N'Consumidor Final', 111145)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (7, N'ZGRAZGQuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asda', 123123, 0, N'Activo', N'YXNkYQ==', N'YXNkYXNk', N'DNI', N'Consumidor Final', 117374)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (8, N'ZGRkZEBkYWQuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asdasd', 24412, 0, N'Activo', N'c2Rh', N'ZGFzZGE=', N'DNI', N'Consumidor Final', 120999)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (9, N'YWFkQGFhLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'asda', 41241, 0, N'Activo', N'YXNkYQ==', N'YWRhZA==', N'DNI', N'Consumidor Final', 121415)
INSERT [dbo].[Usuario] ([id_usuario], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente], [DVH]) VALUES (10, N'a2tAa2suY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'erqwr', 99999, 0, N'Activo', N'ZGFzZHM=', N'ZGFzZA==', N'DNI', N'Consumidor Final', 117537)
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

INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (4, CAST(N'2024-10-30T15:52:20.000' AS DateTime), N'Venta', 74452204481671, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 14, 4, N'6', 276000, 47900.83, 228099.17, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (5, CAST(N'2024-10-30T17:01:30.000' AS DateTime), N'Venta', 74452204478641, CAST(N'2024-11-18T00:00:00.000' AS DateTime), 1, 9, 4, N'6', 180000, 28491.08, 151508.92, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (6, CAST(N'2024-10-30T19:38:19.000' AS DateTime), N'Venta', 74452204479228, CAST(N'2024-11-18T00:00:00.000' AS DateTime), 1, 10, 4, N'6', 650000, 112809.92, 537190.08, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (7, CAST(N'2024-10-30T19:40:06.000' AS DateTime), N'Venta', 74452204481537, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 13, 4, N'6', 364000, 63173.55, 300826.45, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (8, CAST(N'2024-10-30T20:02:46.000' AS DateTime), N'Venta', 74452204481511, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 12, 4, N'6', 297000, 51545.45, 245454.55, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (12, CAST(N'2024-11-09T02:22:59.000' AS DateTime), N'Venta', 74452204481906, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 15, 3, N'6', 209000, 33524.14, 175475.86, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (13, CAST(N'2024-11-09T02:24:54.000' AS DateTime), N'Venta', 74452204481951, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 16, 3, N'6', 231000, 37342.32, 193657.68, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (14, CAST(N'2024-11-09T02:27:12.000' AS DateTime), N'Venta', 74452204481964, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 17, 3, N'6', 200000, 31962.15, 168037.85, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (15, CAST(N'2024-11-09T02:27:43.000' AS DateTime), N'Venta', 74452204481977, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 18, 3, N'6', 324000, 56231.4, 267768.6, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (16, CAST(N'2024-11-09T02:31:49.000' AS DateTime), N'Venta', 74452204482363, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 19, 3, N'6', 1105000, 191776.86, 913223.14, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (17, CAST(N'2024-11-09T03:25:01.000' AS DateTime), N'Venta', 74452204482787, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 22, 3, N'6', 169000, 29330.58, 139669.42, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (18, CAST(N'2024-11-10T10:50:51.000' AS DateTime), N'Venta', 74452204513996, CAST(N'2024-11-20T00:00:00.000' AS DateTime), 1, 23, 3, N'6', 186000, 32280.99, 153719.01, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMCIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMywiaW1wb3J0ZSI6MTg2MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDUxMzk5Nn0=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (19, CAST(N'2024-11-12T09:07:24.000' AS DateTime), N'Venta', 74462204758762, CAST(N'2024-11-22T00:00:00.000' AS DateTime), 1, 24, 3, N'6', 207000, 35925.62, 171074.38, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMiIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyNCwiaW1wb3J0ZSI6MjA3MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDc1ODc2Mn0=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (20, CAST(N'2024-11-13T15:34:21.000' AS DateTime), N'Venta', 74462204866838, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 29, 4, N'6', 141000, 24471.07, 116528.93, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyOSwiaW1wb3J0ZSI6MTQxMDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDg2NjgzOH0=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (21, CAST(N'2024-11-13T15:37:07.000' AS DateTime), N'Venta', 74462204941203, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 30, 4, N'6', 60000, 7664.63, 52335.37, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozMCwiaW1wb3J0ZSI6NjAwMDAuMCwibW9uZWRhIjoiUEVTIiwiY3R6IjoxLjAsInRpcG9Eb2NSZWMiOjk2LCJucm9Eb2NSZWMiOjMzMzMzMywidGlwb0NvZEF1dCI6IkUiLCJjb2RBdXQiOjc0NDYyMjA0OTQxMjAzfQ==')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (22, CAST(N'2024-11-13T17:45:21.000' AS DateTime), N'Venta', 74462204941305, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 31, 4, N'6', 235000, 32539.36, 202460.64, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozMSwiaW1wb3J0ZSI6MjM1MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDk0MTMwNX0=')
INSERT [dbo].[Venta] ([id_venta], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (23, CAST(N'2024-11-25T19:35:13.000' AS DateTime), N'Venta', 74482208760411, CAST(N'2024-12-05T00:00:00.000' AS DateTime), 1, 36, 4, N'6', 114000, 19785.12, 94214.88, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0yNSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozNiwiaW1wb3J0ZSI6MTE0MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ4MjIwODc2MDQxMX0=')
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
USE [master]
GO
ALTER DATABASE [EnerTech] SET  READ_WRITE 
GO
