PRINT 'Form 4317';
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
SELECT 4317,'HMIS Client Intake 2017',1,'Dashboard.aspx?PrimaryKey=@PrimaryKey@',NULL,1,NULL,NULL,0,'cmClient.LastName',0,1,'Default_FamilyQuickAdd @OldClientID@,@FamilyAcctID@,@HousingID@,@RoomID@','Title=Client%20Information','The purpose of this form is to collect the basic, static data (#clientdemographics, #clientcontactinformation) about a client required by HUD.&nbsp;<br />
<br />
<br />
This form is designed to comply with the 2017 #HMIS data standards. Copies of this form should be configured carefully in order to maintain #compliance.&nbsp;<br />
<br />
This form uses form rules to accomplish the following:<br />
-Calculate Name Quality, specifically if a full name (first and last) is recorded then the name quality value is 1 (full name)<br />
-Calculate SSN quality.<br />
-Show or hid address/contact information<br />
-Display and require disabling condition and veteran status based on age. (client must be 18 or older)<br />
<br />
Security data is defaulted and hidden on this form. #defaultandhide<br />
The client record will be associated with #informationrelease 1, i.e. cmClient.infoReleaseNo=1<br />
<br />
All client records should have a #familyaccount. If an existing family is not selected using the family search field then ClientTrack will automatically generate a family account using the #AutoGenerateFamily #plugin.';
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
SELECT 4317,1,'<P style="MARGIN: 0in 0in 0pt" class=MsoNormal><SPAN style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">The first step in adding a new client is to search existing client records for possible matches to avoid duplicate entry.<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>Enter partial identifying information on the client, and then click Next to search from existing client records.<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;</SPAN>&nbsp; </SPAN></P>
<P style="TEXT-INDENT: -0.25in; MARGIN: 0in 0in 0pt 0.25in; mso-list: l0 level1 lfo1; tab-stops: list .25in" class=MsoNormal><SPAN style="FONT-FAMILY: Symbol; FONT-SIZE: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN style="mso-list: Ignore">·<SPAN style="FONT: 7pt ''Times New Roman''">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN></SPAN></SPAN><SPAN style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">If the system finds no potential matches, you will&nbsp;be taken directly to Step 2.</SPAN></P>
<P style="TEXT-INDENT: -0.25in; MARGIN: 0in 0in 0pt 0.25in; mso-list: l0 level1 lfo1; tab-stops: list .25in" class=MsoNormal><SPAN style="FONT-FAMILY: Symbol; FONT-SIZE: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN style="mso-list: Ignore">·<SPAN style="FONT: 7pt ''Times New Roman''">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN></SPAN></SPAN><SPAN style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">If the system finds potential matches, the search results will display below.<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>If an accurate match appears,&nbsp;select&nbsp;and open that existing&nbsp;client record by clicking on that row.<SPAN style="mso-spacerun: yes">&nbsp; </SPAN><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></P>
<P style="TEXT-INDENT: -0.25in; MARGIN: 0in 0in 0pt 0.25in; mso-list: l0 level1 lfo1; tab-stops: list .25in" class=MsoNormal><SPAN style="FONT-FAMILY: Symbol; FONT-SIZE: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol"><SPAN style="mso-list: Ignore">·<SPAN style="FONT: 7pt ''Times New Roman''">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN></SPAN></SPAN><SPAN style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">If there are no accurate matches, click Next again to continue to Step 2 in adding a new client record.<SPAN style="mso-spacerun: yes">&nbsp; </SPAN></SPAN></P>',2,'Search Existing Clients','',NULL
UNION ALL SELECT 4317,2,'<div style="padding: 2px;">Complete the client''s identifying information. Name and social security number have associated data quality fields. Data quality fields are used to indicate the reason full information wasn''t collected. Name and social security number data quality fields allow users to indicate when a client doesn''t know or refuses to provide information. If the required data is collected then ClientTrack automatically records that full data quality was met. &nbsp;</div>',1,'Basic Client Information','Use the following guide for more information about race categories*:<BR>
<UL>
<LI><STRONG>American Indian or Alaska Native</STRONG> is a person having origins in any of the original peoples of North and South America, including Central America, and who maintains tribal affiliation or community attachment. </LI>
<LI><STRONG>Asian</STRONG> is a person having origins in any of the original peoples of the Far East, Southeast Asia or the Indian subcontinent including, for example, Cambodia, China, India, Japan, Korea, Malaysia, Pakistan, the Philippine Islands, Thailand and Vietnam.</LI>
<LI><STRONG>Black or African American</STRONG> is a person having origins in any of the black racial groups of Africa. Terms such as “Haitian” can be used in addition to “Black or African American.”</LI>
<LI><STRONG>Native Hawaiian or Other Pacific Islander</STRONG> is a person having origins in any of the original peoples of Hawaii, Guam, Samoa or other Pacific Islands.</LI>
<LI><STRONG>White</STRONG> is a person having origins in any of the original peoples of Europe, the Middle East or North Africa.</LI></UL>
<P><EM>*In the October 30, 1997 issue of the Federal Register (62 FR 58782), the Office of Management and Budget (OMB) published “Standards for Maintaining, Collecting, and Presenting Federal Data on Race and Ethnicity.” All existing federal recordkeeping and report requirements must be in compliance with these Standards as of January 1, 2003. </EM></P>',NULL;
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
SELECT 4299,4317,'cmClient','cmClient.ClientID',NULL,0,1,1,1,'cmClient',NULL;
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
SELECT 9482,4317,'cmClient','cmClient.FamilyAcct','cmFamilyAccFile','cmFamilyAccFile.FamilyAcctID','cmFamilyAccFile.FamilyAcctID',0,1,NULL,'cmFamilyAccFile',0,0,1,0,0,1,1,1,1,1,1,0,NULL,NULL;
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
SELECT 65,'cmComboBoxItem','Item','ItemDesc','Combobox','relationship','ComboboxGrp','CMFML',NULL,'relationship - CMFML'
UNION ALL SELECT 201,'cmComboBoxItem','item','itemDesc','Combobox','sbEthnic','ComboboxGrp','HMHOU',NULL,'sbEthnic - CMSCL'
UNION ALL SELECT 322,'cmComboBoxItem','item','itemDesc','Combobox','infoRelease','ComboboxGrp','CMCLN',NULL,'infoRelease - CMCLN'
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
SELECT 82136,4317,14,180,'Family','cmFamilyAccFile.familyName','cmClient.familyName',0,1,NULL,NULL,2,1,NULL,NULL,0,'HelpText=If%20the%20client%20is%20a%20member%20of%20an%20existing%20family%2C%20link%20the%20client%20to%20the%20family%20using%20the%20lookup.%20%20Otherwise%2C%20click%20Finish%20to%20automatically%20create%20a%20new%20family.',0,0
UNION ALL SELECT 82137,4317,15,195,'Information Release #','cmClient.infoReleaseNo','cmClient.infoReleaseNo',0,0,NULL,'DataSystems.Plugins.InlineSearchBox',2,1,NULL,'1',0,NULL,0,0
UNION ALL SELECT 82138,4317,3,200,'Begin Date','cmClient.infoReleaseDate','cmClient.infoReleaseDate',0,1,NULL,NULL,2,1,NULL,'@Date',0,'ValueIfBlank=1/1/1753',0,0
UNION ALL SELECT 82139,4317,24,215,'Security Restriction','cmClient.restrictOrg','cmClient.restrictOrg',0,0,322,'DataSystems.Plugins.InfoReleasePlugin',2,1,NULL,'X',0,NULL,0,0
UNION ALL SELECT 82140,4317,15,190,'Hidden - FamilyAcct','cmClient.familyAcct','cmClient.familyAcct',0,0,NULL,'',2,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 82141,4317,2,15,'Social Security Number','cmClient.SocSecNo',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82142,4317,1,5,'First Name','cmClient.firstName',NULL,0,1,NULL,NULL,1,1,150,NULL,0,NULL,0,0
UNION ALL SELECT 82143,4317,1,10,'Last Name','cmClient.lastName',NULL,0,1,NULL,NULL,1,1,150,NULL,0,NULL,0,0
UNION ALL SELECT 82144,4317,3,20,'Birth Date','cmClient.birthDate',NULL,0,1,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82145,4317,17,25,'Find Duplicate Client','cmClient.clientId',NULL,0,0,NULL,'NOSOUNDEX',1,1,NULL,NULL,0,'NoSoundex=1',0,0
UNION ALL SELECT 82146,4317,8,75,'Gender','cmClient.Gender','cmClient.Gender',1,1,3436,'You must provide a gender.',2,1,NULL,NULL,0,'HelpText=Gender%20should%20be%20assigned%20based%20on%20the%20client%u2019s%20self-perceived%20gender%20identity.%20Transgender%20is%20defined%20as%20identification%20with%2C%20or%20presentation%20as%2C%20a%20gender%20that%20is%20different%20from%20the%20gender%20at%20birth.',0,0
UNION ALL SELECT 82147,4317,1,10,'Last Name','cmClient.lastName','cmClient.lastName',1,1,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82148,4317,1,5,'First Name','cmClient.firstName','cmClient.firstName',1,1,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82149,4317,1,15,'Middle Name','cmClient.MiddleInitial','cmClient.MiddleInitial',0,1,NULL,'',2,1,100,'',0,NULL,0,0
UNION ALL SELECT 82150,4317,2,30,'Social Security Number','cmClient.socSecNo','cmClient.socSecNo',0,1,NULL,NULL,2,1,NULL,NULL,0,'HelpText=Enter%20a%20full%20or%20partial%20Social%20Security%20Number.%20If%20no%20SSN%2C%20select%20an%20answer%20for%20SSN%20Quality.',0,0
UNION ALL SELECT 82151,4317,3,45,'Birth Date','cmClient.birthdate','cmClient.birthdate',0,1,NULL,NULL,2,1,NULL,NULL,0,'HelpText=If%20an%20exact%20birth%20date%20is%20unknown%2C%20enter%20the%20first%20day%20of%20the%20month%20and/or%20year%20of%20birth.',0,0
UNION ALL SELECT 82152,4317,20,175,'Family Information','DATANULL',NULL,0,1,NULL,'Use this section to collect data about a client''s family. The Family search field allows you to search for and select an existing family account. This is appropriate when adding a family member to an existing family. ',2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82153,4317,15,35,'Hidden - ClientID','cmClient.ClientID',NULL,0,0,NULL,NULL,1,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82154,4317,8,185,'Relationship to Head of Household','cmClient.relationToFamilyHead','cmClient.relationToFamilyHead',1,1,65,NULL,2,1,NULL,'SL',0,'HelpText=Select%20the%20client%27s%20relationship%20to%20the%20family%27s%20head%20of%20household.&HiddenValues=EX%2COC%2CG%2CP%2CGP',0,0
UNION ALL SELECT 82155,4317,15,210,'Restrict Client Intake Except By MOU','cmClient.restrictIntake','cmClient.restrictIntake',0,0,NULL,'',2,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 82156,4317,3,205,'End Date','cmClient.infoReleaseEndDate','cmClient.infoReleaseEndDate',0,1,NULL,NULL,2,1,NULL,NULL,0,'ValueIfBlank=12/31/9999',0,0
UNION ALL SELECT 82157,4317,24,50,'Client Age','ClientAge',NULL,0,1,NULL,'DataSystems.Plugins.CalculateBirthDate',2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82158,4317,8,60,'Ethnicity','cmClient.HUDEthnicity','cmClient.HUDEthnicity',1,1,1141,NULL,2,1,NULL,NULL,0,'HelpText=Select%20Ethnicity%20based%20on%20whether%20or%20not%20the%20client%20identifies%20as%20Hispanic%20or%20Latino.%20The%20definition%20of%20Hispanic%20or%20Latino%20ethnicity%20is%20a%20person%20of%20Cuban%2C%20Mexican%2C%20Puerto%20Rican%2C%20South%20or%20Central%20American%20or%20other%20Spanish%20culture%20of%20origin%2C%20regardless%20of%20race.',0,0
UNION ALL SELECT 82159,4317,10,35,'SSN Quality','cmClient.SSNQuality','cmClient.SSNQuality',1,1,2529,NULL,2,1,NULL,'8',0,'HiddenValues=1%2C2',0,0
UNION ALL SELECT 82160,4317,1,20,'Suffix','cmClient.Suffix','cmClient.Suffix',0,1,NULL,'',2,1,30,'',0,NULL,0,0
UNION ALL SELECT 82161,4317,24,225,'After Save Validation','AfterSaveValidation','',0,0,NULL,'DataSystems.Plugins.AfterSaveValidation',2,1,NULL,'',0,NULL,0,0
UNION ALL SELECT 82162,4317,20,40,'Basic Client Demographics','DATANULL',NULL,0,1,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82163,4317,3,95,'Pregnancy Due Date','cmClient.pregDueDate','cmClient.pregDueDate',0,0,NULL,NULL,2,1,NULL,NULL,0,'HelpText=If%20Due%20Date%20is%20unknown%2C%20set%20to%20January%20first%20of%20current%20year%20%28per%20HMIS%20Data%20Dictionary%29',0,0
UNION ALL SELECT 82164,4317,24,220,'Auto Generate Family','DATANULL',NULL,0,1,NULL,'DataSystems.Plugins.AutoGenerateFamily',2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82165,4317,10,55,'Date of Birth Quality','cmClient.BirthDateQuality','cmClient.BirthDateQuality',1,1,2585,NULL,2,1,NULL,'8',0,NULL,0,0
UNION ALL SELECT 82166,4317,24,65,'Race','Race',NULL,1,1,2591,'DataSystems.Plugins.MultiSaveList',2,1,NULL,NULL,0,'ChildColumn=Race&NoSelectAll=1&ParentColumn=ClientID&ParentValue=@PrimaryKey@&TableName=ClientRace&HelpText=Select%20one%20or%20more%20categories%20for%20Race%20based%20on%20how%20the%20client%20self-identifies.%20Staff%20observations%20should%20not%20be%20used%20to%20collect%20information%20on%20race.%20Click%20on%20page%20help%20for%20additional%20information.',0,0
UNION ALL SELECT 82167,4317,24,30,'Entity Data','EntityData',NULL,0,1,NULL,'DataSystems.Plugins.EntityData',1,1,NULL,NULL,0,'Data=FirstName%3D@cmClient.FirstName@%26LastName%3D@cmClient.LastName@%26Birthdate%3D@cmClient.BirthDate@%26SocSecNo%3D@cmClient.SocSecNo@%26Name%3D@cmClient.LastName@%2C%20@cmClient.FirstName@',0,0
UNION ALL SELECT 82169,4317,8,110,'Veteran Status','cmClient.VeteranStatus','cmClient.VeteranStatus',1,1,2040,NULL,2,1,NULL,NULL,0,'HelpText=Excerpt%20from%20HMIS%20Data%20Standards%20Manual%3C/br%3E%3C/br%3E%20%22%3Ci%3EData%20Collection%20Instructions%3A%3C/i%3E%20Record%20whether%20or%20not%20the%20client%20is%20a%20veteran.%20Asking%20additional%20questions%20may%20result%20in%20more%20accurate%20information%20as%20some%20clients%20may%20not%20be%20aware%20that%20they%20are%20considered%20veterans.%20Examples%20include%3A%20%u201CHave%20you%20ever%20been%20on%20active%20duty%20in%20the%20military%3F%u201D%22%20%3C/br%3E%3C/br%3E%20%22%3Ci%3EResponse%20Category%20Descriptions%3A%3C/i%3E%20Respond%20%u201CYes%u201D%20to%20Veteran%20Status%20if%20the%20person%20is%20someone%20who%20has%20served%20on%20active%20duty%20in%20the%20armed%20forces%20of%20the%20United%20States.%20This%20does%20not%20include%20inactive%20military%20reserves%20or%20the%20National%20Guard%20unless%20the%20person%20was%20called%20up%20to%20active%20duty.%22',0,0
UNION ALL SELECT 82170,4317,8,25,'Name Quality','cmClient.NameQuality','cmClient.NameQuality',1,1,3019,NULL,2,1,NULL,'1',0,'HelpText=Response%20Category%20Descriptions%3A%0A%3C/br%3E%0A%3C/br%3E%0A%u201CFull%20name%20reported%u201D%20should%20be%20selected%20for%20Name%20Data%20Quality%20as%20long%20as%20complete%2C%20full%20first%20and%20last%20names%20have%20been%20recorded.%20%20To%20avoid%20duplicate%20record%20creation%2C%20the%20full%20first%20name%20should%20be%20used%20%28e.g.%2C%20James%20vs.%20Jim%29%20and%20the%20last%20name%20should%20be%20recorded%20as%20the%20individual%20has%20it%20recorded%20on%20their%20official%20legal%20documents%20%28driver%u2019s%20license%2C%20social%20security%20card%2C%20etc.%29%20%0A%3C/br%3E%0A%3C/br%3E%0ASelect%20%u201CPartial%2C%20street%20name%20or%20code%20name%20reported%u201D%20in%20the%20following%20circumstances%3A%20%201%29%20a%20partial%2C%20short%2C%20or%20nickname%20was%20used%20instead%20of%20the%20full%20first%20name%3B%202%29%20a%20street%20name%20or%20code%20name%20was%20used%20for%20street%20outreach%20clients%20at%20initial%20intake%20and%20until%20the%20client%20was%20able%20to%20supply%20their%20full%20legal%20name%3B%203%29%20a%20name%20modification%20was%20used%20for%20victims%20of%20domestic%20violence%20for%20security%20reasons%3B%20and%204%29%20for%20any%20other%20reason%20the%20name%20does%20not%20match%20the%20clients%20full%20name%20as%20it%20would%20appear%20on%20identification.%0A%3C/br%3E%0A%3C/br%3E%20%0ASelect%20%u201CClient%20doesn%u2019t%20know%u201D%20when%20client%20does%20not%20know%20their%20name.%20%20Use%20%u201CClient%20doesn%u2019t%20know%u201D%20vs.%20%u201CPartial%2C%20street%20name%20or%20code%20name%20reported%u201D%20if%20you%20entered%20a%20false%20name/made%20up%20name%20in%20order%20to%20create%20a%20record%20in%20the%20system%20solely%20because%20the%20client%20did%20not%20know%20or%20was%20unable%20to%20provide%20their%20name.%20%0A%3C/br%3E%0A%3C/br%3E%0ASelect%20%u201CClient%20refused%u201D%20when%20client%20refuses%20to%20provide%20their%20name.%20%20Use%20%u201CClient%20refused%u201D%20vs.%20%u201CPartial%20street%20name%20or%20code%20name%20reported%u201D%20if%20you%20entered%20a%20false%20name/made%20up%20name%20in%20order%20to%20create%20a%20record%20in%20the%20system%20solely%20because%20the%20client%20refused%20to%20tell%20you%20their%20name.%20',0,0
UNION ALL SELECT 82171,4317,20,120,'Contact Information','DATANULL',NULL,0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82172,4317,9,115,'Show Address and Contact Information','showcontact',NULL,0,1,NULL,NULL,2,1,NULL,'0',0,'IfChecked=1&IfUnchecked=0&HelpText=By%20defaulting%20address%20information%20is%20hidden.%20Use%20this%20checkbox%20to%20show%20address%20data%20fields%20in%20order%20to%20add%2C%20view%2C%20or%20edit%20a%20client%20address.',0,0
UNION ALL SELECT 82173,4317,1,125,'Address','cmClient.Address','cmClient.Address',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82174,4317,7,135,'City, State, Zip Code','cmClient.ZipCodeID','cmClient.ZipCodeID',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82175,4317,15,140,'City','cmClient.City','cmClient.City',0,1,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82176,4317,15,145,'State','cmClient.State','cmClient.State',0,1,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82177,4317,15,150,'Zip Code','cmClient.ZipCode','cmClient.ZipCode',0,1,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82178,4317,1,155,'Email','cmClient.Email','cmClient.Email',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82179,4317,6,160,'Home Phone','cmClient.HomePhone','cmClient.HomePhone',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82180,4317,6,165,'Work Phone','cmClient.WorkPhone','cmClient.WorkPhone',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82181,4317,6,170,'Msg Phone','cmClient.MsgPhone','cmClient.MsgPhone',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82182,4317,1,130,'Address 2','cmClient.Address2','cmClient.Address2',0,0,NULL,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82183,4317,8,90,'Pregnancy Status','cmClient.pregnancySt','cmClient.pregnancySt',0,0,1720,NULL,2,1,NULL,NULL,0,NULL,0,0
UNION ALL SELECT 82184,4317,8,100,'Sexual Orientation','cmClient.Orientation','cmClient.Orientation',0,1,2156,NULL,2,1,NULL,NULL,0,'HelpText=Any%20questions%20regarding%20a%20client%u2019s%20sexual%20orientation%20must%20be%20voluntary%20and%20clients%20must%20be%20informed%20prior%20to%20responding%20of%20the%20voluntary%20nature%20of%20the%20question%20and%20that%20their%20refusal%20to%20respond%20will%20not%20result%20in%20a%20denial%20of%20services',0,0
UNION ALL SELECT 82168,4317,8,105,'Disabling Condition','cmClient.DisablingCondition','cmClient.DisablingCondition',1,1,2040,NULL,2,1,NULL,NULL,1,'HelpText=Excerpt%20from%20HMIS%20Data%20Standards%20Manual%20%3C/br%3E%3C/br%3E%20Data%20Collection%20Instructions%3A%20Record%20whether%20the%20client%20has%20a%20disabling%20condition%20based%20on%20one%20or%20more%20of%20the%20following%3A%3C/br%3E%0A%3Cul%3E%0A%3Cli%3EA%20physical%2C%20mental%2C%20or%20emotional%20impairment%2C%20including%20an%20impairment%20caused%20by%20alcohol%20or%20drug%20abuse%2C%20post-traumatic%20stress%20disorder%2C%20or%20brain%20injury%20that%3A%0A%3Cul%3E%0A%3Cli%3E%281%29%20Is%20expected%20to%20be%20long-continuing%20or%20of%20indefinite%20duration%3B%3C/li%3E%0A%3Cli%3E%282%29%20Substantially%20impedes%20the%20individual%27s%20ability%20to%20live%20independently%3B%20and%3C/li%3E%0A%3Cli%3E%283%29%20Could%20be%20improved%20by%20the%20provision%20of%20more%20suitable%20housing%20conditions.%3C/li%3E%0A%3C/li%3E%0A%3C/ul%3E%0A%3Cli%3EA%20developmental%20disability%2C%20as%20defined%20in%20section%20102%20of%20the%20Developmental%20Disabilities%20Assistance%20and%20Bill%20of%20Rights%20Act%20of%202000%20%2842%20U.S.C.%2015002%29%3B%20or%3C/li%3E%0A%3Cli%3E%20The%20disease%20of%20acquired%20immunodeficiency%20syndrome%20%28AIDS%29%20or%20any%20condition%20arising%20from%20the%20etiologic%20agency%20for%20acquired%20immunodeficiency%20syndrome%20%28HIV%29.%20%3C/li%3E%0A%3C/ul%3EAdditionally%20for%20veterans%20note%3A%20if%20the%20client%20is%20a%20veteran%20who%20is%20disabled%20by%20an%20injury%20or%20illness%20that%20was%20incurred%20or%20aggravated%20during%20active%20military%20service%20and%20whose%20disability%20meets%20the%20disability%20definition%20defined%20in%20Section%20223%20of%20the%20social%20security%20act.',0,0
UNION ALL SELECT 82185,4317,1,40,'Continuum ID','cmClient.AltRefID1','cmClient.AltRefID1',0,1,NULL,NULL,1,1,NULL,NULL,1,NULL,0,0
UNION ALL SELECT 82186,4317,1,45,'AltRefID2','cmClient.AltRefID2','cmClient.AltRefID2',0,1,NULL,NULL,1,1,NULL,NULL,1,NULL,0,0
UNION ALL SELECT 82187,4317,8,70,'Race','cmClient.HUDRace','cmClient.HUDRace',1,1,201,'',2,1,NULL,'',1,NULL,0,0
UNION ALL SELECT 82188,4317,1,80,'If other, specify','cmClient.OtherGender','cmClient.OtherGender',0,0,NULL,NULL,2,1,NULL,NULL,1,'HelpText=%3Ci%3EExcerpt%20from%20the%20HUD%20Data%20Standards%20Manual%3C/i%3E%20%u201COther%u201D%20may%20include%20intersex%20individuals%20or%20persons%20who%20prefer%20not%20to%20identify%20a%20specific%20gender.',0,0;
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
SELECT 22790,82136,0,'EXEC vdefault_cmClient_Relationship @cmClient.FamilyAcct@,@cmClient.RelationToFamilyHead@,@cmClient.Birthdate@,@cmClient.Gender@',1,0,1,0,3
UNION ALL SELECT 22791,82137,0,'@cmClient.infoReleaseNo@  ==" "',1,1,1,0,3
UNION ALL SELECT 22792,82139,0,'EXEC v_RestrictOrg "cmClient","ClientID",@cmClient.ClientID@,@userid@,@orgid@,@cmClient.RestrictOrg@',1,0,1,0,3
UNION ALL SELECT 22793,82143,0,'@cmClient.lastName@  !=" "',0,1,1,0,3
UNION ALL SELECT 22794,82145,0,'@cmClient.clientId@  !=" "',0,1,1,0,3
UNION ALL SELECT 22795,82150,0,'EXEC vdefault_SSNQuality @cmClient.SocSecNo@,@cmClient.SSNQuality@,"cmClient"',1,1,1,0,3
UNION ALL SELECT 22796,82151,0,'EXEC v_Unborn @cmClient.BirthDate@,"Birth date cannot be in the future%2C please use the health assessment to track pregnancy status."',1,1,1,0,3
UNION ALL SELECT 22797,82161,0,'EXEC v_UniqueID "cmClient","AltRefID2","ClientID",@PrimaryKey@,"0"',1,1,1,0,3
UNION ALL SELECT 22798,82146,0,'@cmClient.Gender@ == ''1''',1,1,1,1,3
UNION ALL SELECT 22799,82151,0,'((@cmClient.BirthDate@ != '''') && ((@cmClient.BirthdateQuality@ == 8) || ((@cmClient.BirthdateQuality@ == 9) || (@cmClient.BirthDateQuality@ == 99))))',1,1,1,0,3
UNION ALL SELECT 22800,82165,0,'((@cmClient.BirthDateQuality@ == 8) || ((@cmClient.BirthDateQuality@ == 9) || (@cmClient.BirthDateQuality@ == 99)))',1,1,1,0,3
UNION ALL SELECT 22801,82144,0,'((@cmClient.BirthDate@ != '''') && ((@cmClient.BirthdateQuality@ == 8) || ((@cmClient.BirthdateQuality@ == 9) || (@cmClient.BirthDateQuality@ == 99))))',1,1,1,0,3
UNION ALL SELECT 22802,82141,0,'('''' + @cmClient.SocSecNo@).length == 11 && ('''' + @cmClient.SocSecNo@).indexOf( ''?'' ) == -1',1,1,1,0,3
UNION ALL SELECT 22803,82141,0,'(!!(@cmClient.SocSecNo@).match(/\d/)) && ((''''+@cmClient.SocSecNo@).length < 11 || (''''+@cmClient.SocSecNo@).indexOf(''?'') != -1)',1,1,1,0,3
UNION ALL SELECT 22804,82154,0,'EXEC v_SingleHeadofHousehold @cmClient.FamilyAcct@,@PrimaryKey@,@cmClient.RelationToFamilyHead@,@Date@',1,1,1,0,3
UNION ALL SELECT 22805,82172,0,'@showcontact@ == 1',1,1,1,0,3
UNION ALL SELECT 22806,82147,0,'(((@cmClient.firstName@ != '''') && (@cmClient.firstName@ != ''Anonymous'')) && ((@cmClient.lastName@ != '''') && (@cmClient.NameQuality@ == '''')))',1,1,1,0,3
UNION ALL SELECT 22807,82170,0,'@cmClient.NameQuality@ == ''1''',1,1,1,0,3
UNION ALL SELECT 22808,82159,0,'@cmClient.SSNQuality@ == ''99''',1,1,1,0,3
UNION ALL SELECT 22809,82170,0,'@cmClient.NameQuality@ == ''99''',1,1,1,0,3
UNION ALL SELECT 22810,82144,0,'@cmClient.birthdate@ < @DateAdd( y, -18)@',1,1,1,1,3
UNION ALL SELECT 22811,82151,0,'(@cmClient.birthdate@ < @DateAdd( y, -18)@)',1,1,1,1,3
UNION ALL SELECT 22812,82144,0,'@cmClient.birthDate@ <= @DateAdd(y,-18)@',1,1,1,0,3
UNION ALL SELECT 22813,82151,0,'@cmClient.birthdate@ <= @DateAdd(y,-18)@',1,1,1,0,3
UNION ALL SELECT 22814,82146,0,'((@cmClient.pregnancySt@ != '''' || @GrantTypeID@ == ''RHY'') && (@cmClient.Gender@ == 1 && @cmClient.Birthdate@ <= @DateAdd( y, -12)@))',1,1,1,0,3
UNION ALL SELECT 22815,82183,0,'@cmClient.pregnancySt@ == ''Y''',1,1,1,0,3
UNION ALL SELECT 22816,82144,0,'((@cmClient.Orientation@ != '''') || (@GrantTypeID@ == ''RHY''))',1,1,1,0,3
UNION ALL SELECT 22817,82146,0,'(@cmClient.Gender@ == 1 && @cmClient.birthdate@ <= @DateAdd( y, -12)@)',1,1,1,0,3;
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
SELECT 22790,56431,82154,0,'Required=True,Error=You must specify a relationship to the household''s head.,',1,1
UNION ALL SELECT 22791,56432,82138,0,'Value=Null,',1,1
UNION ALL SELECT 22793,56433,82143,0,'Required=false,',1,1
UNION ALL SELECT 22793,56434,82143,0,'Required=True,Visible=True',0,1
UNION ALL SELECT 22794,56435,82142,0,'Required=false,',1,1
UNION ALL SELECT 22794,56436,82142,0,'Required=False,Visible=True',0,1
UNION ALL SELECT 22795,56437,82159,0,'Visible=false,',1,1
UNION ALL SELECT 22795,56438,82159,0,'Required=True,Visible=True',0,1
UNION ALL SELECT 22799,56439,82165,0,'value=1,',1,1
UNION ALL SELECT 22800,56440,82151,0,'required=false,',1,1
UNION ALL SELECT 22800,56441,82151,0,'required=true,',0,1
UNION ALL SELECT 22801,56442,82165,0,'value=1,',1,1
UNION ALL SELECT 22802,56443,82159,0,'visible=false,value=1,',1,1
UNION ALL SELECT 22803,56444,82159,0,'visible=false,value=2,',1,1
UNION ALL SELECT 22805,56445,82171,0,'visible=true',1,1
UNION ALL SELECT 22805,56446,82173,0,'visible=true',1,1
UNION ALL SELECT 22805,56447,82182,0,'visible=true',1,1
UNION ALL SELECT 22805,56448,82174,0,'visible=true',1,1
UNION ALL SELECT 22805,56449,82178,0,'visible=true',1,1
UNION ALL SELECT 22805,56450,82179,0,'visible=true',1,1
UNION ALL SELECT 22805,56451,82180,0,'visible=true',1,1
UNION ALL SELECT 22805,56452,82181,0,'visible=true',1,1
UNION ALL SELECT 22805,56453,82171,0,'visible=false',0,1
UNION ALL SELECT 22805,56454,82173,0,'visible=false',0,1
UNION ALL SELECT 22805,56455,82182,0,'visible=false',0,1
UNION ALL SELECT 22805,56456,82174,0,'visible=false',0,1
UNION ALL SELECT 22805,56457,82178,0,'visible=false',0,1
UNION ALL SELECT 22805,56458,82179,0,'visible=false',0,1
UNION ALL SELECT 22805,56459,82180,0,'visible=false',0,1
UNION ALL SELECT 22805,56460,82181,0,'visible=false',0,1
UNION ALL SELECT 22806,56461,82170,0,'value=1',1,1
UNION ALL SELECT 22807,56462,82148,0,'required=true',1,1
UNION ALL SELECT 22807,56463,82147,0,'required=true',1,1
UNION ALL SELECT 22807,56464,82148,0,'required=false',0,1
UNION ALL SELECT 22807,56465,82147,0,'required=false',0,1
UNION ALL SELECT 22808,56466,82150,0,'visible=false,value=**BLANK**',1,1
UNION ALL SELECT 22808,56467,82150,0,'visible=true',0,1
UNION ALL SELECT 22809,56468,82148,0,'visible=true',0,1
UNION ALL SELECT 22809,56469,82147,0,'visible=true',0,1
UNION ALL SELECT 22809,56470,82149,0,'visible=true',0,1
UNION ALL SELECT 22809,56471,82160,0,'visible=true',0,1
UNION ALL SELECT 22809,56472,82148,0,'visible=false,value=**BLANK**',1,1
UNION ALL SELECT 22809,56473,82147,0,'visible=false,value=**BLANK**',1,1
UNION ALL SELECT 22809,56474,82149,0,'visible=false,value=**BLANK**',1,1
UNION ALL SELECT 22809,56475,82160,0,'visible=false,value=**BLANK**',1,1
UNION ALL SELECT 22812,56476,82169,0,'visible=true,required=true',1,1
UNION ALL SELECT 22812,56477,82169,0,'visible=false,required=false,value=**BLANK**',0,1
UNION ALL SELECT 22813,56478,82169,0,'visible=true,required=true',1,1
UNION ALL SELECT 22813,56479,82169,0,'visible=false,required=false,value=**BLANK**',0,1
UNION ALL SELECT 22814,56480,82183,0,'required=true',1,0
UNION ALL SELECT 22814,56481,82183,0,'required=false',0,1
UNION ALL SELECT 22815,56482,82163,0,'visible=true,required=true',1,1
UNION ALL SELECT 22815,56483,82163,0,'visible=false,required=false,value=**BLANK**',0,1
UNION ALL SELECT 22816,56484,82184,0,'required=true',1,1
UNION ALL SELECT 22816,56485,82184,0,'required=false',0,1
UNION ALL SELECT 22817,56486,82183,0,'visible=true',1,0
UNION ALL SELECT 22817,56487,82183,0,'visible=false',0,1;
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
SELECT 8344,82136,100,'familyAcctId','cmClient.familyAcct','&LastName=@cmClient.LastName@&FirstName=@cmClient.FirstName@&Birthdate=@cmClient.Birthdate@',0
UNION ALL SELECT 8345,82136,100,'familyName','cmFamilyAccFile.familyName',NULL,0
UNION ALL SELECT 8346,82136,100,'address1','cmClient.Address',NULL,0
UNION ALL SELECT 8347,82136,100,'address2','cmClient.Address2',NULL,0
UNION ALL SELECT 8348,82136,100,'city','cmClient.City',NULL,0
UNION ALL SELECT 8349,82136,100,'state','cmClient.State',NULL,0
UNION ALL SELECT 8350,82136,100,'zipCodeId','cmClient.ZipCodeID',NULL,0
UNION ALL SELECT 8351,82136,100,'ZipCode','cmClient.ZipCode',NULL,0
UNION ALL SELECT 8352,82136,100,'homePhone','cmClient.HomePhone',NULL,0
UNION ALL SELECT 8353,82137,103,'infoReleaseNo','cmClient.infoReleaseNo',NULL,0;
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
UNION ALL SELECT 'CMCLN','infoRelease','R','Restrict To Organization',1,NULL,NULL,'A',NULL
UNION ALL SELECT 'CMCLN','infoRelease','U','Restrict To User',2,NULL,NULL,'A',NULL
UNION ALL SELECT 'CMCLN','infoRelease','X','Restrict to MOU/Info Release',3,NULL,NULL,'A',NULL
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
UNION ALL SELECT 'HMHOU','sbEthnic','A','American Indian/Alaskan Native',2,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','B','Asian',3,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','C','Black/African American',4,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','D','Native Hawaiian/Pac Islander',5,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','E','White',6,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','F','Amer Indian/Alaskan Native & White',7,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','G','Asian and White',8,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','H','Black or African Amer & White',9,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','I','Amer Indian/Alask Native & Black',10,NULL,NULL,'A',NULL
UNION ALL SELECT 'HMHOU','sbEthnic','J','Other/Balance',11,NULL,NULL,'A',NULL
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
FROM (SELECT '#AutoGenerateFamily' AS HashTag
UNION ALL SELECT '#clientcontactinformation' AS HashTag
UNION ALL SELECT '#clientdemographics' AS HashTag
UNION ALL SELECT '#compliance' AS HashTag
UNION ALL SELECT '#defaultandhide' AS HashTag
UNION ALL SELECT '#familyaccount' AS HashTag
UNION ALL SELECT '#HMIS' AS HashTag
UNION ALL SELECT '#informationrelease' AS HashTag
UNION ALL SELECT '#plugin' AS HashTag
UNION ALL SELECT '#complianceassuranceengine' AS HashTag
UNION ALL SELECT '#HMIS2014' AS HashTag
) Z
WHERE NOT EXISTS(SELECT * FROM HashTag H WHERE H.HashTag = Z.HashTag);

MERGE INTO HashTagLink T
USING(VALUES('#AutoGenerateFamily','A'),
('#clientcontactinformation','A'),
('#clientdemographics','A'),
('#compliance','A'),
('#defaultandhide','A'),
('#familyaccount','A'),
('#HMIS','A'),
('#informationrelease','A'),
('#plugin','A'),
('#complianceassuranceengine','D'),
('#HMIS2014','D')) S(HashTag, ActiveStatus)
ON T.HashTag = S.HashTag
  AND T.LinkTable='DynamicForm'
  AND T.LinkColumn='FormID'
  AND T.LinkID=4317
WHEN MATCHED THEN
	UPDATE
	SET ActiveStatus = S.ActiveStatus
WHEN NOT MATCHED BY TARGET THEN
	INSERT(HashTag, LinkTable, LinkColumn, LinkID, ActiveStatus)
	VALUES(S.HashTag, 'DynamicForm', 'FormID', 4317, S.ActiveStatus)
WHEN NOT MATCHED BY SOURCE AND T.LinkTable='DynamicForm' AND T.LinkColumn='FormID' AND T.LinkID=4317 THEN
	DELETE;
