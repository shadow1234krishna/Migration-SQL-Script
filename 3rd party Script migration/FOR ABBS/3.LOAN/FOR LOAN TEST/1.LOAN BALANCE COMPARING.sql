use nexgencosysdbdev
SELECT LOANACCOUNTNO,DBO.FN_GETLOANPRINCIPLEBALANCE(LOANACCOUNTNO) BAL INTO #TEMP FROM NEXGENCOSYSDBDEV..LMTLOANISSUE
WHERE TRANSSTATUS='i'

SELECT ACCTNO,LBALPRINC INTO #TEMP1 fROM KAMANA..LOAN

SELECT  *fROM #TEMP t JOIN #TEMP1 T1 ON T.LOANACCOUNTNO=T1.ACCTNO
WHERE T.BAL!=T1.LBALPRINC

DROP TABLE #TEMP
DROP TABLE #TEMP1