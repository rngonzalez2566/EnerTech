USE [master]
GO
/****** Object:  Database [EnerTech]    Script Date: 27/10/2024 23:05:00 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 27/10/2024 23:05:00 ******/
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
/****** Object:  Table [dbo].[Carrito]    Script Date: 27/10/2024 23:05:00 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 27/10/2024 23:05:00 ******/
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
/****** Object:  Table [dbo].[Marca]    Script Date: 27/10/2024 23:05:00 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 27/10/2024 23:05:00 ******/
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
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 27/10/2024 23:05:00 ******/
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
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Carrito] ON 

INSERT [dbo].[Carrito] ([Id], [id_producto], [id_usuario], [cantidad]) VALUES (8, 6, 3, 2)
INSERT [dbo].[Carrito] ([Id], [id_producto], [id_usuario], [cantidad]) VALUES (9, 3, 3, 1)
SET IDENTITY_INSERT [dbo].[Carrito] OFF
GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (1, N'Sensores')
SET IDENTITY_INSERT [dbo].[Categoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Marca] ON 

INSERT [dbo].[Marca] ([Id], [Nombre]) VALUES (1, N'Samsung')
SET IDENTITY_INSERT [dbo].[Marca] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio]) VALUES (1, N'P001', N'Sensor M15', 1, 1, 1, N'', 10, 2000)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio]) VALUES (2, N'P002', N'Sensores G11', 1, 1, 0, N'', 0, 4000)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio]) VALUES (3, N'P003', N'Sensor Q113', 1, 1, 0, N'', 551, 12550)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio]) VALUES (4, N'P004', N'Sensor a distancia', 1, 1, 0, N'', 441, 23441)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad], [Precio]) VALUES (6, N'P005', N'Sensores G15', 1, 1, 0, N'~/Images/p005.jpg', 5, 145661)
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (1, N'cnJAZ21haWwuY29t', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Rodrigo', 1111, 0, N'Activo', N'Um9kcmlnbw==', N'R29uemFsZXo=', N'DNI', N'Consumidor Final')
INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (2, N'd2VibWFzdGVyQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'WebMaster', 1111111, 0, N'Activo', N'V2ViTWFzdGVy', N'V2ViTWFzdGVy', N'DNI', N'Consumidor Final')
INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (3, N'VUFDQGdtYWlsLmNvbQ==', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Usuario Administrador Contable(UAC)', 222222, 0, N'Activo', N'VUFD', N'VUFD', N'DNI', N'Consumidor Final')
INSERT [dbo].[Usuario] ([Id], [Email], [Password], [RazonSocial], [Identificacion], [Contador], [Estado], [Nombre], [Apellido], [TipoDocumento], [TipoCliente]) VALUES (4, N'Q2xpZW50ZUBnbWFpbC5jb20=', N'qGDTEj76cdzAvT2eXvu+cIloeqPANJBZo5ivElu7CzM=', N'Cliente', 333333, 0, N'Activo', N'Q2xpZW50ZQ==', N'Q2xpZW50ZQ==', N'DNI', N'Consumidor Final')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
USE [master]
GO
ALTER DATABASE [EnerTech] SET  READ_WRITE 
GO
