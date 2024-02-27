/* #CodeValue Update Script of LmtLoanIssue
Created Date: 7 Feb, 2023
Updated Date: 03 August, 2023
Version: 1.2
Author: Bikash Chaudhary
*/

use NexGenCoSysDBDev
go



--Updating the code value
Declare @i  as int=1,@curr_code_name as nvarchar(255),  @row_number as bigint, @max_code_value as bigint, @code_type as nvarchar(255);
 SET @row_number = (select MAX(LmtLoanTypeMasterId) from LmtLoanTypeMaster);
 print(@row_number)
 while @i <= @row_number
 BEGIN

		
		Set @max_code_value = (select MAX (cast (RIGHT(LoanAccountNo, CHARINDEX('-',REVERSE (LoanAccountNo))-1) as bigint)) from  LmtLoanIssue where LmtLoanTypeMasterId=@i);
		print(concat('Max Code Value: ', @max_code_value));

		 --To update code value
		update LmtLoanTypeMaster
		Set CodeValue = @max_code_value
		where LmtLoanTypeMasterId=@i;
		
	
	SET @i = @i + 1;
 END;
