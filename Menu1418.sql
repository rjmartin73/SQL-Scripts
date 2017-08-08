USE [QA15];
GO

IF NOT EXISTS (   SELECT    *
                  FROM      [dbo].[MenuOption] AS [MO]
                  WHERE     [MO].[MenuOptionID] = 1814 )
BEGIN

    SET IDENTITY_INSERT [dbo].[MenuOption] ON;

    BEGIN TRANSACTION;

    INSERT INTO [dbo].[MenuOption] ( [MenuOptionID]
                                   , [Description]
                                   , [FormID]
                                   , [FormPage]
                                   , [URL]
                                   , [NoParameters]
                                   , [Popup]
                                   , [EntityRequired]
                                   , [RestrictToOrg]
                                   , [Condition]
                                   , [PageID]
                                   , [OldIconID]
                                   , [IconID]
                                   , [UpdatedDate] )
    VALUES ( 1814
           , 'RHY Aftercare'
           , 4296
           , 0
           , 'viewform.aspx?FormID=4296&PrimaryKey=@PrimaryKey@&SecondaryKey='
           , 0
           , 0
           , 1
           , 0
           , NULL
           , 2
           , 1
           , 879
           , N'2017-07-10T10:32:44.73' );

    SET IDENTITY_INSERT [dbo].[MenuOption] OFF;
END;

COMMIT TRANSACTION