/*
Run this script on:

        13.94.200.55.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.1.0.3760 from Red Gate Software Ltd at 2/5/2017 9:19:48 PM

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
PRINT N'Creating [Report].[sp_ChequeDashboard]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [Report].[sp_ChequeDashboard]
    @DatabaseName AS NVARCHAR(50)
AS
    BEGIN
        SET FMTONLY OFF;

        CREATE TABLE #Cheques
            (
              ChequeDate DATETIME ,
              Number NVARCHAR(50) ,
              Bank NVARCHAR(50) ,
              Branch NVARCHAR(50) ,
              Amount DECIMAL(19, 4) ,
              Customer NVARCHAR(50) ,
              [Status] NVARCHAR(50)
            );

        DECLARE @Query NVARCHAR(MAX);
        SET @Query = N'
INSERT INTO #Cheques
			        ( ChequeDate ,
			          Number ,
			          Bank ,
			          Branch ,
			          Amount ,
			          Customer ,
			          Status
			        )
SELECT  c.ChequeDate ,
c.Number,
        c.Bank ,
        c.Branch ,
        c.Amount ,
        c2.ShortName ,
        CASE WHEN CONVERT(DATE, c.ChequeDate) = CONVERT(DATE, GETDATE())
             THEN ''today''
             WHEN CONVERT(DATE, c.ChequeDate) > CONVERT(DATE, GETDATE())
             THEN ''pending''
             WHEN CONVERT(DATE, c.ChequeDate) < CONVERT(DATE, GETDATE())
             THEN ''late''
        END [Status]
FROM    ' + @DatabaseName + '.Payment.Cheque AS c
        JOIN ' + @DatabaseName + '.dbo.Customer AS c2 ON c2.Id = c.CustomerId
WHERE   c.ChequeStatusId = 1 --cleared or bounced
ORDER BY c.ChequeDate;
		';

        PRINT @Query;

        EXEC sp_executesql @Query;

       SELECT * FROM #Cheques AS c ORDER BY c.ChequeDate
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
