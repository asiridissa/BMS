/* 
Run this script on: 
 
ROBOT01.BMSTenantModel    -  This database will be modified 
 
to synchronize it with: 
 
ROBOT01.BMSTenant 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.30.3199 from Red Gate Software Ltd at 11/6/2016 10:18:49 PM 
 
*/ 
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)
 
PRINT(N'Add 3 rows to [dbo].[UnitOfMeasure]')
SET IDENTITY_INSERT [dbo].[UnitOfMeasure] ON
INSERT INTO [dbo].[UnitOfMeasure] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'g', N'Gram', '2016-10-15 15:32:08.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [dbo].[UnitOfMeasure] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'kg', N'Kilo Gram', '2016-10-15 15:32:08.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [dbo].[UnitOfMeasure] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'l', N'Leter', '2016-10-29 10:11:43.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
SET IDENTITY_INSERT [dbo].[UnitOfMeasure] OFF
 
PRINT(N'Add 4 rows to [Bill].[BillStatus]')
SET IDENTITY_INSERT [Bill].[BillStatus] ON
INSERT INTO [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'Billed', NULL, '2016-10-15 14:19:38.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'Delivered', NULL, '2016-10-14 23:15:34.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'Paid', NULL, '2016-10-14 23:15:34.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Bill].[BillStatus] ([Id], [Name], [Description], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (4, N'Credit', NULL, '2016-10-14 23:15:34.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
SET IDENTITY_INSERT [Bill].[BillStatus] OFF
 
PRINT(N'Add 4 rows to [Payment].[ChequeStatus]')
SET IDENTITY_INSERT [Payment].[ChequeStatus] ON
INSERT INTO [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'Received', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'Banked', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'Cleared', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Payment].[ChequeStatus] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (4, N'Bounced', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
SET IDENTITY_INSERT [Payment].[ChequeStatus] OFF
 
PRINT(N'Add 3 rows to [Payment].[PaymentMethod]')
SET IDENTITY_INSERT [Payment].[PaymentMethod] ON
INSERT INTO [Payment].[PaymentMethod] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (1, N'Cash', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (2, N'Credit', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [ShortName], [FullName], [CreatedDateTime], [CreatedUserId], [DeletedDateTime], [DeletedUserId]) VALUES (3, N'Cheque', NULL, '2016-10-17 00:00:00.000', N'286c12d3-be7f-448e-8702-b0d701cceaf2', NULL, NULL)
SET IDENTITY_INSERT [Payment].[PaymentMethod] OFF
COMMIT TRANSACTION
GO
