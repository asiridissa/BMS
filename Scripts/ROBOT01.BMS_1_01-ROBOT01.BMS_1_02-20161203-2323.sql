/* 
Run this script on: 
 
        ROBOT01.BMS_1_03    -  This database will be modified 
 
to synchronize it with: 
 
        ROBOT01.BMS_1_01 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 12/3/2016 11:23:44 PM 
 
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
PRINT N'Altering [Bill].[RoadDistribution]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Bill].[RoadDistribution] ADD 
[BillingFreeQuantity] [int] NOT NULL CONSTRAINT [DF_RoadDistribution_BillingQuantity1] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Item].[Item]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Item].[Item] ADD 
[FreePerUnits] [int] NOT NULL CONSTRAINT [DF_Item_FreePerUnits] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Store].[InvoiceLine]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Store].[InvoiceLine] ADD 
[FreeCase] [int] NOT NULL CONSTRAINT [DF_InvoiceLine_FreeCase] DEFAULT ((0)), 
[FreePiese] [int] NOT NULL CONSTRAINT [DF_InvoiceLine_Piese] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Store].[Lot]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Store].[Lot] ADD 
[FreeCase] [int] NOT NULL CONSTRAINT [DF_Lot_FreeCase] DEFAULT ((0)), 
[FreePiece] [int] NOT NULL CONSTRAINT [DF_Lot_Piece1] DEFAULT ((0)), 
[FreeQuantity] [int] NOT NULL CONSTRAINT [DF_Lot_FreeQuantity] DEFAULT ((0))
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
