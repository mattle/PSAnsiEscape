@{
    # Module manifest for PSAnsiEscape
    
    # Script module or binary module file associated with this manifest.
    RootModule = 'PSAnsiEscape.psm1'
    
    # Version number of this module.
    ModuleVersion = '1.0.0'
    
    # Supported PowerShell versions
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    
    # ID used to uniquely identify this module
    GUID = '12345678-1234-1234-1234-123456789012'
    
    # Author of this module
    Author = 'Your Name'
    
    # Company or vendor of this module
    CompanyName = 'Unknown'
    
    # Copyright statement for this module
    Copyright = '(c) 2025. All rights reserved.'
    
    # Description of the functionality provided by this module
    Description = 'A PowerShell module that makes using ANSI escape sequences in the terminal easy. Provides functions for colors, text formatting, cursor movement, and screen manipulation.'
    
    # Functions to export from this module
    FunctionsToExport = @(
        'Set-AnsiColor',
        'Set-AnsiFormat',
        'Move-AnsiCursor',
        'Clear-AnsiScreen',
        'New-AnsiSequence'
    )
    
    # Cmdlets to export from this module
    CmdletsToExport = @()
    
    # Variables to export from this module
    VariablesToExport = @()
    
    # Aliases to export from this module
    AliasesToExport = @()
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module
            Tags = @('ANSI', 'Terminal', 'Console', 'Color', 'Formatting')
            
            # A URL to the license for this module.
            LicenseUri = ''
            
            # A URL to the main website for this project.
            ProjectUri = ''
            
            # A URL to an icon representing this module.
            IconUri = ''
            
            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of PSAnsiEscape module with support for colors, formatting, cursor movement, and screen manipulation.'
        }
    }
}