UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(AMIAssessID),0) + 1 FROM AMIAssessment)
WHERE TableName = 'AMIAssessment'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(ClientSeq),0) + 1 FROM cmAddictionHealth)
WHERE TableName = 'cmAddictionHealth'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(AddressID),0) + 1 FROM cmAddress)
WHERE TableName = 'cmAddress'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(AliasID),0) + 1 FROM cmAlias)
WHERE TableName = 'cmAlias'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(ClntCaseID),0) + 1 FROM cmCaseAssign)
WHERE TableName = 'cmCaseAssign'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(ClientID),0) + 1 FROM cmClient)
WHERE TableName = 'cmClient'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(EvalID),0) + 1 FROM cmClntEval)
WHERE TableName = 'cmClntEval'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(FamilyAcctID),0) + 1 FROM cmFamilyAccFile)
WHERE TableName = 'cmFamilyAccFile'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(FamilyMemID),0) + 1 FROM cmFamilyMemFile)
WHERE TableName = 'cmFamilyMemFile'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(GoalID),0) + 1 FROM cmGoals)
WHERE TableName = 'cmGoals'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(InfoReleaseID),0) + 1 FROM cmInfoRelease)
WHERE TableName = 'cmInfoRelease'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(IntOthID),0) + 1 FROM cmInterOther)
WHERE TableName = 'cmInterOther'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(ProviderID),0) + 1 FROM cmProvider)
WHERE TableName = 'cmProvider'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(WorkHistID),0) + 1 FROM cmWorkHist)
WHERE TableName = 'cmWorkHist'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(EmployerID),0) + 1 FROM emEmployer)
WHERE TableName = 'emEmployer'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(EndPointID),0) + 1 FROM IntegrationEndPoint)
WHERE TableName = 'IntegrationEndPoint'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(RomaReportID),0) + 1 FROM RomaLog)
WHERE TableName = 'RomaLog'

UPDATE osNextKey
SET KeyValue = (SELECT ISNULL(MAX(EntityID),0) + 1 FROM vEntityContact)
WHERE TableName = 'vEntityContact'

Select * FROM osNextKey