USE [_CTN_Dev]
GO

PRINT 'Form 3680';
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
SELECT 3680,'HMIS Grant Setup',1,NULL,NULL,1,NULL,NULL,0,NULL,0,147,NULL,'EditableIf=@tool-setup@',NULL;
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
SELECT 3680,1,'',1,'HMIS Grant Setup',NULL,NULL;
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
SELECT 3663,3680,'cmProgFund','cmProgFund.GrantID',NULL,0,0,0,0,NULL,NULL;
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
SELECT 325,'cmProgCodes','ProgID','Prog',NULL,NULL,NULL,NULL,NULL,'Module'
UNION ALL SELECT 538,'osOrganization','OrgID','Organization','ActiveStatus','A',NULL,NULL,NULL,'Orgs from osOrganization'
UNION ALL SELECT 557,'cmComboBoxItem','item','itemDesc','Combobox','grantTypeCat','ComboboxGrp','CMGTC',NULL,'grantTypeCat - CMGTC'
UNION ALL SELECT 3454,'cmGrantProg','GrantTypeCatDesc','GrantTypeDescript',NULL,NULL,NULL,NULL,'SELECT 3454 AS ListItemTypeID, 
[CGP].[GrantTypeCatDesc] AS ListItemKey, 
[CGP].[GrantTypeDescript] AS ListItemLabel 
FROM [dbo].[cmGrantProg] AS [CGP]
WHERE [CGP].[GrantTypeCat] = ''@cmProgFund.GrantTypeCat@'' AND [CGP].[ActiveStatus] = ''A''
ORDER BY [CGP].[DsiSerNo]','Grant Type Description Sorted';
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
SELECT 62829,3680,1,25,'Grant ID','cmProgFund.FundID','cmProgFund.FundID',1,1,NULL,NULL,1,1,50,NULL,0,'MaxLength=3&ReadOnlyOnEdit=1',0,0
UNION ALL SELECT 62830,3680,1,35,'Grant Description','cmProgFund.FundDesc','cmProgFund.FundDesc',1,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62831,3680,1,40,'Grantee Agency','cmProgFund.GrantteeName','cmProgFund.GrantteeName',0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62832,3680,1,55,'Address','cmProgFund.GrantteeAdd1','cmProgFund.GrantteeAdd1',0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62833,3680,1,60,'Address 2','cmProgFund.GrantteeAdd2','cmProgFund.GrantteeAdd2',0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62834,3680,1,70,'City','cmProgFund.GrantteeCity','cmProgFund.GrantteeCity',0,0,NULL,'DISABLED',1,1,NULL,NULL,0,'Disabled=1',0,0
UNION ALL SELECT 62835,3680,1,75,'State','cmProgFund.GrantteeState','cmProgFund.GrantteeState',0,0,NULL,'DISABLED',1,1,50,NULL,0,'Disabled=1',0,0
UNION ALL SELECT 62836,3680,14,65,'Zip Code','cmProgFund.GrantteeZip','cmProgFund.GrantteeZip',0,0,NULL,NULL,1,1,70,NULL,0,'Inline=1',0,0
UNION ALL SELECT 62837,3680,3,115,'Begin Date','cmProgFund.GrantBeginDate','cmProgFund.GrantBeginDate',1,1,NULL,NULL,1,1,NULL,'@Date',0,NULL,0,0
UNION ALL SELECT 62838,3680,3,120,'End Date','cmProgFund.GrantEndDate','cmProgFund.GrantEndDate',1,1,NULL,NULL,1,1,NULL,NULL,0,'TimeValue=11%3A59%20PM',0,0
UNION ALL SELECT 62847,3680,24,30,'Hidden - GrantID','cmProgFund.GrantID',NULL,0,0,NULL,'DataSystems.Plugins.Formula',1,1,NULL,NULL,0,'Formula=%22%22%20+%20@cmProgFund.ProgID@%20+%20@cmProgFund.FundID@',0,0
UNION ALL SELECT 62848,3680,9,140,'Enrollment Required','cmProgFund.EnrollmentRequired','cmProgFund.EnrollmentRequired',0,1,NULL,'',1,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 62849,3680,24,150,'Define Eligibility','EligibilityResource',NULL,0,1,NULL,'DataSystems.Plugins.SubRenderer',1,1,NULL,NULL,0,'FormID=3120&MappedFields=EligibilityResource.ResourceTable%3D%22cmProgFund%22&PrimaryKey=@PrimaryKey&UniqueField=Eligibility.LinkTable&config-queryfilter=AND%20EligibilityResource.ResourceTable%3D%27cmProgFund%27&config-orderby=EligibilityResource.UniqueID&AllowNew=1&config-newlines=0',0,0
UNION ALL SELECT 62852,3680,20,135,'Enrollment Required','DATANULL',NULL,0,1,NULL,'Historically, this property would require that a client have an open Enrollment in the Grant to be able to receive Services from the Grant. Post 2014 HMIS Service Pack, HMIS enrollments no longer need grant on the enrollment. In most cases administrators should uncheck this property. Please see the Service Pack release notes for details.',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62853,3680,20,145,'Eligibility Rules','DATANULL','',0,1,NULL,'Select an Eligibility Rule group to use Eligibility Determination for the Grant.',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62854,3680,20,5,'Instructions','DATANULL',NULL,0,1,NULL,'Enter a 3-character Grant ID to uniquely identify the Grant record.  Enter a Grant Description for display on transactions.  Enter the Grantee Agency and Address.  Select the Owning Organization for the Grant.  ',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62855,3680,20,110,'Date Range','DATANULL','',0,1,NULL,'The Grant will only be active and available to Users for transactions where the data entry date falls within this date range.',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62857,3680,20,80,'Federal Grant Programs','DATANULL',NULL,0,1,NULL,'If this is a grant related to specific federal programs, enter the following information. Select the Federal Grant Program and Grant Program Component. ',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62858,3680,20,125,'Accessing Organization(s)','DATANULL',NULL,0,1,NULL,'The organizations listed below will be able to access this grant.',1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 62860,3680,24,100,'Entity Data','EntityData',NULL,0,1,NULL,'DataSystems.Plugins.EntityData',1,1,NULL,NULL,0,'Data=FundDesc%3D@cmProgFund.FundDesc@',0,0
UNION ALL SELECT 62861,3680,24,15,'Access Violation','AccessViolation',NULL,0,1,NULL,'DataSystems.Plugins.AccessViolation',1,1,NULL,NULL,0,'AccessFormula=@tool-ro-setup@',0,0
UNION ALL SELECT 62862,3680,24,10,'Access Violation','AccessViolation',NULL,0,1,NULL,'DataSystems.Plugins.AccessViolation',1,1,NULL,NULL,0,'AccessFormula=@tool-setup@&AccessOn=New',0,0
UNION ALL SELECT 62864,3680,8,20,'Module','cmProgFund.progId','cmProgFund.ProgID',1,0,325,NULL,1,1,NULL,'UN',0,NULL,0,0
UNION ALL SELECT 62866,3680,8,90,'Grant Program Component','cmProgFund.GrantTypeDescID','cmProgFund.GrantTypeDescID',1,1,3454,NULL,1,1,NULL,NULL,0,'RejectInvalid=1',0,0
UNION ALL SELECT 62868,3680,24,130,'Accessing Organizations','cmProgFund.OrgGroupID','cmProgFund.OrgGroupID',0,1,538,'DataSystems.Plugins.OrgGroupID',1,1,NULL,'-2',0,'AllOrgs=All%20Organizations',0,0
UNION ALL SELECT 62869,3680,8,45,'Owning Organization','cmProgFund.OrgID','cmProgFund.OrgID',1,1,538,'',1,1,NULL,'@OrgID',0,NULL,0,0
UNION ALL SELECT 62870,3680,8,85,'Federal Grant Program','cmProgFund.GrantTypeCat','cmProgFund.GrantTypeCat',1,1,557,NULL,1,1,NULL,NULL,0,'HiddenValues=CDC%2CEVL%2CCDB%2CESP%2CHPR%2CEAP%2CNAH%2CRWH%2CS8M%2CSPC%2CSHP%2CVOC%2CVAW',0,0
UNION ALL SELECT 62873,3680,9,50,'Show Address Information','ShowAddress',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,'IfChecked=1&IfUnchecked=0',0,0
UNION ALL SELECT 70101,3680,1,105,'Grant Identifier','cmProgFund.HUDGrantProjID','cmProgFund.HUDGrantProjID',0,1,NULL,NULL,1,1,NULL,NULL,0,'HelpText=A%20grant%20identifier%20%28grant%20number%20or%20other%20identification%20associated%20with%20the%20specific%20funding%20source%29',0,0;
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
SELECT 17852,62870,0,'@cmProgFund.GrantTypeCat@  =="-1"',1,1,1,0,3
UNION ALL SELECT 17853,62829,0,'EXEC v_cmProgFund_NoDuplicateGrantID @cmProgFund.ProgID@,@cmProgFund.FundID@,@PrimaryKey@',0,0,1,0,3
UNION ALL SELECT 17854,62838,0,'@cmProgFund.GrantEndDate@  <@cmProgFund.GrantBeginDate@',0,0,1,0,3
UNION ALL SELECT 17858,62829,0,'((@cmProgFund.FundID@ != '''') && (@PrimaryKey@ != ''''))',1,1,1,0,3
UNION ALL SELECT 17859,62873,0,'@ShowAddress@ == 1',1,1,1,0,3;
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
SELECT 17854,47399,62838,0,'FORCEERROR=TRUE,Error=The End Date cannot be before the Begin Date,',1,1
UNION ALL SELECT 17858,47403,62829,0,'disabled=true,',1,1
UNION ALL SELECT 17858,47404,62829,0,'disabled=false,',0,1
UNION ALL SELECT 17859,47405,62832,0,'visible=true',1,0
UNION ALL SELECT 17859,47406,62833,0,'visible=true',1,1
UNION ALL SELECT 17859,47407,62836,0,'visible=true',1,2
UNION ALL SELECT 17859,47408,62834,0,'visible=true',1,3
UNION ALL SELECT 17859,47409,62835,0,'visible=true',1,4
UNION ALL SELECT 17859,47410,62832,0,'visible=false',0,5
UNION ALL SELECT 17859,47411,62833,0,'visible=false',0,6
UNION ALL SELECT 17859,47412,62836,0,'visible=false',0,7
UNION ALL SELECT 17859,47413,62834,0,'visible=false',0,8
UNION ALL SELECT 17859,47414,62835,0,'visible=false',0,9;
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
SELECT 6754,62836,101,'zipCodeId','cmProgFund.GrantteeZip','',0
UNION ALL SELECT 6755,62836,101,'City','cmProgFund.GrantteeCity',NULL,0
UNION ALL SELECT 6756,62836,101,'State','cmProgFund.GrantteeState',NULL,0;
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
SELECT 'CMGTC','grantTypeCat','CDB','Community Development Block Grant (CDBG)',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','CDC','CDC - CBO Funding for Prevention and Testing',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','CoC','HUD:CoC',1,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','EAP','Low Income Home Energy Assistance Program (LIHEAP)',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','ESG','Emergency Solutions Grant (ESG)',2,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','ESP','ESAP (State of WA)',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','EVL','CDC - Eval Web',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','GPD','VA: VA Funded Transitional Housing',10,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','HPA','Housing Opportunities for People with AIDS (HOPWA)',6,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','HPR','Homeless Prevention and Rapid Re-Housing (HPRP)',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','HPS','HUD: Pay for Success',3,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','HPT','HHS:PATH',8,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','HRY','HHS:RHY',9,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','HVA','HUD-VASH',7,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','NAA','N/A',14,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','NAH','NAHBG',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','PIH','HUD: Public and Indian Housing (PIH)',4,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','RHS','HUD:Rural Housing Stability Assistance Program',5,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','RWH','Ryan White',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','S8M','Sec. 8 Moderate Rehabilitation',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','SHP','Supportive Housing Program',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','SPC','Shelter Plus Care',30,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','SVF','VA:Supportive Services for Veteran Families',12,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','VAC','VA: Health Care for Homeless',13,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','VAW','VAWA',21,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','VOC','VOCA',22,NULL,NULL,'A',''
UNION ALL SELECT 'CMGTC','grantTypeCat','VPD','VA: Grant Per Diem',11,NULL,NULL,'A','';
INSERT INTO cmComboboxItem(ComboboxGrp,Combobox,Item,ItemDesc,DisplayOrder,ReadOnly,SubGroup,ActiveStatus,HelpText,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate)
SELECT ComboboxGrp,Combobox,Item,ItemDesc,DisplayOrder,ReadOnly,SubGroup,ActiveStatus,HelpText,'DSI',GETDATE(),'DSI',GETDATE()
FROM @cmComboboxItem T
WHERE NOT EXISTS( SELECT *
	FROM cmComboboxItem
	WHERE Combobox = T.Combobox
	  AND ComboboxGrp = T.ComboboxGrp );
DELETE FROM HashTagLink WHERE LinkTable='DynamicForm' AND LinkColumn='FormID' AND LinkID=3680;
