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

# Combined Color and Format
Write-Host "`n=== Combined Examples ===" -ForegroundColor Cyan
$text = "Important Notice"
$text = Set-AnsiColor -Text $text -ForegroundColor Red -BackgroundColor Yellow
$text = Set-AnsiFormat -Text $text -Bold
Write-Host $text

# Pipeline Examples
Write-Host "`n=== Pipeline Examples ===" -ForegroundColor Cyan
@("Red", "Green", "Blue") | ForEach-Object {
    $_ | Set-AnsiColor -ForegroundColor $_ | Set-AnsiFormat -Bold
} | ForEach-Object {
    Write-Host $_
}

# Cursor Movement Example
Write-Host "`n=== Cursor Movement Example ===" -ForegroundColor Cyan
Write-Host "Watch the cursor move..."
Start-Sleep -Seconds 1

# Save current position
Move-AnsiCursor -SavePosition

# Move around and write text
Move-AnsiCursor -Down 2
Write-Host "Line 1" -NoNewline
Move-AnsiCursor -Down 1 -Right 6
Write-Host "Line 2" -NoNewline
Move-AnsiCursor -Down 1 -Right 6
Write-Host "Line 3" -NoNewline

Start-Sleep -Seconds 2

# Restore position
Move-AnsiCursor -RestorePosition

# Screen Clearing Example (commented out to avoid clearing the console)
<#
Write-Host "`n=== Screen Clearing Example ===" -ForegroundColor Cyan
Write-Host "This would clear the screen..."
# Clear-AnsiScreen -All
# Move-AnsiCursor -Home
#>

# Custom Sequence Example
Write-Host "`n=== Custom Sequence Example ===" -ForegroundColor Cyan
$customRed = New-AnsiSequence -Code "91m" -Raw  # Bright red
$reset = New-AnsiSequence -Code "0m" -Raw       # Reset
Write-Host "${customRed}Custom bright red text${reset}"

Write-Host "`n=== Examples Complete ===`n"