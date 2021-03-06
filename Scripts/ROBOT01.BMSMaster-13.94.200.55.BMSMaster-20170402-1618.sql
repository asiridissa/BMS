/*
Run this script on:

        13.94.200.55.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.2.1.4077 from Red Gate Software Ltd at 4/2/2017 4:18:59 PM

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
PRINT N'Creating [Report].[sp_ChequePrint]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [Report].[sp_ChequePrint]
    @DatabaseName AS NVARCHAR(50) ,
    @ChequePrintId AS INT
AS
    BEGIN
        DECLARE @Query NVARCHAR(MAX);
		SET @Query = N'SELECT * FROM ' + @DatabaseName + '.Account.ChequeBook AS cp WHERE cp.Id = 1';
        PRINT @Query;
        EXEC sp_executesql @Query;
    END;
    
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
