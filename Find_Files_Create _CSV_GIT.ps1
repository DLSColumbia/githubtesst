CLS
write-host
write-host
write-host
write-host
Write-Host "Using the format xxxx.yyyy, Enter the name and file type if searching for a specific file"       
$Extension = Read-Host "or using that format enter wildcards to search for multiple files                                              "
write-host
$SourcePath = Read-host "Enter the full path (including the drive letter, i.e C:\) to the Uppermost Folder for the Files of interest    "
write-host                       
$OutputFile = Read-Host "Enter the name for the CSV file that will be generated                                                         "
write-host
$OutputFolder = Read-host "Enter the complete path (including drive letter) to the Folder for where you want the CSV file storred         "
write-host
write-host
write-host
write-host
write-host "SEARCH IS IS IN PROGRESS, PLEASE STAND BY"
write-host
write-host
write-host
write-host
$RetrievedFiles = Get-ChildItem -path $SourcePath -include $Extension -recurse -file | 
 select basename, extension, creationtime, psparentpath , @{Name='FileNameLength';Expression={$_.pschildname.length}} , @{Name='PathLength';Expression={$_.fullname.length}} | sort-object pschildname

$i = 0
$RetrievedFiles | ForEach-Object {
    Write-Progress -Activity "Counting Dir file $($_.name)" -Status "File $i of $($RetrievedFiles.Count)" -PercentComplete (($i / $RetrievedFiles.Count) * 100)  
    $i++
}

$DateTime = get-date -UFormat "%Y_%m_%d__%H_%M_%S"
$OutputFile_DateTime = $OutputFile + "_" + $DateTime
$OutputFolder_File = $OutputFolder +"\" + $OutputFile_DateTime
$RetrievedFiles | Export-Csv -path "$OutputFolder_File.csv" -Encoding ascii -NoTypeInformation -NoClobber

$OutputFileFinal=$OutputFolder_File+"SEQno"


Import-CSV -path "$OutputFolder_File.csv" | Select *,SeqNo | ForEach-Object -Begin { $SeqNo = 1 } { 
    $_.SeqNo = $SeqNo++
    $_ 
} | Export-CSV -path "$OutputFileFinal.csv" -Encoding ascii -NoTypeInformation -NoClobber



cls
Write-host
Write-host "YOUR SEARCH IS COMPLETE, THE FOLLOWING CSV FILE HAS BEEN GENERATED " $OutputFileFinal
Remove-Item "$OutputFolder_File.csv" 

write-host
Write-host "added line"
write-host "added a second line to the end"
Wirte-host "added a third line to the ned of the code"