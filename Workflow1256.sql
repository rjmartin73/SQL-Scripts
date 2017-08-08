PRINT 'Workflow 1256';
ALTER TABLE Workflow NOCHECK CONSTRAINT ALL;
ALTER TABLE WorkflowStep NOCHECK CONSTRAINT ALL;
ALTER TABLE WorkflowButton NOCHECK CONSTRAINT ALL;
ALTER TABLE WorkflowAction NOCHECK CONSTRAINT ALL;
ALTER TABLE WorkflowDependency NOCHECK CONSTRAINT ALL;
DECLARE @Workflow	TABLE
(
[WorkflowID]	INT,
[WorkflowName]	NVARCHAR(max),
[Label]	NVARCHAR(max),
[Sequential]	BIT,
[PausedIdentification]	NVARCHAR(max),
[LinkTable]	NVARCHAR(max),
[LinkID]	NVARCHAR(max),
[BaseWorkflowID]	INT,
[PageID]	INT,
[EntityVariable]	NVARCHAR(max),
[Assessment]	BIT,
[WorkflowExplanation]	NVARCHAR(max),
PRIMARY KEY([WorkflowID])
);
INSERT INTO @Workflow([WorkflowID],[WorkflowName],[Label],[Sequential],[PausedIdentification],[LinkTable],[LinkID],[BaseWorkflowID],[PageID],[EntityVariable],[Assessment],[WorkflowExplanation])
SELECT 1256,'HMIS 2017 Post Exit','HMIS 2017 Post Exit',1,'@Name@','cmClient','@ClientID@',NULL,2,'ClientID',0,NULL
UNION ALL SELECT 1257,'PostExitAssessment','PostExitAssessment',1,'@Name@','cmClient','@ClientID@',NULL,2,'ClientID',1,NULL;
UPDATE Workflow
SET WorkflowName=T.WorkflowName,
Label=T.Label,
Sequential=T.Sequential,
PausedIdentification=T.PausedIdentification,
LinkTable=T.LinkTable,
LinkID=T.LinkID,
BaseWorkflowID=T.BaseWorkflowID,
PageID=T.PageID,
EntityVariable=T.EntityVariable,
Assessment=T.Assessment,
WorkflowExplanation=T.WorkflowExplanation
FROM Workflow O
INNER JOIN @Workflow T ON O.WorkflowID = T.WorkflowID;
SET IDENTITY_INSERT Workflow ON;
INSERT INTO Workflow(WorkflowID,WorkflowName,Label,Sequential,PausedIdentification,LinkTable,LinkID,BaseWorkflowID,PageID,EntityVariable,Assessment,WorkflowExplanation)
SELECT WorkflowID,WorkflowName,Label,Sequential,PausedIdentification,LinkTable,LinkID,BaseWorkflowID,PageID,EntityVariable,Assessment,WorkflowExplanation
FROM @Workflow T
WHERE NOT EXISTS( SELECT * FROM Workflow WHERE WorkflowID = T.WorkflowID );
SET IDENTITY_INSERT Workflow OFF;

DECLARE @WorkflowStep	TABLE
(
[WorkflowID]	INT,
[StepID]	INT,
[ParentStepID]	INT,
[Label]	NVARCHAR(max),
[TypeID]	INT,
[Required]	BIT,
[Visible]	BIT,
[IndentChildren]	BIT,
[Sequential]	BIT,
[Condition]	NVARCHAR(max),
[Parameters]	NVARCHAR(max),
[SortOrder]	INT,
[TableID]	INT,
[Disabled]	BIT,
PRIMARY KEY([StepID])
);
INSERT INTO @WorkflowStep([WorkflowID],[StepID],[ParentStepID],[Label],[TypeID],[Required],[Visible],[IndentChildren],[Sequential],[Condition],[Parameters],[SortOrder],[TableID],[Disabled])
SELECT 1256,4240,NULL,'Initialize',2,1,0,0,1,NULL,NULL,2,NULL,0
UNION ALL SELECT 1256,4241,NULL,'Post Exit Assessment',4,1,0,0,1,NULL,'WorkflowID=1257&AssessmentID=@AssessmentID@&AssessmentType=4&AssessmentDate=@Date@&ProgramID=@ProgramID@&ClientID=@ClientID@&EditForm=1104&SearchForm=1370&AutoStart=true&NoSkip=false',4,NULL,0
UNION ALL SELECT 1257,4242,NULL,'New Generic Step',2,1,0,0,1,NULL,NULL,2,NULL,0
UNION ALL SELECT 1257,4243,NULL,'RHY Aftercare Assessment',1,1,1,0,1,NULL,'FormID=4294&PrimaryKey=@EnrollID@&SecondaryKey=@RHYAftercareAssessmentID@&PowerEdit=false&NoSkip=false',4,NULL,0;
UPDATE WorkflowStep
SET WorkflowID=T.WorkflowID,
ParentStepID=T.ParentStepID,
Label=T.Label,
TypeID=T.TypeID,
Required=T.Required,
Visible=T.Visible,
IndentChildren=T.IndentChildren,
Sequential=T.Sequential,
Condition=T.Condition,
Parameters=T.Parameters,
SortOrder=T.SortOrder,
TableID=T.TableID,
Disabled=T.Disabled
FROM WorkflowStep O
INNER JOIN @WorkflowStep T ON O.StepID = T.StepID;
SET IDENTITY_INSERT WorkflowStep ON;
INSERT INTO WorkflowStep(WorkflowID,StepID,ParentStepID,Label,TypeID,Required,Visible,IndentChildren,Sequential,Condition,Parameters,SortOrder,TableID,Disabled)
SELECT WorkflowID,StepID,ParentStepID,Label,TypeID,Required,Visible,IndentChildren,Sequential,Condition,Parameters,SortOrder,TableID,Disabled
FROM @WorkflowStep T
WHERE NOT EXISTS( SELECT * FROM WorkflowStep WHERE StepID = T.StepID );
SET IDENTITY_INSERT WorkflowStep OFF;

DECLARE @WorkflowButton	TABLE
(
[StepID]	INT,
[ButtonID]	INT,
[Label]	NVARCHAR(max),
[Icon]	NVARCHAR(max),
[Event]	TINYINT,
[Condition]	NVARCHAR(max),
[Parameters]	NVARCHAR(max),
[TopOfPage]	BIT,
[PageNumber]	SMALLINT,
[SaveForm]	BIT,
[SortOrder]	INT,
[Disabled]	BIT,
[IconID]	INT,
PRIMARY KEY([ButtonID])
);
DECLARE @WorkflowAction	TABLE
(
[ActionID]	INT,
[WorkflowID]	INT,
[StepID]	INT,
[ButtonID]	INT,
[TypeID]	INT,
[StepEventType]	TINYINT,
[Condition]	NVARCHAR(max),
[Parameters]	NVARCHAR(max),
[SortOrder]	INT,
[Disabled]	BIT,
PRIMARY KEY([ActionID])
);
INSERT INTO @WorkflowAction([ActionID],[WorkflowID],[StepID],[ButtonID],[TypeID],[StepEventType],[Condition],[Parameters],[SortOrder],[Disabled])
SELECT 8251,1256,4240,NULL,1,1,NULL,'EnrollID=@EnrollID@&ClientID=@PrimaryKey@',0,0;
UPDATE WorkflowAction
SET WorkflowID=T.WorkflowID,
StepID=T.StepID,
ButtonID=T.ButtonID,
TypeID=T.TypeID,
StepEventType=T.StepEventType,
Condition=T.Condition,
Parameters=T.Parameters,
SortOrder=T.SortOrder,
Disabled=T.Disabled
FROM WorkflowAction O
INNER JOIN @WorkflowAction T ON O.ActionID = T.ActionID;
SET IDENTITY_INSERT WorkflowAction ON;
INSERT INTO WorkflowAction(ActionID,WorkflowID,StepID,ButtonID,TypeID,StepEventType,Condition,Parameters,SortOrder,Disabled)
SELECT ActionID,WorkflowID,StepID,ButtonID,TypeID,StepEventType,Condition,Parameters,SortOrder,Disabled
FROM @WorkflowAction T
WHERE NOT EXISTS( SELECT * FROM WorkflowAction WHERE ActionID = T.ActionID );
SET IDENTITY_INSERT WorkflowAction OFF;

DECLARE @WorkflowDependency	TABLE
(
[WorkflowID]	INT,
[DependsOnID]	INT,
PRIMARY KEY([DependsOnID],[WorkflowID])
);
INSERT INTO @WorkflowDependency([WorkflowID],[DependsOnID])
SELECT 1256,1257;
INSERT INTO WorkflowDependency(WorkflowID,DependsOnID)
SELECT WorkflowID,DependsOnID
FROM @WorkflowDependency T
WHERE NOT EXISTS( SELECT * FROM WorkflowDependency WHERE DependsOnID = T.DependsOnID
  AND WorkflowID = T.WorkflowID );

DELETE WorkflowDependency FROM WorkflowDependency O WHERE NOT EXISTS(SELECT * FROM @WorkflowDependency WHERE DependsOnID = O.DependsOnID
  AND WorkflowID = O.WorkflowID)
  AND EXISTS(SELECT * FROM @Workflow WHERE WorkflowID = O.WorkflowID);
DELETE WorkflowAction FROM WorkflowAction O WHERE NOT EXISTS(SELECT * FROM @WorkflowAction WHERE ActionID = O.ActionID)
  AND EXISTS(SELECT * FROM @Workflow WHERE WorkflowID = O.WorkflowID);
DELETE WorkflowButton FROM WorkflowButton O WHERE NOT EXISTS(SELECT * FROM @WorkflowButton WHERE ButtonID = O.ButtonID)
  AND EXISTS(SELECT * FROM @WorkflowStep WHERE StepID = O.StepID);
DELETE WorkflowStep FROM WorkflowStep O WHERE NOT EXISTS(SELECT * FROM @WorkflowStep WHERE StepID = O.StepID)
  AND EXISTS(SELECT * FROM @Workflow WHERE WorkflowID = O.WorkflowID);

ALTER TABLE Workflow WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE WorkflowStep WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE WorkflowButton WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE WorkflowAction WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE WorkflowDependency WITH CHECK CHECK CONSTRAINT ALL;
