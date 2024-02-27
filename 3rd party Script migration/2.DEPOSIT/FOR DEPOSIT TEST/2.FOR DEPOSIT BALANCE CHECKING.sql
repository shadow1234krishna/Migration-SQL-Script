use nexgencosysdbdev
declare @accountno nvarchar(max)='10402010005017'

select sum(cashreceived)-sum(cashwithdrawl) bal,transactionon into #temp  From acotransaction
where mamaccountopeningid=(select mamaccountopeningid from mamaccountopening
where accountno=@accountno) group by transactionon
go

select sum(bal) bal,transactionon into #temp1 From #temp group by transactionon
go
alter table #temp1
add balance money
go

declare @balance money =0
update #temp1 set balance=@balance,
                  @balance=bal+@balance

				  alter table #temp1 
				  add nepdate nvarchar(10)
				  go

				  update #temp1 set nepdate=dbo.ConvertDateEnglishToNepali(transactionon)

				
				 GO

select 
neptrandate,balofacct INTO #KTEMP
From KAMANA..[transaction] where tranno in (
select max(tranno) tranno From kamana..[transaction]
where acctno='10402010005017' group by neptrandate)
order by tranno

SELECT * fROM #TEMP1 T
INNER JOIN #KTEMP KT ON T.BALANCE=KT.BALOFACCT AND T.NEPDATE=KT.NEPTRANDATE
ORDER BY T.TRANSACTIONON

DROP TABLE #TEMP1
DROP TABLE #TEMP
DROP TABLE #KTEMP