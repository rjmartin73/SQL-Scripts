USE [_CTN_Dev]
GO

/****** Object:  Table [dbo].[RHYAftercareAssessment]    Script Date: 8/8/2017 11:11:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RHYAftercareAssessment](
	[ClientID] [INT] NOT NULL,
	[RHYAftercareAssessmentID] [INT] IDENTITY(1,1) NOT NULL,
	[AssessmentID] [INT] NULL,
	[AssessmentDate] [DATETIME2](7) NOT NULL,
	[RestrictOrg] [CHAR](1) NOT NULL,
	[OrgID] [CHAR](3) NOT NULL,
	[CreatedBy] [CHAR](3) NOT NULL,
	[CreatedDate] [DATETIME] NOT NULL,
	[UpdatedBy] [CHAR](3) NOT NULL,
	[UpdatedDate] [DATETIME] NOT NULL,
	[ActiveStatus] [CHAR](1) NOT NULL,
	[AftercareProvided] [TINYINT] NULL,
	[EnrollID] [INT] NOT NULL,
 CONSTRAINT [pk_RHYAftercareAssessment] PRIMARY KEY CLUSTERED 
(
	[RHYAftercareAssessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_RestrictOrg]  DEFAULT ('X') FOR [RestrictOrg]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_OrgID]  DEFAULT ('DSI') FOR [OrgID]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_CreatedBy]  DEFAULT ('DSI') FOR [CreatedBy]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_UpdatedBy]  DEFAULT ('DSI') FOR [UpdatedBy]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_UpdatedDate]  DEFAULT (GETDATE()) FOR [UpdatedDate]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] ADD  CONSTRAINT [DF_RHYAftercareAssessment_ActiveStatus]  DEFAULT ('A') FOR [ActiveStatus]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment]  WITH CHECK ADD  CONSTRAINT [sk_RHYAftercareAssessment_Assessment] FOREIGN KEY([AssessmentID])
REFERENCES [dbo].[Assessment] ([AssessmentID])
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] CHECK CONSTRAINT [sk_RHYAftercareAssessment_Assessment]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment]  WITH CHECK ADD  CONSTRAINT [sk_RHYAftercareAssessment_cmClient] FOREIGN KEY([ClientID])
REFERENCES [dbo].[cmClient] ([ClientID])
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] CHECK CONSTRAINT [sk_RHYAftercareAssessment_cmClient]
GO

ALTER TABLE [dbo].[RHYAftercareAssessment]  WITH CHECK ADD  CONSTRAINT [sk_RHYAftercareAssessment_Enrollment] FOREIGN KEY([EnrollID])
REFERENCES [dbo].[Enrollment] ([EnrollID])
GO

ALTER TABLE [dbo].[RHYAftercareAssessment] CHECK CONSTRAINT [sk_RHYAftercareAssessment_Enrollment]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<b>HMIS Program specific data elemts: RHY (R20) HMIS 2017</b>' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RHYAftercareAssessment'
GO


