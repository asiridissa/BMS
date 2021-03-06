/*
Run this script on:

        13.94.200.55.BMS_1_01    -  This database will be modified

to synchronize it with:

        ROBOT01.BMS_1_01

You are recommended to back up your database before running this script

Script created by SQL Compare version 12.2.1.4077 from Red Gate Software Ltd at 4/13/2017 2:46:54 AM

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
PRINT N'Creating [Bill].[BillHeaderView]'
GO



CREATE VIEW [Bill].[BillHeaderView]
AS
    SELECT  bh.Id ,
            bh.BillStatusId ,
            bh.BillNo ,
            bh.BillingDate ,
            bh.CustomerId ,
            bh.AreaId ,
            bh.VehicleId ,
            bh.Discount ,
            bh.Deduction ,
            bh.Amount ,
            bh.Value ,
            bh.PaidAmount ,
            bh.DeliveryDate ,
            bh.CreatedDateTime ,
            bh.CreatedUserId ,
            bh.DeletedDateTime ,
            bh.DeletedUserId ,
            a.ShortName AreaShortName ,
            a.FullName AreaFullName ,
            v.No VehicleNo ,
            v.Description VehicleDescription ,
            c.ShortName CustomerShortName ,
            c.FullName CustomerFullName ,
            u.UserName ,
            ( SELECT TOP 1
                        CONVERT(BIT, IIF(rd.FinalizedDateTime IS NULL, 0, 1))
              FROM      Bill.RoadDistribution AS rd
              WHERE     rd.Date = bh.BillingDate
                        AND rd.VehicleId = bh.VehicleId
                        AND rd.DeletedDateTime IS NULL
            ) Finalized
    FROM    Bill.BillHeader AS bh
            JOIN dbo.Areas AS a ON a.Id = bh.AreaId
            JOIN dbo.Customer AS c ON c.Id = bh.CustomerId
            JOIN dbo.Vehicle AS v ON v.Id = bh.VehicleId
            JOIN BMSMaster.Admin.[User] AS u ON u.Id = bh.CreatedUserId
    WHERE   bh.DeletedDateTime IS NULL;




GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[11] 4[50] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 26
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'Bill', 'VIEW', N'BillHeaderView', NULL, NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'Bill', 'VIEW', N'BillHeaderView', NULL, NULL
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
