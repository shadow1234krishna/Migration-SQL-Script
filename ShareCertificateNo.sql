use NexGenCoSysDBDev

-- certificate no. update
update ShmShareAllotment
set CertificateNo = ShmShareAllotmentId


-- update all share types to SHARE HOLDER
update ShmShareAllotment
set ShmShareTypeId = 3
