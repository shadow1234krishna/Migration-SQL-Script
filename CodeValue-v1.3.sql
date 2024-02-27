/* #CodeValue Update Script
Created Date: 27 Jan, 2023
Updated Date: 03 August, 2023
Version: 1.3
Author: Bikash Chaudhary
*/

use NexGenCoSysDBDev
go


--Updating the code value
Declare @i  as int=1,@curr_code_name as nvarchar(255),  @row_number as bigint, @max_code_value as bigint, @code_type as nvarchar(255);
 SET @row_number = (select MAX(SycDepositTypeId) from SycDepositType);
 while @i <= @row_number
 BEGIN


		--select MAX (cast (RIGHT(AccountNo, CHARINDEX('-',REVERSE(AccountNo))-1) as bigint)) from MamAccountOpening where SycDepositTypeId=@i
		Set @max_code_value = (select MAX (cast (RIGHT(AccountNo, CHARINDEX('-',REVERSE(AccountNo))-1) as bigint)) from MamAccountOpening where SycDepositTypeId=@i);
		print(concat('Max Code Value: ', @max_code_value));
		--Set @code_type = (select SycDepositTypeId from SycDepositType where DepositTypeCode = @curr_code_name and IsActive = 1);
		--print(concat('Code Type: ', @code_type));

		 --To update code value
		update SycDepositType
		Set CodeValue = @max_code_value
		where SycDepositTypeId=@i;
		
	SET @i = @i + 1;
 END;

 --Shows SycDepositeType Table
 select CodeValue,* from SycDepositType;
