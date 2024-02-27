	use nexgencosysdbdev
	declare @loanaccountno nvarchar(255)='20501150000662'
	declare @openingbalance money =0
	CREATE TABLE #tempBalance
	(
		LoanAccountNo Nvarchar(50),
		DateOn Date, 
		DateOnBs Nvarchar(50), 
		LoanIssueAmount Numeric(18,2),
		Principal Numeric(18,2),
		BalanceAmount Numeric(18,2)
	)

	INSERT INTO #tempBalance
	       SELECT 
		   LS.LoanAccountNo,
		   TR.TransactionOn,
		   TR.TransactionOnBs,
		    0,
		   CASE  WHEN TR.AcoTransactionTypeId IN (5,20,39,44) THEN ISNULL(TR.CashReceived,0) Else 0 END,
		    0
		   FROM dbo.LmtLoanIssue AS LS
		   INNER JOIN dbo.AcoTransaction AS TR
		   ON TR.LmtLoanIssueId=LS.LmtLoanIssueId
		   WHERE  TR.IsActive=1 AND TR.AcoTransactionTypeId in (5,6,7,20,21,22,39,40,41,44,45,46) AND LS.IsVerified = 1 and LS.IsActive= 1
		   and ls.loanaccountno=@loanaccountno

		   	INSERT INTO #tempBalance
	       SELECT 
		   LS.LoanAccountNo,
		   LS.LoanIssueOn,
		   LS.LoanIssueOnBs,
		   
		   LS.LoanIssueAmount,
		   0,
		   0
		   FROM dbo.LmtLoanIssue AS LS
		   WHERE  LS.IsVerified = 1 and LS.IsActive= 1 AND LS.TransStatus IN ('I','U') and ls.loanaccountno=@loanaccountno
		   SELECT * INTO #TEMP FROM #tempBalance ORDER BY DateOn ASC,LoanIssueAmount DESC
		  	   UPDATE #TEMP SET BalanceAmount = @OpeningBalance,
			@OpeningBalance= @OpeningBalance + LoanIssueAmount - Principal;
		
		  go
	select 
neptrandate,balofacct INTO #temp1
From KAMANA..[transaction] where tranno in (
select max(tranno) tranno From kamana..[transaction]
where acctno='20501150000662' group by neptrandate)
order by tranno
 go
   select *From #temp t inner join #temp1 t1
   on t.balanceamount=t1.balofacct and t.dateonbs=t1.neptrandate
   order by t.dateonbs


		  
		   drop table #tempbalance
		   drop table #temp
		   drop table #temp1