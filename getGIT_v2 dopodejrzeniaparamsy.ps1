#Default params

    $path = 
"C:\Source\brms-additional-message",
"C:\Source\brms-archive",
"C:\Source\brms-clearance",
"C:\Source\brms-control",
"C:\Source\brms-coverage",
"C:\Source\brms-customs-debt",
"C:\Source\brms-customs-position",
"C:\Source\brms-dispatcher",
"C:\Source\brms-export-handle-exit-messages",
"C:\Source\brms-export-monitor-after-release",
"C:\Source\brms-irregularity",
"C:\Source\brms-process-manager",
"C:\Source\brms-validation",
"C:\Source\cwm",
"C:\Source\devops",
"C:\Source\devops-config",
"C:\Source\dms-common",
"C:\Source\dms-connectors",
"C:\Source\dms-custom-validations",
"C:\Source\dms-data-mocks",
"C:\Source\dms-debitor-restance",
"C:\Source\dms-helm-charts",
"C:\Source\dms-helm-values",
"C:\Source\dms-kria",
"C:\Source\dms-letter",
"C:\Source\ermis-auditing",
"C:\Source\ermis-csrd2",
"C:\Source\ermis-cwm-emulator-develop",
"C:\Source\ermis-designer",
"C:\Source\ermis-e2e",
"C:\Source\ermis-goods-accounting",
"C:\Source\ermis-party-mgt",
"C:\Source\ermis-reference-data",
"C:\Source\ermis-trader-portal",
"C:\Source\external-validation-common",
"C:\Source\integration-currency-tqs",
"C:\Source\integration-dcs",
"C:\Source\integration-dk-crs",
"C:\Source\integration-manifest-consume",
"C:\Source\integration-surveillance-tqs",
"C:\Source\integration-tariff-tqs",
"C:\Source\jira-utilities",
"C:\Source\keycloak-dcs-plugin",
"C:\Source\nc-devops-pipeline-shared-libraries",
"C:\Source\operations-images",
"C:\Source\pipeline-shared-libs",
"C:\Source\test-performance" 
    $username = "aso@netcompany.com"#"Andrew Solski"
    $filename = "ASO_2021_09_"
    $dateFrom = "2021-09-15"
    $dateTo = "2021-10-15"
    $destination = "C:\Users\aso\Documents\Copyright"

    $i=1
ForEach ($value in $path) {
#Go to the desired directory
        # file with path $path doesn't exist
    
	    cd $value
	    $repo=Split-Path $value -leaf
        $output = "$filename" + "$repo"

        #echo "$value"
        #echo "$output"
	    #echo ""$PSScriptRoot\$output.patch""
	
	    #Fill default dates to the fetch previous week's Commits
	    if([string]::IsNullOrEmpty($dateTo))
	    {
	    	$dateTo = Get-Date -format "yyyy-MM-dd"
	    }
	    if([string]::IsNullOrEmpty($dateFrom))
	    {
	    	$dateFrom = (Get-Date).AddDays(-7).ToString("yyyy-MM-dd")
	    }
    
	    $command = ""
	    #Do we search by commiter or in comments? Useful if we commit as someone else
	    if(![string]::IsNullOrEmpty($username))
        {	
	       $command = "git log --all --since=""$dateFrom"" --until=""$dateTo"" --author=""$username"" -p > ""$output.patch"""        
	    }
        $i++
        #end
        #check if we have command
        if(![string]::IsNullOrEmpty($command))
        {

            #Get git Log
            IEX $command 
    
            #Done!
            Write-Output "Moving file $output"
            # use PSScriptRoot on Win10
            #Copy-Item "$output.patch" "$PSScriptRoot"
            $scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
            Move-Item "$output.patch" "$scriptPath"
            Write-Output "Done!"
        }
    
    else
    {
        Write-Output "NOTHING TO DO"
    }
}
