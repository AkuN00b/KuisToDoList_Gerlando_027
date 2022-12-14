USE [master]
GO
/****** Object:  Database [KuisToDoList_Gerlando_027]    Script Date: 2022-11-04 오후 3:56:14 ******/
CREATE DATABASE [KuisToDoList_Gerlando_027]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KuisToDoList_Gerlando_027', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\KuisToDoList_Gerlando_027.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KuisToDoList_Gerlando_027_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\KuisToDoList_Gerlando_027_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KuisToDoList_Gerlando_027].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET ARITHABORT OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET RECOVERY FULL 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET  MULTI_USER 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KuisToDoList_Gerlando_027', N'ON'
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET QUERY_STORE = OFF
GO
USE [KuisToDoList_Gerlando_027]
GO
/****** Object:  Table [dbo].[ToDoList]    Script Date: 2022-11-04 오후 3:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToDoList](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[priorityLevel] [int] NOT NULL,
	[status] [int] NOT NULL,
 CONSTRAINT [PK_ToDoList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_ChangeStatus]    Script Date: 2022-11-04 오후 3:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ChangeStatus]
	@id	int
AS
BEGIN
	UPDATE ToDoList
	SET status = 0
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteToDoList]    Script Date: 2022-11-04 오후 3:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteToDoList]
	@id		int
AS
BEGIN
	DELETE FROM ToDoList WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDone]    Script Date: 2022-11-04 오후 3:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getDone]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT id, ROW_NUMBER() OVER (ORDER BY id ASC) AS rownum, name, (CASE WHEN priorityLevel = 1 THEN 'High' WHEN priorityLevel = 2 THEN 'Medium' ELSE 'Low' END) AS priorityLevel, status FROM ToDoList WHERE status = 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getNotDone]    Script Date: 2022-11-04 오후 3:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getNotDone]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT id, ROW_NUMBER() OVER (ORDER BY id ASC) AS rownum, name, (CASE WHEN priorityLevel = 1 THEN 'High' WHEN priorityLevel = 2 THEN 'Medium' ELSE 'Low' END) AS priorityLevel, status FROM ToDoList WHERE status = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertToDoList]    Script Date: 2022-11-04 오후 3:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertToDoList]
	@name				varchar(50),
	@priority			int
AS
BEGIN
	INSERT INTO ToDoList(name, priorityLevel, status)
	VALUES(@name, @priority, 1)
END
GO
USE [master]
GO
ALTER DATABASE [KuisToDoList_Gerlando_027] SET  READ_WRITE 
GO
