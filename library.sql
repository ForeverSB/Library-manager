USE [master]
GO
/****** Object:  Database [MBOOK]    Script Date: 05/07/2019 16:51:14 ******/
CREATE DATABASE [MBOOK] ON  PRIMARY 
( NAME = N'MBOOK', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\MBOOK.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MBOOK_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\MBOOK_log.ldf' , SIZE = 3136KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MBOOK] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MBOOK].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MBOOK] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [MBOOK] SET ANSI_NULLS OFF
GO
ALTER DATABASE [MBOOK] SET ANSI_PADDING OFF
GO
ALTER DATABASE [MBOOK] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [MBOOK] SET ARITHABORT OFF
GO
ALTER DATABASE [MBOOK] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [MBOOK] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [MBOOK] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [MBOOK] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [MBOOK] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [MBOOK] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [MBOOK] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [MBOOK] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [MBOOK] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [MBOOK] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [MBOOK] SET  DISABLE_BROKER
GO
ALTER DATABASE [MBOOK] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [MBOOK] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [MBOOK] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [MBOOK] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [MBOOK] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [MBOOK] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [MBOOK] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [MBOOK] SET  READ_WRITE
GO
ALTER DATABASE [MBOOK] SET RECOVERY SIMPLE
GO
ALTER DATABASE [MBOOK] SET  MULTI_USER
GO
ALTER DATABASE [MBOOK] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [MBOOK] SET DB_CHAINING OFF
GO
USE [MBOOK]
GO
/****** Object:  Table [dbo].[TBook]    Script Date: 05/07/2019 16:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBook](
	[ISBN] [char](18) NOT NULL,
	[BookName] [char](40) NOT NULL,
	[Author] [char](16) NOT NULL,
	[Publisher] [char](30) NOT NULL,
	[Price] [float] NOT NULL,
	[CNum] [int] NOT NULL,
	[SNum] [int] NOT NULL,
	[Summary] [varchar](200) NULL,
	[Photo] [varbinary](max) NULL,
 CONSTRAINT [PK_TBook] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TReader]    Script Date: 05/07/2019 16:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TReader](
	[ReaderID] [char](8) NOT NULL,
	[Name] [char](8) NOT NULL,
	[Sex] [bit] NOT NULL,
	[Born] [date] NOT NULL,
	[Spec] [char](12) NOT NULL,
	[Num] [int] NOT NULL,
	[Photo] [varbinary](max) NOT NULL,
	[Detail] [ntext] NOT NULL,
 CONSTRAINT [PK_TReader] PRIMARY KEY CLUSTERED 
(
	[ReaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TLend]    Script Date: 05/07/2019 16:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TLend](
	[BookID] [char](10) NOT NULL,
	[ReaderID] [char](8) NOT NULL,
	[ISBN] [char](18) NOT NULL,
	[LTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TLend] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[RBL]    Script Date: 05/07/2019 16:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RBL]
AS
SELECT     dbo.TReader.ReaderID, dbo.TLend.BookID, dbo.TLend.ISBN, dbo.TBook.BookName, dbo.TBook.Publisher, dbo.TBook.Price, dbo.TLend.LTime
FROM         dbo.TBook INNER JOIN
                      dbo.TLend ON dbo.TBook.ISBN = dbo.TLend.ISBN INNER JOIN
                      dbo.TReader ON dbo.TLend.ReaderID = dbo.TReader.ReaderID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "TLend"
            Begin Extent = 
               Top = 6
               Left = 218
               Bottom = 126
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TReader"
            Begin Extent = 
               Top = 6
               Left = 398
               Bottom = 126
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TBook"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RBL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RBL'
GO
/****** Object:  StoredProcedure [dbo].[Book_Borrow]    Script Date: 05/07/2019 16:51:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Book_Borrow] @in_ReaderID char(8), @in_ISBN char(18), @in_BookID char(10), @out_str char(30) OUTPUT
AS
BEGIN
	IF NOT EXISTS(select * from TReader where ReaderID=@in_ReaderID)
	begin
		set @out_str='该读者不存在'
		return 0
	end
	if not exists(select * from TBook where ISBN=@in_ISBN)
	begin
		set @out_str='该图书不存在'
		return 0
	end
	if(select Num from TReader where ReaderID=@in_ReaderID)=5
	begin
		set @out_str='读者借书量不能大于5'
		return 0
	end
	if @in_ISBN in (select ISBN from TLend where ReaderID=@in_ReaderID)
	begin
		set @out_str='该读者已经借过该书'
		return 0
	end
	if exists(select * from TLend where BookID=@in_BookID)
	begin
		set @out_str='该图书ID已存在'
		return 0
	end
	begin tran
	insert into TLend values(@in_BookID,@in_ReaderID,@in_ISBN,GETDATE())
	if @@ERROR>0
	begin
		rollback tran
		set @out_str='执行过程中遇到错误'
		return 0
	end
	update TReader set Num=Num+1 where ReaderID=@in_ReaderID
	if @@ERROR>0
	begin
		rollback tran
		set @out_str='执行过程中遇到错误'
		return 0
	end
	update TBook set SNum=SNum-1 where ISBN=@in_ISBN
	if @@ERROR=0
	begin
		commit tran
		set @out_str='借书成功'
		return 1
	end
	else
	begin
		rollback tran
		set @out_str='执行过程中遇到错误'
		return 0
	end
END
GO
/****** Object:  Default [DF_TBook_Photo]    Script Date: 05/07/2019 16:51:17 ******/
ALTER TABLE [dbo].[TBook] ADD  CONSTRAINT [DF_TBook_Photo]  DEFAULT ((0)) FOR [Photo]
GO
/****** Object:  Default [DF_TReader_Num]    Script Date: 05/07/2019 16:51:17 ******/
ALTER TABLE [dbo].[TReader] ADD  CONSTRAINT [DF_TReader_Num]  DEFAULT ((0)) FOR [Num]
GO
