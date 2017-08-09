

DECLARE @string varchar(200) = 'NoNoNoNoNoNoNoNo'

SELECT (LEN(@string) - LEN(REPLACE(@string,'No','')))/ Len('No')
SELECT (LEN(@string) - LEN(REPLACE(@string,'Yes','')))/ Len('Yes')

