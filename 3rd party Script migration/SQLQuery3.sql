select * FROM Finact.dbo.Loan 
where AcctNo = '20501120005423'

select * FROM Finact.DBO.[TRANSACTION] 
where AcctNo = '20501120005431'
order by nepTranDate

select *  FROM Finact.DBO.[TRANSACTION] WHERE AcctNo = '20501120005474' AND Typeoftranname in ('coll','clos')
ORDER BY [SEQUENCE]

select sum(TranAmount)  FROM Finact.DBO.[TRANSACTION] WHERE AcctNo = '20501120005474' AND Typeoftranname in ('coll','clos')
  ORDER BY [SEQUENCE]


select * FROM Finact.DBO.[TRANSACTION]
where Typeoftranname = 'rev'
	and TypeOfTran = 78



select COUNT(AcctNo), AcctNo FROM Finact.DBO.[TRANSACTION] 
where Typeoftranname = 'CAPT'
group by AcctNo
order by AcctNo

