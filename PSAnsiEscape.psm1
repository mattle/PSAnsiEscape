# PSAnsiEscape Module
# A PowerShell module for working with ANSI escape sequences

# Get the path to the module directory
$ModulePath = $PSScriptRoot

# Import all public functions
Get-ChildItem -Path "$ModulePath\Public\*.ps1" | ForEach-Object {
    . $_.FullName
}

# Import all private functions (if any exist)
if (Test-Path "$ModulePath\Private") {
    Get-ChildItem -Path "$ModulePath\Private\*.ps1" | ForEach-Object {
        . $_.FullName
    }
}

# Export only the public functions
$PublicFunctions = @(
    'Set-AnsiColor',
    'Set-AnsiFormat', 
    'Move-AnsiCursor',
    'Clear-AnsiScreen',
    'New-AnsiSequence'
)

Export-ModuleMember -Function $PublicFunctions