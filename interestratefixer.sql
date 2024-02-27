use nexgencosysdbdev
UPDATE mao
  SET 
      mao.InterestRate = NULL
FROM MamAccountOpening mao
     JOIN SycDepositType sdt ON mao.SycDepositTypeId = sdt.SycDepositTypeId
WHERE MamAccountStatusId IN(1, 4, 5)
AND sdt.SycDepositCategoryId != 3
AND mao.InterestRate = sdt.InterestRate;
GO
UPDATE mao
  SET 
      mao.InterestRate = sdt.InterestRate
FROM MamAccountOpening mao
     JOIN SycDepositType sdt ON mao.SycDepositTypeId = sdt.SycDepositTypeId
WHERE MamAccountStatusId IN(1, 4, 5)
AND sdt.SycDepositCategoryId = 3
AND mao.InterestRate IS NULL;

update mamaccountopening set SycInterestCalculationTypeId=null where SycDepositTypeId in
(select sycdeposittypeid from sycdeposittype where SycDepositCategoryId=3 and SycInterestCalculationPeriodId!=5)
and SycInterestCalculationTypeId!=5;