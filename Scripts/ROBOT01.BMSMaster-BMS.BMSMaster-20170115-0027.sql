/*
Run this script on:

        BMS.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.1.0.3760 from Red Gate Software Ltd at 1/15/2017 12:27:49 AM

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
PRINT N'Dropping [dbo].[sp_RemoveUserRole]'
GO
DROP PROCEDURE [dbo].[sp_RemoveUserRole]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[sp_AddUserRole]'
GO
DROP PROCEDURE [dbo].[sp_AddUserRole]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [dbo].[sp_GetUserRoles]'
GO
DROP PROCEDURE [dbo].[sp_GetUserRoles]
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
