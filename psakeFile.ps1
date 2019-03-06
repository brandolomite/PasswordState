# properties {
#     $projectRoot = $ENV:BHProjectPath
#     if(-not $projectRoot) {
#         $projectRoot = $PSScriptRoot
#     }

#     $sut   = "$projectRoot\PasswordState"
#     $tests = "$projectRoot\Tests"

#     $psVersion = $PSVersionTable.PSVersion.Major
# }

# task default -depends Test

# task Init {
#     "`nSTATUS: Testing with PowerShell $psVersion"
#     "Build System Details:"
#     Get-Item ENV:BH*
# }

# task Test -Depends Init, Analyze, Pester

# task Analyze -Depends Init {
#     $saResults = Invoke-ScriptAnalyzer -Path $sut -Severity Error -Recurse -Verbose:$false
#     if ($saResults) {
#         $saResults | Format-Table
#         Write-Error -Message 'One or more Script Analyzer errors/warnings where found. Build cannot continue!'
#     }
# }

# task Pester -Depends Init {
#     $testResults = Invoke-Pester -Path $tests -PassThru
#     if ($testResults.FailedCount -gt 0) {
#         $testResults | Format-List
#         Write-Error -Message 'One or more Pester tests failed. Build cannot continue!'
#     }
# }

# task UpdateHelpMarkdown -Depends Init {
#     Import-Module -Name $env:BHPSModuleManifest -Force
#     Update-MarkdownHelp -Path "$projectRoot\docs\*" -Encoding ([System.Text.Encoding]::UTF8)
# }

# task GenerateHelp -Depends Init {
#     New-ExternalHelp -Path "$projectRoot\docs\*" -OutputPath "$sut\en-US" -Force -Encoding ([System.Text.Encoding]::UTF8)
# }

# task ExportFunctions {
#     $files = Get-ChildItem -Path $sut\Public | Select-Object -ExpandProperty Name
#     $functions = @()
#     $files | ForEach-Object {
#         $functions += $_.Split('.')[0]
#     }
#     Update-ModuleManifest -Path $env:BHPSModuleManifest -FunctionsToExport $functions
# }

# task Deploy -depends Test {
#     # Gate deployment
#     if(
#         $ENV:BHBuildSystem -ne 'Unknown' -and
#         $ENV:BHBranchName -eq "master" -and
#         $ENV:BHCommitMessage -match '!deploy'
#     ) {
#         $params = @{
#             Path = "$projectRoot\module.psdeploy.ps1"
#             Force = $true
#             Recurse = $false
#         }

#         Invoke-PSDeploy @Params
#     } else {
#         "Skipping deployment: To deploy, ensure that...`n" +
#         "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
#         "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
#         "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage)"
#     }
# }

properties {
    # "Compile" module source files into monolithic PSM1
    $PSBPreference.Build.CompileModule = $true
}

task default -depends Test

task Test -FromModule PowerShellBuild -Version '0.3.0'
