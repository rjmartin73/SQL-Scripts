PRINT 'Form 2778';
ALTER TABLE DynamicFormElement NOCHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormAction NOCHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormGroup NOCHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormEdge NOCHECK CONSTRAINT ALL;
ALTER TABLE Report NOCHECK CONSTRAINT ALL;
DECLARE @DynamicForm	TABLE
(
[FormID]	INT,
[FormDescription]	NVARCHAR(100),
[FormTypeID]	TINYINT,
[OnFormCompleteURL]	NVARCHAR(1000),
[OnFormCompleteNewURL]	NVARCHAR(1000),
[ShowConfirmation]	BIT,
[Width]	SMALLINT,
[Height]	SMALLINT,
[AutoExecuteSearch]	BIT,
[PauseIdentificationColumn]	NVARCHAR(100),
[IsDefaultForm]	BIT,
[OrigionalFormID]	INT,
[DefaultValuesStoredProc]	NVARCHAR(2000),
[FormParameters]	NVARCHAR(max),
[FormExplanation]	NVARCHAR(max),
PRIMARY KEY([FormID])
);
INSERT INTO @DynamicForm([FormID],[FormDescription],[FormTypeID],[OnFormCompleteURL],[OnFormCompleteNewURL],[ShowConfirmation],[Width],[Height],[AutoExecuteSearch],[PauseIdentificationColumn],[IsDefaultForm],[OrigionalFormID],[DefaultValuesStoredProc],[FormParameters],[FormExplanation])
SELECT 2778,'Program Enrollments for HUD Programs',2,NULL,NULL,1,NULL,NULL,0,'CaseDescription.EnrollmentDesc',0,1198,NULL,NULL,NULL;
UPDATE DynamicForm
SET FormDescription=T.FormDescription,
FormTypeID=T.FormTypeID,
OnFormCompleteURL=T.OnFormCompleteURL,
OnFormCompleteNewURL=T.OnFormCompleteNewURL,
ShowConfirmation=T.ShowConfirmation,
Width=T.Width,
Height=T.Height,
AutoExecuteSearch=T.AutoExecuteSearch,
PauseIdentificationColumn=T.PauseIdentificationColumn,
IsDefaultForm=T.IsDefaultForm,
OrigionalFormID=T.OrigionalFormID,
DefaultValuesStoredProc=T.DefaultValuesStoredProc,
FormParameters=T.FormParameters,
FormExplanation=T.FormExplanation
FROM DynamicForm O
INNER JOIN @DynamicForm T ON O.FormID = T.FormID;
SET IDENTITY_INSERT DynamicForm ON;
INSERT INTO DynamicForm(FormID,FormDescription,FormTypeID,OnFormCompleteURL,OnFormCompleteNewURL,ShowConfirmation,Width,Height,AutoExecuteSearch,PauseIdentificationColumn,IsDefaultForm,OrigionalFormID,DefaultValuesStoredProc,FormParameters,FormExplanation)
SELECT FormID,FormDescription,FormTypeID,OnFormCompleteURL,OnFormCompleteNewURL,ShowConfirmation,Width,Height,AutoExecuteSearch,PauseIdentificationColumn,IsDefaultForm,OrigionalFormID,DefaultValuesStoredProc,FormParameters,FormExplanation
FROM @DynamicForm T
WHERE NOT EXISTS( SELECT * FROM DynamicForm WHERE FormID = T.FormID );
SET IDENTITY_INSERT DynamicForm OFF;

DECLARE @DynamicFormPage	TABLE
(
[FormID]	INT,
[PageNumber]	TINYINT,
[Description]	NVARCHAR(max),
[LayoutMode]	TINYINT,
[Heading]	NVARCHAR(500),
[Help]	NVARCHAR(max),
[Parameters]	NVARCHAR(max),
PRIMARY KEY([FormID],[PageNumber])
);
INSERT INTO @DynamicFormPage([FormID],[PageNumber],[Description],[LayoutMode],[Heading],[Help],[Parameters])
SELECT 2778,1,'All of client''s enrollments display below.&nbsp; An enrollment represents a defined period of participation in a grant and/or program.&nbsp;From here, you can enroll a client in a program, exit them from an existing program or perform annual assessment updates.&nbsp; ',1,'Enrollments',NULL,NULL;
UPDATE DynamicFormPage
SET Description=T.Description,
LayoutMode=T.LayoutMode,
Heading=T.Heading,
Help=T.Help,
Parameters=T.Parameters
FROM DynamicFormPage O
INNER JOIN @DynamicFormPage T ON O.FormID = T.FormID
  AND O.PageNumber = T.PageNumber;
INSERT INTO DynamicFormPage(FormID,PageNumber,Description,LayoutMode,Heading,Help,Parameters)
SELECT FormID,PageNumber,Description,LayoutMode,Heading,Help,Parameters
FROM @DynamicFormPage T
WHERE NOT EXISTS( SELECT * FROM DynamicFormPage WHERE FormID = T.FormID
  AND PageNumber = T.PageNumber );

DECLARE @DynamicFormTables	TABLE
(
[DynamicFormTableID]	INT,
[FormID]	INT,
[TableName]	NVARCHAR(50),
[TablePrimaryKey]	NVARCHAR(100),
[TableSecondaryKey]	NVARCHAR(100),
[ReadOnly]	BIT,
[IsIdentityPK]	BIT,
[IsSecuredTable]	BIT,
[FilterActiveStatus]	BIT,
[TableAlias]	NVARCHAR(50),
[Parameters]	NVARCHAR(max),
PRIMARY KEY([DynamicFormTableID])
);
INSERT INTO @DynamicFormTables([DynamicFormTableID],[FormID],[TableName],[TablePrimaryKey],[TableSecondaryKey],[ReadOnly],[IsIdentityPK],[IsSecuredTable],[FilterActiveStatus],[TableAlias],[Parameters])
SELECT 2758,2778,'Enrollment','Enrollment.ClientID','Enrollment.EnrollID',1,1,1,1,'Enrollment',NULL;
UPDATE DynamicFormTables
SET FormID=T.FormID,
TableName=T.TableName,
TablePrimaryKey=T.TablePrimaryKey,
TableSecondaryKey=T.TableSecondaryKey,
ReadOnly=T.ReadOnly,
IsIdentityPK=T.IsIdentityPK,
IsSecuredTable=T.IsSecuredTable,
FilterActiveStatus=T.FilterActiveStatus,
TableAlias=T.TableAlias,
Parameters=T.Parameters
FROM DynamicFormTables O
INNER JOIN @DynamicFormTables T ON O.DynamicFormTableID = T.DynamicFormTableID;
SET IDENTITY_INSERT DynamicFormTables ON;
INSERT INTO DynamicFormTables(DynamicFormTableID,FormID,TableName,TablePrimaryKey,TableSecondaryKey,ReadOnly,IsIdentityPK,IsSecuredTable,FilterActiveStatus,TableAlias,Parameters)
SELECT DynamicFormTableID,FormID,TableName,TablePrimaryKey,TableSecondaryKey,ReadOnly,IsIdentityPK,IsSecuredTable,FilterActiveStatus,TableAlias,Parameters
FROM @DynamicFormTables T
WHERE NOT EXISTS( SELECT * FROM DynamicFormTables WHERE DynamicFormTableID = T.DynamicFormTableID );
SET IDENTITY_INSERT DynamicFormTables OFF;

DECLARE @DynamicFormTableJoin	TABLE
(
[TableJoinID]	INT,
[FormID]	INT,
[ParentTableName]	NVARCHAR(50),
[ParentKeyName]	NVARCHAR(100),
[ChildTableName]	NVARCHAR(50),
[ChildKeyName]	NVARCHAR(100),
[ChildTablePrimaryKey]	NVARCHAR(100),
[InnerJoin]	TINYINT,
[ReadOnly]	BIT,
[AppendWhereClause]	NVARCHAR(max),
[TableAlias]	NVARCHAR(50),
[IsSecuredTable]	BIT,
[PrimaryKeyIsString]	BIT,
[SecondaryKeyIsString]	BIT,
[IsIdentity]	BIT,
[FilterActiveStatus]	BIT,
[HasOrgID]	BIT,
[HasCreatedBy]	BIT,
[HasCreatedDate]	BIT,
[HasUpdatedBy]	BIT,
[HasUpdatedDate]	BIT,
[HasActiveStatus]	BIT,
[SaveOrder]	SMALLINT,
[Top1Order]	NVARCHAR(200),
[Parameters]	NVARCHAR(max),
PRIMARY KEY([TableJoinID])
);
INSERT INTO @DynamicFormTableJoin([TableJoinID],[FormID],[ParentTableName],[ParentKeyName],[ChildTableName],[ChildKeyName],[ChildTablePrimaryKey],[InnerJoin],[ReadOnly],[AppendWhereClause],[TableAlias],[IsSecuredTable],[PrimaryKeyIsString],[SecondaryKeyIsString],[IsIdentity],[FilterActiveStatus],[HasOrgID],[HasCreatedBy],[HasCreatedDate],[HasUpdatedBy],[HasUpdatedDate],[HasActiveStatus],[SaveOrder],[Top1Order],[Parameters])
SELECT 3491,2778,'Enrollment','Enrollment.CaseID','EnrollmentCase','EnrollmentCase.CaseID','EnrollmentCase.CaseID',1,1,NULL,'EnrollmentCase',0,0,1,1,0,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 3492,2778,'EnrollmentCase','EnrollmentCase.ProgramID','Programs','Programs.ProgramID','Programs.ProgramID',0,1,NULL,'Programs',0,0,1,1,0,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 3518,2778,'Enrollment','Enrollment.CaseID','CaseDescription','CaseDescription.CaseID','CaseDescription.CaseID',0,1,NULL,'CaseDescription',0,0,1,0,0,0,0,0,0,0,0,0,NULL,NULL
UNION ALL SELECT 3524,2778,'Enrollment','Enrollment.OrgID','osOrganization','osOrganization.OrgID','osOrganization.OrgID',0,1,NULL,'osOrganization',0,1,1,0,0,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 3572,2778,'Enrollment','Enrollment.EnrollID','AssessmentLinks','AssessmentLinks.RecordID','AssessmentLinks.UniqueID',0,1,'AND AssessmentLinks.RecordType = ''Enrollment''','AssessmentLinks',1,0,1,0,1,1,1,0,0,0,1,0,NULL,NULL
UNION ALL SELECT 8956,2778,'AssessmentLinks','AssessmentLinks.AssessmentID','Assessment','Assessment.AssessmentID','Assessment.ClientID',0,1,'AND Assessment.AssessmentDate BETWEEN Enrollment.EnrollDate AND ISNULL(Enrollment.ExitDate,''12/31/2099'')','Assessment',1,0,0,0,1,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 9528,2778,'EnrollmentCase','EnrollmentCase.ProgramID','HMISProgramGrantTypesComponents','HMISProgramGrantTypesComponents.ProgramID','HMISProgramGrantTypesComponents.ProgramID',0,1,NULL,'HMISProgramGrantTypesComponents',0,0,1,0,0,0,0,0,0,0,0,0,NULL,NULL;
UPDATE DynamicFormTableJoin
SET FormID=T.FormID,
ParentTableName=T.ParentTableName,
ParentKeyName=T.ParentKeyName,
ChildTableName=T.ChildTableName,
ChildKeyName=T.ChildKeyName,
ChildTablePrimaryKey=T.ChildTablePrimaryKey,
InnerJoin=T.InnerJoin,
ReadOnly=T.ReadOnly,
AppendWhereClause=T.AppendWhereClause,
TableAlias=T.TableAlias,
IsSecuredTable=T.IsSecuredTable,
PrimaryKeyIsString=T.PrimaryKeyIsString,
SecondaryKeyIsString=T.SecondaryKeyIsString,
IsIdentity=T.IsIdentity,
FilterActiveStatus=T.FilterActiveStatus,
HasOrgID=T.HasOrgID,
HasCreatedBy=T.HasCreatedBy,
HasCreatedDate=T.HasCreatedDate,
HasUpdatedBy=T.HasUpdatedBy,
HasUpdatedDate=T.HasUpdatedDate,
HasActiveStatus=T.HasActiveStatus,
SaveOrder=T.SaveOrder,
Top1Order=T.Top1Order,
Parameters=T.Parameters
FROM DynamicFormTableJoin O
INNER JOIN @DynamicFormTableJoin T ON O.TableJoinID = T.TableJoinID;
SET IDENTITY_INSERT DynamicFormTableJoin ON;
INSERT INTO DynamicFormTableJoin(TableJoinID,FormID,ParentTableName,ParentKeyName,ChildTableName,ChildKeyName,ChildTablePrimaryKey,InnerJoin,ReadOnly,AppendWhereClause,TableAlias,IsSecuredTable,PrimaryKeyIsString,SecondaryKeyIsString,IsIdentity,FilterActiveStatus,HasOrgID,HasCreatedBy,HasCreatedDate,HasUpdatedBy,HasUpdatedDate,HasActiveStatus,SaveOrder,Top1Order,Parameters)
SELECT TableJoinID,FormID,ParentTableName,ParentKeyName,ChildTableName,ChildKeyName,ChildTablePrimaryKey,InnerJoin,ReadOnly,AppendWhereClause,TableAlias,IsSecuredTable,PrimaryKeyIsString,SecondaryKeyIsString,IsIdentity,FilterActiveStatus,HasOrgID,HasCreatedBy,HasCreatedDate,HasUpdatedBy,HasUpdatedDate,HasActiveStatus,SaveOrder,Top1Order,Parameters
FROM @DynamicFormTableJoin T
WHERE NOT EXISTS( SELECT * FROM DynamicFormTableJoin WHERE TableJoinID = T.TableJoinID );
SET IDENTITY_INSERT DynamicFormTableJoin OFF;

DECLARE @DynamicFormTableSort	TABLE
(
[DynamicFormTableID]	INT,
[SortColumn]	NVARCHAR(100),
[IsAscending]	BIT,
[SortOrder]	TINYINT,
PRIMARY KEY([DynamicFormTableID],[SortColumn])
);
INSERT INTO @DynamicFormTableSort([DynamicFormTableID],[SortColumn],[IsAscending],[SortOrder])
SELECT 2758,'Enrollment.EnrollDate',0,1;
UPDATE DynamicFormTableSort
SET IsAscending=T.IsAscending,
SortOrder=T.SortOrder
FROM DynamicFormTableSort O
INNER JOIN @DynamicFormTableSort T ON O.DynamicFormTableID = T.DynamicFormTableID
  AND O.SortColumn = T.SortColumn;
INSERT INTO DynamicFormTableSort(DynamicFormTableID,SortColumn,IsAscending,SortOrder)
SELECT DynamicFormTableID,SortColumn,IsAscending,SortOrder
FROM @DynamicFormTableSort T
WHERE NOT EXISTS( SELECT * FROM DynamicFormTableSort WHERE DynamicFormTableID = T.DynamicFormTableID
  AND SortColumn = T.SortColumn );

DECLARE @DynamicFormListItemType	TABLE
(
[ListItemTypeID]	INT,
[TableName]	NVARCHAR(50),
[TablePrimaryKey]	NVARCHAR(100),
[TableLabel]	NVARCHAR(100),
[FilterField]	NVARCHAR(100),
[FilterFieldValue]	NVARCHAR(50),
[SecondFilterField]	NVARCHAR(100),
[SecondFilterFieldValue]	NVARCHAR(50),
[ForcePopulationQuery]	NVARCHAR(4000),
[ListItemDescription]	NVARCHAR(50),
PRIMARY KEY([ListItemTypeID])
);
DECLARE @DynamicFormElement	TABLE
(
[ElementID]	INT,
[FormID]	INT,
[FieldTypeID]	TINYINT,
[FieldOrder]	INT,
[FieldLabel]	NVARCHAR(max),
[FieldDataColumn]	NVARCHAR(100),
[FieldDataColumnOutput]	NVARCHAR(100),
[Required]	BIT,
[Visible]	BIT,
[ListItemTypeID]	INT,
[Error]	NVARCHAR(1000),
[PageNumber]	TINYINT,
[ColumnNumber]	TINYINT,
[PixelWidth]	SMALLINT,
[DefaultValue]	NVARCHAR(100),
[DisabledElement]	BIT,
[ElementParameters]	NVARCHAR(max),
[RequireAllWorkgroups]	BIT,
[OrGroup]	TINYINT,
PRIMARY KEY([ElementID])
);
INSERT INTO @DynamicFormElement([ElementID],[FormID],[FieldTypeID],[FieldOrder],[FieldLabel],[FieldDataColumn],[FieldDataColumnOutput],[Required],[Visible],[ListItemTypeID],[Error],[PageNumber],[ColumnNumber],[PixelWidth],[DefaultValue],[DisabledElement],[ElementParameters],[RequireAllWorkgroups],[OrGroup])
SELECT 44240,2778,15,50,'Hidden - CaseID','Enrollment.CaseID','Enrollment.CaseID',0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44241,2778,15,35,'Project Start Date','Enrollment.EnrollDate',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44242,2778,15,45,'Hidden - EnrollID','Enrollment.EnrollID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44243,2778,15,40,'Exit Date','Enrollment.ExitDate','',0,1,NULL,'',1,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 44245,2778,15,55,'Hidden - ProgramID','EnrollmentCase.ProgramID','',0,0,NULL,'',1,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 44246,2778,15,15,'Program','Programs.ProgramName',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44277,2778,15,60,'Enroll Assessment ID','Enrollment.EnrollAssessmentID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44278,2778,15,65,'Exit Assessment ID','Enrollment.ExitAssessmentID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44458,2778,15,25,'Enrollment<br/>Description','CaseDescription.EnrollmentDesc',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44459,2778,15,20,'Form ID','CaseDescription.FormID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44487,2778,15,70,'Organization','osOrganization.Organization',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 44831,2778,15,30,'Case<br/>Members','CaseDescription.CaseMembers',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,'Alignment=center',0,0
UNION ALL SELECT 44832,2778,15,75,'Last Assessment<br/>Completed','Assessment.AssessmentDate',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,'Aggregate=MAX&Alignment=left',0,0
UNION ALL SELECT 45015,2778,15,10,'Org ID','Enrollment.OrgID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 78097,2778,15,80,'Program Type','Programs.ProgramType',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82500,2778,15,90,'Relationship','Enrollment.Relationship',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'Ignore=1&NoSearch=1',0,0
UNION ALL SELECT 82501,2778,15,95,'Grant Type List','HMISProgramGrantTypesComponents.GrantTypeList',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82563,2778,15,100,'Componant List','HMISProgramGrantTypesComponents.ComponantList',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 44244,2778,15,5,'Case','EnrollmentCase.CaseName','',0,1,NULL,'',1,1,NULL,'',1,NULL,0,0
UNION ALL SELECT 59237,2778,15,85,'Grant ID - must exist','EnrollmentCase.GrantID',NULL,0,0,NULL,NULL,1,1,NULL,'1',1,'WhereClause=EnrollmentCase.GrantID%20IS%20NOT%20NULL',0,0;
UPDATE DynamicFormElement
SET FormID=T.FormID,
FieldTypeID=T.FieldTypeID,
FieldOrder=T.FieldOrder,
FieldLabel=T.FieldLabel,
FieldDataColumn=T.FieldDataColumn,
FieldDataColumnOutput=T.FieldDataColumnOutput,
Required=T.Required,
Visible=T.Visible,
ListItemTypeID=T.ListItemTypeID,
Error=T.Error,
PageNumber=T.PageNumber,
ColumnNumber=T.ColumnNumber,
PixelWidth=T.PixelWidth,
DefaultValue=T.DefaultValue,
DisabledElement=T.DisabledElement,
ElementParameters=T.ElementParameters,
RequireAllWorkgroups=T.RequireAllWorkgroups,
OrGroup=T.OrGroup
FROM DynamicFormElement O
INNER JOIN @DynamicFormElement T ON O.ElementID = T.ElementID;
SET IDENTITY_INSERT DynamicFormElement ON;
INSERT INTO DynamicFormElement(ElementID,FormID,FieldTypeID,FieldOrder,FieldLabel,FieldDataColumn,FieldDataColumnOutput,Required,Visible,ListItemTypeID,Error,PageNumber,ColumnNumber,PixelWidth,DefaultValue,DisabledElement,ElementParameters,RequireAllWorkgroups,OrGroup)
SELECT ElementID,FormID,FieldTypeID,FieldOrder,FieldLabel,FieldDataColumn,FieldDataColumnOutput,Required,Visible,ListItemTypeID,Error,PageNumber,ColumnNumber,PixelWidth,DefaultValue,DisabledElement,ElementParameters,RequireAllWorkgroups,OrGroup
FROM @DynamicFormElement T
WHERE NOT EXISTS( SELECT * FROM DynamicFormElement WHERE ElementID = T.ElementID );
SET IDENTITY_INSERT DynamicFormElement OFF;

DECLARE @DynamicFormButton	TABLE
(
[ButtonID]	INT,
[FormID]	INT,
[Command]	NVARCHAR(1000),
[Parameters]	NVARCHAR(4000),
[Icon]	NVARCHAR(255),
[Label]	NVARCHAR(255),
[ButtonType]	TINYINT,
[SortOrder]	TINYINT,
[IconID]	INT,
PRIMARY KEY([ButtonID])
);
INSERT INTO @DynamicFormButton([ButtonID],[FormID],[Command],[Parameters],[Icon],[Label],[ButtonType],[SortOrder],[IconID])
SELECT 180756,2778,'LINK=startworkflow.aspx?WorkflowID=1219&EditClientID=@PrimaryKey@',NULL,'navigation-queue.gif','Add New',1,1,2234
UNION ALL SELECT 183670,2778,'LINK=viewform.aspx?FormID=4172&PrimaryKey=@PrimaryKey@&SecondaryKey=@Enrollment.EnrollID@',NULL,NULL,'Use of Other Crisis Services',2,1,3418
UNION ALL SELECT 181874,2778,'LINK=startworkflow.aspx?WorkflowID=1219&EnrollID=@Enrollment.EnrollID@&EditClientID=@PrimaryKey@&CaseID=@Enrollment.CaseID@',NULL,'icon-document-nest.gif','Edit Enrollment Workflow',2,2,2493
UNION ALL SELECT 180820,2778,'PROC=Enrollment_Reenter Enrollment.EnrollID,"90"','Restricted=1','icon-document-reopen.gif','Re Enter the Enrollment',2,3,NULL
UNION ALL SELECT 182163,2778,'LINK=startworkflow.aspx?WorkflowID=1225&CaseID=@Enrollment.CaseID@',NULL,'icon-family.gif','Add Family Member',2,4,2679
UNION ALL SELECT 180757,2778,'LINK=viewform.aspx?FormID=1212&PrimaryKey=@Enrollment.CaseID@&SecondaryKey=',NULL,'icon-document-view.gif','View Case Members',2,5,2516
UNION ALL SELECT 183859,2778,'LINK=startworkflow.aspx?FormID=4294&PrimaryKey=@Enrollment.EnrollID@&SecondaryKey=&EnrollDate=@Enrollment.EnrollDate@&ExitDate=@Enrollment.ExitDate@&WorkflowID=1256&ProgramID=@EnrollmentCase.ProgramID@&EnrollID=@Enrollment.EnrollID@',NULL,NULL,'RHY_Aftercare',2,10,2630
UNION ALL SELECT 180760,2778,'LINK=startworkflow.aspx?WorkflowID=1226&EnrollID=@Enrollment.EnrollID@',NULL,'icon-history.gif','Update/Annual Assessment',2,16,2544
UNION ALL SELECT 182197,2778,'LINK=startworkflow.aspx?WorkflowID=1233&EnrollID=@Enrollment.EnrollID@',NULL,'icon-history.gif','Missed Annual/Update Assessment',2,17,2544
UNION ALL SELECT 183664,2778,'LINK=viewform.aspx?FormID=4157&PrimaryKey=@Enrollment.EnrollID@&ClientID=@Enrollment.ClientID@&RecordType=Enrolment&EnrollID=@Enrollment.EnrollID@',NULL,NULL,'Link Assessments',2,18,2184
UNION ALL SELECT 183662,2778,'LINK=viewform.aspx?FormID=4155&PrimaryKey=@Enrollment.EnrollID@&RecordType=Enrollment',NULL,NULL,'Associated Assessments',2,19,2516
UNION ALL SELECT 180755,2778,'LINK=startworkflow.aspx?WorkflowID=1260&ClientID=@ClientID@&EnrollID=@Enrollment.EnrollID@&Education=1','Restricted=1','icon-document-exit.gif','Exit the Enrollment',2,20,2225
UNION ALL SELECT 182171,2778,'LINK=assessment.aspx?AssessmentID=@Enrollment.EnrollAssessmentID@&PrimaryKey=@PrimaryKey@',NULL,'icon-document-nest.gif','Review Entry Assessments',2,26,2493
UNION ALL SELECT 182172,2778,'LINK=assessment.aspx?AssessmentID=@Enrollment.ExitAssessmentID@&PrimaryKey=@PrimaryKey@',NULL,'icon-document-nest.gif','Review Exit Assessments',2,27,2493
UNION ALL SELECT 182240,2778,'PROC=Delete_GenericActiveStatus "Enrollment","EnrollID",@Enrollment.EnrollID@,@UserID@','IsDelete=1&Restricted=1&NoConfirm=1','recycle.png','Delete Enrollment',2,99,2604;
UPDATE DynamicFormButton
SET FormID=T.FormID,
Command=T.Command,
Parameters=T.Parameters,
Icon=T.Icon,
Label=T.Label,
ButtonType=T.ButtonType,
SortOrder=T.SortOrder,
IconID=T.IconID
FROM DynamicFormButton O
INNER JOIN @DynamicFormButton T ON O.ButtonID = T.ButtonID;
SET IDENTITY_INSERT DynamicFormButton ON;
INSERT INTO DynamicFormButton(ButtonID,FormID,Command,Parameters,Icon,Label,ButtonType,SortOrder,IconID)
SELECT ButtonID,FormID,Command,Parameters,Icon,Label,ButtonType,SortOrder,IconID
FROM @DynamicFormButton T
WHERE NOT EXISTS( SELECT * FROM DynamicFormButton WHERE ButtonID = T.ButtonID );
SET IDENTITY_INSERT DynamicFormButton OFF;

DECLARE @DynamicFormCondition	TABLE
(
[ConditionID]	INT,
[ElementID]	INT,
[ButtonID]	INT,
[CompareFormula]	VARCHAR(4096),
[ImmediateEvaluation]	BIT,
[TestIfBlank]	BIT,
[SortOrder]	TINYINT,
[DisabledCondition]	BIT,
[AppliesTo]	TINYINT,
PRIMARY KEY([ConditionID])
);
INSERT INTO @DynamicFormCondition([ConditionID],[ElementID],[ButtonID],[CompareFormula],[ImmediateEvaluation],[TestIfBlank],[SortOrder],[DisabledCondition],[AppliesTo])
SELECT 14594,0,180820,'@Enrollment.ExitDate@ == ''''',1,1,1,0,3
UNION ALL SELECT 18370,0,182171,'@Enrollment.EnrollAssessmentID@ == ''''',0,0,1,0,3
UNION ALL SELECT 18371,0,182172,'@Enrollment.ExitAssessmentID@ == ''''',0,0,1,0,3
UNION ALL SELECT 19547,0,181874,'@Enrollment.ExitDate@ == ''''',1,1,1,0,3
UNION ALL SELECT 19548,0,180760,'@Enrollment.ExitDate@ == ''''',1,1,1,0,3
UNION ALL SELECT 19549,0,182197,'@Enrollment.ExitDate@ != ''''',1,1,1,0,3
UNION ALL SELECT 21737,0,183670,'(((@Programs.ProgramType@ == ''12'') || (@Programs.ProgramType@ == ''13'')) && @Age@ >=18)',1,1,1,0,3
UNION ALL SELECT 22957,0,183859,'(("@Age@" >= "18" || "@Enrollment.Relationship@" == "SL") && 
  ("@HMISProgramGrantTypesComponents.GrantTypeList@".indexOf("HRY") >= 0) && 
  (!"@HMISProgramGrantTypesComponents.ComponantList@".indexOf("ESO")>=0) && 
  ("@Programs.ProgramType@" == "1" || "@Programs.ProgramType@" == "2" || "@Programs.ProgramType@" == "12"))',1,1,1,0,3;
UPDATE DynamicFormCondition
SET ElementID=T.ElementID,
ButtonID=T.ButtonID,
CompareFormula=T.CompareFormula,
ImmediateEvaluation=T.ImmediateEvaluation,
TestIfBlank=T.TestIfBlank,
SortOrder=T.SortOrder,
DisabledCondition=T.DisabledCondition,
AppliesTo=T.AppliesTo
FROM DynamicFormCondition O
INNER JOIN @DynamicFormCondition T ON O.ConditionID = T.ConditionID;
SET IDENTITY_INSERT DynamicFormCondition ON;
INSERT INTO DynamicFormCondition(ConditionID,ElementID,ButtonID,CompareFormula,ImmediateEvaluation,TestIfBlank,SortOrder,DisabledCondition,AppliesTo)
SELECT ConditionID,ElementID,ButtonID,CompareFormula,ImmediateEvaluation,TestIfBlank,SortOrder,DisabledCondition,AppliesTo
FROM @DynamicFormCondition T
WHERE NOT EXISTS( SELECT * FROM DynamicFormCondition WHERE ConditionID = T.ConditionID );
SET IDENTITY_INSERT DynamicFormCondition OFF;

DECLARE @DynamicFormAction	TABLE
(
[ConditionID]	INT,
[ActionID]	INT,
[TargetElementID]	INT,
[TargetButtonID]	INT,
[TargetParameter]	NVARCHAR(1000),
[IfTrueAction]	BIT,
[SortOrder]	INT,
PRIMARY KEY([ActionID])
);
INSERT INTO @DynamicFormAction([ConditionID],[ActionID],[TargetElementID],[TargetButtonID],[TargetParameter],[IfTrueAction],[SortOrder])
SELECT 14594,41548,0,180820,'visible=false,',1,0
UNION ALL SELECT 18370,48326,0,182171,'visible=false',1,0
UNION ALL SELECT 18371,48327,0,182172,'visible=false',1,0
UNION ALL SELECT 19547,49597,0,181874,'visible=true',1,0
UNION ALL SELECT 19547,49598,0,181874,'visible=false',0,1
UNION ALL SELECT 19548,49599,0,180760,'visible=true',1,0
UNION ALL SELECT 19548,49600,0,180760,'visible=false',0,1
UNION ALL SELECT 19549,49601,0,182197,'visible=true',1,0
UNION ALL SELECT 19549,49602,0,182197,'visible=false',0,1
UNION ALL SELECT 21737,54125,0,183670,'visible=true',1,0
UNION ALL SELECT 21737,54126,0,183670,'visible=false',0,1
UNION ALL SELECT 22957,56753,0,183859,'visible=true',1,0
UNION ALL SELECT 22957,56754,0,183859,'visible=false',0,1;
UPDATE DynamicFormAction
SET ConditionID=T.ConditionID,
TargetElementID=T.TargetElementID,
TargetButtonID=T.TargetButtonID,
TargetParameter=T.TargetParameter,
IfTrueAction=T.IfTrueAction,
SortOrder=T.SortOrder
FROM DynamicFormAction O
INNER JOIN @DynamicFormAction T ON O.ActionID = T.ActionID;
SET IDENTITY_INSERT DynamicFormAction ON;
INSERT INTO DynamicFormAction(ConditionID,ActionID,TargetElementID,TargetButtonID,TargetParameter,IfTrueAction,SortOrder)
SELECT ConditionID,ActionID,TargetElementID,TargetButtonID,TargetParameter,IfTrueAction,SortOrder
FROM @DynamicFormAction T
WHERE NOT EXISTS( SELECT * FROM DynamicFormAction WHERE ActionID = T.ActionID );
SET IDENTITY_INSERT DynamicFormAction OFF;

DECLARE @DynamicFormSearchMapping	TABLE
(
[MappingID]	INT,
[ElementID]	INT,
[FormID]	INT,
[SearchColumn]	NVARCHAR(50),
[ResultColumn]	NVARCHAR(100),
[PassParam]	NVARCHAR(4000),
[AutoPopup]	BIT,
PRIMARY KEY([MappingID])
);
DECLARE @DynamicFormGroup	TABLE
(
[GroupID]	INT,
[FormID]	INT,
[GroupBy]	NVARCHAR(max),
[Format]	NVARCHAR(100),
[DisplayText]	NVARCHAR(max),
[SortAscending]	BIT,
[SortOrder]	TINYINT,
[Expansion]	TINYINT,
PRIMARY KEY([GroupID])
);
INSERT INTO @DynamicFormGroup([GroupID],[FormID],[GroupBy],[Format],[DisplayText],[SortAscending],[SortOrder],[Expansion])
SELECT 25,2778,'CASE WHEN ISNULL(Enrollment.ExitDate,''12/31/2099'') > GETDATE() THEN ''Current'' ELSE ''Previous'' END',NULL,NULL,1,2,1;
UPDATE DynamicFormGroup
SET FormID=T.FormID,
GroupBy=T.GroupBy,
Format=T.Format,
DisplayText=T.DisplayText,
SortAscending=T.SortAscending,
SortOrder=T.SortOrder,
Expansion=T.Expansion
FROM DynamicFormGroup O
INNER JOIN @DynamicFormGroup T ON O.GroupID = T.GroupID;
SET IDENTITY_INSERT DynamicFormGroup ON;
INSERT INTO DynamicFormGroup(GroupID,FormID,GroupBy,Format,DisplayText,SortAscending,SortOrder,Expansion)
SELECT GroupID,FormID,GroupBy,Format,DisplayText,SortAscending,SortOrder,Expansion
FROM @DynamicFormGroup T
WHERE NOT EXISTS( SELECT * FROM DynamicFormGroup WHERE GroupID = T.GroupID );
SET IDENTITY_INSERT DynamicFormGroup OFF;

DECLARE @DynamicFormEdge	TABLE
(
[FormID]	INT,
[EdgeID]	INT,
[WhenColumn]	NVARCHAR(50),
[WhenColumnValue]	NVARCHAR(50),
[GoToURL]	NVARCHAR(1000),
PRIMARY KEY([FormID],[EdgeID])
);
DECLARE @Report	TABLE
(
[ReportID]	INT,
[ReportDescription]	NVARCHAR(100),
[ReportFileName]	NVARCHAR(100),
[FormID]	INT,
[RunFormID]	INT,
[ReportType]	TINYINT,
PRIMARY KEY([ReportID])
);
DECLARE @ReportParameters	TABLE
(
[ParamterID]	INT,
[ParameterName]	NVARCHAR(50),
[ElementID]	INT,
[FormID]	INT,
PRIMARY KEY([ParamterID])
);
DELETE ReportParameters FROM ReportParameters O WHERE NOT EXISTS(SELECT * FROM @ReportParameters WHERE ParamterID = O.ParamterID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE Report FROM Report O WHERE NOT EXISTS(SELECT * FROM @Report WHERE ReportID = O.ReportID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormEdge FROM DynamicFormEdge O WHERE NOT EXISTS(SELECT * FROM @DynamicFormEdge WHERE FormID = O.FormID
  AND EdgeID = O.EdgeID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormGroup FROM DynamicFormGroup O WHERE NOT EXISTS(SELECT * FROM @DynamicFormGroup WHERE GroupID = O.GroupID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormSearchMapping FROM DynamicFormSearchMapping O WHERE NOT EXISTS(SELECT * FROM @DynamicFormSearchMapping WHERE MappingID = O.MappingID)
  AND EXISTS(SELECT * FROM @DynamicFormElement WHERE ElementID = O.ElementID);
DELETE DynamicFormAction FROM DynamicFormAction O WHERE NOT EXISTS(SELECT * FROM @DynamicFormAction WHERE ActionID = O.ActionID)
  AND EXISTS(SELECT * FROM @DynamicFormCondition WHERE ConditionID = O.ConditionID);
DELETE DynamicFormCondition FROM DynamicFormCondition O WHERE NOT EXISTS(SELECT * FROM @DynamicFormCondition WHERE ConditionID = O.ConditionID)
  AND (ElementID IN (SELECT ElementID FROM @DynamicFormElement) OR ButtonID IN (SELECT ButtonID FROM @DynamicFormButton));
DELETE DynamicFormButton FROM DynamicFormButton O WHERE NOT EXISTS(SELECT * FROM @DynamicFormButton WHERE ButtonID = O.ButtonID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormElement FROM DynamicFormElement O WHERE NOT EXISTS(SELECT * FROM @DynamicFormElement WHERE ElementID = O.ElementID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormTableSort FROM DynamicFormTableSort O WHERE NOT EXISTS(SELECT * FROM @DynamicFormTableSort WHERE DynamicFormTableID = O.DynamicFormTableID
  AND SortColumn = O.SortColumn)
  AND EXISTS(SELECT * FROM @DynamicFormTables WHERE DynamicFormTableID = O.DynamicFormTableID);
DELETE DynamicFormTableJoin FROM DynamicFormTableJoin O WHERE NOT EXISTS(SELECT * FROM @DynamicFormTableJoin WHERE TableJoinID = O.TableJoinID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormTables FROM DynamicFormTables O WHERE NOT EXISTS(SELECT * FROM @DynamicFormTables WHERE DynamicFormTableID = O.DynamicFormTableID)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);
DELETE DynamicFormPage FROM DynamicFormPage O WHERE NOT EXISTS(SELECT * FROM @DynamicFormPage WHERE FormID = O.FormID
  AND PageNumber = O.PageNumber)
  AND EXISTS(SELECT * FROM @DynamicForm WHERE FormID = O.FormID);

ALTER TABLE DynamicFormElement WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormAction WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormGroup WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormEdge WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Report WITH CHECK CHECK CONSTRAINT ALL;
DELETE FROM HashTagLink WHERE LinkTable='DynamicForm' AND LinkColumn='FormID' AND LinkID=2778;
