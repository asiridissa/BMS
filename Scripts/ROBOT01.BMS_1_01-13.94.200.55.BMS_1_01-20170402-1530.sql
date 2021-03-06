/*
Run this script on:

        13.94.200.55.BMS_1_01    -  This database will be modified

to synchronize it with:

        ROBOT01.BMS_1_01

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.2.1.4077 from Red Gate Software Ltd at 4/2/2017 3:30:40 PM

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
CREATE SCHEMA [Account]
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Account].[ChequeBook]'
GO
CREATE TABLE [Account].[ChequeBook]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Date] [datetime] NOT NULL,
[Amount] [decimal] (18, 2) NOT NULL,
[AmountInWords] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PayeeName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BankId] [int] NOT NULL,
[BankName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BranchId] [int] NOT NULL,
[BranchName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BranchCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CheckNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PayeeOnly] [bit] NOT NULL CONSTRAINT [DF_ChequePrint_PayeeOnly] DEFAULT ((0)),
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_Cheque_CreatedDateTime] DEFAULT (getutcdate()),
[CreatedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeletedDateTime] [datetime] NULL,
[DeletedUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Cheque_1] on [Account].[ChequeBook]'
GO
ALTER TABLE [Account].[ChequeBook] ADD CONSTRAINT [PK_Cheque_1] PRIMARY KEY CLUSTERED  ([Id])
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
