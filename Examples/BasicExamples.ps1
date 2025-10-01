# PSAnsiEscape Examples
# This script demonstrates the basic usage of the PSAnsiEscape module

# Import the module (assumes it's in your module path)
Import-Module PSAnsiEscape

Write-Host "`n=== PSAnsiEscape Module Examples ===`n"

# Color Examples
Write-Host "=== Color Examples ===" -ForegroundColor Cyan
Write-Host (Set-AnsiColor -Text "Success!" -ForegroundColor Green)
Write-Host (Set-AnsiColor -Text "Warning!" -ForegroundColor Yellow)
Write-Host (Set-AnsiColor -Text "Error!" -ForegroundColor Red)
Write-Host (Set-AnsiColor -Text "Info with background" -ForegroundColor White -BackgroundColor Blue)

# Format Examples
Write-Host "`n=== Format Examples ===" -ForegroundColor Cyan
Write-Host (Set-AnsiFormat -Text "Bold Text" -Bold)
Write-Host (Set-AnsiFormat -Text "Italic Text" -Italic)
Write-Host (Set-AnsiFormat -Text "Underlined Text" -Underline)
Write-Host (Set-AnsiFormat -Text "Bold and Underlined" -Bold -Underline)
Write-Host (Set-AnsiFormat -Text "Dim Text" -Dim)
Write-Host (Set-AnsiFormat -Text "Blinking Text" -Blink)
Write-Host (Set-AnsiFormat -Text "Secrete message!" -Invisible), "<- Invisible text!"

Write-Host "`n=== Examples Complete ===`n"