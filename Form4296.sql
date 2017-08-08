USE [QA15]
GO

PRINT 'Form 4296';
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
SELECT 4296,'RHY Aftercare Assessments',2,NULL,NULL,0,NULL,NULL,0,NULL,1,NULL,NULL,NULL,NULL;
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
SELECT 4296,1,'RHY Aftercare Assessments',1,'RHY Aftercare Assessments',NULL,NULL;
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
SELECT 4278,4296,'RHYAftercareAssessment','RHYAftercareAssessment.ClientID','RHYAftercareAssessment.RHYAftercareAssessmentID',1,1,1,1,'RHYAftercareAssessment',NULL;
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
SELECT 9413,4296,'RHYAftercareAssessment','RHYAftercareAssessment.RHYAftercareAssessmentID','RHYAftercareMethod','RHYAftercareMethod.RHYAftercareAssessmentID','RHYAftercareMethod.RHYAftercareMethodID',0,1,NULL,'RHYAftercareMethod',0,0,0,1,0,0,0,0,0,0,0,0,NULL,NULL
UNION ALL SELECT 9420,4296,'RHYAftercareAssessment','RHYAftercareAssessment.AftercareProvided','cmComboBoxItem','AftercareProvidedVal.Item','AftercareProvidedVal.dsiSerNo',0,1,' AND AftercareProvidedVal.Combobox=''YesNo'' AND AftercareProvidedVal.ComboboxGrp=''HMIS''','AftercareProvidedVal',0,1,0,1,1,0,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 9421,4296,'RHYAftercareAssessment','RHYAftercareAssessment.EnrollID','Enrollment','Enrollment.EnrollID','Enrollment.EnrollID',0,1,NULL,'Enrollment',1,0,1,1,1,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 9422,4296,'Enrollment','Enrollment.CaseID','EnrollmentCase','EnrollmentCase.CaseID','EnrollmentCase.CaseID',0,1,NULL,'EnrollmentCase',1,0,1,1,1,1,1,1,1,1,1,0,NULL,NULL
UNION ALL SELECT 9423,4296,'EnrollmentCase','EnrollmentCase.ProgramID','Programs','Programs.ProgramID','Programs.ProgramID',0,1,NULL,'Programs',0,0,1,1,1,1,1,1,1,1,1,0,NULL,NULL;
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
INSERT INTO @DynamicFormListItemType([ListItemTypeID],[TableName],[TablePrimaryKey],[TableLabel],[FilterField],[FilterFieldValue],[SecondFilterField],[SecondFilterFieldValue],[ForcePopulationQuery],[ListItemDescription])
SELECT 3450,'cmComboBoxItem','Item','ItemDesc','Combobox','RHYAftercareMethod','ComboboxGrp','HMIS2017',NULL,'RHY Aftercare Method';
UPDATE DynamicFormListItemType
SET TableName=T.TableName,
TablePrimaryKey=T.TablePrimaryKey,
TableLabel=T.TableLabel,
FilterField=T.FilterField,
FilterFieldValue=T.FilterFieldValue,
SecondFilterField=T.SecondFilterField,
SecondFilterFieldValue=T.SecondFilterFieldValue,
ForcePopulationQuery=T.ForcePopulationQuery,
ListItemDescription=T.ListItemDescription
FROM DynamicFormListItemType O
INNER JOIN @DynamicFormListItemType T ON O.ListItemTypeID = T.ListItemTypeID;
SET IDENTITY_INSERT DynamicFormListItemType ON;
INSERT INTO DynamicFormListItemType(ListItemTypeID,TableName,TablePrimaryKey,TableLabel,FilterField,FilterFieldValue,SecondFilterField,SecondFilterFieldValue,ForcePopulationQuery,ListItemDescription)
SELECT ListItemTypeID,TableName,TablePrimaryKey,TableLabel,FilterField,FilterFieldValue,SecondFilterField,SecondFilterFieldValue,ForcePopulationQuery,ListItemDescription
FROM @DynamicFormListItemType T
WHERE NOT EXISTS( SELECT * FROM DynamicFormListItemType WHERE ListItemTypeID = T.ListItemTypeID );
SET IDENTITY_INSERT DynamicFormListItemType OFF;

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
SELECT 81538,4296,15,20,'Aftercare was Provided','AftercareProvidedVal.ItemDesc',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 81539,4296,15,30,'Information Date','RHYAftercareAssessment.AssessmentDate',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 81540,4296,15,5,'Enroll ID','RHYAftercareAssessment.EnrollID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81541,4296,15,40,'RHY Aftercare Assessment ID','RHYAftercareAssessment.RHYAftercareAssessmentID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 81543,4296,15,50,'Aftercare Method(s)','RHYAftercareMethod.AftercareMethod',NULL,0,1,3450,NULL,1,1,NULL,NULL,0,'MultiSelectList=1&NoSearch=1&Ignore=1&Aggregate=dbo.List',0,0
UNION ALL SELECT 81559,4296,15,10,'Case Name','EnrollmentCase.CaseName',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81560,4296,15,15,'Enrollment','Programs.ProgramName',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81609,4296,15,25,'Project Exit Date','Enrollment.ExitDate',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81610,4296,16,35,'DateDiff','DateDiff',NULL,0,0,NULL,'DataSystems.Plugins.Formula',1,1,NULL,NULL,0,'Formula=DateDiff%28%27d%27%2C@AftercareAssessment.AssessmentDate@%2C@Enrollment.ExitDate@%29&NoSearch=1&SqlExpression=datediff%28day%2CEnrollment.ExitDate%2CRHYAftercareAssessment.AssessmentDate%29',0,0
UNION ALL SELECT 81611,4296,24,55,'@ExitDateProblem@','RenderHTML',NULL,0,1,NULL,'DataSystems.Plugins.RenderHTML',1,1,NULL,NULL,0,'Content=%3Cscript%3E%20%0A%09%28%28@DateDiff@%3E%3D180%29%3Fdocument.write%28%22%3Cspan%20style%3D%27color%3Ared%27%3EThis%20will%20not%20be%20reported%20due%20to%20information%20date%20being%20greater%20than%20180%20days%20after%20exit%20date.%3C/span%3E%22%29%3A%22%22%29%3B%0A%09%28%28@DateDiff@%3C0%29%3Fdocument.write%28%22%3Cspan%20style%3D%27color%3Ared%27%3EThis%20will%20not%20be%20reported%20due%20to%20information%20date%20being%20prior%20to%20exit%20date.%3C/span%3E%22%29%3A%22%22%29%3B%20%09%0A%3C/script%3E%0A&NoSearch=1',0,0
UNION ALL SELECT 81542,4296,15,45,'Item Desc','AftercareMethod.ItemDesc',NULL,0,1,NULL,NULL,1,1,NULL,NULL,1,'MultiSelectList=1&NoSearch=1',0,0;
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
SELECT 183814,4296,'LINK=viewform.aspx?FormID=4294&PrimaryKey=@RHYAftercareAssessment.EnrollID@&SecondaryKey=@RHYAftercareAssessment.RHYAftercareAssessmentID@&ExitDate=@Enrollment.ExitDate@',NULL,NULL,'Edit/View',2,1,2643
UNION ALL SELECT 183825,4296,'PROC=Delete_GenericActiveStatus "RHYAftercareAssessment","RHYAftercareAssessmentID",@RHYAftercareAssessment.RHYAftercareAssessmentID@,@UserID@','IsDelete=1&NoSave=1&NoConfirm=1&Restricted=1',NULL,'Delete',2,99,2604;
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
DECLARE @cmComboboxItem	TABLE
(
[ComboboxGrp]	NVARCHAR(20),
[Combobox]	NVARCHAR(25),
[Item]	NVARCHAR(50),
[ItemDesc]	NVARCHAR(255),
[DisplayOrder]	SMALLINT,
[ReadOnly]	NVARCHAR(1),
[SubGroup]	NVARCHAR(10),
[ActiveStatus]	NVARCHAR(1),
[HelpText]	NVARCHAR(max),
PRIMARY KEY([ComboboxGrp],[Combobox],[Item])
);
INSERT INTO @cmComboboxItem([ComboboxGrp],[Combobox],[Item],[ItemDesc],[DisplayOrder],[ReadOnly],[SubGroup],[ActiveStatus],[HelpText])
SELECT 'HMIS2017','RHYAftercareMethod','1','Via email/social media',1,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','RHYAftercareMethod','2','Via telephone',2,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','RHYAftercareMethod','3','In person: one-on-one',3,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','RHYAftercareMethod','4','In person: group',4,NULL,NULL,'A','';
INSERT INTO cmComboboxItem(ComboboxGrp,Combobox,Item,ItemDesc,DisplayOrder,ReadOnly,SubGroup,ActiveStatus,HelpText,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate)
SELECT ComboboxGrp,Combobox,Item,ItemDesc,DisplayOrder,ReadOnly,SubGroup,ActiveStatus,HelpText,'DSI',GETDATE(),'DSI',GETDATE()
FROM @cmComboboxItem T
WHERE NOT EXISTS( SELECT *
	FROM cmComboboxItem
	WHERE Combobox = T.Combobox
	  AND ComboboxGrp = T.ComboboxGrp );
DELETE FROM HashTagLink WHERE LinkTable='DynamicForm' AND LinkColumn='FormID' AND LinkID=4296;
