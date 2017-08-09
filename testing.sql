USE [TwoTenFoundation_Train]
GO
/****** Object:  StoredProcedure [report].[ClientsInPrograms]    Script Date: 08/05/14 11:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jane
-- Create date: ?
-- Description:	Gets the data for the Clients in Programs report.
--Jane April 19, 2007 (NOLOCK)
--Jane add cmClient and Enrollment tables restriction 11/1/06
-- =============================================
ALTER PROCEDURE [report].[ClientsInPrograms]
	@BeginDate		DATETIME = '1/1/2011',
    @EndDate		DATETIME = '7/1/2011',
    @OrgList 		VARCHAR(max) = 'DSI',
	@ProgramList	VARCHAR(max) = '*',--'0,17915,17920,17914,17921,17922',
	@GrantList		VARCHAR(max) = '*',
	@UserList		VARCHAR(max) = '*',
    @HeadHousehold	BIT = 0,
	@ProgramsDrill	INT = -1,
	@Type			CHAR(1) = 'D',
	@FilterByAge	BIT = 0,
	@MinAge			INT = 0,
	@MaxAge			INT = 200,
	@ctUserID		CHAR(3) = 'DSI',
	@ctOrg			CHAR(3) = 'DSI'
AS

DECLARE @LogID INT;

EXEC @LogID = Report_LogBegin
	@ReportName = 'Clients in Programs',
	@UserID = @ctUserID,
	@BeginDate = @BeginDate,
	@EndDate = @EndDate,
	@OrgList = @OrgList,
	@ProgramList = @ProgramList,
	@GrantList = @GrantList,
	@UserList = @UserList,
	@Boolean1 = @HeadHousehold,
	@Int1 = @ProgramsDrill,
	@Param1 = @Type,
	@Int2 = @MinAge,
	@Int3 = @MaxAge;

DECLARE	@Date	DATETIME = GETDATE();

DECLARE @Users	TABLE
(
	UserID	CHAR(3)
);
INSERT INTO @Users(UserID)
SELECT UserID
FROM dbo.UserList(@CTUserID, @Date);

SELECT DISTINCT
	O.Organization, 
	ISNULL(P.ProgramName, 'No Program On Enrollment') ProgramName,
	C.[Name], 
	'XXX-XX-' + RIGHT(c.SocSecNo, 4) SocSecNo, 	
	Gender.ItemDesc AS GenderDesc, 
	CC.RaceDesc,
	--CONVERT(VARCHAR, (
	dbo.Age(C.BirthDate, E.EnrollDate) AS Age,
	E.EnrollDate, E.ExitDate, 
	DATEDIFF(day, dbo.MaxDate(E.EnrollDate, @BeginDate), dbo.MinDate(E.ExitDate, @EndDate)) + 1 AS DaysEnrolled,
	DATEDIFF(DAY, E.EnrollDate, E.ExitDate) LenthofStay,
	CASE WHEN E.EnrollDate > @BeginDate THEN 1 ELSE 0 END Enrolled,
	/*SELECT 1
	FROM Enrollment E
	INNER JOIN EnrollmentCase EC ON E.CaseID = EC.CaseID
	WHERE E.ClientID = */
	CASE WHEN (E.ExitDate IS NULL OR E.ExitDate > @EndDate) AND C.ClientID IS NOT NULL THEN 1 ELSE 0 END AS StillEnrolled,
	CASE WHEN E.ExitDate IS NULL OR E.ExitDate > @EndDate THEN 0 ELSE 1 END AS Exited,
	E.EnrollID,
	ISNULL(P.ProgramID, 0) ProgramID,
	ISNULL(C.ClientID, -1) ClientID,
	ExitReason.ItemDesc ExitReason,
	ExitDestination.ItemDesc ExitDestination,
	E.CaseID
FROM Enrollment E (NOLOCK) 
INNER JOIN cmClient C (NOLOCK) ON E.ClientID = C.ClientID
INNER JOIN osOrganization O (NOLOCK) ON O.OrgID = E.OrgID
LEFT OUTER JOIN (EnrollmentCase EC (NOLOCK) 
	INNER JOIN Programs P (NOLOCK) ON EC.ProgramID = P.ProgramID
	  AND P.ActiveStatus <>  'D'
) ON E.CaseID = EC.CaseID
LEFT OUTER JOIN cmProgFund PF (NOLOCK) ON PF.GrantID = EC.GrantID
  AND PF.ActiveStatus <>  'D'
LEFT OUTER JOIN cmCaseAssign CA (NOLOCK) ON E.ClntCaseID = CA.ClntCaseID
  AND CA.ActiveStatus <>  'D'
LEFT OUTER JOIN osUsers U (NOLOCK) ON CA.UserID = U.UserID
  AND U.ActiveStatus <>  'D'
LEFT OUTER JOIN dbo.ComboboxList( 'CMCSM', 'Gender' ) Gender ON C.Gender = Gender.Item
LEFT OUTER JOIN ClientCalculations CC (NOLOCK) ON C.ClientID = CC.ClientID
LEFT OUTER JOIN dbo.ComboboxList( 'Enrollment','ExitReason' ) ExitReason ON E.ExitReason = ExitReason.Item
LEFT OUTER JOIN dbo.ComboboxList( 'HUDExit','HMISDestination' ) ExitDestination ON E.ExitDestination = ExitDestination.Item
WHERE E.ActiveStatus =  'A'
  AND C.ActiveStatus <>  'D'
  AND ((@Type = 'E' AND E.EnrollDate BETWEEN @BeginDate AND @EndDate)
   OR (@Type = 'X' AND E.ExitDate BETWEEN @BeginDate AND @EndDate)
   OR (@Type = 'D' 
  AND E.EnrollDate <= @EndDate
  AND ISNULL(E.ExitDate, @EndDate) >= @BeginDate))
/*AND E.EnrollID = (SELECT TOP 1 EnrollID
FROM Enrollment
WHERE ClientID = E.ClientID
AND ActiveStatus <> 'D'
ORDER BY EnrollDate DESC)*/
  AND O.OrgID IN (SELECT Value FROM dbo.Split(@OrgList, ',' ))
  AND (@ProgramList = '*' OR ISNULL(P.ProgramID, 0) IN (SELECT Value FROM dbo.Split(@ProgramList, ',')))
  AND (@ProgramsDrill = -1 OR ISNULL(P.ProgramID, 0) = @ProgramsDrill)
  AND (@GrantList = '*' OR EC.GrantID IN (SELECT Value FROM dbo.Split(@GrantList, ',')))
  AND (@UserList = '*' OR CA.UserID IN (SELECT Value FROM dbo.Split(@UserList, ',')))
  AND (@HeadHousehold = 0
   OR (@HeadHousehold = 1
  AND C.RelationToFamilyHead = 'SL'))
  AND (@FilterByAge = 0
   OR (@FilterByAge = 1
  AND C.Birthdate BETWEEN DATEADD(YEAR, -@MaxAge, E.EnrollDate) AND DATEADD(YEAR, -@MinAge, E.EnrollDate)))

-- Client Restriction
  AND (C.RestrictIntake = 0
   OR (C.CreatedBy IN (SELECT UserID FROM @Users)
   OR (C.RestrictOrg <> 'U'
  AND (C.OrgID = @ctOrg
   OR (C.RestrictOrg <> 'R'
  AND (C.OrgID IN (SELECT OrgID
	FROM osInfoRelAccess (NOLOCK)
	WHERE InfoReleaseNo = C.InfoReleaseNo
	  AND @Date BETWEEN C.InfoReleaseDate AND C.InfoReleaseEndDate
	  AND AccessOrgID = @ctOrg
	  AND ActiveStatus <> 'D'
UNION ALL
	SELECT GrantingOrgID
	FROM cmInfoRelease  (NOLOCK)
	WHERE ClientID = C.ClientID
	  AND @Date BETWEEN GrantedDate AND EndDate
	  AND GrantToOrg = @ctOrg
	  AND ActiveStatus <> 'D')))))))
-- Enrollment Restriction
  AND (E.CreatedBy IN (SELECT UserID FROM @Users)
   OR (E.RestrictOrg <> 'U'
  AND (E.OrgID = @ctOrg
   OR (E.RestrictOrg <> 'R'
  AND (E.OrgID IN (SELECT OrgID
	FROM osInfoRelAccess (NOLOCK)
	WHERE InfoReleaseNo = C.InfoReleaseNo
	  AND @Date BETWEEN C.InfoReleaseDate AND C.InfoReleaseEndDate
	  AND AccessOrgID = @ctOrg
	  AND ActiveStatus <> 'D'
UNION ALL
	SELECT GrantingOrgID
	FROM cmInfoRelease (NOLOCK)
	WHERE ClientID = C.ClientID
	  AND @Date BETWEEN GrantedDate AND EndDate
	  AND GrantToOrg = @ctOrg
	  AND ActiveStatus <> 'D'))))))

--and C.name = 'Caller, Hotline'
ORDER BY
	O.Organization, 
	ProgramName, 
	ProgramID,
	C.[Name], 
	'XXX-XX-' + RIGHT(c.SocSecNo,4),  
	ClientID, 
	GenderDesc, 
	RaceDesc,
	E.EnrollDate,
	E.ExitDate, 
	DaysEnrolled,	
	StillEnrolled,
	Exited;

EXEC Report_LogEnd @LogID;













