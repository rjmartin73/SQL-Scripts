USE [QA15]
GO

PRINT 'Form 4294';
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
SELECT 4294,'RHY Aftercare Assessment',1,NULL,NULL,0,NULL,NULL,0,NULL,1,NULL,NULL,'EditableIf=@CanEditOrg@&nopause=1',NULL;
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
SELECT 4294,1,'Collected at Post-Exit stage for all RHY funded projects with the exception of the street outreach component (SOP).<br />
<br />
This must be dated within 180 days after the project exit date.',1,'RHY Aftercare Assessment',NULL,NULL;
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
SELECT 4276,4294,'RHYAftercareAssessment','RHYAftercareAssessment.EnrollID','RHYAftercareAssessment.RHYAftercareAssessmentID',0,1,1,0,'RHYAftercareAssessment',NULL;
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
SELECT 2040,'cmComboBoxItem','Item','ItemDesc','Combobox','YesNo','ComboboxGrp','HMIS',NULL,'Yes, No, Don''t Know, Refused'
UNION ALL SELECT 3450,'cmComboBoxItem','Item','ItemDesc','Combobox','RHYAftercareMethod','ComboboxGrp','HMIS2017',NULL,'RHY Aftercare Method';
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
SELECT 81524,4294,24,45,'Restriction','RHYAftercareAssessment.RestrictOrg','RHYAftercareAssessment.RestrictOrg',1,1,NULL,'DataSystems.Plugins.RestrictOrg',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81526,4294,3,20,'Information Date<br /> (Date information was collected)','RHYAftercareAssessment.AssessmentDate','RHYAftercareAssessment.AssessmentDate',1,1,NULL,NULL,1,1,NULL,'@Date',0,NULL,0,0
UNION ALL SELECT 81527,4294,24,15,'Assessment','RHYAftercareAssessment.AssessmentID','RHYAftercareAssessment.AssessmentID',0,1,NULL,'DataSystems.Plugins.Assessment',1,1,NULL,NULL,0,'AllowChange=1',0,0
UNION ALL SELECT 81528,4294,8,25,'Aftercare Provided','RHYAftercareAssessment.AftercareProvided','RHYAftercareAssessment.AftercareProvided',0,1,2040,NULL,1,1,NULL,NULL,0,'HiddenValues=8%2C99',0,0
UNION ALL SELECT 81529,4294,24,30,'Identify the primary way(s) it was provided','MultiSaveList',NULL,0,1,3450,'DataSystems.Plugins.MultiSaveList',1,1,NULL,NULL,0,'ChildColumn=AftercareMethod&ParentColumn=RHYAftercareAssessmentID&ParentValue=@SecondaryKey@&TableName=RHYAftercareMethod',0,0
UNION ALL SELECT 81537,4294,1,10,'Client ID','RHYAftercareAssessment.ClientID','RHYAftercareAssessment.ClientID',1,0,NULL,NULL,1,1,NULL,'@ClientID@',0,NULL,0,0
UNION ALL SELECT 81562,4294,24,35,'Immediate Validation Plugin','ImmediateValidationPlugin',NULL,0,1,NULL,'DataSystems.Plugins.ImmediateValidationPlugin',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 81563,4294,24,40,'Exit_Date','Exit_Date',NULL,0,0,NULL,'DataSystems.Plugins.Formula',1,1,NULL,'@ExitDate@',0,'Disabled=1&Content=%3Cscript%3E%0Avar%20d%20%3D%20new%20Date%28%22@ExitDate@%22%29%3B%0AbyID%28@id@%29.value%20%3D%20d%3B%0A%3C/script%3E&Formula=%28DateAdd%28%27d%27%2C179%2C@ExitDate@%29%29',0,0;
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
SELECT 22614,81528,0,'@RHYAftercareAssessment.AftercareProvided@ == ''1''',1,1,1,0,3
UNION ALL SELECT 22622,81526,0,'@RHYAftercareAssessment.AssessmentDate@ < @ExitDate@',1,1,1,0,3
UNION ALL SELECT 22623,81526,0,'@RHYAftercareAssessment.AssessmentDate@ > DateAdd(''d'',180,@ExitDate@)',1,1,1,0,3;
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
SELECT 22614,56071,81529,0,'visible=true',1,0
UNION ALL SELECT 22614,56072,81529,0,'visible=false,value=**BLANK**',0,1
UNION ALL SELECT 22622,56083,81526,0,'error=An%20%3Cem%3Einformation%20date%3C/em%3E%20prior%20to%20the%20project%20exit%20date%20%20will%20%3Cstrong%3E%3Cu%3Enot%3C/u%3E%3C/strong%3E%20be%20considered%20in%20reporting%20or%20exports.,warn=true',1,0
UNION ALL SELECT 22623,56084,81526,0,'error=An%20%3Cem%3EInformation%20date%3C/em%3E%20greater%20than%20%3Cem%3E@Exit_Date@%3C/em%3E%20or%20180%20days%20from%20exit%20date%2C%20will%20%3Cu%3E%3Cstrong%3Enot%3C/strong%3E%3C/u%3E%20be%20considered%20in%20reporting%20or%20exports.,warn=true',1,0;
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
INSERT INTO @DynamicFormSearchMapping([MappingID],[ElementID],[FormID],[SearchColumn],[ResultColumn],[PassParam],[AutoPopup])
SELECT 8272,81527,1103,'AssessmentID','RHYAftercareAssessment.AssessmentID','',0
UNION ALL SELECT 8273,81527,1103,'AssessmentDate','RHYAftercareAssessment.AssessmentDate',NULL,0;
UPDATE DynamicFormSearchMapping
SET ElementID=T.ElementID,
FormID=T.FormID,
SearchColumn=T.SearchColumn,
ResultColumn=T.ResultColumn,
PassParam=T.PassParam,
AutoPopup=T.AutoPopup
FROM DynamicFormSearchMapping O
INNER JOIN @DynamicFormSearchMapping T ON O.MappingID = T.MappingID;
SET IDENTITY_INSERT DynamicFormSearchMapping ON;
INSERT INTO DynamicFormSearchMapping(MappingID,ElementID,FormID,SearchColumn,ResultColumn,PassParam,AutoPopup)
SELECT MappingID,ElementID,FormID,SearchColumn,ResultColumn,PassParam,AutoPopup
FROM @DynamicFormSearchMapping T
WHERE NOT EXISTS( SELECT * FROM DynamicFormSearchMapping WHERE MappingID = T.MappingID );
SET IDENTITY_INSERT DynamicFormSearchMapping OFF;

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
UNION ALL SELECT 'HMIS2017','RHYAftercareMethod','4','In person: group',4,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','YesNo','0','No',1,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','YesNo','1','Yes',10,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','YesNo','11','Yes',10,NULL,NULL,'D',NULL
UNION ALL SELECT 'HMIS','YesNo','8','Client doesn''t know',80,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','YesNo','88','Don''t Know',80,NULL,NULL,'D',NULL
UNION ALL SELECT 'HMIS','YesNo','9','Client refused',90,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','YesNo','99','Data Not Collected',99,NULL,NULL,'A','';
INSERT INTO cmComboboxItem(ComboboxGrp,Combobox,Item,ItemDesc,DisplayOrder,ReadOnly,SubGroup,ActiveStatus,HelpText,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate)
SELECT ComboboxGrp,Combobox,Item,ItemDesc,DisplayOrder,ReadOnly,SubGroup,ActiveStatus,HelpText,'DSI',GETDATE(),'DSI',GETDATE()
FROM @cmComboboxItem T
WHERE NOT EXISTS( SELECT *
	FROM cmComboboxItem
	WHERE Combobox = T.Combobox
	  AND ComboboxGrp = T.ComboboxGrp );
DELETE FROM HashTagLink WHERE LinkTable='DynamicForm' AND LinkColumn='FormID' AND LinkID=4294;
