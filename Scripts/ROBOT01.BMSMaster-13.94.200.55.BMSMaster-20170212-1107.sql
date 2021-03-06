/*
Run this script on:

        13.94.200.55.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.1.0.3760 from Red Gate Software Ltd at 2/12/2017 11:08:06 AM

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
PRINT N'Creating [Report].[sp_CollectionDetails]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [Report].[sp_CollectionDetails]
    @DatabaseName AS NVARCHAR(50) ,
    @From AS DATE,
    @To AS DATE
AS
    BEGIN
        DECLARE @Query NVARCHAR(MAX);
        SET @Query = N'
		SELECT  bp.PaymentDate ,
				bh.BillNo ,
				MAX(bh.BillingDate) BillingDate,
				MAX(c.ShortName) Customer ,
				MAX(a.ShortName) Area ,
				MAX(bh.Amount) Total ,
				MAX(bh.PaidAmount) PaidAmount,
				SUM(CASE WHEN bp.PaymentMethodId = 1 THEN bp.Amount
					 ELSE 0
				END) Cash ,
				SUM(CASE WHEN bp.PaymentMethodId = 2 THEN bp.Amount
					 ELSE 0
				END) Credit ,
				SUM(CASE WHEN bp.PaymentMethodId = 3 THEN bp.Amount
					 ELSE 0
				END) Cheque
		FROM    '+@DatabaseName+'.Payment.BillPayment AS bp
				JOIN '+@DatabaseName+'.Bill.BillHeader AS bh ON bh.Id = bp.BillHeaderId
				JOIN '+@DatabaseName+'.dbo.Customer AS c ON c.Id = bh.CustomerId
				JOIN '+@DatabaseName+'.dbo.Areas AS a ON a.Id = bh.AreaId
				JOIN '+@DatabaseName+'.Payment.PaymentMethod AS pm ON pm.Id = bp.PaymentMethodId
		WHERE   bp.DeletedDateTime IS NULL
				AND CONVERT(DATE, bp.PaymentDate) >= ''' + CONVERT(NVARCHAR(50), CAST(@From AS DATE))   + '''
				AND CONVERT(DATE, bp.PaymentDate) <= ''' + CONVERT(NVARCHAR(50), CAST(@To AS DATE))   + '''
		GROUP BY bp.PaymentDate,bh.BillNo
		ORDER BY  bp.PaymentDate,
				bh.BillNo;
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
