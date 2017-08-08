USE [_CTN_Dev];
GO

CREATE TABLE #temptable (
    [TableID] INT
  , [TableName] VARCHAR (50)
  , [TableKey] VARCHAR (50)
  , [Label] VARCHAR (75)
  , [URL] VARCHAR (250)
  , [OneToMany] BIT
  , [AssessmentID] VARCHAR (50)
  , [VariableName] VARCHAR (50)
  , [TypeID] INT
  , [Parameters] VARCHAR (4000));
INSERT INTO #temptable
VALUES ( 90
       , 'ProviderAssessment'
       , 'ID'
       , 'Primary Care Assessment'
       , NULL
       , 0
       , 'AssessmentID'
       , NULL
       , 1
       , 'FormID=4241&PrimaryKey=@ClientID@&SecondaryKey=@PrimaryCareID@&PowerEdit=false&NoSkip=false' )
     , ( 91, 'HUDVASHExitAssessment', 'HUDVASHExitID', 'HUD VASH Exit Assessment', NULL, 0, 'AssessmentID', NULL, 1, NULL )
     , ( 92, 'VASH_VoucherTracking', 'VoucherTrackingID', 'VASH Voucher Tracking', NULL, 0, 'AssessmentID', NULL, 1, NULL )
     , ( 93
       , 'SafeExitAssessment'
       , 'SafeExitAssessmentID'
       , 'Safe and Exit Assessment'
       , NULL
       , 0
       , 'AssessmentID'
       , NULL
       , 1
       , 'FormID=4305&PowerEdit=false&NoSkip=false' );

SET IDENTITY_INSERT [dbo].[AssessmentTable] ON;

INSERT INTO [dbo].[AssessmentTable] ( [TableID]
                                    , [TableName]
                                    , [TableKey]
                                    , [Label]
                                    , [URL]
                                    , [OneToMany]
                                    , [AssessmentID]
                                    , [VariableName]
                                    , [TypeID]
                                    , [Parameters] )
SELECT  [T].[TableID]
      , [T].[TableName]
      , [T].[TableKey]
      , [T].[Label]
      , [T].[URL]
      , [T].[OneToMany]
      , [T].[AssessmentID]
      , [T].[VariableName]
      , [T].[TypeID]
      , [T].[Parameters]
FROM    [#temptable] AS [T];
DROP TABLE #temptable;

SET IDENTITY_INSERT [dbo].[AssessmentTable] OFF;