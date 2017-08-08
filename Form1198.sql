USE [_CTN_Dev]
GO

PRINT 'Form 1198';
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
SELECT 1198,'Enrollments',2,NULL,NULL,1,NULL,NULL,0,'EnrollmentCase.CaseName',1,NULL,NULL,'MobileResults=main%3D@EnrollmentCase.CaseName@%26right%3D@Enrollment.EnrollDate@%26bottomleft%3D@CaseDescription.EnrollmentDesc@%26bottomright%3D@CaseDescription.CaseMembers@&RowHeader=@EnrollmentCase.CaseName',NULL;
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
SELECT 1198,1,'All of client''s enrollments display below with current enrollments listed at the top and previous enrollments listed below.&nbsp; To add a universal enrollment for the client select <strong>Add New Enrollment</strong>.&nbsp; Note that exiting or reentering an enrollment will not affect the other members of the case, but deleting a case<em> <strong>will delete the enrollment for all case members</strong></em>.',1,'Enrollments',NULL,NULL;
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
SELECT 297,1198,'Enrollment','Enrollment.ClientID','Enrollment.EnrollID',1,1,1,1,'Enrollment',NULL;
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
SELECT 667,1198,'Enrollment','Enrollment.CaseID','EnrollmentCase','EnrollmentCase.CaseID','EnrollmentCase.CaseID',1,1,NULL,'EnrollmentCase',0,0,1,1,1,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 668,1198,'Enrollment','Enrollment.CaseID','CaseDescription','CaseDescription.CaseID','CaseDescription.CaseID',0,1,NULL,'CaseDescription',0,0,1,0,0,0,0,0,0,0,0,0,NULL,NULL
UNION ALL SELECT 3205,1198,'EnrollmentCase','EnrollmentCase.ProgramID','Programs','Programs.ProgramID','Programs.ProgramID',0,1,'AND ( Programs.ProgramType IS NULL OR Programs.ProgramType < 100  OR Programs.ProgramType > 200 )','Programs',0,0,1,1,0,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 9418,1198,'EnrollmentCase','EnrollmentCase.ProgramID','HMISProgramGrantTypesComponents','HMISProgramGrantTypesComponents.ProgramID','HMISProgramGrantTypesComponents.ProgramID',0,1,NULL,'HMISProgramGrantTypesComponents',0,0,1,0,0,0,0,0,0,0,0,0,NULL,NULL;
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
SELECT 297,'Enrollment.EnrollDate',0,1;
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
SELECT 4980,1198,15,25,'Case Name','EnrollmentCase.CaseName',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 4981,1198,15,50,'CaseID','Enrollment.CaseID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 4983,1198,15,40,'Enroll Date','Enrollment.EnrollDate','DATEONLY',0,1,NULL,'',1,1,NULL,'',0,'Format=MM/dd/yyyy&',0,0
UNION ALL SELECT 4985,1198,15,30,'Enrollment','CaseDescription.EnrollmentDesc','',0,1,NULL,'',1,1,NULL,'',0,'',0,0
UNION ALL SELECT 4986,1198,15,5,'EnrollID','Enrollment.EnrollID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 13406,1198,15,65,'Hidden - ProgramID','EnrollmentCase.ProgramID','',0,0,NULL,'',1,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 13673,1198,15,45,'Exit Date','Enrollment.ExitDate','DATEONLY',0,1,NULL,NULL,1,1,NULL,NULL,0,'Format=MM/dd/yyyy',0,0
UNION ALL SELECT 15614,1198,15,70,'Hidden - OrgID','Enrollment.OrgID','',0,0,NULL,'',1,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 19146,1198,15,35,'Members','CaseDescription.CaseMembers',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,'Alignment=center',0,0
UNION ALL SELECT 21762,1198,15,75,'CaseDescription.FormID','CaseDescription.FormID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 30376,1198,15,55,'EntryAssessID','Enrollment.EnrollAssessmentID','',0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 36692,1198,15,15,'CaseDescription.CaseID','CaseDescription.CaseID','',0,0,NULL,NULL,1,1,NULL,NULL,0,'',0,0
UNION ALL SELECT 40158,1198,15,20,'Family AcctID','EnrollmentCase.FamilyAcctID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 40859,1198,15,60,'Exit Assessment ID','Enrollment.ExitAssessmentID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 42625,1198,15,10,'Clnt Case ID','Enrollment.ClntCaseID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81546,1198,15,80,'Component List','HMISProgramGrantTypesComponents.ComponantList',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 81548,1198,15,85,'Grant Type List','HMISProgramGrantTypesComponents.GrantTypeList',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 81558,1198,16,105,'RHY','RHYProject',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1&SqlExpression=CASE%20WHEN%20%28Enrollment.EnrollDate%20IS%20NOT%20NULL%20AND%20HMISProgramGrantTypesComponents.GrantTypeList%20LIKE%20%27%25HRY%25%27%20AND%20HMISProgramGrantTypesComponents.ComponantList%20NOT%20LIKE%20%27%25SOP%25%27%20AND%20%28@Age@%20%3E%3D18%20OR%20Enrollment.Relationship%20%3D%20%27SL%27%29%29%20THEN%201%20ELSE%200%20END%0A',0,0
UNION ALL SELECT 81561,1198,15,90,'Relationship','Enrollment.Relationship',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 4984,1198,15,95,'Hidden - GrantID','EnrollmentCase.GrantID','',0,1,NULL,'',1,1,NULL,'',1,NULL,0,0
UNION ALL SELECT 52310,1198,24,100,'Notes','AttachCaseNote',NULL,0,1,NULL,'DataSystems.Plugins.AttachCaseNote',1,1,NULL,NULL,1,'NoSearch=1&EntityColumn=ClientID&EntityID=@PrimaryKey&EntityTable=cmClient&LinkColumn=EnrollID&LinkID=@Enrollment.EnrollID&LinkTable=Enrollment&HelpText=Click%20the%20paper-clip%20icon%20to%20view%20the%20case%20notes%20attached%20to%20that%20enrollment.&Alignment=center&TemplateID=3',0,0;
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
SELECT 197,1198,'LINK=viewform.aspx?FormID=1200',NULL,'navigation-addnew.gif','Add New Enrollment',1,1,2450
UNION ALL SELECT 198,1198,'LINK=viewform.aspx?FormID=@CaseDescription.FormID@&SecondaryKey=@Enrollment.EnrollID@',NULL,'icon-document-edit.gif','Edit Enrollment',2,5,2643
UNION ALL SELECT 1138,1198,'LINK=viewform.aspx?FormID=1110&PrimaryKey=@Enrollment.CaseID@','','icon-document-nest.gif','Case Members',2,10,2493
UNION ALL SELECT 183812,1198,'LINK=startworkflow.aspx?FormID=4294&PrimaryKey=@Enrollment.EnrollID@&SecondaryKey=&EnrollDate=@Enrollment.EnrollDate@&ExitDate=@Enrollment.ExitDate@&WorkflowID=1256',NULL,NULL,'RHY Aftercare',2,10,2630
UNION ALL SELECT 1380,1198,'LINK=viewform.aspx?FormID=140&EnrollID=@Enrollment.EnrollID@&FULLSEARCH=True',NULL,'icon-document-nest.gif','Goals',2,15,2629
UNION ALL SELECT 609,1198,'LINK=viewform.aspx?FormID=1161&EnrollID=@Enrollment.EnrollID@&FULLSEARCH=True','','icon-document-nest.gif','Action Plan',2,20,2493
UNION ALL SELECT 613,1198,'LINK=viewform.aspx?FormID=1194&EnrollID=@Enrollment.EnrollID@&FULLSEARCH=True',NULL,'icon-document-nest.gif','Services',2,25,3485
UNION ALL SELECT 180507,1198,'LINK=assessment.aspx?AssessmentID=@Enrollment.EnrollAssessmentID@&PrimaryKey=@PrimaryKey@',NULL,'icon-document-nest.gif','Review Entry Assessments',2,26,2493
UNION ALL SELECT 180508,1198,'LINK=assessment.aspx?AssessmentID=@Enrollment.ExitAssessmentID@&PrimaryKey=@PrimaryKey@',NULL,'icon-document-nest.gif','Review Exit Assessments',2,27,2493
UNION ALL SELECT 1031,1198,'LINK=viewform.aspx?FormID=1025&SecondaryKey=@Enrollment.EnrollID@&CurrentPage=all','Restricted=1','icon-document-exit.gif','Exit the Enrollment',2,30,2225
UNION ALL SELECT 1145,1198,'PROC=Enrollment_Reenter Enrollment.EnrollID,"90"',NULL,'icon-document-reopen.gif','Reenter',2,35,NULL
UNION ALL SELECT 182016,1198,'LINK=startworkflow.aspx?WorkflowID=1205&EnrollID=@Enrollment.EnrollID@',NULL,'icon-document-exit.gif','Exit Workflow',2,35,2225
UNION ALL SELECT 180038,1198,'PROC=Delete_GenericActiveStatusTwoTables "Enrollment","EnrollID",@Enrollment.EnrollID@,"cmCaseAssign","ClntCaseID",@Enrollment.ClntCaseID@,@UserID@','Restricted=1&IsDelete=1&Restore=Restore_GenericActiveStatusTwoTables%20%22Enrollment%22%2C%22EnrolliD%22%2C@Enrollment.EnrollID@%2C%22cmCaseAssign%22%2C%22ClntCaseID%22%2C@Enrollment.ClntCaseID@%2C@UserID@','recycle.png','Delete Enrollment',2,39,2604;
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
SELECT 1756,0,1145,'@Enrollment.ExitDate@ != ""',1,1,1,0,3
UNION ALL SELECT 13734,0,180507,'@Enrollment.EnrollAssessmentID@ == ''''',1,1,1,0,3
UNION ALL SELECT 13735,0,180508,'@Enrollment.ExitAssessmentID@ == ''''',1,1,1,0,3
UNION ALL SELECT 15637,4986,0,'@Enrollment.EnrollDate@ < @Date@',1,1,1,1,3
UNION ALL SELECT 22617,0,183812,'(@Enrollment.ExitDate@ != '''' && @RHYProject@ == 1)',1,1,1,0,3;
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
SELECT 1756,2146,0,1145,'Visible=false,',0,0
UNION ALL SELECT 13734,40264,0,180507,'visible=false,',1,0
UNION ALL SELECT 13735,40265,0,180508,'visible=false,',1,0
UNION ALL SELECT 22617,56077,0,183812,'visible=true',1,0
UNION ALL SELECT 22617,56078,0,183812,'visible=false',0,1;
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
SELECT 20,1198,'CASE WHEN ISNULL(Enrollment.ExitDate,''12/31/2099'') > GETDATE() THEN ''Current'' ELSE ''Previous'' END',NULL,NULL,1,2,1;
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

ALTER TABLE DynamicFormElement CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormAction CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormGroup CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormEdge CHECK CONSTRAINT ALL;
ALTER TABLE Report CHECK CONSTRAINT ALL;
DELETE FROM HashTagLink WHERE LinkTable='DynamicForm' AND LinkColumn='FormID' AND LinkID=1198;
