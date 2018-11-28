
param(
    [Switch]$Verbose = $true
)


Function Main {
    param(
        [String]$Repository = "\\ad.ds-bq.local\THOTH",
        [String]$JsonConfig = "\\ad.ds-bq.local\THOTH\.thoth.conf",
        [String]$Machine,
        [String]$ReportDate
    )

    #vars
    $countFilesFound = 0
    $countProcessReports = 0
    $headers = (cat $JsonConfig | ConvertFrom-Json).headers

    #sorts
    if ($Machine -ne "" -and $ReportDate -ne "") {
        Logger "Search sort by Machine and  Date: $Machine - $ReportDate"
        $_ReportDate = $ReportDate.Replace("/","").Replace("-","").Replace(" ","").Replace(":","")
        $Search = ls "$Repository\$($Machine)_*$($_ReportDate)*.csv" -File
    } elseif ($Machine -ne "") {
        Logger "Search sort by Machine: $Machine"
        $Search = ls "$Repository\$($Machine)_*.csv" -File
    } elseif ($ReportDate -ne ""){
        Logger "Search sort by Date: $ReportDate"
        $_ReportDate = $ReportDate.Replace("/","").Replace("-","").Replace(" ","").Replace(":","")
        $Search = ls "$Repository\*_*$($_ReportDate)*.csv" -File
    } else {
        Logger "Search all files in Repository: $Repository"
        $Search = ls "$Repository" -File
    }
    
    #browse files
    foreach ($file in $Search) {
        if ($file.Extension -match "csv") {
            $countFilesFound++
            $report = DecomposeReport $file
            if ($report -ne $null) {
                $countProcessReports++
                #Logger "Search in File:[$($file.basename)] { HostName:[$($report.name)] Date:[$($report.date)] }"
                
                #browse report`s lines
                foreach ($line in (cat $file.fullname)) {
                    $header = $headers.($line.split(";")[1])
                    $rawdata = $line.split(";")

                    if ($header.Length -gt 0) {
                        $header = (@("Date", "Class", "Hostname") + $header)
                        $csv = ($line | ConvertFrom-Csv -Delimiter ";" -Header $header)
                        $countData = $rawdata.Length
                        
                        #data integrity errors

                        #{NF-0001query dont found
                        if ($rawdata[$rawdata.Length -1] -eq "No Found") {
                            #Logger {"NF-0001}Not Getted correctly data: [$($header.Length)/$($countData)], header: [$header]`n           Process line: [$line]"
                        
                        #{MMDM-0002}missmatch data with model
                        } elseif ($countData -ne $header.Length) {
                            Logger "{MMDM-0002}Missmatch Data with model: [$($header.Length)/$($countData)] ->, <$($rawdata[1])>"#: [$header]`n           Process line: [$line]"
                        } 
                        
                        #$line | where  -Contains "; "

                    } else {}
                    #Logger "Process header: [$header]`n           Process line: [$line]"
                }

            } else {
                Logger "No valid file:[$($file.fullname)]"
            }

        }
    }
    Logger "Files/Process: $countFilesFound/$countProcessReports"
}

Function DecomposeReport ($file) {
    try {
        return [hashtable]@{
            "date" = [DateTime]::parseexact($($file.basename.split("_")[-1]), 'ddMMyyyyHHmmss', $null);
            "name" = [String]$file.basename.replace( "_$($file.basename.split("_")[-1])", "" )
        }
    }
    catch {
        return $null
    }
}

function Logger([Object]$message) {
    Write-Verbose $message -Verbose:$Verbose
}

Main -ReportDate 31/05/2018 #-Machine DT-AUXSISTEMAS2 