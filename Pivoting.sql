--USE _CTN_Dev
--GO

--DECLARE @StartDate DATETIME = '1/1/1900'
--DECLARE @EndDate DATETIME = '10/1/2016'
--DECLARE @PIT DATETIME = '10/1/2016'
--SELECT * FROM dbo.HMIS_ISChronicHomeless_PIT_v5_fn(@StartDate,@EndDate,@PIT, NULL)
--WHERE ClientID IN (410739,410738,410737)

	


USE tempdb;
GO
IF object_id('#PhoneNumbers') IS NOT NULL DROP TABLE #PhoneNumbers;
GO
--CREATE TABLE #PhoneNumbers (
--	PersonID int, 
--	HomePhone varchar(12),
--	CellPhone varchar(12), 
--	Workphone varchar(12), 
--	FaxNumber varchar(12));

--INSERT INTO #PhoneNumbers VALUES 
--	(1,Null,'444-555-2931',Null,Null),
--	(2,'444-555-1950','444-555-2931',Null, Null),
--	(3,'444-555-1950', Null,'444-555-1324','444-555-2310'),
--	(4,'444-555-1950','444-555-2931','444-555-1324',
--        '444-555-1987');

--SELECT * FROM #PhoneNumbers pn

--SELECT PersonID, PhoneType, PhoneNumber
--FROM (SELECT pn.PersonID, pn.HomePhone, pn.CellPhone, pn.Workphone, pn.FaxNumber 
--FROM #PhoneNumbers pn) AS src
--UNPIVOT (
--	PhoneNumber FOR PhoneType IN (HomePhone, CellPhone, WorkPhone, FaxNumber )) unpvt


IF object_id('#CustPref') IS NOT NULL DROP TABLE #CustPref;
GO
CREATE TABLE #CustPref(CustID int identity, CustName varchar(20), 
             Pref1Type varchar(20),  Pref1Data varchar(100),
             Pref2Type varchar(20),  Pref2Data varchar(100),
			Pref3Type varchar(20),  Pref3Data varchar(100),
			 Pref4Type varchar(20),  Pref4Data varchar(100),
			 );
GO
INSERT INTO #CustPref (CustName, Pref1Type, Pref1Data,
                                Pref2Type, Pref2Data, 
                                Pref3Type, Pref3Data,
                                Pref4Type, Pref4Data)
VALUES 
	('David Smith','Pool', 'Yes',
	              'Children', 'Yes',
				  'Bed', 'King',
				  'Pets', 'No'),
	('Randy Johnson','Vehicle', 'Convertible',
	              'PriceRange', '$$$',
				  null, null,
				  null, null),
	('Dr. John Fluke','Email', 'DrJ@Pain.com',
	              'Office Phone', '555-444-9845',
				  'Emergency Phone', '555-444-9846',
				  null,null);
--SELECT * FROM #CustPref;

SELECT 
CustID, 
CustName, 
 prefvalues,PrefTypes,
PrefType 
,PrefValue 
FROM (
SELECT cp.CustID, cp.CustName, cp.Pref1Type, cp.Pref1Data, cp.Pref2Type, cp.Pref2Data, cp.Pref3Type, cp.Pref3Data, cp.Pref4Type, cp.Pref4Data FROM #CustPref cp) src
UNPIVOT 
(PrefValue FOR PrefValues IN (Pref1Data,Pref2Data,Pref3Data,Pref4Data)) UP1
UNPIVOT 
(PrefType FOR PrefTypes IN (Pref1Type, Pref2Type, Pref3Type, Pref4Type)) UP2
WHERE SUBSTRING(prefvalues,5,1) = SUBSTRING(PrefTypes,5,1)
