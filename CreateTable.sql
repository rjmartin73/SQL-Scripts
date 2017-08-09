USE _CTN_Dev
GO

--IF (OBJECT_ID('dbo.CounselingAssessment') IS NOT NULL)
--	DROP TABLE dbo.CounselingAssessment;

--CREATE TABLE dbo.CounselingAssessment (
--		CounselingID INT IDENTITY
--	   ,ClientID INT NOT NULL  
--	   ,AssessmentID INT
--	   ,AssessmentDate DATETIME2
--	   ,CreatedDate DATETIME2 DEFAULT SYSDATETIME() NOT NULL
--	   ,CreatedBy CHAR(3) NOT NULL
--	   ,UpdatedDate DATETIME2 NOT NULL
--	   ,UpdatedBy CHAR(3) NOT NULL
--	   ,ActiveStatus CHAR(1) DEFAULT 'A' NOT NULL
--	   ,OrgID CHAR(3) NOT NULL
--	   ,RestrictOrg CHAR(1) DEFAULT 'X' NOT NULL

--	   ,PRIMARY KEY(CounselingID)
--	   ,FOREIGN KEY (ClientID) REFERENCES cmClient(ClientID)
--	   ,FOREIGN KEY(AssessmentID) REFERENCES Assessment(AssessmentID)
--	   ,FOREIGN KEY (OrgID) REFERENCES osOrganization (OrgID)
--	)




