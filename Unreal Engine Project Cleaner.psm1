<#
.SYNOPSIS
    Prompts the user for a valid project path.

.DESCRIPTION
    This function repeatedly prompts the user to enter a path to their project until a valid path is provided.
    A valid path is one that exists, is a directory, and is not empty.

.NOTES
    This function will continue to prompt the user until a valid path is provided.

.EXAMPLE
    $projectPath = Get-ValidProjectPath
    This example shows how to call the Get-ValidProjectPath function and store the result in the $projectPath variable.
#>

function Get-ValidProjectPath {
    do {
        $folder = Read-Host "Enter the path to your project"
        if ((Test-Path($folder) -PathType Container) -and !(IsDirectoryEmpty($folder))) {
            return $folder
        }
        Write-Host "Invalid or empty project path, try again. Do not include quotes." -ForegroundColor Red
    } while ($true)
}

<#
.SYNOPSIS
    Calculates the total size of a given project folder.

.DESCRIPTION
    This function calculates the total size of all files in the given project folder, including hidden files and files in subdirectories.
    The size is returned in megabytes, rounded to two decimal places.

.PARAMETER folder
    The path to the project folder. This parameter is mandatory.

.NOTES
    This function uses the Get-ChildItem cmdlet with the -Force and -Recurse parameters to get all files, including hidden files and files in subdirectories.
    It uses the Measure-Object cmdlet to calculate the total size of these files.

.EXAMPLE
    $projectSize = Get-ProjectSize "C:\Path\To\Your\Project"
    This example shows how to call the Get-ProjectSize function and store the result in the $projectSize variable.
#>

function Get-ProjectSize {
    param(  [Parameter(Mandatory=$true)]
            [string]$folder
        ) 
        
    return [math]::Round((Get-ChildItem $folder -Force -Recurse | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum / 0x1MB, 0x2)
}

<#
.SYNOPSIS
    Checks if a given directory is empty.

.DESCRIPTION
    This function checks if the given directory is empty. It considers a directory to be empty if it contains no files, even if it contains subdirectories.
    The function returns $true if the directory is empty, and $false otherwise.

.PARAMETER folder
    The path to the directory to check. This parameter is mandatory.

.NOTES
    This function uses the Get-ChildItem cmdlet with the -File and -Recurse parameters to get all files in the directory and its subdirectories.

.EXAMPLE
    $isEmpty = Is-DirectoryEmpty "C:\Path\To\Your\Directory"
    This example shows how to call the Is-DirectoryEmpty function and store the result in the $isEmpty variable.
#>

function IsDirectoryEmpty {
    param(  [Parameter(Mandatory=$true)]
            [string]$folder 
        )

    return !(Get-ChildItem $folder -File -Recurse)
}

<#
.SYNOPSIS
    Clears an Unreal Engine project directory.

.DESCRIPTION
    This function removes certain subdirectories from the given Unreal Engine project directory. 
    These subdirectories are typically used for temporary or derived data and can be safely removed to save space.

.PARAMETER folder
    The path to the Unreal Engine project directory. This parameter is mandatory.

.NOTES
    This function removes the following subdirectories: .idea, .vs, Config, DerivedDataCache, Intermediate, Platforms, Saved, Binaries, Build.
    It uses the Remove-Item cmdlet with the -Recurse and -Force parameters to remove these directories and all their contents.

.EXAMPLE
    Clear-Project "C:\Path\To\Your\UnrealEngineProject"
    This example shows how to call the Clear-Project function to Clear an Unreal Engine project directory.
#>

function Clear-Project {
    param(
        [Parameter(Mandatory=$true)]
        [string]$folder
    )

    $subdirs = @(".idea", ".vs", "Config", "DerivedDataCache", "Intermediate", "Platforms", "Saved", "Binaries", "Build")
    foreach ($subdir in $subdirs) {
        $path = Join-Path $folder $subdir
        if (Test-Path($path)) {
            Write-Host ("Removing {0}..." -f $path) -ForegroundColor Yellow
            Remove-Item -Recurse -Force $path
        }
    }
}

Export-ModuleMember -Function Get-ValidProjectPath, Get-ProjectSize, Is-DirectoryEmpty, Clear-Project -Alias gvp, gps, ide, cpr 