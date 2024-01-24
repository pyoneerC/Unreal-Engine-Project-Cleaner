<#
.SYNOPSIS
Unreal Engine Project Cleaner

.DESCRIPTION
This script cleans the specified Unreal Engine project directory by removing specified subdirectories.

.AUTHOR
Max Comperatore

.COPYRIGHT
Copyright (c) 2024 Max Comperatore. All rights reserved.

.LICENSE
This script is licensed under the MIT License. open-source.org/licenses/MIT

.NOTES
File Name      : Unreal Project Cleaner.ps1
Last Updated   : 23/01/2024
#>

Import-Module '.\Unreal Engine Project Cleaner.psm1'

Write-Host "Unreal Engine Project Cleaner" -ForegroundColor DarkCyan

$firstIteration = $true

do {
    if (!$firstIteration) {
        Clear-Host
    }
    $firstIteration = $false

    $folder = Get-ValidProjectPath
    Write-Host "Project is valid." -ForegroundColor Green

    if ((Read-Host "Do you want to clean this project? (y/n)") -eq "y") {
        Clear-Project -folder $folder
        Write-Host "Project cleaned successfully." -ForegroundColor Green
        Write-Host ("Project size: {0} MB" -f (Get-ProjectSize($folder))) -ForegroundColor Green
    } else {
        Write-Host "Exiting..."
        Start-Sleep -Seconds 0x2 
        exit
    }

    $userInput = Read-Host "Enter 1 to clean another project, or any other key to exit"
    if ($userInput -ne '1') {
        Write-Host "Exiting..."
        Start-Sleep -Seconds 0x2 
        Start-Process "explorer.exe" -ArgumentList $folder
        exit
    }
} while ($userInput -eq '1')