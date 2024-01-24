@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'Unreal Engine Project Cleaner.psm1'

    # Version number of this module.
    ModuleVersion = '1.0'

    # ID used to uniquely identify this module
    GUID = '57ea71e2-639e-4a1a-bd3c-107147d52489'

    # Author of this module
    Author = 'Max Comperatore'

    # Copyright statement for this module
    Copyright = '(c) 2024 Max Comperatore. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'This script cleans the specified Unreal Engine project directory by removing specified subdirectories.'

    # Functions to export from this module
    FunctionsToExport = 'Get-ValidProjectPath', 'Get-ProjectSize', 'Is-DirectoryEmpty', 'Clean-Project'

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = 'UnrealEngine', 'ProjectCleaner'

            # License Uri for this module
            LicenseUri = 'https://opensource.org/licenses/MIT'

            # Project Uri for this module
            ProjectUri = 'https://github.com/your-github-username/your-repo-name'

            # Release notes for this module
            ReleaseNotes = 'Initial release of Unreal Engine Project Cleaner'
        }
    }
}