USE [Hopelink_Train]
GO

INSERT INTO [dbo].[CT_RelationToPrimaryNRG]
           ([OrgID]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[UpdatedBy]
           ,[UpdatedDate]
           ,[ActiveStatus]
           ,[Relationship])
     VALUES
           (<OrgID, char(3),>
           ,<CreatedBy, char(3),>
           ,<CreatedDate, datetime,>
           ,<UpdatedBy, char(3),>
           ,<UpdatedDate, datetime,>
           ,<ActiveStatus, char(1),>
           ,<Relationship, varchar(50),>)
GO

