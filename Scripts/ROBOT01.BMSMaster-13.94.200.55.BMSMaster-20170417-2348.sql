/*
Run this script on:

        13.94.200.55.BMSMaster    -  This database will be modified

to synchronize it with:

        ROBOT01.BMSMaster

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.2.1.4077 from Red Gate Software Ltd at 4/17/2017 11:49:14 PM

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
PRINT N'Altering [Report].[sp_SpotStockTest]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [Report].[sp_SpotStockTest]
    @DatabaseName AS NVARCHAR(50)
AS
    BEGIN

DECLARE @Query NVARCHAR(MAX);
SET @Query = N'
        SELECT  ROW_NUMBER() OVER ( ORDER BY MAX(i.Id) ) Id ,
                l.ItemId ,
                ( MAX(b.ShortName) + '' '' + MAX(c.ShortName) + '' ''
                  + MAX(p.ShortName) + '' ''
                  + CAST(CAST(MAX(i.UOMValue) AS DECIMAL(8, 3)) AS NVARCHAR(50))
                  + CONVERT(NVARCHAR(50), MAX(uom.ShortName)) + '' ''
                  + CAST(CAST(MAX(i.SalesPrice) AS DECIMAL(8, 2)) AS NVARCHAR(50))
                  --+ '' | ''
                  --+ CAST(CAST(MAX(i.WholesalePrice) AS DECIMAL(8, 2)) AS NVARCHAR(50)) 
				  ) AS ItemName ,
                MAX(i.UnitsPerCase) UnitsPerCase ,
                CAST(MAX(i.SalesPrice) AS DECIMAL(8, 2)) SalesPrice ,
                CAST(MAX(i.WholesalePrice) AS DECIMAL(8, 2)) WholesalePrice ,
                CAST(MAX(i.PurchasePrice) AS DECIMAL(8, 2)) PurchasePrice ,
                MAX(ISNULL(BSItemQuantity.BSC, 0)) BSC ,
                MAX(ISNULL(BSItemQuantity.BSP, 0)) BSP ,
                MAX(ISNULL(BSItemQuantity.BSQ, 0)) BSQ ,
                SUM(l.[Case]) [Case] ,
                SUM(l.Piece) Piece ,
                SUM(l.Quantity) Quantity ,
                ( SUM(l.[Case]) * MAX(i.UnitsPerCase) + SUM(l.Piece)
                  + MAX(ISNULL(BSItemQuantity.BSQ, 0)) ) TotalQ ,
                CAST(( ( SUM(l.[Case]) * MAX(i.UnitsPerCase) + SUM(l.Piece)
                         + MAX(ISNULL(BSItemQuantity.BSQ, 0)) )
                       * MAX(i.PurchasePrice) ) AS DECIMAL(12, 2)) PurchaseAmount ,
                CAST(( ( SUM(l.[Case]) * MAX(i.UnitsPerCase) + SUM(l.Piece)
                         + MAX(ISNULL(BSItemQuantity.BSQ, 0)) )
                       * MAX(i.SalesPrice) ) AS DECIMAL(12, 2)) SalesAmount ,
                CAST(( ( SUM(l.[Case]) * MAX(i.UnitsPerCase) + SUM(l.Piece)
                         + MAX(ISNULL(BSItemQuantity.BSQ, 0)) )
                       * MAX(i.WholesalePrice) ) AS DECIMAL(12, 2)) WholesaleAmount
        FROM    '+@DatabaseName+'.Store.Lot AS l
                JOIN '+@DatabaseName+'.Item.Item AS i ON i.Id = l.ItemId
                JOIN '+@DatabaseName+'.Item.Brand AS b ON b.Id = i.BrandId
                JOIN '+@DatabaseName+'.Item.Category AS c ON c.Id = i.CategoryId
                JOIN '+@DatabaseName+'.Item.Product AS p ON p.Id = i.ProductId
                JOIN '+@DatabaseName+'.dbo.UnitOfMeasure AS uom ON uom.Id = i.UOMId
                LEFT OUTER JOIN ( SELECT    rd2.ItemId ,
                                            SUM(rd2.BalanceStockQuantity) BSQ ,
                                            SUM(rd2.BalanceStockCase) BSC ,
                                            SUM(rd2.BalanceStockPiece) BSP
                                  FROM      ( SELECT    rd.VehicleId ,
                                                        MAX(rd.Date) Date
                                              FROM      '+@DatabaseName+'.dbo.Vehicle AS v
                                                        JOIN '+@DatabaseName+'.Bill.RoadDistribution
                                                        AS rd ON rd.VehicleId = v.Id
                                              GROUP BY  rd.VehicleId
                                            ) BS
                                            JOIN '+@DatabaseName+'.Bill.RoadDistribution AS rd2 ON rd2.Date = BS.Date
                                                              AND rd2.VehicleId = BS.VehicleId
                                  GROUP BY  rd2.ItemId
                                ) BSItemQuantity ON BSItemQuantity.ItemId = l.ItemId
								WHERE l.DeletedDateTime IS NULL
        GROUP BY l.ItemId;
	';
	PRINT @Query;

	EXEC sp_executesql @Query;
    END
    
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
