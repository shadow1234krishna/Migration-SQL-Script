
USE NexGenCoSysDBDev
UPDATE AO SET AO.MamInterestTransferAccountOpeningId=
	(
		SELECT TOP 1 MA.MamAccountOpeningId FROM MamAccountOpening AS MA
		LEFT JOIN SycDepositType AS DT 
		ON DT.SycDepositTypeId=MA.SycDepositTypeId
		WHERE MA.MemMemberRegistrationId=AO.MemMemberRegistrationId AND MA.IsDeleted=0 
		AND MA.MamAccountStatusId IN (1,4) AND DT.SycDepositCategoryId IN (1)
	)
	FROM MamAccountOpening AS AO
	LEFT JOIN SycDepositType AS DTY 
	ON DTY.SycDepositTypeId=AO.SycDepositTypeId
	WHERE DTY.SycDepositCategoryId IN (3) AND AO.MamAccountStatusId IN (1,4)