USE [master]
GO
/****** Object:  Database [EnerTech]    Script Date: 25/10/2024 08:00:42 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 25/10/2024 08:00:42 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 25/10/2024 08:00:42 ******/
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
/****** Object:  Table [dbo].[Marca]    Script Date: 25/10/2024 08:00:42 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 25/10/2024 08:00:42 ******/
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
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 25/10/2024 08:00:42 ******/
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
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
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

INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad]) VALUES (1, N'P001', N'Sensor M15', 1, 1, 1, NULL, 10)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad]) VALUES (2, N'P002', N'Sensores G11', 1, 1, 1, N'', 18)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad]) VALUES (3, N'P003', N'Sensor Q113', 1, 1, 0, N'', 551)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad]) VALUES (4, N'P004', N'Sensor a distancia', 1, 1, 0, N'', 441)
INSERT [dbo].[Producto] ([id], [Codigo], [Descripcion], [id_marca], [id_categoria], [Catalogo], [Imagen], [Cantidad]) VALUES (6, N'P005', N'Sensores G15', 1, 1, 0, N'~/Images/p005.jpg', 5)
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
