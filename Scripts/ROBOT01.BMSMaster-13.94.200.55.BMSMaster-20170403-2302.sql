/*
Run this script on:

        13.94.200.55.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.2.1.4077 from Red Gate Software Ltd at 4/3/2017 11:02:29 PM

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
PRINT N'Altering [Report].[sp_SalesDashboard]'
GO


--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [Report].[sp_SalesDashboard]
    @DatabaseName NVARCHAR(50) ,
    @From DATETIME ,
    @To DATETIME
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN

        SET FMTONLY OFF;

        DECLARE @Query NVARCHAR(MAX);

        CREATE TABLE #Sales
            (
              BillingDate DATETIME ,
              Bills INT ,
              Sale DECIMAL(19, 4) ,
              Paid DECIMAL(19, 4) ,
              [Collection] DECIMAL(19, 4) ,
              Diduction DECIMAL(19, 4) ,
              Discount DECIMAL(19, 4) ,
              SaleQty INT ,
              Free INT ,
              Damage INT ,
              Expire INT
            );

			
        SET @Query = '
		INSERT INTO #Sales
			        ( BillingDate ,
					Bills,
			          Sale ,
			          Paid ,
			          Collection ,
			          Diduction ,
			          Discount ,
					  SaleQty,
			          Free ,
			          Damage ,
			          Expire
			        )

    SELECT  bh.BillingDate ,
        COUNT(bh.BillNo) Bills ,
        SUM(bh.Amount) Sale ,
        SUM(bh.PaidAmount) Paid ,
        SUM(bh.Amount) - SUM(bh.PaidAmount) [Collection] ,
        SUM(bh.Deduction) Diduction ,
        ( SUM(bh.Value) - SUM(bh.Amount) ) - SUM(bh.Deduction) Discount ,
        SUM(bl.Sale) SaleQty ,
        SUM(bl.FreeIssue) Free ,
        SUM(bl.Damage) Damage ,
        SUM(bl.Expire) Expire
FROM    ' + @DatabaseName + '.Bill.BillHeader AS bh
        JOIN ' + @DatabaseName
            + '.Bill.BillLine AS bl ON bl.BillHeaderId = bh.Id
WHERE   bh.DeletedDateTime IS NULL 
AND CONVERT(DATE,bh.BillingDate) >= CONVERT(DATE,'''
            + CONVERT(NVARCHAR(50), @From) + ''')
AND CONVERT(DATE,bh.BillingDate) <= CONVERT(DATE,'''
            + CONVERT(NVARCHAR(50), @To) + ''')
GROUP BY bh.BillingDate';

        PRINT @Query;

        EXEC sp_executesql @Query;

        SELECT  *
        FROM    #Sales AS s;

        DROP TABLE #Sales;
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
