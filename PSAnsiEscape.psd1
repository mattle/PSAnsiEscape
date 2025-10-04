@{
    # Module manifest for PSAnsiEscape

    # Script module or binary module file associated with this manifest.
    RootModule = 'PSAnsiEscape.psm1'

    # Version number of this module.
    ModuleVersion = '2.0.0'

    # Supported PowerShell versions
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')

    # ID used to uniquely identify this module
    GUID = 'fc179da9-788c-4660-8f1d-2bd00d4c3c90'

    # Author of this module
    Author = 'Mattle'

    # Company or vendor of this module
    CompanyName = 'Mattle'

    # Copyright statement for this module
    Copyright = '(c) 2025. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'A PowerShell module that makes using ANSI escape sequences in the terminal easy. Provides functions for colors (including 256-color and 24-bit RGB), text formatting, cursor movement, screen manipulation, hyperlinks, and advanced terminal features.'

    # Functions to export from this module
    FunctionsToExport = @(
        'Set-AnsiColor',
        'Set-AnsiFormat',
        'Move-AnsiCursor',
        'Clear-AnsiScreen',
        'Set-AnsiCursor',
        'Get-AnsiCursorPosition',
        'Set-AnsiTrueColor',
        'Set-Ansi256Color',
        'Get-Ansi256ColorChart',
        'Set-AnsiWindowTitle',
        'Reset-AnsiWindowTitle',
        'Enter-AnsiAlternateScreen',
        'Exit-AnsiAlternateScreen',
        'Use-AnsiAlternateScreen',
        'New-AnsiHyperlink',
        'Write-AnsiHyperlink'
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
            Tags = @('ANSI', 'Terminal', 'Console', 'Color', 'Formatting', 'TrueColor', '256Color', 'RGB', 'Hyperlinks', 'AlternateScreen')

            # A URL to the license for this module.
            LicenseUri = ''

            # A URL to the main website for this project.
            ProjectUri = ''

            # A URL to an icon representing this module.
            IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = 'Version 2.0.0: Major update adding 24-bit RGB colors, 256-color palette, cursor control, window titles, alternate screen buffer, and hyperlink support.'
        }
    }
}