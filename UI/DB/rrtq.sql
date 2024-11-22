USE [master]
GO
/****** Object:  Database [EnerTech]    Script Date: 13/11/2024 17:47:30 ******/
CREATE DATABASE [EnerTech]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnerTech', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EnerTech.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EnerTech_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EnerTech_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[Detalle] [nvarchar](200) NOT NULL,
	[Criticidad] [nvarchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_Carrito] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Venta]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Venta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FamiliaPatente]    Script Date: 13/11/2024 17:47:30 ******/
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
/****** Object:  Table [dbo].[Marca]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marca](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Marca] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permiso]    Script Date: 13/11/2024 17:47:30 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[id] [int] IDENTITY(1,1) NOT NULL,
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
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelatedTaxes]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelatedTaxes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigoIVA] [int] NOT NULL,
	[TasaIVA] [float] NOT NULL,
	[BaseImponible] [float] NOT NULL,
	[TotalIVA] [float] NOT NULL,
	[id_venta] [int] NOT NULL,
 CONSTRAINT [PK_RelatedTaxes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tokenAFIP]    Script Date: 13/11/2024 17:47:30 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioPermiso]    Script Date: 13/11/2024 17:47:30 ******/
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
/****** Object:  Table [dbo].[Venta]    Script Date: 13/11/2024 17:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (1, 0, N'1111 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T16:44:44.793' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (2, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T16:44:51.633' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (3, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T17:31:11.433' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (4, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T17:32:59.963' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (5, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T17:38:19.513' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (6, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T17:38:25.727' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (7, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T21:01:14.957' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (8, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T21:01:16.480' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (9, 1, N'rr@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T21:01:18.460' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (10, 1, N'rr@gmail.com - Usuario Bloqueado', N'Medio', CAST(N'2024-10-01T21:01:19.883' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (11, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:09:27.883' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (12, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:12:24.020' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (13, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:15:50.427' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (14, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:17:13.057' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (15, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:18:30.980' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (16, 1, N'rr@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:43:10.887' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (17, 0, N'1111111 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T21:44:29.443' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (18, 0, N'222222 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T21:45:01.940' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (19, 0, N'333333 - Se registro un nuevo usuario correctamente', N'Media', CAST(N'2024-10-01T21:45:24.523' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (20, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:45:31.083' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (21, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:46:04.297' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (22, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:47:06.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (23, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:47:31.043' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (24, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:53:07.587' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (25, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:53:45.373' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (26, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:55:47.640' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (27, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:57:05.637' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (28, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T21:59:09.587' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (29, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:01:23.157' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (30, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:02:36.893' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (31, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:03:15.257' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (32, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:03:30.307' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (33, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:03:50.693' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (34, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:11:21.430' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (35, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:13:21.570' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (36, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:14:22.390' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (37, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T22:15:05.893' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (38, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:15:10.123' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (39, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:16:07.193' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (40, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:18:23.887' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (41, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:21:22.653' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (42, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:28:11.070' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (43, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:28:21.320' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (44, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-01T22:28:33.617' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (45, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:28:37.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (46, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:29:53.543' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (47, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:31:20.300' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (48, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:33:18.930' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (49, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:33:29.823' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (50, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:33:38.973' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (51, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:45:18.213' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (52, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:46:02.590' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (53, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:47:52.397' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (54, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:48:12.757' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (55, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:48:30.493' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (56, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:54:25.757' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (57, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-01T22:55:04.743' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (58, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-12T09:22:54.853' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (59, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-12T09:23:11.093' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (60, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-12T20:08:00.380' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (61, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T20:08:51.387' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (62, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T20:14:46.753' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (63, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:11:41.010' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (64, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:11:55.330' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (65, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:12:01.003' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (66, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:12:40.987' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (67, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:15:29.120' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (68, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:15:48.993' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (69, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:16:10.557' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (70, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:16:16.823' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (71, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:16.553' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (72, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:18.693' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (73, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:57.723' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (74, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:17:59.983' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (75, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:41:00.987' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (76, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:41:05.660' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (77, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T21:41:11.360' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (78, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:02:41.403' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (79, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:03:12.720' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (80, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:03:51.407' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (81, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:03:55.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (82, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:33.437' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (83, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:40.663' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (84, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:42.310' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (85, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:42.993' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (86, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:55.907' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (87, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:56.647' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (88, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:04:57.433' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (89, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:05:05.920' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (90, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:05:38.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (91, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:09.733' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (92, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:12.037' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (93, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:28.667' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (94, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:48.490' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (95, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:51.113' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (96, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:53.397' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (97, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:54.447' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (98, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:54.850' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (99, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:55.560' AS DateTime))
GO
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (100, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:09:57.807' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (101, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:25.400' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (102, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:27.230' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (103, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:27.940' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (104, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:28.523' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (105, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:29.223' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (106, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:31.047' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (107, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:33.450' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (108, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:33.767' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (109, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:33.923' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (110, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.127' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (111, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.297' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (112, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.477' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (113, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.660' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (114, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:34.833' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (115, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.043' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (116, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.223' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (117, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.420' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (118, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:35.613' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (119, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:36.157' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (120, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:10:40.007' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (121, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:14:09.310' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (122, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:14:33.613' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (123, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:15:08.487' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (124, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:15:14.253' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (125, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:04.397' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (126, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:07.223' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (127, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:11.900' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (128, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:12.657' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (129, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:12.933' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (130, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:14.020' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (131, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:54.317' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (132, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:55.103' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (133, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:55.743' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (134, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:17:56.503' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (135, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:05.920' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (136, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:08.087' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (137, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:08.843' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (138, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:09.417' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (139, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:09.720' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (140, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:11.023' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (141, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:11.773' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (142, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:12.150' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (143, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:13.200' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (144, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:13.507' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (145, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:14.987' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (146, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:16.243' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (147, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:17.017' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (148, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:18.660' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (149, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:19.487' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (150, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:20.400' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (151, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:21.023' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (152, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:21.703' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (153, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:22.123' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (154, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:23.377' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (155, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:23.853' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (156, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:24.377' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (157, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:24.717' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (158, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:30.497' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (159, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:18:32.247' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (160, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:27:32.710' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (161, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:27:35.140' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (162, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:30:43.703' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (163, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:35:30.860' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (164, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:37:39.547' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (165, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:38:16.613' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (166, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:40:33.050' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (167, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-27T22:45:30.110' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (168, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:20.767' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (169, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:21.697' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (170, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:22.337' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (171, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:23.103' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (172, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:23.900' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (173, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:33.130' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (174, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:39.287' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (175, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:05:40.867' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (176, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:06:24.350' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (177, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:06:31.977' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (178, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:14:53.230' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (179, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:15:00.480' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (180, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:17:52.193' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (181, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:17:53.523' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (182, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:20.117' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (183, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:22.663' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (184, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:54.940' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (185, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:47:56.810' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (186, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:52:15.907' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (187, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:53:00.470' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (188, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:53:13.993' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (189, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:12.010' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (190, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:14.527' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (191, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:17.030' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (192, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:45.097' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (193, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:47.020' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (194, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:55:51.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (195, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:56:56.683' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (196, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T20:56:59.433' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (197, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T21:23:30.303' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (198, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-28T21:23:35.120' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (199, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T09:47:56.853' AS DateTime))
GO
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (200, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-10-30T09:51:29.340' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (201, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T09:51:37.780' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (202, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T10:08:20.910' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (203, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T10:13:07.550' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (204, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T10:20:04.500' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (205, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T15:51:35.280' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (206, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T16:59:44.027' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (207, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T17:00:50.187' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (208, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T18:50:01.090' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (209, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T18:50:53.803' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (210, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T18:53:37.227' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (211, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:12:33.887' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (212, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:23:38.877' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (213, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:24:09.423' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (214, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:25:40.940' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (215, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:29:06.813' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (216, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:36:44.353' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (217, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:37:51.917' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (218, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:39:27.577' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (219, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T19:40:47.587' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (220, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T20:00:50.927' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (221, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-10-30T20:02:00.723' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (222, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-01T18:32:34.817' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (223, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:44:45.623' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (224, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:57:46.720' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (225, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:58:14.303' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (226, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-08T23:58:48.663' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (227, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:01:41.207' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (228, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:02:23.193' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (229, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:04:23.300' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (230, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:05:57.630' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (231, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:07:43.533' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (232, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:07:56.470' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (233, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:08:02.540' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (234, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:09:14.213' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (235, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:09:54.477' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (236, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:11:29.033' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (237, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:11:45.323' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (238, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:17:40.553' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (239, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:21:06.317' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (240, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:23:22.123' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (241, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:24:50.450' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (242, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T00:57:20.177' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (243, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:03:23.910' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (244, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:03:30.197' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (245, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:04:12.110' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (246, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:04:17.397' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (247, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:04:51.803' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (248, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:05:33.397' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (249, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:06:10.053' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (250, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:06:17.897' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (251, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:08:53.367' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (252, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:08:57.067' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (253, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:09:39.200' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (254, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:09:44.860' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (255, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:10:17.167' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (256, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:10:22.533' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (257, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:01.217' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (258, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:02.613' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (259, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:18.177' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (260, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:29.500' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (261, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:14:39.897' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (262, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:49:02.097' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (263, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:49:22.060' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (264, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:49:23.423' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (265, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:23.537' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (266, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:24.730' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (267, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:50.337' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (268, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:50:51.483' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (269, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:51:20.637' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (270, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:51:22.057' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (271, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:53:50.973' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (272, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:53:51.003' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (273, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:54:55.143' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (274, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T01:57:54.677' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (275, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:02:57.220' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (276, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:02:58.253' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (277, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:03:50.330' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (278, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:16.420' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (279, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:17.990' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (280, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:21.513' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (281, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:37.953' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (282, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:04:39.030' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (283, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:05:57.157' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (284, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:07.587' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (285, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:08.697' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (286, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:11.177' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (287, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:12.913' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (288, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:30.913' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (289, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:19:50.473' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (290, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:10.953' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (291, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:13.390' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (292, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:22.740' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (293, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:27.537' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (294, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:29.337' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (295, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:34.120' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (296, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:37.583' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (297, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:21:41.053' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (298, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:41.620' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (299, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:50.550' AS DateTime))
GO
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (300, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:51.383' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (301, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:52.190' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (302, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:22:52.810' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (303, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:07.543' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (304, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:28.103' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (305, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:34.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (306, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:42.163' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (307, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:43.780' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (308, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:45.213' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (309, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:46.443' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (310, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:23:47.890' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (311, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:43.083' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (312, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:44.873' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (313, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:45.483' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (314, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:45.983' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (315, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:46.430' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (316, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:24:47.047' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (317, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:02.970' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (318, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:04.607' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (319, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:05.693' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (320, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:07.397' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (321, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:08.223' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (322, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:33.490' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (323, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:35.127' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (324, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:35.690' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (325, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:36.303' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (326, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:36.867' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (327, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:37.917' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (328, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:45.180' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (329, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:55.230' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (330, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:27:57.513' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (331, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:28:02.203' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (332, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:28:04.040' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (333, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:30:04.950' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (334, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:30:16.733' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (335, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:30:52.500' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (336, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:40.587' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (337, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:43.003' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (338, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:44.487' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (339, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:45.670' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (340, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:31:51.813' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (341, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:32:03.403' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (342, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:02.673' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (343, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:04.163' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (344, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:36.427' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (345, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:54:37.857' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (346, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:57:09.953' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (347, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:57:12.093' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (348, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T02:57:35.070' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (349, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:00:12.670' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (350, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:00:15.737' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (351, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:01:59.627' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (352, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:00.817' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (353, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:05.893' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (354, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:07.173' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (355, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:09.280' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (356, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:10.817' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (357, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:12.200' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (358, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:13.297' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (359, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:02:42.817' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (360, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:53.150' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (361, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:54.570' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (362, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:55.317' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (363, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:24:56.790' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (364, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:01.703' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (365, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:09.550' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (366, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:11.103' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (367, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:25:36.527' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (368, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:27:05.340' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (369, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:27:24.243' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (370, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:28:46.920' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (371, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:28:48.360' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (372, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:31:50.417' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (373, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:31:51.667' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (374, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:33:13.967' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (375, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:33:14.833' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (376, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:35:43.790' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (377, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:35:44.790' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (378, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:36:56.820' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (379, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:36:57.927' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (380, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:40:00.520' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (381, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T03:40:01.673' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (382, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:22:33.553' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (383, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:22:34.810' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (384, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:35.993' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (385, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:37.607' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (386, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:53.077' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (387, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:27:55.633' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (388, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:29:58.580' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (389, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:29:59.627' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (390, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:30:56.187' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (391, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:30:58.707' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (392, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:32:18.253' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (393, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:32:19.347' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (394, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:34:19.380' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (395, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:34:20.760' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (396, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T09:59:25.183' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (397, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T10:12:39.067' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (398, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:07:21.367' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (399, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:07:22.810' AS DateTime))
GO
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (400, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:08:44.227' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (401, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:08:45.643' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (402, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:27:17.830' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (403, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:27:19.023' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (404, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:30:50.170' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (405, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:30:51.617' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (406, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:32:28.197' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (407, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:32:29.277' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (408, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:33:24.127' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (409, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:33:25.150' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (410, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:35:35.303' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (411, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T19:35:36.563' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (412, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:17:04.383' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (413, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:17:06.190' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (414, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:18:49.883' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (415, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:18:56.917' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (416, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:23:30.480' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (417, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:23:31.493' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (418, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:25:03.003' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (419, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:25:04.170' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (420, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:31:04.223' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (421, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:31:05.293' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (422, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:32:56.837' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (423, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:32:58.057' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (424, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:33:47.923' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (425, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:33:49.110' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (426, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:35:49.410' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (427, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:35:50.370' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (428, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:36:20.823' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (429, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:36:24.543' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (430, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:37:57.823' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (431, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:37:58.697' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (432, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:40:42.123' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (433, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:40:43.117' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (434, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:41:10.703' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (435, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:41:22.213' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (436, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T20:41:23.803' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (437, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:17:24.283' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (438, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:17:32.297' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (439, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:02.923' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (440, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:04.823' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (441, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:10.580' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (442, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:11.733' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (443, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-09T21:18:25.930' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (444, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:28:10.220' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (445, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:28:12.063' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (446, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:28:40.063' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (447, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:30:52.500' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (448, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:30:53.360' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (449, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:32:09.183' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (450, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:32:10.130' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (451, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:33:55.047' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (452, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:33:55.860' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (453, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:24.207' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (454, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:25.227' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (455, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:40.863' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (456, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:34:47.900' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (457, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:35:36.477' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (458, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:35:37.343' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (459, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:51.193' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (460, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:52.600' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (461, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:55.037' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (462, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:55.747' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (463, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:39:56.960' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (464, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:14.960' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (465, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:15.740' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (466, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:56.630' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (467, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:40:57.330' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (468, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:41:14.850' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (469, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:41:15.877' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (470, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:42:00.080' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (471, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:42:00.933' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (472, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:43:05.803' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (473, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:43:06.513' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (474, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:44:09.867' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (475, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:44:10.757' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (476, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:53:43.907' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (477, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T09:55:08.693' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (478, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-10T10:05:54.573' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (479, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-10T10:06:46.193' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (480, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:07:25.100' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (481, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:09:34.680' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (482, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:09:55.167' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (483, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:11:20.067' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (484, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:29:03.670' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (485, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:30:08.137' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (486, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:30:36.307' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (487, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:34:53.217' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (488, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:37:27.900' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (489, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:40:05.737' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (490, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-10T10:40:43.213' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (491, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:40:47.490' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (492, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:43:08.090' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (493, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:43:47.067' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (494, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:45:43.033' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (495, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:46:04.227' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (496, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:50:19.957' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (497, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:50:53.513' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (498, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:51:00.970' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (499, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:51:13.150' AS DateTime))
GO
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (500, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:52:13.993' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (501, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T10:53:28.627' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (502, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-10T11:54:40.013' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (503, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T09:06:30.223' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (504, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T09:06:36.527' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (505, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:06:47.203' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (506, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:13:13.293' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (507, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:18:56.153' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (508, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:23:27.327' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (509, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:25:48.893' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (510, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:28:19.263' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (511, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:31:15.863' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (512, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:34:38.440' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (513, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:42:27.603' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (514, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:43:16.207' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (515, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:44:05.513' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (516, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T09:44:28.517' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (517, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:44:34.040' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (518, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:48:35.873' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (519, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:55:26.907' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (520, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:56:33.393' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (521, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:58:02.817' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (522, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T09:59:33.287' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (523, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:15:19.960' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (524, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T10:20:35.487' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (525, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:20:41.217' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (526, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:22:11.850' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (527, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:26:33.560' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (528, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:28:07.070' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (529, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:29:36.947' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (530, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T10:32:05.757' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (531, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:32:09.997' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (532, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:32:55.990' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (533, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:34:35.230' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (534, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:37:48.123' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (535, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:40:53.060' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (536, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:44:47.500' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (537, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T10:47:48.843' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (538, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:00:05.720' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (539, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T11:05:41.690' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (540, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:05:47.497' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (541, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:08:12.227' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (542, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-12T11:12:02.797' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (543, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:12:08.273' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (544, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:17:39.220' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (545, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:24:48.920' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (546, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:28:47.260' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (547, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:32:10.653' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (548, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:34:09.007' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (549, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:43:19.550' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (550, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:44:09.547' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (551, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:49:44.000' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (552, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:50:42.627' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (553, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:52:02.277' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (554, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:53:48.857' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (555, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T11:58:51.480' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (556, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:01:38.197' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (557, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:02:47.943' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (558, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:04:43.667' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (559, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:05:30.520' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (560, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:08:14.343' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (561, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:09:15.420' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (562, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:28:00.787' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (563, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:28:56.930' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (564, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:29:22.837' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (565, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:31:22.303' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (566, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:36:02.810' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (567, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:37:22.517' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (568, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:38:28.290' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (569, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:44:24.657' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (570, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:46:16.757' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (571, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:55:46.720' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (572, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:57:37.323' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (573, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-12T12:59:34.057' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (574, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T09:08:36.277' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (575, 4, N'Cliente@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T09:10:34.690' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (576, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T09:10:39.910' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (577, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T14:58:07.593' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (578, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T14:59:21.610' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (579, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:00:26.030' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (580, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:16:45.300' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (581, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T15:17:50.770' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (582, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:17:55.527' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (583, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:20:02.177' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (584, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T15:23:43.243' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (585, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:23:47.133' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (586, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:26:49.460' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (587, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:27:25.137' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (588, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:30:55.273' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (589, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:31:13.047' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (590, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:31:48.570' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (591, 3, N'UAC@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T15:33:22.857' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (592, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:33:28.607' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (593, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:33:55.650' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (594, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:34:43.890' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (595, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:36:46.830' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (596, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:37:19.467' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (597, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:52:55.313' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (598, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:54:15.783' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (599, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:55:02.213' AS DateTime))
GO
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (600, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:55:45.377' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (601, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:57:20.130' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (602, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T15:58:07.083' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (603, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:01:34.890' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (604, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:02:10.617' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (605, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:20:52.810' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (606, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:22:35.763' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (607, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:35:11.417' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (608, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:44:11.267' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (609, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:45:49.923' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (610, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:54:02.897' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (611, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T16:54:37.110' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (612, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:10:53.267' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (613, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:12:13.593' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (614, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:14:24.747' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (615, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:14:41.747' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (616, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:16:17.920' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (617, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:16:49.187' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (618, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:19:00.920' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (619, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:20:53.950' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (620, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:23:01.133' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (621, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:23:26.407' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (622, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:24:34.850' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (623, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:26:16.773' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (624, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:28:10.330' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (625, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:30:37.893' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (626, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:32:16.193' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (627, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:33:53.860' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (628, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:35:36.823' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (629, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:35:58.723' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (630, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:36:29.350' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (631, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:37:49.183' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (632, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:38:56.090' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (633, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:39:24.957' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (634, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:40:29.607' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (635, 2, N'webmaster@gmail.com - Inicio de sesion incorrecto', N'Medio', CAST(N'2024-11-13T17:40:59.150' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (636, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:41:02.787' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (637, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:42:17.887' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (638, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:43:07.170' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (639, 2, N'webmaster@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:44:29.413' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (640, 4, N'Cliente@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:45:01.853' AS DateTime))
INSERT [dbo].[Bitacora] ([id], [id_usuario], [Detalle], [Criticidad], [Fecha]) VALUES (641, 3, N'UAC@gmail.com - Inicio sesion correctamente', N'Baja', CAST(N'2024-11-13T17:45:47.537' AS DateTime))
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Carrito] ON 

INSERT [dbo].[Carrito] ([Id], [id_producto], [id_usuario], [cantidad]) VALUES (53, 9, 3, 1)
INSERT [dbo].[Carrito] ([Id], [id_producto], [id_usuario], [cantidad]) VALUES (54, 10, 3, 1)
INSERT [dbo].[Carrito] ([Id], [id_producto], [id_usuario], [cantidad]) VALUES (55, 11, 3, 1)
SET IDENTITY_INSERT [dbo].[Carrito] OFF
GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (1, N'Sensores')
INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (2, N'PLC')
INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (3, N'Cables')
INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (4, N'CNC')
SET IDENTITY_INSERT [dbo].[Categoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Detalle_Venta] ON 

INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (6, 4, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (7, 4, 11, N'S004', N'Sensor 4', 4, 12000, 48000, 8330.58, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (8, 4, 15, N'P003', N'PLC 3', 3, 58000, 174000, 30198.35, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (9, 5, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (10, 5, 9, N'S002', N'Sensor 2', 2, 25000, 50000, 8677.69, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (11, 5, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (12, 6, 9, N'S002', N'Sensor 2', 4, 25000, 100000, 17355.37, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (13, 6, 21, N'CNC003', N'CNC 3', 1, 550000, 550000, 95454.55, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (14, 7, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (15, 7, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (16, 7, 13, N'P001', N'PLC 1', 3, 95000, 285000, 49462.81, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (17, 8, 13, N'P001', N'PLC 1', 3, 95000, 285000, 49462.81, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (18, 8, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (19, 12, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (20, 12, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (21, 12, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (22, 12, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (23, 13, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (24, 13, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (25, 13, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (26, 13, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (27, 13, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (28, 14, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (29, 14, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (30, 14, 18, N'C001', N'Cable 1', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (31, 14, 15, N'P003', N'PLC 3', 1, 58000, 58000, 10066.12, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (32, 15, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (33, 15, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (34, 15, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (35, 15, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (36, 15, 16, N'P004', N'PLC 4', 1, 45000, 45000, 7809.92, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (37, 16, 20, N'CNC002', N'CNC 2', 1, 450000, 450000, 78099.17, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (38, 16, 21, N'CNC003', N'CNC 3', 1, 550000, 550000, 95454.55, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (39, 16, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (40, 17, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (41, 17, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (42, 17, 17, N'P005', N'PLC 5', 1, 90000, 90000, 15619.83, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (43, 18, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (44, 18, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (45, 18, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (46, 18, 13, N'P001', N'PLC 1', 1, 95000, 95000, 16487.6, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (47, 19, 9, N'S002', N'Sensor 2', 3, 25000, 75000, 13016.53, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (48, 19, 10, N'S003', N'Sensor 3', 2, 54000, 108000, 18743.8, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (49, 19, 11, N'S004', N'Sensor 4', 2, 12000, 24000, 4165.29, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (50, 20, 9, N'S002', N'Sensor 2', 3, 25000, 75000, 13016.53, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (51, 20, 10, N'S003', N'Sensor 3', 1, 54000, 54000, 9371.9, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (52, 20, 11, N'S004', N'Sensor 4', 1, 12000, 12000, 2082.64, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (53, 21, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (54, 21, 8, N'S001', N'Sensor 1', 1, 35000, 35000, 3325.79, 4)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (55, 22, 8, N'S001', N'Sensor 1', 3, 35000, 105000, 9977.38, 4)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (56, 22, 9, N'S002', N'Sensor 2', 1, 25000, 25000, 4338.84, 5)
INSERT [dbo].[Detalle_Venta] ([Id], [id_venta], [id_producto], [Codigo], [Descripcion], [Cantidad], [PrecioUnitario], [Total], [IVA], [CodigoIVA]) VALUES (57, 22, 14, N'P002', N'PLC 2', 1, 105000, 105000, 18223.14, 5)
SET IDENTITY_INSERT [dbo].[Detalle_Venta] OFF
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
GO
SET IDENTITY_INSERT [dbo].[Marca] ON 

INSERT [dbo].[Marca] ([Id], [Nombre]) VALUES (1, N'Samsung')
INSERT [dbo].[Marca] ([Id], [Nombre]) VALUES (2, N'Siemens')
INSERT [dbo].[Marca] ([Id], [Nombre]) VALUES (3, N'Keyence')
INSERT [dbo].[Marca] ([Id], [Nombre]) VALUES (4, N'Honeywell')
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
SET IDENTITY_INSERT [dbo].[Permiso] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (8, N'S001', N'Sensor 1', 1, 1, 1, N'~/Images/S001.jpg', 45, 35000, 4)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (9, N'S002', N'Sensor 2', 2, 1, 1, N'~/Images/S002.jpg', 6, 25000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (10, N'S003', N'Sensor 3', 3, 1, 1, N'~/Images/S003.jpg', 21, 54000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (11, N'S004', N'Sensor 4', 1, 1, 1, N'~/Images/S004.jpg', 5, 12000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (12, N'S005', N'Sensor 5', 4, 1, 1, N'~/Images/S005.jpg', 0, 87000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (13, N'P001', N'PLC 1', 1, 2, 1, N'~/Images/P001.jpg', 3, 95000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (14, N'P002', N'PLC 2', 2, 2, 1, N'~/Images/P002.jpg', 6, 105000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (15, N'P003', N'PLC 3', 4, 2, 1, N'~/Images/P003.jpg', 2, 58000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (16, N'P004', N'PLC 4', 1, 2, 1, N'~/Images/P004.jpg', 21, 45000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (17, N'P005', N'PLC 5', 1, 2, 1, N'~/Images/P005.jpg', 3, 90000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (18, N'C001', N'Cable 1', 3, 3, 1, N'~/Images/C001.jpg', 90, 12000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (19, N'CNC001', N'CNC 1', 1, 4, 1, N'~/Images/CN001.jpg', 3, 300000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (20, N'CNC002', N'CNC 2', 4, 4, 1, N'~/Images/CN002.jpg', 4, 450000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (21, N'CNC003', N'CNC 3', 3, 4, 1, N'~/Images/CN003.jpg', 6, 550000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (22, N'CNC004', N'CNC 4', 2, 4, 1, N'~/Images/CN004.jpg', 2, 460000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (23, N'CNC005', N'CNC 5', 4, 4, 1, N'~/Images/CN005.jpg', 0, 520000, 5)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio], [codigo_iva]) VALUES (24, N'S10', N'Sensor 10', 1, 1, 0, N'', 44, 45000, 5)
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[RelatedTaxes] ON 

INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (4, 5, 21, 228099.17, 47900.83, 4)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (5, 4, 10.5, 31674.21, 3325.79, 5)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (6, 5, 21, 119834.71, 25165.29, 5)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (7, 5, 21, 537190.08, 112809.92, 6)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (8, 5, 21, 300826.45, 63173.55, 7)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (9, 5, 21, 245454.55, 51545.45, 8)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (10, 4, 10.5, 31674.21, 3325.79, 12)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (11, 5, 21, 143801.65, 30198.35, 12)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (12, 4, 10.5, 31674.21, 3325.79, 13)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (13, 5, 21, 161983.47, 34016.53, 13)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (14, 4, 10.5, 31674.21, 3325.79, 14)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (15, 5, 21, 136363.64, 28636.36, 14)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (16, 5, 21, 267768.6, 56231.4, 15)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (17, 5, 21, 913223.14, 191776.86, 16)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (18, 5, 21, 139669.42, 29330.58, 17)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (19, 5, 21, 153719.01, 32280.99, 18)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (20, 5, 21, 171074.38, 35925.62, 19)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (21, 5, 21, 116528.93, 24471.07, 20)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (22, 5, 21, 20661.16, 4338.84, 21)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (23, 4, 10.5, 31674.21, 3325.79, 21)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (24, 4, 10.5, 95022.62, 9977.38, 22)
INSERT [dbo].[RelatedTaxes] ([id], [codigoIVA], [TasaIVA], [BaseImponible], [TotalIVA], [id_venta]) VALUES (25, 5, 21, 107438.02, 22561.98, 22)
SET IDENTITY_INSERT [dbo].[RelatedTaxes] OFF
GO
SET IDENTITY_INSERT [dbo].[tokenAFIP] ON 

INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (3, N'pbaeGF2SmiYdVjWebSQKbewq7Rb//tv+bVTTFlCQRaPCQr+xwH+gZ4n7zs4/5EkWQstLadM0rWwFHA9Ss4OYsrMvDEAXqf3tBESk/Mqk8R3D2sdtUlXd6Lxl5oo7x0D7jDBxIdGZ/AhY/WqpP5Ax1v3Ult7OUVAL2L2k96NXj6Q=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iOTY0MDgwMDg3IiBnZW5fdGltZT0iMTczMTEwMTc1MSIgZXhwX3RpbWU9IjE3MzExNDUwMTEiLz4KICAgIDxvcGVyYXRpb24gdHlwZT0ibG9naW4iIHZhbHVlPSJncmFudGVkIj4KICAgICAgICA8bG9naW4gZW50aXR5PSIzMzY5MzQ1MDIzOSIgc2VydmljZT0id3NmZSIgdWlkPSJTRVJJQUxOVU1CRVI9Q1VJVCAyMDM1ODU0NTQ5MiwgQ049dGZpIiBhdXRobWV0aG9kPSJjbXMiIHJlZ21ldGhvZD0iMjIiPgogICAgICAgICAgICA8cmVsYXRpb25zPgogICAgICAgICAgICAgICAgPHJlbGF0aW9uIGtleT0iMjAzNTg1NDU0OTIiIHJlbHR5cGU9IjQiLz4KICAgICAgICAgICAgPC9yZWxhdGlvbnM+CiAgICAgICAgPC9sb2dpbj4KICAgIDwvb3BlcmF0aW9uPgo8L3Nzbz4K', CAST(N'2024-11-09T06:36:51.960' AS DateTime), 1, CAST(N'2024-11-08T18:36:51.960' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (4, N'XNXDIYHNaiozZBC0sPRoEWkXmYY62IV11QIxaRS/RNpH5xfETgtdGFmvKWIoZvQ4TFEEuXC/4ooQJ+V+JCrVYO2GHn9BbH1tT9QiS3Uj68iSz0diA81r17w8qsYTkWSfoTN+HNAMVAmaF3yWHNhICMpAqb2uklLfaGJNfa0z2FA=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iNzE1NzgxNjAiIGdlbl90aW1lPSIxNzMxMjQ2NjA1IiBleHBfdGltZT0iMTczMTI4OTg2NSIvPgogICAgPG9wZXJhdGlvbiB0eXBlPSJsb2dpbiIgdmFsdWU9ImdyYW50ZWQiPgogICAgICAgIDxsb2dpbiBlbnRpdHk9IjMzNjkzNDUwMjM5IiBzZXJ2aWNlPSJ3c2ZlIiB1aWQ9IlNFUklBTE5VTUJFUj1DVUlUIDIwMzU4NTQ1NDkyLCBDTj10ZmkiIGF1dGhtZXRob2Q9ImNtcyIgcmVnbWV0aG9kPSIyMiI+CiAgICAgICAgICAgIDxyZWxhdGlvbnM+CiAgICAgICAgICAgICAgICA8cmVsYXRpb24ga2V5PSIyMDM1ODU0NTQ5MiIgcmVsdHlwZT0iNCIvPgogICAgICAgICAgICA8L3JlbGF0aW9ucz4KICAgICAgICA8L2xvZ2luPgogICAgPC9vcGVyYXRpb24+Cjwvc3NvPgo=', CAST(N'2024-11-10T22:51:05.837' AS DateTime), 1, CAST(N'2024-11-10T10:51:05.837' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (5, N'BNOmLoBs9Ar1L61wCMnO8d4WbjFAZc3E3DnaWBq1nphS8e9bSElCNJLpR//JIzqUTt2VCbNzskM0CBTBJ/WeWj3n/Qx8xL2uwCQ/ztmXNFMg8cg7/cm7NoGoP1bZyX1wdWWfhzX+JwnbD8EE36uqBaFEFpBIzgpGb9emzt5P7Q0=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iMzE5NDU3NjQ4OSIgZ2VuX3RpbWU9IjE3MzE0MTM4ODUiIGV4cF90aW1lPSIxNzMxNDU3MTQ1Ii8+CiAgICA8b3BlcmF0aW9uIHR5cGU9ImxvZ2luIiB2YWx1ZT0iZ3JhbnRlZCI+CiAgICAgICAgPGxvZ2luIGVudGl0eT0iMzM2OTM0NTAyMzkiIHNlcnZpY2U9IndzZmUiIHVpZD0iU0VSSUFMTlVNQkVSPUNVSVQgMjAzNTg1NDU0OTIsIENOPXRmaSIgYXV0aG1ldGhvZD0iY21zIiByZWdtZXRob2Q9IjIyIj4KICAgICAgICAgICAgPHJlbGF0aW9ucz4KICAgICAgICAgICAgICAgIDxyZWxhdGlvbiBrZXk9IjIwMzU4NTQ1NDkyIiByZWx0eXBlPSI0Ii8+CiAgICAgICAgICAgIDwvcmVsYXRpb25zPgogICAgICAgIDwvbG9naW4+CiAgICA8L29wZXJhdGlvbj4KPC9zc28+Cg==', CAST(N'2024-11-12T21:19:05.157' AS DateTime), 1, CAST(N'2024-11-12T09:19:05.157' AS DateTime))
INSERT [dbo].[tokenAFIP] ([id], [sign], [token], [FechaExpiracion], [codigo], [FechaGeneracion]) VALUES (6, N'fVeiFzJx0VelXxwgWBWIEDGI9Vpz5SccpngNvsKCMPvkt8/BDenIvGHHMZlAxS4Y6dgwX7o/jE7c5Qe4G7nlGre9B+km9a+iu9hG8jKZ73966czkuioYKRAIjUA3tbVjEtomCM/RBx4KN/nOq6XT0UddkcbzX06q3iEXggEspBk=', N'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iMzE2NDQ2NTQ5OSIgZ2VuX3RpbWU9IjE3MzE1MjI4MzUiIGV4cF90aW1lPSIxNzMxNTY2MDk1Ii8+CiAgICA8b3BlcmF0aW9uIHR5cGU9ImxvZ2luIiB2YWx1ZT0iZ3JhbnRlZCI+CiAgICAgICAgPGxvZ2luIGVudGl0eT0iMzM2OTM0NTAyMzkiIHNlcnZpY2U9IndzZmUiIHVpZD0iU0VSSUFMTlVNQkVSPUNVSVQgMjAzNTg1NDU0OTIsIENOPXRmaSIgYXV0aG1ldGhvZD0iY21zIiByZWdtZXRob2Q9IjIyIj4KICAgICAgICAgICAgPHJlbGF0aW9ucz4KICAgICAgICAgICAgICAgIDxyZWxhdGlvbiBrZXk9IjIwMzU4NTQ1NDkyIiByZWx0eXBlPSI0Ii8+CiAgICAgICAgICAgIDwvcmVsYXRpb25zPgogICAgICAgIDwvbG9naW4+CiAgICA8L29wZXJhdGlvbj4KPC9zc28+Cg==', CAST(N'2024-11-14T03:34:55.963' AS DateTime), 1, CAST(N'2024-11-13T15:34:55.963' AS DateTime))
SET IDENTITY_INSERT [dbo].[tokenAFIP] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (1, N'cnJAZ21haWwuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Rodrigo', 1111, 0, N'Activo', N'Um9kcmlnbw==', N'R29uemFsZXo=', N'DNI', N'Consumidor Final')
INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (2, N'd2VibWFzdGVyQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'WebMaster', 1111111, 0, N'Activo', N'V2ViTWFzdGVy', N'V2ViTWFzdGVy', N'DNI', N'Consumidor Final')
INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (3, N'VUFDQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Usuario Administrador Contable(UAC)', 222222, 0, N'Activo', N'VUFD', N'VUFD', N'DNI', N'Consumidor Final')
INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (4, N'Q2xpZW50ZUBnbWFpbC5jb20=', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Cliente', 333333, 0, N'Activo', N'Q2xpZW50ZQ==', N'Q2xpZW50ZQ==', N'DNI', N'Consumidor Final')
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
SET IDENTITY_INSERT [dbo].[UsuarioPermiso] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (4, CAST(N'2024-10-30T15:52:20.000' AS DateTime), N'Venta', 74452204481671, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 14, 4, N'6', 276000, 47900.83, 228099.17, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (5, CAST(N'2024-10-30T17:01:30.000' AS DateTime), N'Venta', 74452204478641, CAST(N'2024-11-18T00:00:00.000' AS DateTime), 1, 9, 4, N'6', 180000, 28491.08, 151508.92, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (6, CAST(N'2024-10-30T19:38:19.000' AS DateTime), N'Venta', 74452204479228, CAST(N'2024-11-18T00:00:00.000' AS DateTime), 1, 10, 4, N'6', 650000, 112809.92, 537190.08, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (7, CAST(N'2024-10-30T19:40:06.000' AS DateTime), N'Venta', 74452204481537, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 13, 4, N'6', 364000, 63173.55, 300826.45, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (8, CAST(N'2024-10-30T20:02:46.000' AS DateTime), N'Venta', 74452204481511, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 12, 4, N'6', 297000, 51545.45, 245454.55, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (12, CAST(N'2024-11-09T02:22:59.000' AS DateTime), N'Venta', 74452204481906, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 15, 3, N'6', 209000, 33524.14, 175475.86, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (13, CAST(N'2024-11-09T02:24:54.000' AS DateTime), N'Venta', 74452204481951, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 16, 3, N'6', 231000, 37342.32, 193657.68, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (14, CAST(N'2024-11-09T02:27:12.000' AS DateTime), N'Venta', 74452204481964, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 17, 3, N'6', 200000, 31962.15, 168037.85, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (15, CAST(N'2024-11-09T02:27:43.000' AS DateTime), N'Venta', 74452204481977, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 18, 3, N'6', 324000, 56231.4, 267768.6, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (16, CAST(N'2024-11-09T02:31:49.000' AS DateTime), N'Venta', 74452204482363, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 19, 3, N'6', 1105000, 191776.86, 913223.14, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (17, CAST(N'2024-11-09T03:25:01.000' AS DateTime), N'Venta', 74452204482787, CAST(N'2024-11-19T00:00:00.000' AS DateTime), 1, 22, 3, N'6', 169000, 29330.58, 139669.42, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0wOSIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMiwiaW1wb3J0ZSI6MTY5MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDQ4Mjc4N30=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (18, CAST(N'2024-11-10T10:50:51.000' AS DateTime), N'Venta', 74452204513996, CAST(N'2024-11-20T00:00:00.000' AS DateTime), 1, 23, 3, N'6', 186000, 32280.99, 153719.01, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMCIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyMywiaW1wb3J0ZSI6MTg2MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ1MjIwNDUxMzk5Nn0=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (19, CAST(N'2024-11-12T09:07:24.000' AS DateTime), N'Venta', 74462204758762, CAST(N'2024-11-22T00:00:00.000' AS DateTime), 1, 24, 3, N'6', 207000, 35925.62, 171074.38, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMiIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyNCwiaW1wb3J0ZSI6MjA3MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjoyMjIyMjIsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDc1ODc2Mn0=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (20, CAST(N'2024-11-13T15:34:21.000' AS DateTime), N'Venta', 74462204866838, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 29, 4, N'6', 141000, 24471.07, 116528.93, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjoyOSwiaW1wb3J0ZSI6MTQxMDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDg2NjgzOH0=')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (21, CAST(N'2024-11-13T15:37:07.000' AS DateTime), N'Venta', 74462204941203, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 30, 4, N'6', 60000, 7664.63, 52335.37, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozMCwiaW1wb3J0ZSI6NjAwMDAuMCwibW9uZWRhIjoiUEVTIiwiY3R6IjoxLjAsInRpcG9Eb2NSZWMiOjk2LCJucm9Eb2NSZWMiOjMzMzMzMywidGlwb0NvZEF1dCI6IkUiLCJjb2RBdXQiOjc0NDYyMjA0OTQxMjAzfQ==')
INSERT [dbo].[Venta] ([Id], [Fecha], [Detalle], [CodigoAutorizacion], [FechaVtoCae], [PuntoDeVenta], [NumeroVenta], [id_usuario], [TipoComprobante], [Total], [IVA], [TotalGravado], [TipoAutorizacion], [Estado], [Observaciones], [Facturado], [QRData]) VALUES (22, CAST(N'2024-11-13T17:45:21.000' AS DateTime), N'Venta', 74462204941305, CAST(N'2024-11-23T00:00:00.000' AS DateTime), 1, 31, 4, N'6', 235000, 32539.36, 202460.64, N'CAE', N'A', N'Autorizada', 1, N'https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyNC0xMS0xMyIsImN1aXQiOjIwMzU4NTQ1NDkyLCJwdG9WdGEiOjEsInRpcG9DbXAiOiI2IiwibnJvQ21wIjozMSwiaW1wb3J0ZSI6MjM1MDAwLjAsIm1vbmVkYSI6IlBFUyIsImN0eiI6MS4wLCJ0aXBvRG9jUmVjIjo5NiwibnJvRG9jUmVjIjozMzMzMzMsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0Ijo3NDQ2MjIwNDk0MTMwNX0=')
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
USE [master]
GO
ALTER DATABASE [EnerTech] SET  READ_WRITE 
GO
