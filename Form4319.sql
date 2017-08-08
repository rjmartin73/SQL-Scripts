PRINT 'Form 4319';
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
SELECT 4319,'Quick Family Members for HMIS 2017',5,NULL,NULL,0,NULL,NULL,0,NULL,0,2530,NULL,'EditableIf=@CanEditOrg@&EditElement=cmFamilyMemFile.FamilyMemID&AllowNew=1&NewLines=1','<div>The purpose of the family members form is to gather basic identifying and demographic data for #family members. The data on this version of the form is intended for use with #HMIS programs.&nbsp;</div>
<div></div>
<div>This multi-edit form uses #formrules for the following purposes:</div>
<div>-Determine social security quality. This includes hiding the field in a row with a complete SSN (i.e. right number of characters)&nbsp;</div>
<div>-Determine required fields related to birth date and birth date quality.&nbsp;</div>
<div>-Hide veteran status and disabling condition for non-Adults.</div>
<div>- show other gender when the category "other" is selected for #gender.<br />
<br />
</div>
<div>The form also uses #validation stored procedures; including:</div>
<div>#writeback to write the FamilyAcct back to the client records created for a family members</div>
<div>#DuplicateClient check to determine if a potential duplicate is found while adding new family member.</div>
<div>#SingleHeadofHousehold &nbsp;is validation to ensure that users only select one family member as "self" for relationship to head of household.</div>
<div>#CopyFamilyAddress which is utilized to copy a family address to a client''s record. Typically utilized when adding new family members to a family.<br />
<br />
</div>
<div>The family member record has a date added and date removed column to accurately represent changes in the family membership. This form defaults date added to the client''s birthdate. If the client doesn''t have a birthdate then the form will use the current date. #family #familymember</div>';
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
SELECT 4319,1,'The selected client''s family members are displayed below. You may search for existing clients to add to this family or add new clients to the database and associate them with this family.<br/>
<br/>
It''s important to note that family members are the people who the client is related to. Family isn''t always the same as a client''s household. According to HUD "[a] household is a single individual or a group of persons who apply together to a continuum project for assistance and who live together in one dwelling unit (or, for persons who are not housed, who would live together in one dwelling unit if they were housed." (Data Manual)<br/>
<br/>
This workflow will allow you to enroll all family members or select which family members you want to enroll.&nbsp;<br/>
<br/>
<br/>',1,'Family Members',NULL,NULL;
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
SELECT 4301,4319,'cmFamilyMemFile','cmFamilyMemFile.FamilyAcctID','cmFamilyMemFile.FamilyMemID',0,0,0,1,NULL,NULL;
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
SELECT 9484,4319,'cmFamilyMemFile','cmFamilyMemFile.ClientID','cmClient','cmClient.ClientID','cmClient.ClientID',1,0,'AND cmFamilyMemFile.DateRemoved > GETDATE()','cmClient',1,0,1,1,1,1,1,1,1,1,1,-1,NULL,NULL;
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
SELECT 4301,'cmClient.Birthdate',1,1;
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
INSERT INTO @DynamicFormListItemType([ListItemTypeID],[TableName],[TablePrimaryKey],[TableLabel],[FilterField],[FilterFieldValue],[SecondFilterField],[SecondFilterFieldValue],[ForcePopulationQuery],[ListItemDescription])
SELECT 65,'cmComboBoxItem','Item','ItemDesc','Combobox','relationship','ComboboxGrp','CMFML',NULL,'relationship - CMFML'
UNION ALL SELECT 1141,'cmComboBoxItem','Item','ItemDesc','Combobox','HUDEthnicity','ComboboxGrp','Homeless',NULL,'HUD Ethnicity'
UNION ALL SELECT 1720,'cmComboBoxItem','Item','ItemDesc','Combobox','DisablingCondition','ComboboxGrp','HUDEnroll',NULL,'Yes, No, Don''t Know, Refused'
UNION ALL SELECT 2040,'cmComboBoxItem','Item','ItemDesc','Combobox','YesNo','ComboboxGrp','HMIS',NULL,'Yes, No, Don''t Know, Refused'
UNION ALL SELECT 2156,'cmComboBoxItem','Item','ItemDesc','Combobox','Orientation','ComboboxGrp','cmClient',NULL,'Sexual Orientation'
UNION ALL SELECT 2529,'cmComboBoxItem','Item','ItemDesc','Combobox','SSNQuality','ComboboxGrp','HMIS',NULL,'SSN Quality'
UNION ALL SELECT 2585,'cmComboBoxItem','Item','ItemDesc','Combobox','BirthDateQuality','ComboboxGrp','HMIS',NULL,'Birth Date Quaility'
UNION ALL SELECT 2591,'cmComboBoxItem','Item','ItemDesc','Combobox','HUDRaceHMIS','ComboboxGrp','Client',NULL,'HUD Race - HMIS Standards'
UNION ALL SELECT 3019,'cmComboBoxItem','Item','ItemDesc','Combobox','HMISNameQuality','ComboboxGrp','HMIS',NULL,'HMIS Name Quality'
UNION ALL SELECT 3436,'cmComboBoxItem','Item','ItemDesc','Combobox','Gender','ComboboxGrp','HMIS2017',NULL,'Gender HMIS 2017';
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
SELECT 82242,4319,3,40,'Birth Date','cmClient.Birthdate','cmClient.Birthdate',1,1,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82243,4319,8,50,'Birth Date<br/>Quality','cmClient.BirthDateQuality','cmClient.BirthDateQuality',1,1,2585,NULL,1,1,NULL,'1',0,'Heading=Birth%20Date%3CBR%3EQuality&NoSearch=1&Ignore=1',0,0
UNION ALL SELECT 82244,4319,16,115,'ClientID','cmClient.ClientID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82245,4319,15,170,'Hidden - ClientType','cmClient.ClientType','cmClient.ClientType',1,0,NULL,NULL,1,1,NULL,'1',0,'NoSearch=1',0,0
UNION ALL SELECT 82246,4319,1,100,'FamilyAcct','cmClient.FamilyAcct','cmClient.FamilyAcct',0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82247,4319,1,15,'First<br/>Name','cmClient.FirstName','cmClient.FirstName',1,1,NULL,NULL,1,1,100,NULL,0,'NoSearch=1&ReadOnlyOnEdit=2',0,0
UNION ALL SELECT 82248,4319,8,55,'Gender','cmClient.Gender','cmClient.Gender',1,1,3436,NULL,1,1,NULL,NULL,0,'NoSearch=1&HelpText=Select%20Gender',0,0
UNION ALL SELECT 82249,4319,8,125,'Ethnicity','cmClient.HUDEthnicity','cmClient.HUDEthnicity',1,1,1141,NULL,1,1,NULL,'@HUDEthnicity@',0,'NoSearch=1',0,0
UNION ALL SELECT 82250,4319,3,180,'InfoReleaseDate','cmClient.InfoReleaseDate','cmClient.InfoReleaseDate',0,0,NULL,NULL,1,1,NULL,'@Date',0,'NoSearch=1&ValueIfBlank=1/1/1753&BlankWhen=1/1/1753&DateOnly=1',0,0
UNION ALL SELECT 82251,4319,1,175,'InfoReleaseNo','cmClient.InfoReleaseNo','cmClient.InfoReleaseNo',0,0,NULL,NULL,1,1,NULL,'1',0,'NoSearch=1',0,0
UNION ALL SELECT 82252,4319,14,25,'Last<br/>Name','cmClient.LastName','cmClient.LastName',1,1,NULL,NULL,1,1,100,NULL,0,'NoSearch=1&NoAutoSelect=1&ReadOnlyOnEdit=2',0,0
UNION ALL SELECT 82253,4319,1,20,'Middle<br/>Name','cmClient.MiddleInitial','cmClient.MiddleInitial',0,1,NULL,NULL,1,1,60,NULL,0,'NoSearch=1&ReadOnlyOnEdit=2',0,0
UNION ALL SELECT 82254,4319,8,85,'Relationship<br/>to Head<br/>of Household','cmClient.RelationToFamilyHead','cmClient.RelationToFamilyHead',1,1,65,NULL,1,1,NULL,NULL,0,'NoSearch=1&HiddenValues=EX%2COC%2CG%2CP%2CGP',0,0
UNION ALL SELECT 82255,4319,15,80,'Relationship','cmClient.RelationToFamilyHead','cmFamilyMemFile.Relationship',0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82256,4319,9,160,'RestrictIntake','cmClient.RestrictIntake','cmClient.RestrictIntake',0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82257,4319,24,165,'Restriction','cmClient.RestrictOrg','cmClient.RestrictOrg',1,0,NULL,'DataSystems.Plugins.InfoReleasePlugin',1,1,124,'X',0,'NoSearch=1',0,0
UNION ALL SELECT 82258,4319,2,65,'SSN','cmClient.SocSecNo','cmClient.SocSecNo',0,1,NULL,NULL,1,1,70,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82259,4319,8,75,'SSN Quality','cmClient.SSNQuality','cmClient.SSNQuality',1,1,2529,NULL,1,1,NULL,'8',0,'NoSearch=1&Ignore=1',0,0
UNION ALL SELECT 82260,4319,3,150,'Date Added','cmFamilyMemFile.DateAdded','cmFamilyMemFile.DateAdded',0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1&Ignore=1',0,0
UNION ALL SELECT 82261,4319,3,155,'Date Removed','cmFamilyMemFile.DateRemoved','cmFamilyMemFile.DateRemoved',0,0,NULL,NULL,1,1,NULL,NULL,0,'ValueIfBlank=12/31/9999&NoSearch=1',0,0
UNION ALL SELECT 82262,4319,1,5,'FamilyAcctID','cmFamilyMemFile.FamilyAcctID','cmFamilyMemFile.FamilyAcctID',1,0,NULL,NULL,1,1,NULL,'@PrimaryKey',0,'NoSearch=1',0,0
UNION ALL SELECT 82263,4319,1,10,'FamilyMemID','cmFamilyMemFile.FamilyMemID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82264,4319,9,145,'Copy<br/>Family<br/>Address','CopyAddress','CopyAddress',0,0,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82265,4319,24,45,'Age','DATANULL',NULL,0,1,NULL,'DataSystems.Plugins.CalculateBirthDate',1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82266,4319,24,110,'After Save Validation','DATANULL',NULL,0,0,NULL,'DataSystems.Plugins.AfterSaveValidation',1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82267,4319,24,105,'Before Save Validation','DATANULL',NULL,0,0,NULL,'DataSystems.Plugins.BeforeSaveValidation',1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82268,4319,24,120,'Race','Race',NULL,1,1,2591,'DataSystems.Plugins.MultiSaveList',1,1,NULL,'@RaceList@',0,'ChildColumn=Race&NoSearch=1&ParentColumn=ClientID&ParentValue=@cmClient.ClientID@&TableName=ClientRace&NoSelectAll=1',0,0
UNION ALL SELECT 82269,4319,8,35,'Name Quality','cmClient.NameQuality','cmClient.NameQuality',1,1,3019,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82271,4319,8,95,'Veteran Status','cmClient.VeteranStatus','cmClient.VeteranStatus',1,1,2040,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82272,4319,8,130,'Pregnancy Status','cmClient.pregnancySt','cmClient.pregnancySt',0,1,1720,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82273,4319,3,135,'Pregnancy Due Date','cmClient.pregDueDate','cmClient.pregDueDate',0,1,NULL,NULL,1,1,NULL,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82274,4319,8,140,'Orientation','cmClient.Orientation','cmClient.Orientation',0,1,2156,NULL,1,1,NULL,NULL,0,'NoSearch=1&HelpText=Any%20questions%20regarding%20a%20client%u2019s%20sexual%20orientation%20must%20be%20voluntary%20and%20clients%20must%20be%20informed%20prior%20to%20responding%20of%20the%20voluntary%20nature%20of%20the%20question%20and%20that%20their%20refusal%20to%20respond%20will%20not%20result%20in%20a%20denial%20of%20services',0,0
UNION ALL SELECT 82275,4319,1,30,'Suffix','cmClient.Suffix','cmClient.Suffix',0,1,NULL,NULL,1,1,60,NULL,0,'NoSearch=1',0,0
UNION ALL SELECT 82270,4319,8,90,'Disabling Condition','cmClient.DisablingCondition','cmClient.DisablingCondition',1,1,2040,NULL,1,1,NULL,NULL,1,'NoSearch=1',0,0
UNION ALL SELECT 82276,4319,1,70,'RelationshipType','cmClient.RelationToFamilyHead','cmFamilyMemFile.RelationshipType',0,1,NULL,NULL,1,1,NULL,NULL,1,'NoSearch=1',0,0;
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
SELECT 22847,82266,0,'EXEC v_WriteBack "cmClient","FamilyAcct",@cmFamilyMemFile.FamilyAcctID@,"ClientID",@cmClient.ClientID@,"",""',1,1,1,0,3
UNION ALL SELECT 22848,82267,0,'EXEC v_DuplicateClient @cmClient.ClientID@,@cmClient.LastName@,@cmClient.FirstName@,@cmClient.SocSecNo@,@OrgID@,@UserID@',1,1,1,0,3
UNION ALL SELECT 22849,82258,0,'('''' + @cmClient.SocSecNo@).length == 11 && ('''' + @cmClient.SocSecNo@).indexOf( ''?'' ) == -1',1,1,1,0,3
UNION ALL SELECT 22850,82258,0,'(@cmClient.SocSecNo@ == '''' || !('''' + @cmClient.SocSecNo@).match(/\d/)) && (@cmClient.SSNQuality@ < 3)',1,1,1,0,3
UNION ALL SELECT 22851,82258,0,'(!!(@cmClient.SocSecNo@).match(/\d/)) && ((''''+@cmClient.SocSecNo@).length < 11 || (''''+@cmClient.SocSecNo@).indexOf(''?'') != -1)',1,1,1,0,3
UNION ALL SELECT 22852,82258,0,'@cmClient.socSecNo@ == '''' || !('''' + @cmClient.SocSecNo@).match(/\d/)',1,1,1,0,3
UNION ALL SELECT 22853,82242,0,' @cmClient.BirthDate@ != '''' && (@cmClient.BirthdateQuality@ == 8 ||@cmClient.BirthdateQuality@ == 9 || @cmClient.BirthdateQuality@==99)',1,1,1,0,3
UNION ALL SELECT 22854,82243,0,'((@cmClient.BirthDateQuality@ == 8) || ((@cmClient.BirthDateQuality@ == 9) || (@cmClient.BirthDateQuality@ == 99)))',1,1,1,0,3
UNION ALL SELECT 22855,82267,0,'EXEC v_SingleHeadofHousehold @PrimaryKey@,@cmClient.ClientID@,@cmClient.RelationtoFamilyHead@,@cmFamilyMemFile.DateAdded@',1,1,1,0,3
UNION ALL SELECT 22856,82266,0,'EXEC v_CopyFamilyAddress @CopyAddress@,@PrimaryKey@,@cmClient.ClientID@',0,1,1,0,3
UNION ALL SELECT 22857,82242,0,'((@cmFamilyMemFile.FamilyMemID@ == '''') && (@cmClient.Birthdate@ != ''''))',1,1,1,0,3
UNION ALL SELECT 22858,82260,0,'((@cmFamilyMemFile.FamilyMemID@ == '''') && ((@cmClient.Birthdate@ == '''') && (((@cmClient.FirstName@ != '''') || (@cmClient.BirthDateQuality@ > 2)) || (@cmClient.LastName@ != ''''))))',0,1,1,0,3
UNION ALL SELECT 22859,82267,0,'@cmClient.Birthdate@ > @Date@',1,1,1,0,3
UNION ALL SELECT 22860,82252,0,'((@cmClient.FirstName@ != '''') && (@cmClient.LastName@ != ''''))',1,1,1,0,3
UNION ALL SELECT 22861,82269,0,'@cmClient.NameQuality@ != ''1''',1,1,1,0,3
UNION ALL SELECT 22862,82242,0,'@cmClient.Birthdate@ <= @DateAdd(y,-18)@',1,1,1,0,3
UNION ALL SELECT 22863,82248,0,'(((@cmClient.pregnancySt@ != '''') || (@GrantTypeID@ == ''RHY'')) && ((@cmClient.Gender@ == 1) && (@cmClient.Birthdate@ <= @DateAdd( y, -12)@)))',1,1,1,0,3
UNION ALL SELECT 22864,82272,0,'@cmClient.pregnancySt@ == ''Y''',1,1,1,0,3
UNION ALL SELECT 22865,82247,0,'(@GrantTypeID@ == ''RHY'')',1,1,1,0,3
UNION ALL SELECT 22866,82242,0,'(@GrantTypeID@ == ''RHY'')',1,1,1,0,3;
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
SELECT 22849,56549,82259,0,'visible=true,value=1,',1,1
UNION ALL SELECT 22850,56550,82259,0,'value=**BLANK**,',1,1
UNION ALL SELECT 22851,56551,82259,0,'visible=false,value=2,',1,1
UNION ALL SELECT 22852,56552,82259,0,'visible=true,',1,1
UNION ALL SELECT 22852,56553,82259,0,'visible=false,',0,1
UNION ALL SELECT 22853,56554,82243,0,'value=1,',1,1
UNION ALL SELECT 22854,56555,82242,0,'visible=false,required=false,value=**BLANK**',1,1
UNION ALL SELECT 22854,56556,82242,0,'visible=true,required=true',0,1
UNION ALL SELECT 22857,56557,82260,0,'value=@cmClient.BirthDate@,',1,1
UNION ALL SELECT 22858,56558,82260,0,'value=@Date@,',1,1
UNION ALL SELECT 22859,56559,82242,0,'error=The%20family%20member%27s%20Birth%20Date%20cannot%20be%20in%20the%20future.,forceerror=true',1,1
UNION ALL SELECT 22860,56560,82269,0,'value=1',1,1
UNION ALL SELECT 22861,56561,82247,0,'required=false',1,1
UNION ALL SELECT 22861,56562,82252,0,'required=false',1,1
UNION ALL SELECT 22861,56563,82247,0,'required=true',0,1
UNION ALL SELECT 22861,56564,82252,0,'required=true',0,1
UNION ALL SELECT 22862,56565,82271,0,'visible=true,required=true',1,1
UNION ALL SELECT 22862,56566,82271,0,'visible=false,required=false,value=**BLANK**',0,1
UNION ALL SELECT 22863,56567,82272,0,'visible=true,required=true',1,1
UNION ALL SELECT 22863,56568,82272,0,'visible=false,required=false,value=**BLANK**',0,1
UNION ALL SELECT 22864,56569,82273,0,'visible=true,required=true',1,1
UNION ALL SELECT 22864,56570,82273,0,'visible=false,required=false,value=**BLANK**',0,1
UNION ALL SELECT 22865,56571,82274,0,'columnvisible=true',1,1
UNION ALL SELECT 22865,56572,82274,0,'columnvisible=false',0,1
UNION ALL SELECT 22866,56573,82274,0,'visible=true,required=true',1,1
UNION ALL SELECT 22866,56574,82274,0,'visible=false,required=false',0,1;
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
SELECT 8364,82252,98,'FirstName','cmClient.FirstName','&Prefill=cmClient.FirstName%7C@cmClient.FirstName@%7CcmClient.MiddleInitial%7C@cmClient.MiddleInitial@',0
UNION ALL SELECT 8365,82252,98,'LastName','cmClient.LastName',NULL,0
UNION ALL SELECT 8366,82252,98,'Gender','cmClient.Gender',NULL,0
UNION ALL SELECT 8367,82252,98,'HUDEthnicity','cmClient.HUDEthnicity',NULL,0
UNION ALL SELECT 8368,82252,98,'MiddleInitial','cmClient.MiddleInitial',NULL,0
UNION ALL SELECT 8369,82252,98,'SocSecNo','cmClient.SocSecNo',NULL,0
UNION ALL SELECT 8370,82252,98,'ClientID','cmClient.ClientID',NULL,0
UNION ALL SELECT 8371,82252,98,'Birthdate','cmClient.Birthdate',NULL,0
UNION ALL SELECT 8372,82252,98,'RaceList','Race',NULL,0
UNION ALL SELECT 8373,82252,98,'RestrictOrg','cmClient.RestrictOrg',NULL,0
UNION ALL SELECT 8374,82252,98,'ClientType','cmClient.ClientType',NULL,0
UNION ALL SELECT 8375,82252,98,'SSNQuality','cmClient.SSNQuality',NULL,0
UNION ALL SELECT 8376,82252,98,'BirthDateQuality','cmClient.BirthDateQuality',NULL,0
UNION ALL SELECT 8377,82252,98,'Suffix','cmClient.Suffix',NULL,0
UNION ALL SELECT 8378,82252,98,'Orientation','cmClient.Orientation',NULL,0
UNION ALL SELECT 8379,82252,98,'pregnancySt','cmClient.pregnancySt',NULL,0
UNION ALL SELECT 8380,82252,98,'pregDueDate','cmClient.pregDueDate',NULL,0
UNION ALL SELECT 8381,82252,98,'DisablingCondition','cmClient.DisablingCondition',NULL,0
UNION ALL SELECT 8382,82252,98,'VeteranStatus','cmClient.VeteranStatus',NULL,0;
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

ALTER TABLE DynamicFormElement WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormAction WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormGroup WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE DynamicFormEdge WITH CHECK CHECK CONSTRAINT ALL;
ALTER TABLE Report WITH CHECK CHECK CONSTRAINT ALL;
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
SELECT 'HMIS','BirthDateQuality','1','Full DOB reported',1,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','BirthDateQuality','2','Approximate or partial DOB reported',2,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','BirthDateQuality','8','Client doesn''t know',8,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','BirthDateQuality','9','Client refused',9,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','BirthDateQuality','99','Data not collected',10,NULL,NULL,'A',NULL
UNION ALL SELECT 'HUDEnroll','DisablingCondition','D','Client doesn''t know',30,NULL,NULL,'A',''
UNION ALL SELECT 'HUDEnroll','DisablingCondition','N','No',20,NULL,NULL,'A',''
UNION ALL SELECT 'HUDEnroll','DisablingCondition','R','Client Refused',40,NULL,NULL,'A',''
UNION ALL SELECT 'HUDEnroll','DisablingCondition','Y','Yes',10,NULL,NULL,'A',''
UNION ALL SELECT 'HUDEnroll','DisablingCondition','Z','Data not collected',100,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','1','Female',1,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','2','Male',2,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','3','Trans Male (FTM or Female to Male)',4,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','4','Client doesn''t know',8,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','5','Trans Female (MTF or Male to Female)',3,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','6','Gender Non-Conforming (i.e. not exclusively male or female)',5,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','7','Client refused',9,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS2017','Gender','9','Data not collected',10,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','HMISNameQuality','1','Full name reported',1,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','HMISNameQuality','2','Partial, street name, or code name reported',5,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','HMISNameQuality','8','Client doesn''t know',80,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','HMISNameQuality','9','Client refused',90,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','HMISNameQuality','99','Data not collected',100,NULL,NULL,'A',NULL
UNION ALL SELECT 'Homeless','HUDEthnicity','7','Data not collected',50,NULL,NULL,'D',NULL
UNION ALL SELECT 'Homeless','HUDEthnicity','8','Client doesn''t know',20,NULL,NULL,'A',NULL
UNION ALL SELECT 'Homeless','HUDEthnicity','9','Client refused',30,NULL,NULL,'A',NULL
UNION ALL SELECT 'Homeless','HUDEthnicity','99','Data not collected',50,NULL,NULL,'A',NULL
UNION ALL SELECT 'Homeless','HUDEthnicity','H','Hispanic/Latino',1,NULL,NULL,'A',NULL
UNION ALL SELECT 'Homeless','HUDEthnicity','O','Non-Hispanic/Latino',2,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','1','American Indian or Alaska Native',10,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','10','something',99,NULL,NULL,'D',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','11','American Indian or Alaska Native',10,NULL,NULL,'D',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','111','American Indian or Alaska Native',10,NULL,NULL,'D',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','2','Asian',20,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','22','Asian',20,NULL,NULL,'D',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','3','Black or African American',30,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','4','Native Hawaiian or Other Pacific Islander',40,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','5','White',50,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','7','Data not collected',100,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','8','Client doesn''t know',80,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','9','Client refused',90,NULL,NULL,'A',NULL
UNION ALL SELECT 'Client','HUDRaceHMIS','99','Data not collected',100,NULL,NULL,'D',NULL
UNION ALL SELECT 'cmClient','Orientation','1','Heterosexual',5,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','2','Gay',10,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','3','Lesbian',15,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','4','Bisexual',20,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','5','Questioning / Unsure',21,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','8','Client doesn''t know',25,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','9','Client Refused',30,NULL,NULL,'A',''
UNION ALL SELECT 'cmClient','Orientation','99','Data not collected',99,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','D','Daughter',4,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','DC','Dependent Child',5,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','EX','Ex Spouse',12,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','F','Other Family Member',9,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','G','Guardian',7,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','GP','Grandparent',6,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','Relationship','LP','Life Partner',9,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','O','Other Non-Family',10,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','OC','Other Caretaker',11,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','P','Parent',2,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','S','Son',3,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','SL','Self',1,NULL,NULL,'A',''
UNION ALL SELECT 'CMFML','relationship','SLA','Self',1,NULL,NULL,'D',NULL
UNION ALL SELECT 'CMFML','relationship','SP','Spouse',8,NULL,NULL,'A',''
UNION ALL SELECT 'HMIS','SSNQuality','1','Full SSN',10,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','SSNQuality','2','Approximate or partial SSN reported',20,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','SSNQuality','7','Invalid',70,NULL,NULL,'D',NULL
UNION ALL SELECT 'HMIS','SSNQuality','8','Client doesn''t know',80,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','SSNQuality','9','Client Refused',90,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMIS','SSNQuality','99','Data not collected',100,NULL,NULL,'A',NULL
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
INSERT INTO HashTag(HashTag)
SELECT DISTINCT HashTag
FROM (SELECT '#CopyFamilyAddress' AS HashTag
UNION ALL SELECT '#DuplicateClient' AS HashTag
UNION ALL SELECT '#family' AS HashTag
UNION ALL SELECT '#familymember' AS HashTag
UNION ALL SELECT '#formrules' AS HashTag
UNION ALL SELECT '#gender' AS HashTag
UNION ALL SELECT '#HMIS' AS HashTag
UNION ALL SELECT '#SingleHeadofHousehold' AS HashTag
UNION ALL SELECT '#validation' AS HashTag
UNION ALL SELECT '#writeback' AS HashTag
) Z
WHERE NOT EXISTS(SELECT * FROM HashTag H WHERE H.HashTag = Z.HashTag);

MERGE INTO HashTagLink T
USING(VALUES('#CopyFamilyAddress','A'),
('#DuplicateClient','A'),
('#family','A'),
('#familymember','A'),
('#formrules','A'),
('#gender','A'),
('#HMIS','A'),
('#SingleHeadofHousehold','A'),
('#validation','A'),
('#writeback','A')) S(HashTag, ActiveStatus)
ON T.HashTag = S.HashTag
  AND T.LinkTable='DynamicForm'
  AND T.LinkColumn='FormID'
  AND T.LinkID=4319
WHEN MATCHED THEN
	UPDATE
	SET ActiveStatus = S.ActiveStatus
WHEN NOT MATCHED BY TARGET THEN
	INSERT(HashTag, LinkTable, LinkColumn, LinkID, ActiveStatus)
	VALUES(S.HashTag, 'DynamicForm', 'FormID', 4319, S.ActiveStatus)
WHEN NOT MATCHED BY SOURCE AND T.LinkTable='DynamicForm' AND T.LinkColumn='FormID' AND T.LinkID=4319 THEN
	DELETE;
