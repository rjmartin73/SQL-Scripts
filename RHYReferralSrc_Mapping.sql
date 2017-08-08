USE [_CTN_Dev];
GO

--SELECT   *
--FROM     [dbo].[cmComboBoxItem] [ccbi]
--WHERE    [ccbi].[ComboboxGrp] = 'HMIS2016'
--         AND [ccbi].[Combobox] = 'RHYReferralSource'
--ORDER BY CAST([ccbi].[Item] AS INT);

GOTO cleanup

BEGIN TRANSACTION [RHYRefSrc];

UPDATE cmComboBoxItem SET ItemDesc = 'Self-Referral' WHERE Item = '1' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'Individual: Parent/Guardian/Relative/Friend/Foster Parent/Other Individual' WHERE Item = '2' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '3'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '4'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '5'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '6'
UPDATE cmComboBoxItem SET ItemDesc = 'Outreach Project ' WHERE Item = '7' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'Client doesn’t know' WHERE Item = '8' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'Client refused' WHERE Item = '9' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '10'
UPDATE cmComboBoxItem SET ItemDesc = 'Temporary Shelter' WHERE Item = '11' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '12'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '13'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '14'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '15'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '16'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '17'
UPDATE cmComboBoxItem SET ItemDesc = 'Residential Project:' WHERE Item = '18' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '19'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '20'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '21'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '22'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '23'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '24'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '25'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '26'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '27'
UPDATE cmComboBoxItem SET ItemDesc = 'Hotline: ' WHERE Item = '28' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '29'
UPDATE cmComboBoxItem SET ItemDesc = 'Child Welfare/CPS' WHERE Item = '30' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '31'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '32'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '33'
UPDATE cmComboBoxItem SET ItemDesc = 'Juvenile Justice' WHERE Item = '34' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'Law Enforcement/ Police' WHERE Item = '35' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ActiveStatus = 'D' WHERE [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource' AND Item = '36'
UPDATE cmComboBoxItem SET ItemDesc = 'Mental Hospital' WHERE Item = '37' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'School' WHERE Item = '38' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'Other Organization' WHERE Item = '39' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'
UPDATE cmComboBoxItem SET ItemDesc = 'Data not collected' WHERE Item = '99' AND [ComboboxGrp] = 'HMIS2016' AND [Combobox] = 'RHYReferralSource'

COMMIT TRAN [RHYRefSrc]
GOTO cleanup

BEGIN TRANSACTION RefSrcMap

UPDATE [ra]
SET    [ra].[ReferralSource] = CASE [ra].[ReferralSource]
                                   WHEN 3
                                       THEN 2
                                   WHEN 4
                                       THEN 2
                                   WHEN 5
                                       THEN 2
                                   WHEN 6
                                       THEN 2
                                   WHEN 10
                                       THEN 7
                                   WHEN 12
                                       THEN 11
                                   WHEN 13
                                       THEN 11
                                   WHEN 14
                                       THEN 11
                                   WHEN 15
                                       THEN 11
                                   WHEN 16
                                       THEN 11
                                   WHEN 17
                                       THEN 11
                                   WHEN 19
                                       THEN 18
                                   WHEN 20
                                       THEN 18
                                   WHEN 21
                                       THEN 18
                                   WHEN 22
                                       THEN 18
                                   WHEN 23
                                       THEN 18
                                   WHEN 24
                                       THEN 18
                                   WHEN 25
                                       THEN 18
                                   WHEN 26
                                       THEN 18
                                   WHEN 27
                                       THEN 18
                                   WHEN 29
                                       THEN 28
                                   WHEN 30
                                       THEN 30
                                   WHEN 31
                                       THEN 30
                                   WHEN 32
                                       THEN 30
                                   WHEN 33
                                       THEN 39
                                   WHEN 36
                                       THEN 39
                               END
FROM   [dbo].[RHYAssessment] [ra]
WHERE [ra].[ReferralSource] IS NOT NULL AND [ra].[ActiveStatus] <> 'D'




Cleanup:

DECLARE @Assessment_ProgramID@ INT = 19630
		,@wf_programid@ INT
		,@HousingRoom_HousingID@  INT = 192
		,@PrimaryKey@ INT = 192

SELECT * FROM [dbo].[DynamicFormListItemType] [dflit]
WHERE [dflit].[ListItemTypeID] = 3216

SELECT 3447 AS ListItemTypeID, C.CoCID AS ListItemKey, C.Number+' - '+C.Name AS ListItemLabel 
FROM  [dbo].[ProgramCOC] [pc] 
INNER JOIN HMIS_CoC_list C ON [C].[CoCID] = [pc].[COCID]
INNER JOIN [dbo].[HousingFacility] [hf] ON [hf].[ProgramID] = [pc].[ProgramID]
WHERE [hf].[HousingID] = @PrimaryKey@ 
AND [pc].[ActiveStatus] != 'D'

SELECT TOP 1 * FROM [dbo].[HousingRoom] [hr]




