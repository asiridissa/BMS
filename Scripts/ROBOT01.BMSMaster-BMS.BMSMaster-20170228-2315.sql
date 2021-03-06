/*
Run this script on:

        BMS.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.1.0.3760 from Red Gate Software Ltd at 2/28/2017 11:15:24 PM

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
PRINT N'Altering [Report].[sp_CollectionReport]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [Report].[sp_CollectionReport]
    @DatabaseName AS NVARCHAR(50),
	@From DATETIME,
	@To DATETIME,
	@Areas NVARCHAR(MAX)
AS
    BEGIN

        DECLARE @Query NVARCHAR(MAX);
        SET @Query = N'
SELECT  ROW_NUMBER() OVER ( ORDER BY bh.Id ) Id ,
        bh.AreaId ,
        a.ShortName Area ,
        a.FullName AreaFull ,
        bh.BillingDate ,
        bh.BillNo ,
        c.ShortName Customer ,
        c.FullName CustomerFull ,
        bh.Amount ,
        bh.PaidAmount ,
        ( bh.Amount - bh.PaidAmount ) Collection ,
        DATEDIFF(DAY, bh.BillingDate, GETDATE()) [Days]
FROM    '+@DatabaseName +'.Bill.BillHeader AS bh
        JOIN '+@DatabaseName +'.dbo.Customer AS c ON c.Id = bh.CustomerId
        JOIN '+@DatabaseName +'.dbo.Areas AS a ON a.Id = bh.AreaId
WHERE   bh.DeletedDateTime IS NULL
        AND ( bh.Amount - bh.PaidAmount ) > 0
		AND a.Id IN ('+@Areas+')
		AND bh.BillingDate >= '''+CONVERT(NVARCHAR(50),@From)+''' 		
		AND bh.BillingDate <= '''+CONVERT(NVARCHAR(50),@To)+''' 
		';

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
