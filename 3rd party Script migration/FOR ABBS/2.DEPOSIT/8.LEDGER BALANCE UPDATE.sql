use NexGenCoSysDBDev
SELECT 
		a.MamAccountOpeningId,		
		m.MemberId As MemberId,
		a.AccountNo,
		a.LastInterestDateOnBs
		INTO #TEMP FROM MamAccountOpening As a					
			LEFT JOIN MemMemberRegistration As m
				On m.MemMemberRegistrationId=a.MemMemberRegistrationId							
			WHERE a.IsDeleted=0  AND a.MamAccountStatusId in(1,2,4,5) 
		
	   UPDATE A SET 
			A.LedgerBalance = ISNULL((SELECT 		
				SUM(DepositAmount)-SUM(WithdrawlAmount) AS Balance				
				FROM 
				(
				SELECT 
				AO.AccountNo,
				CASE WHEN t.AcoTransactionTypeId in (1,14,17,25,27,30,3,33,34,35,43,47,50,54,56,58,60,62,64,69,73) THEN t.CashReceived ELSE 0 END AS DepositAmount,
				CASE WHEN t.AcoTransactionTypeId in (2,23,4,15,16,28,29,31,36,51,55,57,59,61,65,68,71) THEN t.CashWithdrawl
					 WHEN t.AcoTransactionTypeId in (24,67,70) THEN t.CashReceived
					 ELSE 0 END AS WithdrawlAmount
				FROM AcoTransaction AS T
				LEFT JOIN MamAccountOpening AS AO
				ON AO.MamAccountOpeningId=T.MamAccountOpeningId
				WHERE AO.AccountNo = A.AccountNo AND T.AcoTransactionTypeId in (1,14,17,25,27,30,3,2,23,4,15,16,28,29,31,24,33,34,35,36,43,47,50,51,54,55,56,57,58,59,60,61,62,64,69,73,65,68,71,67,70) AND T.IsActive=1 
				) AS TEMP ),0)
				FROM MamAccountOpening AS A
				INNER JOIN #TEMP AS B
				ON A.MamAccountOpeningId=B.MamAccountOpeningId where A.MamAccountOpeningId=B.MamAccountOpeningId			
					
		
		drop table #temp