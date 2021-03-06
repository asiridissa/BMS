/* 
Run this script on: 
 
        ROBOT01.BMSTenantModel    -  This database will be modified 
 
to synchronize it with: 
 
        ROBOT01.BMSTenant 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.30.3199 from Red Gate Software Ltd at 11/6/2016 10:13:59 PM 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating schemas'
GO
CREATE SCHEMA [Bill] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE SCHEMA [Item] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE SCHEMA [Payment] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE SCHEMA [Store] 
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Customer]'
GO
CREATE TABLE [dbo].[Customer] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[AreaId] [int] NOT NULL, 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[Mobile] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[Fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[Email] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[Address] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Customers_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Customers] on [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Payment].[BillPaymentCheque]'
GO
CREATE TABLE [Payment].[BillPaymentCheque] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[BillPaymentId] [bigint] NOT NULL, 
[ChequeId] [int] NOT NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_BillPaymentCheque_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_BillPaymentCheque] on [Payment].[BillPaymentCheque]'
GO
ALTER TABLE [Payment].[BillPaymentCheque] ADD CONSTRAINT [PK_BillPaymentCheque] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Vehicle]'
GO
CREATE TABLE [dbo].[Vehicle] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[No] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Vehicles_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Vehicles] on [dbo].[Vehicle]'
GO
ALTER TABLE [dbo].[Vehicle] ADD CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Bill].[BillHeader]'
GO
CREATE TABLE [Bill].[BillHeader] 
( 
[Id] [bigint] NOT NULL IDENTITY(1, 1), 
[BillStatusId] [int] NOT NULL, 
[BillNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[BillingDate] [datetime] NOT NULL, 
[CustomerId] [int] NOT NULL, 
[AreaId] [int] NOT NULL, 
[VehicleId] [int] NOT NULL, 
[Discount] [decimal] (9, 4) NOT NULL, 
[Deduction] [decimal] (19, 4) NOT NULL, 
[Amount] [decimal] (19, 4) NOT NULL, 
[Value] [decimal] (19, 4) NOT NULL, 
[PaidAmount] [decimal] (19, 4) NOT NULL, 
[DeliveryDate] [datetime] NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_BillHeader_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_BillHeader] on [Bill].[BillHeader]'
GO
ALTER TABLE [Bill].[BillHeader] ADD CONSTRAINT [PK_BillHeader] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UnitOfMeasure]'
GO
CREATE TABLE [dbo].[UnitOfMeasure] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_UnitOfMeasure_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Unit] on [dbo].[UnitOfMeasure]'
GO
ALTER TABLE [dbo].[UnitOfMeasure] ADD CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Item].[Item]'
GO
CREATE TABLE [Item].[Item] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[BrandId] [int] NOT NULL, 
[ProductId] [int] NOT NULL, 
[CategoryId] [int] NOT NULL, 
[UOMId] [int] NOT NULL, 
[UOMValue] [decimal] (9, 5) NOT NULL CONSTRAINT [DF_Item_UOMValue] DEFAULT ((1)), 
[UnitsPerCase] [int] NOT NULL, 
[PurchasePrice] [decimal] (9, 5) NOT NULL CONSTRAINT [DF_Item_PurchasePrice] DEFAULT ((0)), 
[SalesPrice] [decimal] (9, 5) NOT NULL CONSTRAINT [DF_Item_SelesPrice] DEFAULT ((0)), 
[WholesalePrice] [decimal] (9, 5) NOT NULL CONSTRAINT [DF_Item_WholesalePrice] DEFAULT ((0)), 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Item_CreatedDateTime] DEFAULT (getdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Items] on [Item].[Item]'
GO
ALTER TABLE [Item].[Item] ADD CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Bill].[BillStatus]'
GO
CREATE TABLE [Bill].[BillStatus] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NULL CONSTRAINT [DF_BillStatus_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_BillStatus] on [Bill].[BillStatus]'
GO
ALTER TABLE [Bill].[BillStatus] ADD CONSTRAINT [PK_BillStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Bill].[RoadDistribution]'
GO
CREATE TABLE [Bill].[RoadDistribution] 
( 
[Id] [bigint] NOT NULL IDENTITY(1, 1), 
[Date] [datetime] NOT NULL, 
[VehicleId] [int] NOT NULL, 
[ItemId] [int] NOT NULL, 
[UnitsPerCase] [int] NOT NULL, 
[BalanceStockCase] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_BalanceStockCase] DEFAULT ((0)), 
[BalanceStockPiece] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_BalanceStockPiece] DEFAULT ((0)), 
[BalanceStockQuantity] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_BalanceStockQuantity] DEFAULT ((0)), 
[LoadingCase] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_LoadingCase] DEFAULT ((0)), 
[LoadingPiece] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_LoadingPiece] DEFAULT ((0)), 
[LoadingQuantity] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_LoadingQuantity] DEFAULT ((0)), 
[UnloadingCase] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_UnloadingCase] DEFAULT ((0)), 
[UnloadingPiece] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_UnloadingPiece] DEFAULT ((0)), 
[UnloadingQuantity] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_UnloadingQuantity] DEFAULT ((0)), 
[RoadDistributionCase] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_RoadDistributionCase] DEFAULT ((0)), 
[RoadDistributionPiece] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_UnloadingPiece1] DEFAULT ((0)), 
[RoadDistributionQuantity] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_UnloadingQuantity1] DEFAULT ((0)), 
[BillingQuantity] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_BillingQuantity] DEFAULT ((0)), 
[Varience] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_Varience] DEFAULT ((0)), 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_RoadDistribution_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[FinalizedDateTime] [datetime] NULL, 
[FinalizedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_RoadDistribution] on [Bill].[RoadDistribution]'
GO
ALTER TABLE [Bill].[RoadDistribution] ADD CONSTRAINT [PK_RoadDistribution] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Bill].[BillLine]'
GO
CREATE TABLE [Bill].[BillLine] 
( 
[Id] [bigint] NOT NULL IDENTITY(1, 1), 
[BillHeaderId] [bigint] NOT NULL, 
[ItemId] [int] NOT NULL, 
[UnitPrice] [decimal] (19, 4) NOT NULL CONSTRAINT [DF_BillLine_Amount1] DEFAULT ((0)), 
[WholeSale] [bit] NOT NULL CONSTRAINT [DF_BillLine_WholeSale] DEFAULT ((0)), 
[Sale] [int] NOT NULL CONSTRAINT [DF_BillLine_Sale] DEFAULT ((0)), 
[FreeIssue] [int] NOT NULL CONSTRAINT [DF_BillLine_FreeIssue] DEFAULT ((0)), 
[Damage] [int] NOT NULL CONSTRAINT [DF_BillLine_Damage] DEFAULT ((0)), 
[Expire] [int] NOT NULL CONSTRAINT [DF_BillLine_Expire] DEFAULT ((0)), 
[GoodReturn] [int] NOT NULL CONSTRAINT [DF_BillLine_GoodReturn] DEFAULT ((0)), 
[Discount] [decimal] (9, 4) NOT NULL CONSTRAINT [DF_BillLine_Discount] DEFAULT ((0)), 
[Deduction] [decimal] (19, 4) NOT NULL CONSTRAINT [DF_BillLine_Deduction] DEFAULT ((0)), 
[Amount] [decimal] (19, 4) NOT NULL CONSTRAINT [DF_BillLine_Amount] DEFAULT ((0)), 
[Value] [decimal] (19, 4) NOT NULL CONSTRAINT [DF_BillLine_Value] DEFAULT ((0)), 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_BillLine_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_BillLine] on [Bill].[BillLine]'
GO
ALTER TABLE [Bill].[BillLine] ADD CONSTRAINT [PK_BillLine] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Areas]'
GO
CREATE TABLE [dbo].[Areas] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Areas_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__Areas] on [dbo].[Areas]'
GO
ALTER TABLE [dbo].[Areas] ADD CONSTRAINT [PK__Areas] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Item].[Brand]'
GO
CREATE TABLE [Item].[Brand] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Brand_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Brands] on [Item].[Brand]'
GO
ALTER TABLE [Item].[Brand] ADD CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Item].[Category]'
GO
CREATE TABLE [Item].[Category] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Category_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Categories] on [Item].[Category]'
GO
ALTER TABLE [Item].[Category] ADD CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Item].[Product]'
GO
CREATE TABLE [Item].[Product] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Products_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Products] on [Item].[Product]'
GO
ALTER TABLE [Item].[Product] ADD CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Store].[InvoiceHeader]'
GO
CREATE TABLE [Store].[InvoiceHeader] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[InvoiceNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[Date] [datetime] NOT NULL, 
[Finalized] [bit] NOT NULL CONSTRAINT [DF_InvoiceHeader_Finalized] DEFAULT ((0)), 
[FinalizedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[FinalizedDateTime] [datetime] NULL CONSTRAINT [DF_InvoiceHeader_CreatedDateTime1] DEFAULT (getutcdate()), 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_InvoiceHeader_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Invoice] on [Store].[InvoiceHeader]'
GO
ALTER TABLE [Store].[InvoiceHeader] ADD CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Payment].[PaymentMethod]'
GO
CREATE TABLE [Payment].[PaymentMethod] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_PaymentMethod_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_PaymentMethod] on [Payment].[PaymentMethod]'
GO
ALTER TABLE [Payment].[PaymentMethod] ADD CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Store].[InvoiceLine]'
GO
CREATE TABLE [Store].[InvoiceLine] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[InvoiceHeaderId] [int] NOT NULL, 
[ItemId] [int] NOT NULL, 
[Case] [int] NOT NULL CONSTRAINT [DF_InvoiceLine_Case] DEFAULT ((0)), 
[Piece] [int] NOT NULL CONSTRAINT [DF_InvoiceLine_Piece] DEFAULT ((0)), 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_InvoiceLine_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_InvoiceLine] on [Store].[InvoiceLine]'
GO
ALTER TABLE [Store].[InvoiceLine] ADD CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Store].[Lot]'
GO
CREATE TABLE [Store].[Lot] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[InvoiceLineId] [int] NOT NULL, 
[ItemId] [int] NOT NULL, 
[Case] [int] NOT NULL, 
[Piece] [int] NOT NULL CONSTRAINT [DF_Lot_StockQty] DEFAULT ((0)), 
[Quantity] [int] NOT NULL, 
[CreatedDateTime] [datetime] NOT NULL, 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Lot_CreatedUserId] DEFAULT (getutcdate()), 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Lots] on [Store].[Lot]'
GO
ALTER TABLE [Store].[Lot] ADD CONSTRAINT [PK_Lots] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Payment].[BillPayment]'
GO
CREATE TABLE [Payment].[BillPayment] 
( 
[Id] [bigint] NOT NULL IDENTITY(1, 1), 
[BillHeaderId] [bigint] NOT NULL, 
[PaymentMethodId] [int] NOT NULL, 
[Amount] [decimal] (19, 4) NOT NULL, 
[PaymentDate] [datetime] NOT NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_BillPayment_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_BillPayment] on [Payment].[BillPayment]'
GO
ALTER TABLE [Payment].[BillPayment] ADD CONSTRAINT [PK_BillPayment] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Payment].[ChequeStatus]'
GO
CREATE TABLE [Payment].[ChequeStatus] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[ShortName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[FullName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_ChequeStatus_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ChequeStatus] on [Payment].[ChequeStatus]'
GO
ALTER TABLE [Payment].[ChequeStatus] ADD CONSTRAINT [PK_ChequeStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Payment].[Cheque]'
GO
CREATE TABLE [Payment].[Cheque] 
( 
[Id] [int] NOT NULL IDENTITY(1, 1), 
[CustomerId] [int] NOT NULL, 
[Bank] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[Branch] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[Number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[ChequeDate] [datetime] NOT NULL, 
[ChequeStatusId] [int] NOT NULL, 
[Amount] [decimal] (19, 4) NOT NULL CONSTRAINT [DF_Cheque_Amount] DEFAULT ((0)), 
[UtilizedAmount] [decimal] (19, 4) NOT NULL CONSTRAINT [DF_Cheque_UtilizedAmount] DEFAULT ((0)), 
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Cheque_CreatedDateTime] DEFAULT (getutcdate()), 
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[DeletedDateTime] [datetime] NULL, 
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Cheque] on [Payment].[Cheque]'
GO
ALTER TABLE [Payment].[Cheque] ADD CONSTRAINT [PK_Cheque] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DataChangeLog]'
GO
CREATE TABLE [dbo].[DataChangeLog] 
( 
[Id] [bigint] NOT NULL IDENTITY(1, 1), 
[Table] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[NatureOfAction] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
[CreatedDateTime] [datetime] NOT NULL, 
[CreatedUserId] [int] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DataChangeLog] on [dbo].[DataChangeLog]'
GO
ALTER TABLE [dbo].[DataChangeLog] ADD CONSTRAINT [PK_DataChangeLog] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Bill].[BillLine]'
GO
ALTER TABLE [Bill].[BillLine] ADD CONSTRAINT [FK_BillLine_BillHeader] FOREIGN KEY ([BillHeaderId]) REFERENCES [Bill].[BillHeader] ([Id]) 
GO
ALTER TABLE [Bill].[BillLine] ADD CONSTRAINT [FK_BillLine_Item] FOREIGN KEY ([ItemId]) REFERENCES [Item].[Item] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Payment].[BillPayment]'
GO
ALTER TABLE [Payment].[BillPayment] ADD CONSTRAINT [FK_BillPayment_BillHeader] FOREIGN KEY ([BillHeaderId]) REFERENCES [Bill].[BillHeader] ([Id]) 
GO
ALTER TABLE [Payment].[BillPayment] ADD CONSTRAINT [FK_BillPayment_PaymentMethod] FOREIGN KEY ([PaymentMethodId]) REFERENCES [Payment].[PaymentMethod] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Bill].[BillHeader]'
GO
ALTER TABLE [Bill].[BillHeader] ADD CONSTRAINT [FK_BillHeader_BillStatus] FOREIGN KEY ([BillStatusId]) REFERENCES [Bill].[BillStatus] ([Id]) 
GO
ALTER TABLE [Bill].[BillHeader] ADD CONSTRAINT [FK_BillHeader_Customers] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id]) 
GO
ALTER TABLE [Bill].[BillHeader] ADD CONSTRAINT [FK_BillHeader_Areas] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[Areas] ([Id]) 
GO
ALTER TABLE [Bill].[BillHeader] ADD CONSTRAINT [FK_BillHeader_Vehicles] FOREIGN KEY ([VehicleId]) REFERENCES [dbo].[Vehicle] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Bill].[RoadDistribution]'
GO
ALTER TABLE [Bill].[RoadDistribution] ADD CONSTRAINT [FK_RoadDistribution_Vehicles] FOREIGN KEY ([VehicleId]) REFERENCES [dbo].[Vehicle] ([Id]) 
GO
ALTER TABLE [Bill].[RoadDistribution] ADD CONSTRAINT [FK_RoadDistribution_Item] FOREIGN KEY ([ItemId]) REFERENCES [Item].[Item] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Item].[Item]'
GO
ALTER TABLE [Item].[Item] ADD CONSTRAINT [FK_Item_Brand] FOREIGN KEY ([BrandId]) REFERENCES [Item].[Brand] ([Id]) 
GO
ALTER TABLE [Item].[Item] ADD CONSTRAINT [FK_Item_Category] FOREIGN KEY ([CategoryId]) REFERENCES [Item].[Category] ([Id]) 
GO
ALTER TABLE [Item].[Item] ADD CONSTRAINT [FK_Item_Product] FOREIGN KEY ([ProductId]) REFERENCES [Item].[Product] ([Id]) 
GO
ALTER TABLE [Item].[Item] ADD CONSTRAINT [FK_Item_UnitOfMeasure] FOREIGN KEY ([UOMId]) REFERENCES [dbo].[UnitOfMeasure] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Store].[InvoiceLine]'
GO
ALTER TABLE [Store].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLine_Item] FOREIGN KEY ([ItemId]) REFERENCES [Item].[Item] ([Id]) 
GO
ALTER TABLE [Store].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLine_InvoiceHeader] FOREIGN KEY ([InvoiceHeaderId]) REFERENCES [Store].[InvoiceHeader] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Payment].[BillPaymentCheque]'
GO
ALTER TABLE [Payment].[BillPaymentCheque] ADD CONSTRAINT [FK_BillPaymentCheque_BillPayment] FOREIGN KEY ([BillPaymentId]) REFERENCES [Payment].[BillPayment] ([Id]) 
GO
ALTER TABLE [Payment].[BillPaymentCheque] ADD CONSTRAINT [FK_BillPaymentCheque_Cheque] FOREIGN KEY ([ChequeId]) REFERENCES [Payment].[Cheque] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Payment].[Cheque]'
GO
ALTER TABLE [Payment].[Cheque] ADD CONSTRAINT [FK_Cheque_ChequeStatus] FOREIGN KEY ([ChequeStatusId]) REFERENCES [Payment].[ChequeStatus] ([Id]) 
GO
ALTER TABLE [Payment].[Cheque] ADD CONSTRAINT [FK_Cheque_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Store].[Lot]'
GO
ALTER TABLE [Store].[Lot] ADD CONSTRAINT [FK_Lot_InvoiceLine] FOREIGN KEY ([InvoiceLineId]) REFERENCES [Store].[InvoiceLine] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_Customers_Areas] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[Areas] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unit of measure Id', 'SCHEMA', N'Item', 'TABLE', N'Item', 'COLUMN', N'UOMId'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unit of measure value', 'SCHEMA', N'Item', 'TABLE', N'Item', 'COLUMN', N'UOMValue'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
