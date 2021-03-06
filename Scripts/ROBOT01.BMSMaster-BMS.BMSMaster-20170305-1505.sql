/*
Run this script on:

        BMS.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.1.0.3760 from Red Gate Software Ltd at 3/5/2017 3:05:46 PM

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
PRINT N'Creating [Report].[sp_BillingReportSummary]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [Report].[sp_BillingReportSummary]
    @DatabaseName AS NVARCHAR(50) ,
    @VehicleIds AS NVARCHAR(MAX) ,
    @FromDate AS DATE,
    @ToDate AS DATE
AS
    BEGIN

        DECLARE @Query NVARCHAR(MAX);
		SET @Query = N'SELECT ROW_NUMBER() OVER ( ORDER BY d.BillingDate ) Id , * FROM ( SELECT MAX(t.BillingDate) BillingDate , MAX(t.No) No , SUM(t.Amount) Amount , SUM(t.FreeIssue) FreeIssue , SUM(t.GoodReturn) GoodReturn , SUM(t.Damage) Damage , SUM(t.Expire) Expire , SUM(t.Discount) Discount , SUM(t.Deduction) Deduction , IIF(SUM(t.Cash) IS NULL,0,SUM(t.Cash)) Cash ,IIF(SUM(t.Cheque) IS NULL,0,SUM(t.Cheque)) Cheque ,IIF(SUM(t.Debit) IS NULL,0,SUM(t.Debit)) Debit , SUM(t.Credit) Credit FROM ( SELECT bh.BillingDate , v.No , bh.Amount , bl.FreeIssue , bl.GoodReturn , bl.Damage , bl.Expire , ( bl.NetValue - bh.Amount - bh.Deduction ) Discount , bh.Deduction , ( SELECT SUM(bp.Amount) FROM ' + @DatabaseName + '.Payment.BillPayment AS bp WHERE bp.BillHeaderId = bl.BillHeaderId AND bp.PaymentMethodId = 1 /*Cash*/ GROUP BY bp.PaymentMethodId ) Cash , ( SELECT SUM(bp.Amount) FROM ' + @DatabaseName + '.Payment.BillPayment AS bp WHERE bp.BillHeaderId = bl.BillHeaderId AND bp.PaymentMethodId = 3 /*Cheque*/ GROUP BY bp.PaymentMethodId ) Cheque , ( SELECT SUM(bp.Amount) FROM ' + @DatabaseName + '.Payment.BillPayment AS bp WHERE bp.BillHeaderId = bl.BillHeaderId AND bp.PaymentMethodId = 2 /*Credit*/ GROUP BY bp.PaymentMethodId ) Debit , ( bh.Amount - bh.PaidAmount ) Credit FROM ' + @DatabaseName + '.Bill.BillHeader AS bh JOIN ' + @DatabaseName + '.dbo.Vehicle AS v ON v.Id = bh.VehicleId JOIN ( SELECT bl.BillHeaderId , SUM(bl.FreeIssue * i.SalesPrice) FreeIssue , SUM(bl.GoodReturn * i.SalesPrice) GoodReturn , SUM(bl.Damage * i.SalesPrice) Damage , SUM(bl.Expire * i.SalesPrice) Expire , SUM(bl.Discount * i.SalesPrice) Discount , SUM(bl.Deduction * i.SalesPrice) Deduction , SUM(bl.Value) NetValue FROM ' + @DatabaseName + '.Bill.BillLine AS bl JOIN ' + @DatabaseName + '.Item.Item AS i ON i.Id = bl.ItemId WHERE bl.DeletedDateTime IS NULL GROUP BY bl.BillHeaderId ) AS bl ON bl.BillHeaderId = bh.Id WHERE bh.DeletedDateTime IS NULL AND bh.BillingDate >= ''' + CONVERT(NVARCHAR(50), CAST(@FromDate AS DATE)) + ''' AND bh.BillingDate <= ''' + CONVERT(NVARCHAR(50), CAST(@ToDate AS DATE)) + ''' AND bh.VehicleId IN(' + @VehicleIds + ') ) AS t GROUP BY t.BillingDate , t.No ) AS d ORDER BY d.BillingDate , d.No';
        /*SET @Query = N'
 SELECT ROW_NUMBER() OVER ( ORDER   BY  d.BillingDate ) Id ,
        *
  FROM   ( SELECT    MAX(t.BillingDate) BillingDate ,
                    MAX(t.No) No ,
                    SUM(t.Amount) Amount ,
                    SUM(t.FreeIssue) FreeIssue ,
                    SUM(t.GoodReturn) GoodReturn ,
                    SUM(t.Damage) Damage ,
                    SUM(t.Expire) Expire ,
                    SUM(t.Discount) Discount ,
                    SUM(t.Deduction) Deduction ,
                    SUM(t.Cash) Cash ,
                    SUM(t.Cheque) Cheque ,
                    SUM(t.Debit) Debit ,
                    SUM(t.Credit) Credit
           FROM      ( SELECT    bh.BillingDate ,
                                v.No ,
                                bh.Amount ,
                                bl.FreeIssue ,
                                bl.GoodReturn ,
                                bl.Damage ,
                                bl.Expire ,
                                ( bl.NetValue - bh.Amount - bh.Deduction ) Discount ,
                                bh.Deduction ,
                                ( SELECT    SUM(bp.Amount)
                                   FROM      ' + @DatabaseName + '.Payment.BillPayment AS bp
                                   WHERE      bp.BillHeaderId = bl.BillHeaderId
                                             AND bp.PaymentMethodId = 1 --Cash
                                  GROUP   BY   bp.PaymentMethodId
                                ) Cash ,
                                ( SELECT    SUM(bp.Amount)
                                   FROM      ' + @DatabaseName + '.Payment.BillPayment AS bp
                                   WHERE      bp.BillHeaderId = bl.BillHeaderId
                                             AND bp.PaymentMethodId = 3 --Cheque
                                  GROUP   BY   bp.PaymentMethodId
                                ) Cheque ,
                                ( SELECT    SUM(bp.Amount)
                                   FROM      ' + @DatabaseName + '.Payment.BillPayment AS bp
                                   WHERE      bp.BillHeaderId = bl.BillHeaderId
                                             AND bp.PaymentMethodId = 2 --Credit
                                  GROUP   BY   bp.PaymentMethodId
                                ) Debit ,
                                ( bh.Amount - bh.PaidAmount ) Credit
                       FROM      ' + @DatabaseName + '.Bill.BillHeader AS bh
                                 JOIN ' + @DatabaseName + '.dbo.Vehicle AS v ON v.Id = bh.VehicleId
                                 JOIN ( SELECT   bl.BillHeaderId ,
                                                SUM(bl.FreeIssue
                                                    * i.SalesPrice) FreeIssue ,
                                                SUM(bl.GoodReturn
                                                    * i.SalesPrice) GoodReturn ,
                                                SUM(bl.Damage * i.SalesPrice) Damage ,
                                                SUM(bl.Expire * i.SalesPrice) Expire ,
                                                SUM(bl.Discount * i.SalesPrice) Discount ,
                                                SUM(bl.Deduction
                                                    * i.SalesPrice) Deduction ,
                                                SUM(bl.Value) NetValue
                                        FROM     ' + @DatabaseName + '.Bill.BillLine AS bl
                                                 JOIN ' + @DatabaseName + '.Item.Item AS i ON i.Id = bl.ItemId
                                        WHERE     bl.DeletedDateTime IS NULL
                                       GROUP   BY  bl.BillHeaderId
                                     ) AS bl ON bl.BillHeaderId = bh.Id
                       WHERE      bh.DeletedDateTime IS NULL
                                 AND bh.BillingDate >= ''' + CONVERT(NVARCHAR(50), CAST(@FromDate AS DATE))   + '''
								 AND bh.BillingDate <= ''' + CONVERT(NVARCHAR(50), CAST(@ToDate AS DATE))   + '''
								 AND bh.VehicleId IN ('+@VehicleIds+')
                    ) AS t
          GROUP   BY   t.BillingDate ,
                    t.No
        ) AS d
 ORDER   BY  d.BillingDate ,
        d.No';*/
		 
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
