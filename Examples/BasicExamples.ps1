#!/usr/bin/env pwsh
# PSAnsiEscape Comprehensive Examples
# This script demonstrates all features of the PSAnsiEscape module v2.0
# Run this script in a modern terminal (Windows Terminal, VS Code, etc.) for best results

param(
    [switch]$SkipInteractive,
    [switch]$ShowColorCharts,
    [switch]$TestAlternateScreen
)

# Import the module (assumes it's in your module path)
try {
    Import-Module PSAnsiEscape -Force
    Write-Host "✅ PSAnsiEscape module loaded successfully" -ForegroundColor Green
}
catch {
    Write-Error "Failed to load PSAnsiEscape module. Make sure it's installed and in your module path."
    exit 1
}

# Helper function for section headers
function Write-SectionHeader {
    param([string]$Title)
    Write-Host "`n" -NoNewline
    Write-Host (Set-AnsiFormat -Text "=== $Title ===" -Bold) -ForegroundColor Cyan
}

# Helper function for subsection headers
function Write-SubsectionHeader {
    param([string]$Title)
    Write-Host (Set-AnsiFormat -Text "--- $Title ---" -Underline) -ForegroundColor Yellow
}

# Helper function for interactive pause
function Wait-UserInput {
    param([string]$Message = "Press Enter to continue...")
    if (-not $SkipInteractive) {
        Write-Host "`n" -NoNewline
        Write-Host (Set-AnsiFormat -Text $Message -Italic) -ForegroundColor Gray
        Read-Host | Out-Null
    }
}

# Main examples start
Clear-Host
Set-AnsiWindowTitle -Title "PSAnsiEscape v2.0 - Comprehensive Examples"

# Welcome header with RGB colors
$welcomeText = Set-AnsiTrueColor -Text "  PSAnsiEscape v2.0 - Comprehensive Examples  " -HexColor "#FFFFFF" -BackgroundHexColor "#0066CC"
$welcomeText = Set-AnsiFormat -Text $welcomeText -Bold
Write-Host "`n$welcomeText`n"

Write-Host "This script demonstrates all the ANSI escape sequence functions available in PSAnsiEscape v2.0"
Write-Host "For the best experience, run this in Windows Terminal, VS Code, or another modern terminal."
Wait-UserInput

#region Basic Color Examples
Write-SectionHeader "Basic 16-Color Support"
Write-Host "Standard 16 colors with Set-AnsiColor:"

$colors = @('Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
            'BrightBlack', 'BrightRed', 'BrightGreen', 'BrightYellow', 'BrightBlue', 'BrightMagenta', 'BrightCyan', 'BrightWhite')

foreach ($color in $colors) {
    $coloredText = Set-AnsiColor -Text (" {0,-12} " -f $color) -ForegroundColor $color
    Write-Host $coloredText -NoNewline
    if (($colors.IndexOf($color) + 1) % 4 -eq 0) { Write-Host "" }
}

Write-Host "`nWith background colors:"
Write-Host (Set-AnsiColor -Text "Success Message" -ForegroundColor White -BackgroundColor Green)
Write-Host (Set-AnsiColor -Text "Warning Message" -ForegroundColor Black -BackgroundColor Yellow)
Write-Host (Set-AnsiColor -Text "Error Message" -ForegroundColor White -BackgroundColor Red)
Write-Host (Set-AnsiColor -Text "Info Message" -ForegroundColor White -BackgroundColor Blue)
Wait-UserInput
#endregion

#region Text Formatting Examples
Write-SectionHeader "Text Formatting with Set-AnsiFormat"
Write-Host (Set-AnsiFormat -Text "Bold Text" -Bold)
Write-Host (Set-AnsiFormat -Text "Italic Text" -Italic)
Write-Host (Set-AnsiFormat -Text "Underlined Text" -Underline)
Write-Host (Set-AnsiFormat -Text "Strikethrough Text" -Strikethrough)
Write-Host (Set-AnsiFormat -Text "Dim Text" -Dim)
Write-Host (Set-AnsiFormat -Text "Blinking Text (may not work in all terminals)" -Blink)
Write-Host (Set-AnsiFormat -Text "Reverse Video" -Reverse)
Write-Host "Invisible text: " -NoNewline
Write-Host (Set-AnsiFormat -Text "Secret message!" -Invisible) -NoNewline
Write-Host " <- Hidden text (select to reveal)"

Write-Host "`nCombined formatting:"
Write-Host (Set-AnsiFormat -Text "Bold + Underlined + Red" -Bold -Underline | Set-AnsiColor -ForegroundColor Red)
Write-Host (Set-AnsiFormat -Text "Italic + Blue Background" -Italic | Set-AnsiColor -BackgroundColor Blue -ForegroundColor White)
Wait-UserInput
#endregion

#region True Color (24-bit RGB) Examples
Write-SectionHeader "24-bit RGB True Colors with Set-AnsiTrueColor"

Write-SubsectionHeader "RGB Values"
Write-Host (Set-AnsiTrueColor -Text "Pure Red (255,0,0)" -Red 255 -Green 0 -Blue 0)
Write-Host (Set-AnsiTrueColor -Text "Orange (255,165,0)" -Red 255 -Green 165 -Blue 0)
Write-Host (Set-AnsiTrueColor -Text "Purple (128,0,128)" -Red 128 -Green 0 -Blue 128)
Write-Host (Set-AnsiTrueColor -Text "Teal (0,128,128)" -Red 0 -Green 128 -Blue 128)

Write-SubsectionHeader "Hex Color Codes"
Write-Host (Set-AnsiTrueColor -Text "GitHub Orange (#FF5733)" -HexColor "#FF5733")
Write-Host (Set-AnsiTrueColor -Text "PowerShell Blue (#012456)" -HexColor "#012456")
Write-Host (Set-AnsiTrueColor -Text "VS Code Blue (#007ACC)" -HexColor "#007ACC")
Write-Host (Set-AnsiTrueColor -Text "Success Green (#28A745)" -HexColor "#28A745")

Write-SubsectionHeader "Background Colors"
Write-Host (Set-AnsiTrueColor -Text "White on Dark Blue" -HexColor "#FFFFFF" -BackgroundHexColor "#003366")
Write-Host (Set-AnsiTrueColor -Text "Dark Text on Light Background" -Red 50 -Green 50 -Blue 50 -BackgroundRed 220 -BackgroundGreen 220 -BackgroundBlue 220)

Write-SubsectionHeader "Color Gradient Example"
Write-Host "Rainbow gradient: " -NoNewline
for ($i = 0; $i -lt 40; $i++) {
    $hue = ($i / 40) * 360
    # Simple HSV to RGB conversion for demo
    $c = 1
    $x = $c * (1 - [Math]::Abs((($hue / 60) % 2) - 1))
    $m = 0

    switch ([Math]::Floor($hue / 60)) {
        0 { $r = $c; $g = $x; $b = 0 }
        1 { $r = $x; $g = $c; $b = 0 }
        2 { $r = 0; $g = $c; $b = $x }
        3 { $r = 0; $g = $x; $b = $c }
        4 { $r = $x; $g = 0; $b = $c }
        5 { $r = $c; $g = 0; $b = $x }
    }

    $red = [int](($r + $m) * 255)
    $green = [int](($g + $m) * 255)
    $blue = [int](($b + $m) * 255)

    Write-Host (Set-AnsiTrueColor -Text "█" -Red $red -Green $green -Blue $blue) -NoNewline
}
Write-Host "" # New line
Wait-UserInput
#endregion

#region 256-Color Palette Examples
Write-SectionHeader "256-Color Palette with Set-Ansi256Color"

Write-Host "Sample 256-color palette colors:"
Write-Host (Set-Ansi256Color -Text "Color 196 (Bright Red)" -ForegroundColor 196)
Write-Host (Set-Ansi256Color -Text "Color 46 (Bright Green)" -ForegroundColor 46)
Write-Host (Set-Ansi256Color -Text "Color 21 (Bright Blue)" -ForegroundColor 21)
Write-Host (Set-Ansi256Color -Text "Color 208 (Orange)" -ForegroundColor 208)
Write-Host (Set-Ansi256Color -Text "Color 165 (Magenta)" -ForegroundColor 165)
Write-Host (Set-Ansi256Color -Text "Color 51 (Cyan)" -ForegroundColor 51)

Write-Host "`nWith background colors:"
Write-Host (Set-Ansi256Color -Text "Bright text on dark background" -ForegroundColor 226 -BackgroundColor 235)
Write-Host (Set-Ansi256Color -Text "Dark text on light background" -ForegroundColor 235 -BackgroundColor 226)

if ($ShowColorCharts) {
    Write-Host "`nDisplaying full 256-color chart (this may be large):"
    Wait-UserInput "Press Enter to show the color chart..."
    Get-Ansi256ColorChart -ShowStandard -ShowGrayscale
}
else {
    Write-Host "`n💡 Use the -ShowColorCharts parameter to see the full 256-color palette"
}
Wait-UserInput
#endregion

#region Cursor Control Examples
Write-SectionHeader "Cursor Control with Set-AnsiCursor and Get-AnsiCursorPosition"

# Save current position
$originalPos = Get-AnsiCursorPosition
if ($originalPos) {
    Write-Host "Current cursor position: Row $($originalPos.Row), Column $($originalPos.Column)"
}
else {
    Write-Host "⚠️ Cursor position detection not supported in this terminal"
}

Write-Host "`nDemonstrating cursor visibility control:"
Write-Host "Cursor will be hidden for 2 seconds..." -NoNewline
Set-AnsiCursor -Hide
Start-Sleep -Seconds 2
Set-AnsiCursor -Show
Write-Host " Cursor is now visible again!"

Write-Host "`nDemonstrating cursor movement:"
Write-Host "Moving cursor around to draw a simple pattern:"

# Draw a simple box pattern
Move-AnsiCursor -SavePosition
for ($i = 0; $i -lt 5; $i++) {
    Write-Host "*" -NoNewline
    if ($i -lt 4) {
        Move-AnsiCursor -Right 2
    }
}
Move-AnsiCursor -Down 1
Move-AnsiCursor -Left 8
for ($i = 0; $i -lt 3; $i++) {
    Write-Host "*" -NoNewline
    Move-AnsiCursor -Down 1
    Move-AnsiCursor -Left 1
}
for ($i = 0; $i -lt 5; $i++) {
    Write-Host "*" -NoNewline
    if ($i -lt 4) {
        Move-AnsiCursor -Right 2
    }
}
Move-AnsiCursor -RestorePosition
Move-AnsiCursor -Down 5
Wait-UserInput
#endregion

#region Window Title Examples
Write-SectionHeader "Window Title Management"

Write-Host "Demonstrating window title changes (look at your terminal title bar):"

$originalTitle = "PSAnsiEscape Examples"
Set-AnsiWindowTitle -Title "Example 1: Basic Title"
Write-Host "✅ Set basic window title"
Start-Sleep -Seconds 2

Set-AnsiWindowTitle -Title "Example 2: Tab Only" -TabOnly
Write-Host "✅ Set tab-only title"
Start-Sleep -Seconds 2

Set-AnsiWindowTitle -Title "Example 3: Window Only" -WindowOnly
Write-Host "✅ Set window-only title"
Start-Sleep -Seconds 2

Set-AnsiWindowTitle -Title $originalTitle
Write-Host "✅ Restored original title"
Wait-UserInput
#endregion

#region Hyperlink Examples
Write-SectionHeader "Hyperlink Support with New-AnsiHyperlink"

Write-Host "🔗 Hyperlink examples (try clicking if your terminal supports them):"
Write-Host "Note: Hyperlink support varies by terminal (Windows Terminal, VS Code, iTerm2, etc.)"
Write-Host "Visit: " -NoNewline
Write-Host (New-AnsiHyperlink -Url "https://github.com/PowerShell/PowerShell" -Text "PowerShell GitHub")

Write-Host "Documentation: " -NoNewline
Write-Host (New-AnsiHyperlink -Url "https://docs.microsoft.com/powershell" -Text "PowerShell Docs")

Write-Host "Email: " -NoNewline
Write-Host (New-AnsiHyperlink -Url "mailto:example@domain.com" -Text "Contact Support")

Write-Host "With colors: " -NoNewline
Write-AnsiHyperlink -Url "https://www.powershellgallery.com" -Text "PowerShell Gallery" -ForegroundColor Blue
Wait-UserInput
#endregion

#region Screen Clearing Examples
Write-SectionHeader "Screen Manipulation with Clear-AnsiScreen"

Write-Host "Demonstrating various screen clearing options:"
Write-Host "This is line 1"
Write-Host "This is line 2"
Write-Host "This is line 3 - will be partially cleared"

Start-Sleep -Seconds 1
Move-AnsiCursor -Up 1
Move-AnsiCursor -Column 15
Clear-AnsiScreen -FromCursorToEndOfLine
Write-Host "<- Line cleared from cursor"

Start-Sleep -Seconds 1
Write-Host "Adding more content..."
Write-Host "Before scroll demonstration"

Start-Sleep -Seconds 1
Clear-AnsiScreen -ScrollUp 2
Write-Host "Scrolled up 2 lines!"
Wait-UserInput
#endregion

#region Alternate Screen Examples
if ($TestAlternateScreen) {
    Write-SectionHeader "Alternate Screen Buffer Demo"

    Write-Host "About to switch to alternate screen buffer for 5 seconds..."
    Write-Host "The current content will be preserved and restored."
    Wait-UserInput "Press Enter to continue to alternate screen..."

    Use-AnsiAlternateScreen -ClearScreen -SaveCursor -ScriptBlock {
        # In alternate screen
        Set-AnsiCursor -Hide

        # Create a fancy display
        $header = Set-AnsiTrueColor -Text "  ALTERNATE SCREEN DEMO  " -HexColor "#FFFFFF" -BackgroundHexColor "#CC0066"
        $header = Set-AnsiFormat -Text $header -Bold

        Move-AnsiCursor -Row 5 -Column 20
        Write-Host $header

        Move-AnsiCursor -Row 7 -Column 10
        Write-Host "🌟 This is displayed in the alternate screen buffer"

        Move-AnsiCursor -Row 9 -Column 10
        Write-Host "🔄 Your original terminal content is preserved"

        Move-AnsiCursor -Row 11 -Column 10
        Write-Host "⏱️  Returning to main screen in 5 seconds..."

        # Draw a simple progress bar
        Move-AnsiCursor -Row 13 -Column 10
        Write-Host "Progress: [" -NoNewline

        for ($i = 1; $i -le 20; $i++) {
            Start-Sleep -Milliseconds 200
            Write-Host (Set-AnsiTrueColor -Text "█" -HexColor "#00FF00") -NoNewline
        }

        Write-Host "] Complete!"
        Start-Sleep -Seconds 1

        Set-AnsiCursor -Show
    }

    Write-Host "✅ Returned from alternate screen - original content preserved!"
}
else {
    Write-SectionHeader "Alternate Screen Buffer"
    Write-Host "💡 Use the -TestAlternateScreen parameter to see the alternate screen demo"
    Write-Host "   (This preserves your current terminal content)"
}
Wait-UserInput
#endregion

#region Summary and Tips
Write-SectionHeader "Summary and Tips"

Write-Host "🎉 " -NoNewline
Write-Host (Set-AnsiFormat -Text "PSAnsiEscape v2.0 Examples Complete!" -Bold) -ForegroundColor Green
Write-Host ""

Write-Host "💡 Pro Tips:"

Write-Host "   • Combine " -NoNewline
Write-Host (Set-AnsiFormat -Text "Set-AnsiTrueColor" -Bold) -NoNewline
Write-Host " with hex codes for precise colors"

Write-Host "   • Use " -NoNewline
Write-Host (Set-AnsiFormat -Text "Use-AnsiAlternateScreen" -Bold) -NoNewline
Write-Host " for full-screen applications"

Write-Host "   • Always call " -NoNewline
Write-Host (Set-AnsiFormat -Text "Set-AnsiCursor -Show" -Bold) -NoNewline
Write-Host " if you hide the cursor"

Write-Host "   • Modern terminals (Windows Terminal, VS Code) support most features"

Write-Host ""
Write-Host "📖 For more information, check the README.md file or use Get-Help <FunctionName>"

# Reset window title
Reset-AnsiWindowTitle

Write-Host ""
Write-Host (Set-AnsiTrueColor -Text "Thank you for using PSAnsiEscape! 🚀" -HexColor "#FF6B35")
Write-Host ""
#endregion
