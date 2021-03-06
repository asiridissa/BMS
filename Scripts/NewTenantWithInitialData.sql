USE [master]
GO
/****** Object:  Database [BMS_1_05]    Script Date: 11/6/2016 10:27:51 PM ******/
CREATE DATABASE [BMS_1_05]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BMS_1_05', FILENAME = N'D:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BMS_1_05.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BMS_1_05_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BMS_1_05_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BMS_1_05] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BMS_1_05].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BMS_1_05] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BMS_1_05] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BMS_1_05] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BMS_1_05] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BMS_1_05] SET ARITHABORT OFF 
GO
ALTER DATABASE [BMS_1_05] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BMS_1_05] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BMS_1_05] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BMS_1_05] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BMS_1_05] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BMS_1_05] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BMS_1_05] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BMS_1_05] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BMS_1_05] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BMS_1_05] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BMS_1_05] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BMS_1_05] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BMS_1_05] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BMS_1_05] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BMS_1_05] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BMS_1_05] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BMS_1_05] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BMS_1_05] SET RECOVERY FULL 
GO
ALTER DATABASE [BMS_1_05] SET  MULTI_USER 
GO
ALTER DATABASE [BMS_1_05] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BMS_1_05] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BMS_1_05] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BMS_1_05] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BMS_1_05] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BMS_1_05', N'ON'
GO
USE [BMS_1_05]
GO
/****** Object:  Schema [Bill]    Script Date: 11/6/2016 10:27:51 PM ******/
CREATE SCHEMA [Bill]
GO
/****** Object:  Schema [Item]    Script Date: 11/6/2016 10:27:51 PM ******/
CREATE SCHEMA [Item]
GO
/****** Object:  Schema [Payment]    Script Date: 11/6/2016 10:27:51 PM ******/
CREATE SCHEMA [Payment]
GO
/****** Object:  Schema [Store]    Script Date: 11/6/2016 10:27:51 PM ******/
CREATE SCHEMA [Store]
GO
/****** Object:  Table [Bill].[BillHeader]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Bill].[BillHeader](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BillStatusId] [int] NOT NULL,
	[BillNo] [nvarchar](50) NOT NULL,
	[BillingDate] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[AreaId] [int] NOT NULL,
	[VehicleId] [int] NOT NULL,
	[Discount] [decimal](9, 4) NOT NULL,
	[Deduction] [decimal](19, 4) NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[PaidAmount] [decimal](19, 4) NOT NULL,
	[DeliveryDate] [datetime] NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_BillHeader] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Bill].[BillLine]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Bill].[BillLine](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BillHeaderId] [bigint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UnitPrice] [decimal](19, 4) NOT NULL,
	[WholeSale] [bit] NOT NULL,
	[Sale] [int] NOT NULL,
	[FreeIssue] [int] NOT NULL,
	[Damage] [int] NOT NULL,
	[Expire] [int] NOT NULL,
	[GoodReturn] [int] NOT NULL,
	[Discount] [decimal](9, 4) NOT NULL,
	[Deduction] [decimal](19, 4) NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_BillLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Bill].[BillStatus]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Bill].[BillStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NULL,
	[CreatedUserId] [nvarchar](128) NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_BillStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Bill].[RoadDistribution]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Bill].[RoadDistribution](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[VehicleId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UnitsPerCase] [int] NOT NULL,
	[BalanceStockCase] [int] NOT NULL,
	[BalanceStockPiece] [int] NOT NULL,
	[BalanceStockQuantity] [int] NOT NULL,
	[LoadingCase] [int] NOT NULL,
	[LoadingPiece] [int] NOT NULL,
	[LoadingQuantity] [int] NOT NULL,
	[UnloadingCase] [int] NOT NULL,
	[UnloadingPiece] [int] NOT NULL,
	[UnloadingQuantity] [int] NOT NULL,
	[RoadDistributionCase] [int] NOT NULL,
	[RoadDistributionPiece] [int] NOT NULL,
	[RoadDistributionQuantity] [int] NOT NULL,
	[BillingQuantity] [int] NOT NULL,
	[Varience] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
	[FinalizedDateTime] [datetime] NULL,
	[FinalizedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_RoadDistribution] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Areas]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK__Areas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AreaId] [int] NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[Phone] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataChangeLog]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataChangeLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Table] [nvarchar](50) NOT NULL,
	[NatureOfAction] [nvarchar](50) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [int] NOT NULL,
 CONSTRAINT [PK_DataChangeLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UnitOfMeasure]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitOfMeasure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[No] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Item].[Brand]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[Brand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Item].[Category]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Item].[Item]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[Item](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BrandId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[UOMId] [int] NOT NULL,
	[UOMValue] [decimal](9, 5) NOT NULL,
	[UnitsPerCase] [int] NOT NULL,
	[PurchasePrice] [decimal](9, 5) NOT NULL,
	[SalesPrice] [decimal](9, 5) NOT NULL,
	[WholesalePrice] [decimal](9, 5) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Item].[Product]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Payment].[BillPayment]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payment].[BillPayment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BillHeaderId] [bigint] NOT NULL,
	[PaymentMethodId] [int] NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_BillPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Payment].[BillPaymentCheque]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payment].[BillPaymentCheque](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BillPaymentId] [bigint] NOT NULL,
	[ChequeId] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_BillPaymentCheque] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Payment].[Cheque]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payment].[Cheque](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Bank] [nvarchar](50) NOT NULL,
	[Branch] [nvarchar](50) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ChequeDate] [datetime] NOT NULL,
	[ChequeStatusId] [int] NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[UtilizedAmount] [decimal](19, 4) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Cheque] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Payment].[ChequeStatus]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payment].[ChequeStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_ChequeStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Payment].[PaymentMethod]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payment].[PaymentMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[InvoiceHeader]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[InvoiceHeader](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [nvarchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Finalized] [bit] NOT NULL,
	[FinalizedUserId] [nvarchar](128) NULL,
	[FinalizedDateTime] [datetime] NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[InvoiceLine]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[InvoiceLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceHeaderId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Case] [int] NOT NULL,
	[Piece] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[Lot]    Script Date: 11/6/2016 10:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Lot](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceLineId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Case] [int] NOT NULL,
	[Piece] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[CreatedUserId] [nvarchar](128) NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[DeletedUserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_Lots] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [Bill].[BillStatus] ON 

GO
INSERT [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'Billed', NULL, CAST(N'2016-10-15T14:19:38.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'Delivered', NULL, CAST(N'2016-10-14T23:15:34.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'Paid', NULL, CAST(N'2016-10-14T23:15:34.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (4, N'Credit', NULL, CAST(N'2016-10-14T23:15:34.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
SET IDENTITY_INSERT [Bill].[BillStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[UnitOfMeasure] ON 

GO
INSERT [dbo].[UnitOfMeasure] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'g', N'Gram', CAST(N'2016-10-15T15:32:08.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [dbo].[UnitOfMeasure] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'kg', N'Kilo Gram', CAST(N'2016-10-15T15:32:08.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [dbo].[UnitOfMeasure] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'l', N'Leter', CAST(N'2016-10-29T10:11:43.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[UnitOfMeasure] OFF
GO
SET IDENTITY_INSERT [Payment].[ChequeStatus] ON 

GO
INSERT [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'Received', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'Banked', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'Cleared', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (4, N'Bounced', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
SET IDENTITY_INSERT [Payment].[ChequeStatus] OFF
GO
SET IDENTITY_INSERT [Payment].[PaymentMethod] ON 

GO
INSERT [Payment].[PaymentMethod] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'Cash', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Payment].[PaymentMethod] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'Credit', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
INSERT [Payment].[PaymentMethod] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'Cheque', NULL, CAST(N'2016-10-17T00:00:00.000' AS DateTime), N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
GO
SET IDENTITY_INSERT [Payment].[PaymentMethod] OFF
GO
ALTER TABLE [Bill].[BillHeader] ADD  CONSTRAINT [DF_BillHeader_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Amount1]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_WholeSale]  DEFAULT ((0)) FOR [WholeSale]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Sale]  DEFAULT ((0)) FOR [Sale]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_FreeIssue]  DEFAULT ((0)) FOR [FreeIssue]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Damage]  DEFAULT ((0)) FOR [Damage]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Expire]  DEFAULT ((0)) FOR [Expire]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_GoodReturn]  DEFAULT ((0)) FOR [GoodReturn]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Deduction]  DEFAULT ((0)) FOR [Deduction]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_Value]  DEFAULT ((0)) FOR [Value]
GO
ALTER TABLE [Bill].[BillLine] ADD  CONSTRAINT [DF_BillLine_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Bill].[BillStatus] ADD  CONSTRAINT [DF_BillStatus_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_BalanceStockCase]  DEFAULT ((0)) FOR [BalanceStockCase]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_BalanceStockPiece]  DEFAULT ((0)) FOR [BalanceStockPiece]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_BalanceStockQuantity]  DEFAULT ((0)) FOR [BalanceStockQuantity]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_LoadingCase]  DEFAULT ((0)) FOR [LoadingCase]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_LoadingPiece]  DEFAULT ((0)) FOR [LoadingPiece]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_LoadingQuantity]  DEFAULT ((0)) FOR [LoadingQuantity]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_UnloadingCase]  DEFAULT ((0)) FOR [UnloadingCase]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_UnloadingPiece]  DEFAULT ((0)) FOR [UnloadingPiece]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_UnloadingQuantity]  DEFAULT ((0)) FOR [UnloadingQuantity]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_RoadDistributionCase]  DEFAULT ((0)) FOR [RoadDistributionCase]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_UnloadingPiece1]  DEFAULT ((0)) FOR [RoadDistributionPiece]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_UnloadingQuantity1]  DEFAULT ((0)) FOR [RoadDistributionQuantity]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_BillingQuantity]  DEFAULT ((0)) FOR [BillingQuantity]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_Varience]  DEFAULT ((0)) FOR [Varience]
GO
ALTER TABLE [Bill].[RoadDistribution] ADD  CONSTRAINT [DF_RoadDistribution_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[Areas] ADD  CONSTRAINT [DF_Areas_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customers_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[UnitOfMeasure] ADD  CONSTRAINT [DF_UnitOfMeasure_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[Vehicle] ADD  CONSTRAINT [DF_Vehicles_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Item].[Brand] ADD  CONSTRAINT [DF_Brand_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Item].[Category] ADD  CONSTRAINT [DF_Category_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Item].[Item] ADD  CONSTRAINT [DF_Item_UOMValue]  DEFAULT ((1)) FOR [UOMValue]
GO
ALTER TABLE [Item].[Item] ADD  CONSTRAINT [DF_Item_PurchasePrice]  DEFAULT ((0)) FOR [PurchasePrice]
GO
ALTER TABLE [Item].[Item] ADD  CONSTRAINT [DF_Item_SelesPrice]  DEFAULT ((0)) FOR [SalesPrice]
GO
ALTER TABLE [Item].[Item] ADD  CONSTRAINT [DF_Item_WholesalePrice]  DEFAULT ((0)) FOR [WholesalePrice]
GO
ALTER TABLE [Item].[Item] ADD  CONSTRAINT [DF_Item_CreatedDateTime]  DEFAULT (getdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Item].[Product] ADD  CONSTRAINT [DF_Products_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Payment].[BillPayment] ADD  CONSTRAINT [DF_BillPayment_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Payment].[BillPaymentCheque] ADD  CONSTRAINT [DF_BillPaymentCheque_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Payment].[Cheque] ADD  CONSTRAINT [DF_Cheque_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [Payment].[Cheque] ADD  CONSTRAINT [DF_Cheque_UtilizedAmount]  DEFAULT ((0)) FOR [UtilizedAmount]
GO
ALTER TABLE [Payment].[Cheque] ADD  CONSTRAINT [DF_Cheque_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Payment].[ChequeStatus] ADD  CONSTRAINT [DF_ChequeStatus_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Payment].[PaymentMethod] ADD  CONSTRAINT [DF_PaymentMethod_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Store].[InvoiceHeader] ADD  CONSTRAINT [DF_InvoiceHeader_Finalized]  DEFAULT ((0)) FOR [Finalized]
GO
ALTER TABLE [Store].[InvoiceHeader] ADD  CONSTRAINT [DF_InvoiceHeader_CreatedDateTime1]  DEFAULT (getutcdate()) FOR [FinalizedDateTime]
GO
ALTER TABLE [Store].[InvoiceHeader] ADD  CONSTRAINT [DF_InvoiceHeader_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Store].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_Case]  DEFAULT ((0)) FOR [Case]
GO
ALTER TABLE [Store].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_Piece]  DEFAULT ((0)) FOR [Piece]
GO
ALTER TABLE [Store].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_CreatedDateTime]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [Store].[Lot] ADD  CONSTRAINT [DF_Lot_StockQty]  DEFAULT ((0)) FOR [Piece]
GO
ALTER TABLE [Store].[Lot] ADD  CONSTRAINT [DF_Lot_CreatedUserId]  DEFAULT (getutcdate()) FOR [CreatedUserId]
GO
ALTER TABLE [Bill].[BillHeader]  WITH CHECK ADD  CONSTRAINT [FK_BillHeader_Areas] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [Bill].[BillHeader] CHECK CONSTRAINT [FK_BillHeader_Areas]
GO
ALTER TABLE [Bill].[BillHeader]  WITH CHECK ADD  CONSTRAINT [FK_BillHeader_BillStatus] FOREIGN KEY([BillStatusId])
REFERENCES [Bill].[BillStatus] ([Id])
GO
ALTER TABLE [Bill].[BillHeader] CHECK CONSTRAINT [FK_BillHeader_BillStatus]
GO
ALTER TABLE [Bill].[BillHeader]  WITH CHECK ADD  CONSTRAINT [FK_BillHeader_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [Bill].[BillHeader] CHECK CONSTRAINT [FK_BillHeader_Customers]
GO
ALTER TABLE [Bill].[BillHeader]  WITH CHECK ADD  CONSTRAINT [FK_BillHeader_Vehicles] FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicle] ([Id])
GO
ALTER TABLE [Bill].[BillHeader] CHECK CONSTRAINT [FK_BillHeader_Vehicles]
GO
ALTER TABLE [Bill].[BillLine]  WITH CHECK ADD  CONSTRAINT [FK_BillLine_BillHeader] FOREIGN KEY([BillHeaderId])
REFERENCES [Bill].[BillHeader] ([Id])
GO
ALTER TABLE [Bill].[BillLine] CHECK CONSTRAINT [FK_BillLine_BillHeader]
GO
ALTER TABLE [Bill].[BillLine]  WITH CHECK ADD  CONSTRAINT [FK_BillLine_Item] FOREIGN KEY([ItemId])
REFERENCES [Item].[Item] ([Id])
GO
ALTER TABLE [Bill].[BillLine] CHECK CONSTRAINT [FK_BillLine_Item]
GO
ALTER TABLE [Bill].[RoadDistribution]  WITH CHECK ADD  CONSTRAINT [FK_RoadDistribution_Item] FOREIGN KEY([ItemId])
REFERENCES [Item].[Item] ([Id])
GO
ALTER TABLE [Bill].[RoadDistribution] CHECK CONSTRAINT [FK_RoadDistribution_Item]
GO
ALTER TABLE [Bill].[RoadDistribution]  WITH CHECK ADD  CONSTRAINT [FK_RoadDistribution_Vehicles] FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicle] ([Id])
GO
ALTER TABLE [Bill].[RoadDistribution] CHECK CONSTRAINT [FK_RoadDistribution_Vehicles]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Areas] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customers_Areas]
GO
ALTER TABLE [Item].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Brand] FOREIGN KEY([BrandId])
REFERENCES [Item].[Brand] ([Id])
GO
ALTER TABLE [Item].[Item] CHECK CONSTRAINT [FK_Item_Brand]
GO
ALTER TABLE [Item].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Category] FOREIGN KEY([CategoryId])
REFERENCES [Item].[Category] ([Id])
GO
ALTER TABLE [Item].[Item] CHECK CONSTRAINT [FK_Item_Category]
GO
ALTER TABLE [Item].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Product] FOREIGN KEY([ProductId])
REFERENCES [Item].[Product] ([Id])
GO
ALTER TABLE [Item].[Item] CHECK CONSTRAINT [FK_Item_Product]
GO
ALTER TABLE [Item].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_UnitOfMeasure] FOREIGN KEY([UOMId])
REFERENCES [dbo].[UnitOfMeasure] ([Id])
GO
ALTER TABLE [Item].[Item] CHECK CONSTRAINT [FK_Item_UnitOfMeasure]
GO
ALTER TABLE [Payment].[BillPayment]  WITH CHECK ADD  CONSTRAINT [FK_BillPayment_BillHeader] FOREIGN KEY([BillHeaderId])
REFERENCES [Bill].[BillHeader] ([Id])
GO
ALTER TABLE [Payment].[BillPayment] CHECK CONSTRAINT [FK_BillPayment_BillHeader]
GO
ALTER TABLE [Payment].[BillPayment]  WITH CHECK ADD  CONSTRAINT [FK_BillPayment_PaymentMethod] FOREIGN KEY([PaymentMethodId])
REFERENCES [Payment].[PaymentMethod] ([Id])
GO
ALTER TABLE [Payment].[BillPayment] CHECK CONSTRAINT [FK_BillPayment_PaymentMethod]
GO
ALTER TABLE [Payment].[BillPaymentCheque]  WITH CHECK ADD  CONSTRAINT [FK_BillPaymentCheque_BillPayment] FOREIGN KEY([BillPaymentId])
REFERENCES [Payment].[BillPayment] ([Id])
GO
ALTER TABLE [Payment].[BillPaymentCheque] CHECK CONSTRAINT [FK_BillPaymentCheque_BillPayment]
GO
ALTER TABLE [Payment].[BillPaymentCheque]  WITH CHECK ADD  CONSTRAINT [FK_BillPaymentCheque_Cheque] FOREIGN KEY([ChequeId])
REFERENCES [Payment].[Cheque] ([Id])
GO
ALTER TABLE [Payment].[BillPaymentCheque] CHECK CONSTRAINT [FK_BillPaymentCheque_Cheque]
GO
ALTER TABLE [Payment].[Cheque]  WITH CHECK ADD  CONSTRAINT [FK_Cheque_ChequeStatus] FOREIGN KEY([ChequeStatusId])
REFERENCES [Payment].[ChequeStatus] ([Id])
GO
ALTER TABLE [Payment].[Cheque] CHECK CONSTRAINT [FK_Cheque_ChequeStatus]
GO
ALTER TABLE [Payment].[Cheque]  WITH CHECK ADD  CONSTRAINT [FK_Cheque_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [Payment].[Cheque] CHECK CONSTRAINT [FK_Cheque_Customer]
GO
ALTER TABLE [Store].[InvoiceLine]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceLine_InvoiceHeader] FOREIGN KEY([InvoiceHeaderId])
REFERENCES [Store].[InvoiceHeader] ([Id])
GO
ALTER TABLE [Store].[InvoiceLine] CHECK CONSTRAINT [FK_InvoiceLine_InvoiceHeader]
GO
ALTER TABLE [Store].[InvoiceLine]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceLine_Item] FOREIGN KEY([ItemId])
REFERENCES [Item].[Item] ([Id])
GO
ALTER TABLE [Store].[InvoiceLine] CHECK CONSTRAINT [FK_InvoiceLine_Item]
GO
ALTER TABLE [Store].[Lot]  WITH CHECK ADD  CONSTRAINT [FK_Lot_InvoiceLine] FOREIGN KEY([InvoiceLineId])
REFERENCES [Store].[InvoiceLine] ([Id])
GO
ALTER TABLE [Store].[Lot] CHECK CONSTRAINT [FK_Lot_InvoiceLine]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure Id' , @level0type=N'SCHEMA',@level0name=N'Item', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'UOMId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure value' , @level0type=N'SCHEMA',@level0name=N'Item', @level1type=N'TABLE',@level1name=N'Item', @level2type=N'COLUMN',@level2name=N'UOMValue'
GO
USE [master]
GO
ALTER DATABASE [BMS_1_05] SET  READ_WRITE 
GO
