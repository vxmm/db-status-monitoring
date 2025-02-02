$frequencyInMin = 10
$taskAction = New-ScheduledTaskAction -Execute #'//path_to_powershell.exe' `
-Argument '-WindowStyle Hidden -Command "Invoke-Sqlcmd -InputFile '#//path_to_runCheckDB.sql''"'
$trigger = New-ScheduledTaskTrigger -Once `
    -At (Get-Date) `
    -RepetitionInterval (New-TimeSpan -Minutes $frequencyInMin)
Register-ScheduledTask -Action $taskAction -Trigger $trigger -TaskName "DB_status_splunk" -Description "Checks status of DB" -RunLevel Highest