use nexgencosysdbdev
select accountno,ledgerbalance,acctno,dbalance into #temp From mamaccountopening mao 
inner join 
kamana..deposit kd on mao.accountno=kd.acctno
select * From #temp 
where ledgerbalance!=dbalance

DROP TABLE #TEMP