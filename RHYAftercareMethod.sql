USE [_CTN_Dev]
GO

/****** Object:  Table [dbo].[RHYAftercareMethod]    Script Date: 8/8/2017 11:14:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RHYAftercareMethod](
	[RHYAftercareMethodID] [int] IDENTITY(1,1) NOT NULL,
	[RHYAftercareAssessmentID] [int] NOT NULL,
	[AftercareMethod] [tinyint] NULL,
 CONSTRAINT [pk_RHYAftercareMethod] PRIMARY KEY CLUSTERED 
(
	[RHYAftercareMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RHYAftercareMethod]  WITH CHECK ADD  CONSTRAINT [sk_RHYAftercareMethod_RHYAftercareAssessment] FOREIGN KEY([RHYAftercareAssessmentID])
REFERENCES [dbo].[RHYAftercareAssessment] ([RHYAftercareAssessmentID])
GO

ALTER TABLE [dbo].[RHYAftercareMethod] CHECK CONSTRAINT [sk_RHYAftercareMethod_RHYAftercareAssessment]
GO

