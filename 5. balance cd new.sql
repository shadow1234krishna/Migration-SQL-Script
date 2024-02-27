use nexgencosysdbdev

update mamaccountopening 
set LastInterestDateOn=null,LastInterestDateOnBs=NULL
where AccountOpenOnBs>=LastInterestDateOnBs and MamAccountStatusId in (1, 4, 5)

select mamaccountopeningid,accountno,
	case 
		when LastInterestDateOn is null and IsRenewed=0 then 0
        when LastInterestDateOn is null and IsRenewed=1 then dbo.fn_GetSavingAccountBalanceTillDate(accountno,AccountOpenOn)
		else dbo.fn_GetSavingAccountBalanceTillDate(accountno,lastinterestdateon)
	end
 balancecd 
 into 
 #temp
 from mamaccountopening
where mamaccountstatusid in (1, 4, 5)


select mao.mamaccountopeningid,t.accountno,t.balancecd as balancecdnew,mao.balancecd as balancecdold,mao.LastInterestDateOnBs,mao.LedgerBalance
From #temp t 
inner join MamAccountOpening mao 
on t.MamAccountOpeningId=mao.mamaccountopeningid
where t.balancecd!=mao.balancecd



update mao set mao.BalanceCd=t.balancecd from mamaccountopening mao
inner join #temp t on mao.mamaccountopeningid=t.mamaccountopeningid

drop table #temp



