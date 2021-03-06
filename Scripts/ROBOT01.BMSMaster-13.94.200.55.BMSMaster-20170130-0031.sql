/*
Run this script on:

        13.94.200.55.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.1.0.3760 from Red Gate Software Ltd at 1/30/2017 12:32:09 AM

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
PRINT N'Creating [dbo].[fn_CSVLineToTableInt]'
GO
CREATE FUNCTION [dbo].[fn_CSVLineToTableInt] ( @strString nvarchar(max))

RETURNS  @Result TABLE(Id INT)
AS
BEGIN
 
      DECLARE @x XML 
      SELECT @x = CAST('<A>'+ REPLACE(@strString,',','</A><A>')+ '</A>' AS XML)
     
      INSERT INTO @Result            
      SELECT t.value('.', 'INT') AS inVal
      FROM @x.nodes('/A') AS x(t)
 

    RETURN
END   
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Report].[sp_BillingReport]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [Report].[sp_BillingReport]
    @DatabaseName AS NVARCHAR(50) ,
    @VehicleIds AS NVARCHAR(MAX) ,
    @FromDate AS DATE,
    @ToDate AS DATE
AS
    BEGIN

        DECLARE @Query NVARCHAR(MAX);
        SET @Query = N'
		SELECT  ROW_NUMBER() OVER (ORDER BY bh.Id) Id ,
        bh.BillingDate ,
		v.No,
        bh.BillNo ,
        c.ShortName ,
        bh.Amount ,
        bl.FreeIssue ,
        bl.GoodReturn ,
        bl.Damage ,
        bl.Expire ,
	(bl.NetValue - bh.Amount) Discount,
        ( SELECT    SUM(bp.Amount)
          FROM      ' + @DatabaseName + '.Payment.BillPayment AS bp
          WHERE     bp.BillHeaderId = bl.BillHeaderId
                    AND bp.PaymentMethodId = 1 --Cash
          GROUP BY  bp.PaymentMethodId
        ) Cash,
				( SELECT    SUM(bp.Amount)
          FROM      ' + @DatabaseName + '.Payment.BillPayment AS bp
          WHERE     bp.BillHeaderId = bl.BillHeaderId
                    AND bp.PaymentMethodId = 3 --Cheque
          GROUP BY  bp.PaymentMethodId
        ) Cheque,
		( SELECT    SUM(bp.Amount)
          FROM      ' + @DatabaseName + '.Payment.BillPayment AS bp
          WHERE     bp.BillHeaderId = bl.BillHeaderId
                    AND bp.PaymentMethodId = 2 --Credit
          GROUP BY  bp.PaymentMethodId
        ) Debit,
		(bh.Amount - bh.PaidAmount) Credit
FROM    ' + @DatabaseName + '.Bill.BillHeader AS bh
        JOIN ' + @DatabaseName + '.dbo.Customer AS c ON c.Id = bh.CustomerId
		JOIN ' + @DatabaseName + '.dbo.Vehicle AS v ON v.Id = bh.VehicleId
        JOIN ( SELECT   bl.BillHeaderId ,
                        SUM(bl.FreeIssue * i.SalesPrice) FreeIssue ,
                        SUM(bl.GoodReturn * i.SalesPrice) GoodReturn ,
                        SUM(bl.Damage * i.SalesPrice) Damage ,
                        SUM(bl.Expire * i.SalesPrice) Expire ,
                        SUM(bl.Discount * i.SalesPrice) Discount ,
                        SUM(bl.Deduction * i.SalesPrice) Deduction,
			SUM(bl.Value) NetValue
               FROM     ' + @DatabaseName + '.Bill.BillLine AS bl
                        JOIN ' + @DatabaseName
            + '.Item.Item AS i ON i.Id = bl.ItemId
               WHERE    bl.DeletedDateTime IS NULL
               GROUP BY bl.BillHeaderId
             ) AS bl ON bl.BillHeaderId = bh.Id
WHERE   bh.DeletedDateTime IS NULL
        AND bh.BillingDate >= ''' + CONVERT(NVARCHAR(50), CAST(@FromDate AS DATE))   + '''
        AND bh.BillingDate <= ''' + CONVERT(NVARCHAR(50), CAST(@ToDate AS DATE))   + '''
        AND bh.VehicleId  IN ('+@VehicleIds+')
		ORDER BY bh.BillingDate ,
        bh.VehicleId ,
        bh.BillNo
		';

        PRINT @Query;

        EXEC sp_executesql @Query;
    END;
    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Report].[sp_Header]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [Report].[sp_Header]
    @DatabaseName AS NVARCHAR(50) ,
    @VehicleIds AS NVARCHAR(MAX)
AS
    BEGIN

        DECLARE @Query NVARCHAR(MAX);
        DECLARE @VahicleNames NVARCHAR(MAX);
        DECLARE @VahicleNos NVARCHAR(MAX);
        DECLARE @Vehicles AS TABLE ( Id INT, No NVARCHAR(50) );

        SET @Query = 'SELECT  f.Id ,
                        v.No
                FROM    dbo.fn_CSVLineToTableInt(''' + @VehicleIds + ''') f
                        JOIN ' + @DatabaseName
            + '.dbo.Vehicle AS v ON v.Id = f.Id';
        PRINT @Query;

        INSERT  INTO @Vehicles
                ( Id, No )
                EXEC sp_executesql @Query;

        SELECT  @VahicleNos = COALESCE(@VahicleNos + ', ', '')
                + CONVERT(NVARCHAR(50), v.No)
        FROM    @Vehicles AS v
        ORDER BY v.Id;

        SELECT  @VahicleNos [No];
    END;
    
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Report].[sp_RoadDistributionReport]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [Report].[sp_RoadDistributionReport]
    @DatabaseName AS NVARCHAR(50) ,
    @VehicleIds AS NVARCHAR(max) ,
    @FromDate AS DATETIME ,
    @ToDate AS DATETIME
AS
    BEGIN

        DECLARE @Query NVARCHAR(MAX);
        SET @Query = N'
SELECT  ROW_NUMBER() OVER ( ORDER BY MIN(rd.ItemId) ) Id ,
        MAX(rd.Date) Date ,
        MAX(rd.VehicleId) VehicleId ,
        MAX(rd.ItemId) ItemId ,
        MAX(b.ShortName) + '' '' + MAX(c.ShortName) + '' '' + MAX(p.ShortName)
        + '' '' + CAST(CAST(MAX(i.UOMValue) AS DECIMAL(8, 2)) AS NVARCHAR(50))
        + CONVERT(NVARCHAR(50), MAX(uom.ShortName)) + '' ''
        + CAST(CAST(MAX(i.SalesPrice) AS DECIMAL(8, 2)) AS NVARCHAR(50))
        + '' | ''
        + CAST(CAST(MAX(i.WholesalePrice) AS DECIMAL(8, 2)) AS NVARCHAR(50)) AS ItemName ,
        MAX(rd.UnitsPerCase) UnitsPerCase ,
        SUM(rd.BalanceStockCase) BalanceStockCase ,
        SUM(rd.BalanceStockPiece) BalanceStockPiece ,
        SUM(rd.BalanceStockQuantity) BalanceStockQuantity ,
        SUM(rd.LoadingCase) LoadingCase ,
        SUM(rd.LoadingPiece) LoadingPiece ,
        SUM(rd.LoadingQuantity) LoadingQuantity ,
        SUM(rd.UnloadingCase) UnloadingCase ,
        SUM(rd.UnloadingPiece) UnloadingPiece ,
        SUM(rd.UnloadingQuantity) UnloadingQuantity ,
        SUM(rd.RoadDistributionCase) RoadDistributionCase ,
        SUM(rd.RoadDistributionPiece) RoadDistributionPiece ,
        SUM(rd.RoadDistributionQuantity) RoadDistributionQuantity ,
        SUM(rd.BillingQuantity) BillingQuantity ,
        SUM(rd.Varience) Varience ,
        MAX(rd.FinalizedDateTime) FinalizedDateTime ,
        MAX(rd.FinalizedUserId) FinalizedUserId
FROM    ' + @DatabaseName + '.Bill.RoadDistribution AS rd
        JOIN ' + @DatabaseName + '.Item.Item AS i ON i.Id = rd.ItemId
        JOIN ' + @DatabaseName + '.Item.Brand AS b ON b.Id = i.BrandId
        JOIN ' + @DatabaseName + '.Item.Category AS c ON c.Id = i.CategoryId
        JOIN ' + @DatabaseName + '.Item.Product AS p ON p.Id = i.ProductId
        JOIN ' + @DatabaseName
            + '.dbo.UnitOfMeasure AS uom ON uom.Id = i.UOMId
WHERE   rd.Date >= ''' + CONVERT(NVARCHAR(50), CAST(@FromDate AS DATE)) + '''
		AND rd.Date <= ''' + CONVERT(NVARCHAR(50), CAST(@ToDate AS DATE))
            + '''
		AND ( rd.BalanceStockQuantity + rd.LoadingQuantity
              + rd.UnloadingQuantity + rd.RoadDistributionQuantity
              + rd.BillingQuantity + rd.BillingFreeQuantity ) > 0
        AND rd.VehicleId IN ('+@VehicleIds+')
GROUP BY rd.ItemId
ORDER BY MAX(rd.ItemId)
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
