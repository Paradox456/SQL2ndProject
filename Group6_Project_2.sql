/**************************************************************************************************************/
------------------------------------------------GROUP 6--------------------------------------------------------
/**************************************************************************************************************/
--
--
--
/**************************************************
-------------------CREATE TABLES-------------------
----------DB Security Authorization table----------
----------Add columns to existing tables-----------
---------------Work Flow Steps table---------------
--------Create stored procedure for work flow------


--Author: Justin Spears 
--Date: April 12, 2023 
--Description: Create all necessary data 
**************************************************/
-- Create DbSecurity.UserAuthorization
CREATE SCHEMA DbSecurity
GO

DROP TABLE IF EXISTS DbSecurity.UserAuthorization

CREATE TABLE [DbSecurity].[UserAuthorization] 
(
	UserAuthorizationKey INT NOT NULL 
	CONSTRAINT PK_UserAuthorization PRIMARY KEY,
	ClassTime NCHAR(5) DEFAULT '9:15',
	Individual NVARCHAR(60) NULL DEFAULT('Project 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),
	GroupMemberLastName NVARCHAR(35) NOT NULL,
	GroupMemberFirstName NVARCHAR(25) NOT NULL,
	GroupName NVARCHAR(20) DEFAULT 'Group 6',
	DateAdded DATETIME2 NULL DEFAULT SYSDATETIME()
)

INSERT INTO DbSecurity.UserAuthorization
(
    UserAuthorizationKey,
    GroupMemberLastName,
    GroupMemberFirstName
 
)
VALUES
(  1, 'Pak', 'Andrew' ),
( 2, 'Almonte', 'Corey'),
( 3, 'Spears', 'Justin'),
( 4, 'Yeung', 'Harrison'),
( 5, 'Islam', 'Annafi'), 
(6, 'Group 6', 'Group 6')
Go

/**************************************************************************************/
-------------------------------Create product tables------------------------------------
/**************************************************************************************/
	IF (SCHEMA_ID('PkSequence') IS NULL)
	BEGIN
		EXEC ('CREATE SCHEMA [PkSequence] AUTHORIZATION [dbo]')
	END 

	DROP SEQUENCE IF EXISTS [PkSequence].[DimProductSequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimProductSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

CREATE TABLE [CH01-01-Dimension].[DimProductCategory] 
(
	[ProductCategoryKey] [INT] DEFAULT (NEXT VALUE FOR [PkSequence].[DimProductSequenceObject])PRIMARY KEY NOT NULL,
    [ProductCategory] [varchar](20) NULL
)
Go


CREATE TABLE [CH01-01-Dimension].[DimProductSubcategory]
(
    [ProductSubcategoryKey] [INT] DEFAULT (NEXT VALUE FOR [PkSequence].[DimProductSequenceObject])PRIMARY KEY NOT NULL,
    [ProductSubcategory] [varchar](20) NULL,
)
Go
/**************************************************************************************/
--Alter existing tables to add columns 

ALTER TABLE [CH01-01-Dimension].DimCustomer
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].DimGender
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].DimMaritalStatus
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].DimOccupation
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].DimOrderDate
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].DimProduct
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE  [CH01-01-Dimension].[DimProductCategory]
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE  [CH01-01-Dimension].[DimProductSubcategory]
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].DimTerritory
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO

ALTER TABLE [CH01-01-Dimension].SalesManagers
ADD [UserAuthorizationKey] [INT] DEFAULT(-1) NOT NULL,
	[DateAdded] [datetime2] DEFAULT (sysdatetime()) NOT NULL,
	[DateOfLastUpdate] [datetime2] DEFAULT (sysdatetime()) NOT NULL
GO
--Create Workflowstep process table
	IF (SCHEMA_ID('PkSequence') IS NULL)
	BEGIN
		EXEC ('CREATE SCHEMA [PkSequence] AUTHORIZATION [dbo]')
	END 

	DROP SEQUENCE IF EXISTS [PkSequence].[TableRowSequenceObject]
	CREATE SEQUENCE [PkSequence].[TableRowSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[WorkFlowKeySequenceObject]
	CREATE SEQUENCE [PkSequence].[WorkFlowKeySequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647
Go 

CREATE SCHEMA Process
Go 

DROP TABLE IF EXISTS [Process].[WorkFlowSteps]

CREATE TABLE [Process].[WorkFlowSteps] 
(
	
	WorkFlowStepKey INT NOT NULL DEFAULT (NEXT VALUE FOR [PkSequence].[TableRowSequenceObject]), --Primary key 
	WorkFlowStepDescription NVARCHAR(100) NOT NULL, 
	WorkFlowStepTableRowCount INT NULL DEFAULT(0), --(NEXT VALUE FOR [PkSequence].[TableRowSequenceObject]), 
	StartingDateTime DATETIME2 DEFAULT (SYSDATETIME()) NOT NULL ,
	EndingDateTime DATETIME2 DEFAULT (SYSDATETIME()) NOT NULL , 
	ClassTime Char(5) NULL DEFAULT ('9:15'), 
	UserAuthorizationKey INT NOT NULL
--CONSTRAINT PK_WorkFlowSteps_WorkFlowStepKey PRIMARY KEY CLUSTERED (WorkFlowStepKey)
)



	
--Create stored procedure for work flow 
GO

USE BIClass
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears 
-- Create date: April 12, 2023 
-- Description:	Create stored procedure for work flow steps 
-- =============================================
CREATE PROCEDURE [Process].[usp_TrackWorkFlow]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

PRINT 'Alter this procedure to spec'
		   
END;
GO

--Create group name schema for inline table-valued function
CREATE SCHEMA Group6
Go

--Create function to insert data into workflow table 
CREATE FUNCTION Group6.GetWorkFlowData()
	RETURNS TABLE 
AS 
RETURN (SELECT WorkFlowStepTableRowCount, StartingDateTime, W.EndingDateTime, W.WorkFlowStepDescription,
		 W.UserAuthorizationKey
		FROM Process.WorkFlowSteps AS W);
GO

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Process].[usp_TrackWorkFlow]    Script Date: 4/13/2023 9:54:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears 
-- Create date: April 12, 2023 
-- Description:	Create stored procedure for work flow steps 
-- =============================================

ALTER PROCEDURE [Process].[usp_TrackWorkFlow]
	@WorkFlowStepTableRowCount INT,
	@StartTime DATETIME2,
	@EndTime DATETIME2,
	@WorkFlowDescription NVARCHAR(100), 
	@UserAuthorizationKey INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Group6.GetWorkFlowData()
	VALUES (@WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey); 
END;
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[AddForeignKeysToStarSchemaData]    Script Date: 4/12/2023 8:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears 
-- Create date: April 12, 2023 
-- Description:	Modify Project2.AddForeignKeysToStarSchemadata 
--				to add foreign keys 
-- =============================================
ALTER PROCEDURE [Project2].[AddForeignKeysToStarSchemaData] @UserAuthorizationKey INT 
AS
BEGIN

DECLARE 
		@WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'ADD FOREIGN KEYS'
	SET @StartTime = SYSDATETIME()

	ALTER TABLE [CH01-01-Fact].[Data]
	ADD CONSTRAINT FK_Data_DimCustomer  
		FOREIGN KEY (CustomerKey)
		REFERENCES [CH01-01-Dimension].DimCustomer (CustomerKey),

		CONSTRAINT FK_Data_DimGender
		FOREIGN KEY (Gender)
		REFERENCES [CH01-01-Dimension].DimGender (Gender), 

		CONSTRAINT FK_Data_DimMaritalStatus
		FOREIGN KEY (MaritalStatus) 
		REFERENCES [CH01-01-Dimension].DimMaritalStatus (MaritalStatus), 

		CONSTRAINT FK_Data_DimOccupation
		FOREIGN KEY (OccupationKey) 
		REFERENCES [CH01-01-Dimension].DimOccupation (OccupationKey), 

		CONSTRAINT FK_Data_DimOrderDate
		FOREIGN KEY (OrderDate) 
		REFERENCES [CH01-01-Dimension].DimOrderDate (OrderDate), 

		CONSTRAINT FK_Data_DimProduct
		FOREIGN KEY (ProductKey) 
		REFERENCES [CH01-01-Dimension].DimProduct (ProductKey),

		CONSTRAINT FK_Data_DimTerritory
		FOREIGN KEY (TerritoryKey) 
		REFERENCES [CH01-01-Dimension].DimTerritory (TerritoryKey),

		CONSTRAINT FK_Data_SalesManagers
		FOREIGN KEY (SalesManagerKey) 
		REFERENCES [CH01-01-Dimension].SalesManagers(SalesManagerKey)

		--ALTER TABLE [CH01-01-Dimension].[DimProduct]
		--	ADD CONSTRAINT FK_DimProduct_DimProductSubcategory
		--	FOREIGN KEY (ProductSubcategoryKey)
		--	REFERENCES [CH01-01-Dimension].DimProductSubcategory

		--ALTER TABLE [CH01-01-Dimension].DimProductSubcategory
		--	ADD CONSTRAINT FK_DimProductSubcategory_DimProductCategory
		--	FOREIGN KEY (ProductCategoryKey)
		--	REFERENCES [CH01-01-Dimension].DimProductCategory
		
		ALTER TABLE [CH01-01-Fact].[Data]
			DROP CONSTRAINT PK_Data;
		
SET @EndTime = SYSDATETIME()
EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription, 
	@UserAuthorizationKey = @UserAuthorizationKey;
END;
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[DropForeignKeysFromStarSchemaData]    Script Date: 4/9/2023 11:12:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears
-- Create date: April 9, 2023 
-- Description:	Drop the Foreign Keys From the Star Schema
-- =============================================
ALTER PROCEDURE [Project2].[DropForeignKeysFromStarSchemaData]
	@UserAuthorizationKey INT 
AS
BEGIN

	DECLARE 
			@WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'DROP FOREIGN KEYS'
	SET @StartTime = SYSDATETIME()

	-- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON
	
	ALTER TABLE [CH01-01-Fact].[Data]
	DROP CONSTRAINT IF EXISTS 
		FK_Data_DimCustomer,
		FK_Data_DimGender,
		FK_Data_DimMaritalStatus, 
		FK_Data_DimOccupation, 
		FK_Data_DimOrderDate,
		FK_Data_DimProduct,
		FK_Data_DimTerritory, 
		FK_Data_SalesManagers
		
	SET @EndTime = SYSDATETIME()
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription, 
		@UserAuthorizationKey = @UserAuthorizationKey;
END;
GO

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[TruncateStarSchemaData]    Script Date: 4/13/2023 1:45:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears	
-- Create date: April 9th, 2023
-- Description:	Modify Project2._Load_TruncateSchemaData 
-- =============================================
ALTER PROCEDURE [Project2].[TruncateStarSchemaData] @UserAuthorizationKey INT

AS
BEGIN
	
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'TRUNCATE DATA'
	SET @StartTime = SYSDATETIME()
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Truncate all tables 
	
	TRUNCATE TABLE [CH01-01-Dimension].DimCustomer 
	TRUNCATE TABLE [CH01-01-Dimension].DimGender 
	TRUNCATE TABLE [CH01-01-Dimension].DimMaritalStatus 
	TRUNCATE TABLE [CH01-01-Dimension].DimOccupation
	TRUNCATE TABLE [CH01-01-Dimension].DimOrderDate
	TRUNCATE TABLE [CH01-01-Dimension].DimProduct 
	TRUNCATE TABLE [CH01-01-Dimension].DimTerritory 
	TRUNCATE TABLE [CH01-01-Dimension].SalesManagers
	TRUNCATE TABLE [CH01-01-Fact].[Data]

	-- Create Sequence objects
	IF (SCHEMA_ID('PkSequence') IS NULL)
	BEGIN
		EXEC ('CREATE SCHEMA [PkSequence] AUTHORIZATION [dbo]')
	END 

	DROP SEQUENCE IF EXISTS [PkSequence].[DimCustomerSequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimCustomerSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[DimOccupationSequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimOccupationSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[DimTerritorySequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimTerritorySequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[SalesManagersSequenceObject] 
	CREATE SEQUENCE [PkSequence].[SalesManagersSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	SET @EndTime = SYSDATETIME()
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription, 
		@UserAuthorizationKey = @UserAuthorizationKey;
END; 
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[ShowTableStatusRowCount]    Script Date: 4/13/2023 2:26:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Project2].[ShowTableStatusRowCount] @UserAuthorizationKey INT,
@TableStatus VARCHAR(64)

AS
BEGIN
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'EXECUTE ROW COUNT'
	SET @StartTime = SYSDATETIME()

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimCustomer', COUNT(*) FROM [CH01-01-Dimension].DimCustomer
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimGender', COUNT(*) FROM [CH01-01-Dimension].DimGender
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimMaritalStatus', COUNT(*) FROM [CH01-01-Dimension].DimMaritalStatus 
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimOccupation', COUNT(*) FROM [CH01-01-Dimension].DimOccupation 
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimOrderDate', COUNT(*) FROM [CH01-01-Dimension].DimOrderDate
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimProduct', COUNT(*) FROM [CH01-01-Dimension].DimProduct
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimProductCategory', COUNT(*) FROM [CH01-01-Dimension].DimProductCategory
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimProductSubcategory', COUNT(*) FROM [CH01-01-Dimension].DimProductSubcategory
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.DimTerritory', COUNT(*) FROM [CH01-01-Dimension].DimTerritory
	select TableStatus = @TableStatus, TableName ='CH01-01-Dimension.SalesManagers', COUNT(*) FROM [CH01-01-Dimension].SalesManagers
	select TableStatus = @TableStatus, TableName ='CH01-01-Fact.Data', COUNT(*) FROM [CH01-01-Fact].Data
	
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = 0;
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
END;
Go

/**************************************************************************************************************/
-----------------------------------------------TABLE DATA------------------------------------------------------ 
/**************************************************************************************************************/
USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimCustomer]    Script Date: 4/14/2023 4:51:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harrison Yeung
-- Create date: 4/10/23	
-- Description:	Truncate original data in the DimCustomer columns (CustomerKey, CustomerName), and add the 3 necessary columns
--				(UserAuthorizationKey, DateAdded, DateofLastUpdate)
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimCustomer] @UserAuthorizationKey INT
AS
BEGIN

	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD CUSTOMER DATA'
	SET @StartTime = SYSDATETIME()
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO	[CH01-01-Dimension].DimCustomer
(
    CustomerName,
	UserAuthorizationKey
)

SELECT DISTINCT CustomerName,
@UserAuthorizationKey
FROM FileUpload.OriginallyLoadedData
	
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimCustomer);
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription, 
		@UserAuthorizationKey = @UserAuthorizationKey;

END
Go

/************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimGender]    Script Date: 4/14/2023 4:52:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrew Pak
-- Create date: 4/6/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimGender] @UserAuthorizationKey INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMGENDER DATA'
	SET @StartTime = SYSDATETIME()

    INSERT INTO [CH01-01-Dimension].DimGender
    (
        Gender,
        GenderDescription,
		UserAuthorizationKey
    )
    SELECT DISTINCT
           [Gender],
           CASE
               WHEN Gender = 'M' THEN
                   'Male'
               ELSE
                   'Female'
           END AS GenderDescription,
		   @UserAuthorizationKey
    FROM [BIClass].[FileUpload].[OriginallyLoadedData];

	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimGender);
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
END;
Go

/************************************************************************************************************/
USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimMaritalStatus]    Script Date: 4/13/2023 9:55:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Justin Spears	
-- Create date: April 9th, 2023 
-- Description:	Modify Project2.Load_DimMaritalStatus 
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimMaritalStatus] @UserAuthorizationKey INT
AS

BEGIN
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMMARITAL STATUS DATA'
	SET @StartTime = SYSDATETIME()

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	INSERT INTO [CH01-01-Dimension].DimMaritalStatus 
	(
		MaritalStatus,
		MaritalStatusDescription,
		UserAuthorizationKey
	)

	SELECT DISTINCT [MaritalStatus], 
	CASE 
		WHEN MaritalStatus = 'M' THEN 
			'Married' 
		ELSE 
			'Single' 
		END AS MaritalStatusDescription, @UserAuthorizationKey
	FROM BIClass.FileUpload.OriginallyLoadedData

	
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimMaritalStatus);

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
END; 
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimOccupation]    Script Date: 4/13/2023 10:30:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears	
-- Create date: April 10, 2023
-- Description:	Modify load procedure for DimOccupation 
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimOccupation] @UserAuthorizationKey INT 
	
AS
BEGIN
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMOCCUPATION DATA'
		
	SET @StartTime = SYSDATETIME()
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [CH01-01-Dimension].DimOccupation
	(
		OccupationKey, 
		Occupation, 
		UserAuthorizationKey
	)

	SELECT NEXT VALUE FOR [PkSequence].[DimOccupationSequenceObject], O.[Occupation],	
		@UserAuthorizationKey
	FROM (SELECT DISTINCT [Occupation]
		  FROM FileUpload.OriginallyLoadedData) AS O

	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimOccupation);
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription, 
		@UserAuthorizationKey = @UserAuthorizationKey;
END;
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimOrderDate]    Script Date: 4/14/2023 4:54:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Annafi Islam
-- Create date: 04/09/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimOrderDate] @UserAuthorizationKey INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMORDERDATE DATA'
	SET @StartTime = SYSDATETIME()

	INSERT INTO [CH01-01-Dimension].DimOrderDate
	(		
		OrderDate,
		MonthName,
		MonthNumber,
		Year,
		UserAuthorizationKey
	)

	SELECT DISTINCT 
		OrderDate,
		MonthName,
		MonthNumber,
		Year,
		@UserAuthorizationKey

	FROM FileUpload.OriginallyLoadedData
			
	SET @EndTime = SYSDATETIME();
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimOrderDate);

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;

	
END
Go

/**************************************************************************************************************/
USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductSubcategory]    Script Date: 4/14/2023 5:08:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Corey Almonte
-- Create date: 04/10/2023
-- Description:	Load Dim Product Subcategory
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductSubcategory] @UserAuthorizationKey INT
AS
BEGIN
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMPRODUCTSUBCATEGORY DATA'
	SET @StartTime = SYSDATETIME()

	INSERT INTO [CH01-01-Dimension].DimProductSubCategory ( ProductSubcategory, UserAuthorizationKey ) 

	SELECT DISTINCT
		ProductSubcategory,
		@UserAuthorizationKey
		FROM FileUpload.OriginallyLoadedData
	
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimProductSubcategory);

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;

END;
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductCategory]    Script Date: 4/14/2023 4:40:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Corey Almonte
-- Create date: 4/13/2023
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductCategory] @UserAuthorizationKey INT 


AS
BEGIN
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMPRODUCTCATEGORY DATA'
	SET @StartTime = SYSDATETIME()

	INSERT INTO [CH01-01-Dimension].DimProductCategory ( ProductCategory, UserAuthorizationKey) 

	SELECT DISTINCT
		ProductCategory,
		@UserAuthorizationKey
		FROM FileUpload.OriginallyLoadedData
	
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimProductCategory);

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;

END
GO

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProduct]    Script Date: 4/14/2023 4:39:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Corey Almonte
-- Create date: April 10, 2023 
-- Description:	Modify DimProduct procedure 
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProduct] @UserAuthorizationKey INT
AS
BEGIN

 DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMPRODUCT DATA'
	SET @StartTime = SYSDATETIME()
	SET IDENTITY_INSERT [CH01-01-Dimension].DimProduct ON

    INSERT INTO [CH01-01-Dimension].DimProduct
    (
        ProductKey,
        ProductSubcategoryKey,
        ProductCategory,
        ProductSubcategory,
        ProductCode,
        ProductName,
        Color,
        ModelName,
        UserAuthorizationKey
    )
    SELECT DISTINCT
           ROW_NUMBER() OVER (ORDER BY N.ProductCode) AS ProductKey,
           P.ProductSubcategoryKey,
           N.ProductCategory,
           N.ProductSubcategory,
           N.ProductCode,
           N.ProductName,
           N.Color,
           N.ModelName,
           @UserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData AS N
        FULL JOIN [CH01-01-Dimension].DimProductSubCategory AS P
            ON N.ProductSubcategory = P.ProductSubcategory
    GROUP BY P.ProductSubCategoryKey,
             N.ProductCategory,
             N.ProductSubcategory,
             N.ProductCode,
             N.ProductName,
             N.Color,
             N.ModelName;
	
   SET @EndTime = SYSDATETIME()
   SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimProduct);

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
END;
Go

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimTerritory]    Script Date: 4/14/2023 4:55:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harrison Yeung
-- Create date: 04/10/2023
-- Description:	Load Dim Territory
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimTerritory] @UserAuthorizationKey INT
AS

BEGIN
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD DIMTERRITORY DATA'
	SET @StartTime = SYSDATETIME()
INSERT INTO [CH01-01-Dimension].DimTerritory
    (
        TerritoryGroup,
        TerritoryCountry,
        TerritoryRegion,
		UserAuthorizationKey
    )
    SELECT DISTINCT
           TerritoryRegion,
           TerritoryGroup,
           TerritoryCountry,
		   @UserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData;
		SET @EndTime = SYSDATETIME()

		SET @EndTime = SYSDATETIME()
		SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimTerritory);
		EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;

END;
Go 
/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_SalesManagers]    Script Date: 4/14/2023 4:47:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrew Pak	
-- Create date: 04/09/2023
-- Description:	Loading sales managers
-- =============================================
ALTER PROCEDURE [Project2].[Load_SalesManagers] @UserAuthorizationKey INT
AS
BEGIN
	
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD SALESMANAGER DATA'
	SET @StartTime = SYSDATETIME()

	SET NOCOUNT ON;

	INSERT INTO [CH01-01-Dimension].SalesManagers
	(
		Category,
		SalesManagerKey,
		SalesManager,
		Office,
		UserAuthorizationKey
	)
	SELECT DISTINCT
		ProductSubcategory,
		ROW_NUMBER() OVER (ORDER BY ProductSubcategory) AS SalesManagerKey,
		SalesManager,
		Office = CASE
					 WHEN SalesManager LIKE 'Marco%' THEN
						 'Redmond'
					 WHEN SalesManager LIKE 'Alberto%' THEN
						 'Seattle'
					 WHEN SalesManager LIKE 'Maurizio%' THEN
						 'Redmond'
					 ELSE
						 'Seattle'
				 END,
		@UserAuthorizationKey
	FROM FileUpload.OriginallyLoadedData
	GROUP BY ProductSubcategory, SalesManager; 

	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].SalesManagers);
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;

END
Go 

/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_Data]    Script Date: 4/12/2023 12:37:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrew Pak
-- Create date: April 10, 2023 
-- Description:	Modify Load Data procedure 
--
-- @GroupMemberUserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure.
--
-- =============================================
ALTER PROCEDURE [Project2].[Load_Data]
	@UserAuthorizationKey int
AS
BEGIN

	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, @WorkFlowDescription AS VARCHAR(100) = 'LOAD LOADDATA DATA'
	SET @StartTime = SYSDATETIME()
	
   INSERT INTO [CH01-01-Fact].[Data]
   (
       [SalesKey],
       [SalesManagerKey],
       [OccupationKey],
       [TerritoryKey],
       [ProductKey],
       [CustomerKey],
       [ProductCategory],
       [SalesManager],
       [ProductSubcategory],
       [ProductCode],
       [ProductName],
       [Color],
       [ModelName],
       [OrderQuantity],
       [UnitPrice],
       [ProductStandardCost],
       [SalesAmount],
       [OrderDate],
       [MonthName],
       [MonthNumber],
       [Year],
       [CustomerName],
       [MaritalStatus],
       [Gender],
       [Education],
       [Occupation],
       [TerritoryRegion],
       [TerritoryCountry],
       [TerritoryGroup]
   )
 
   SELECT 
	   F.SalesKey,
       SM.SalesManagerKey,
       O.OccupationKey,
       T.TerritoryKey,
       P.ProductKey,
       C.CustomerKey,
       F.ProductSubcategory AS ProductCategory,
       F.ProductCategory AS ProductCategory,
       F.SalesManager,
       F.ProductCode,
       F.ProductName,
       F.Color,
       F.ModelName,
       F.OrderQuantity,
       F.UnitPrice,
       F.ProductStandardCost,
       F.SalesAmount,
       F.OrderDate,
       F.MonthName,
       F.MonthNumber,
       F.Year,
       F.CustomerName,
       F.MaritalStatus,
       F.Gender,
       F.Education,
       F.Occupation,
       F.TerritoryRegion,
       F.TerritoryCountry,
       F.TerritoryGroup
	FROM FileUpload.OriginallyLoadedData AS F
    RIGHT JOIN [CH01-01-Dimension].SalesManagers AS SM
        ON SM.Category = F.ProductSubcategory
    RIGHT JOIN [CH01-01-Dimension].DimOccupation AS O
        ON O.Occupation = F.Occupation
    RIGHT JOIN [CH01-01-Dimension].DimTerritory AS T
        ON T.TerritoryGroup = F.TerritoryRegion
    RIGHT JOIN [CH01-01-Dimension].DimProduct AS P
        ON P.ProductCode = F.ProductCode
    RIGHT JOIN [CH01-01-Dimension].DimCustomer AS C
        ON C.CustomerName = F.CustomerName
	ORDER BY F.SalesKey
	
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Fact].[Data]);
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
END;
Go 

/**************************************************************************************************************/
---------------------------------------------END OF TABLE DATA-------------------------------------------------
/**************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[TruncateStarSchemaData]    Script Date: 4/13/2023 1:45:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears	
-- Create date: April 9th, 2023
-- Description:	Modify Project2._Load_TruncateSchemaData 
-- =============================================
ALTER PROCEDURE [Project2].[TruncateStarSchemaData] @UserAuthorizationKey INT

AS
BEGIN
	
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'TRUNCATE DATA'
	SET @StartTime = SYSDATETIME()
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Truncate all tables 
	
	TRUNCATE TABLE [CH01-01-Dimension].DimCustomer 
	TRUNCATE TABLE [CH01-01-Dimension].DimGender 
	TRUNCATE TABLE [CH01-01-Dimension].DimMaritalStatus 
	TRUNCATE TABLE [CH01-01-Dimension].DimOccupation
	TRUNCATE TABLE [CH01-01-Dimension].DimOrderDate
	TRUNCATE TABLE [CH01-01-Dimension].DimProduct 
	TRUNCATE TABLE [CH01-01-Dimension].DimTerritory 
	TRUNCATE TABLE [CH01-01-Dimension].SalesManagers
	TRUNCATE TABLE [CH01-01-Fact].[Data]

	-- Create Sequence objects
	IF (SCHEMA_ID('PkSequence') IS NULL)
	BEGIN
		EXEC ('CREATE SCHEMA [PkSequence] AUTHORIZATION [dbo]')
	END 

	DROP SEQUENCE IF EXISTS [PkSequence].[DimCustomerSequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimCustomerSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[DimOccupationSequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimOccupationSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[DimTerritorySequenceObject] 
	CREATE SEQUENCE [PkSequence].[DimTerritorySequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	DROP SEQUENCE IF EXISTS [PkSequence].[SalesManagersSequenceObject] 
	CREATE SEQUENCE [PkSequence].[SalesManagersSequenceObject]
	AS [INT]
	START WITH 1 
	INCREMENT BY 1 
	MINVALUE 1 
	MAXVALUE 2147483647

	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = 0; -->; )
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
END; 
Go

/******************************************************************************************************************************/

USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[LoadStarSchemaData]    Script Date: 4/13/2023 3:11:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Justin Spears 
-- Create date: April 13, 2023  
-- Description:	Load Star Schema Data 
-- =============================================
ALTER PROCEDURE [Project2].[LoadStarSchemaData] @UserAuthorizationKey INT 
    -- Add the parameters for the stored procedure here
AS
BEGIN
	TRUNCATE TABLE [process].[workflowsteps]
	DECLARE @WorkFlowStepTableRowCount INT, @StartTime DATETIME2,@EndTime AS DATETIME2, 
		@WorkFlowDescription AS VARCHAR(100) = 'LOAD STAR SCHEMA DATA'
		SET @StartTime = SYSDATETIME()

    SET NOCOUNT ON;

    --	Drop All of the foreign keys prior to truncating tables in the star schema
    EXEC  [Project2].[DropForeignKeysFromStarSchemaData] @UserAuthorizationKey = 6;
	
	--	Check row count before truncation
	EXEC  [Project2].[ShowTableStatusRowCount] @UserAuthorizationKey = 2, 
				@TableStatus = N'''Pre-truncate of tables'''
  
    --	Always truncate the Star Schema Data
    EXEC  [Project2].[TruncateStarSchemaData] @UserAuthorizationKey = 3;
	
    -- Load the star schema
    EXEC  [Project2].[Load_DimProductCategory] @UserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProductSubcategory] @UserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProduct] @UserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project2].[Load_SalesManagers] @UserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project2].[Load_DimGender] @UserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project2].[Load_DimMaritalStatus] @UserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOccupation] @UserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project2].Load_DimOrderDate @UserAuthorizationKey = 5; -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimTerritory] @UserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimCustomer] @UserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_Data] @UserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey

	-- Check row count after loading star schema data 
	EXEC	[Project2].[ShowTableStatusRowCount] 
		@UserAuthorizationKey = 6,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Row Count after loading the star schema'''
	-- Recreate all of the foreign keys prior after loading the star schema
   EXEC [Project2].[AddForeignKeysToStarSchemaData] @UserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
    
	SET @EndTime = SYSDATETIME()
	SET @WorkFlowStepTableRowCount = 0;
	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepTableRowCount, @StartTime, @EndTime, @WorkFlowDescription,
		@UserAuthorizationKey = @UserAuthorizationKey;
	
	-- Show Work Flow results 
SELECT * 
FROM process.workflowsteps
--	SELECT ROW_NUMBER() OVER (ORDER BY EndingDateTime) AS WorkFlowTableKey, 
--		WorkFlowStepDescription, ROW_NUMBER() OVER (ORDER BY EndingDateTime) AS WorkFlowStepTableRowCount, StartingDateTime, EndingDateTime, 
--		ClassTime, UserAuthorizationKey
--	FROM Process.WorkFlowSteps
END;
Go

/******************************************************************************************************************************/
-------------------------------------------END OF FILE--------------------------------------------------------------------------
/******************************************************************************************************************************/


EXEC Project2.LoadStarSchemaData @UserAuthorizationKey = 3; 

--SELECT * FROM	[CH01-01-Fact].[Data]