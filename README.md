# PSAnsiEscape

A PowerShell module that makes using ANSI escape sequences in the terminal easy. This module provides comprehensive functions for colors (including 24-bit RGB and 256-color support), text formatting, cursor movement, screen manipulation, hyperlinks, and advanced terminal features using ANSI escape codes.

## Features

- **Color Support**: Apply foreground and background colors to text
  - 16 standard colors (Red, Green, Blue, etc.)
  - 256-color palette support
  - 24-bit RGB true color support
- **Text Formatting**: Bold, italic, underline, strikethrough, and more
- **Cursor Control**: Move cursor position, save/restore positions, show/hide cursor
- **Screen Manipulation**: Clear screen, lines, scroll, and alternate screen buffer
- **Window Titles**: Set terminal window and tab titles
- **Hyperlinks**: Create clickable links in supported terminals
- **Custom Sequences**: Create custom ANSI escape sequences
- **Advanced Features**: Query cursor position, terminal detection

<figure>
    <img src="Examples/example.png" alt="Console output showing various usage examples">
    <figcaption>Run Examples/BasicExamples.ps1 to view these examples in your terminal</figcaption>
</figure>

## Installation

1. Copy the module folder to one of your PowerShell module paths:
   ```powershell
   $env:PSModulePath -split ';'
   ```

2. Import the module:
   ```powershell
   Import-Module PSAnsiEscape
   ```

## Functions

### Set-AnsiColor
Apply ANSI color formatting to text.

```powershell
# Basic color
Set-AnsiColor -Text "Hello World" -ForegroundColor Red

# Color with background
Set-AnsiColor -Text "Important Message" -ForegroundColor White -BackgroundColor Red

# Pipeline support
"Hello World" | Set-AnsiColor -ForegroundColor Green
```

**Available Colors:**
- Black, Red, Green, Yellow, Blue, Magenta, Cyan, White
- BrightBlack, BrightRed, BrightGreen, BrightYellow, BrightBlue, BrightMagenta, BrightCyan, BrightWhite

### Set-AnsiFormat
Apply ANSI text formatting.

```powershell
# Bold text
Set-AnsiFormat -Text "Bold Text" -Bold

# Multiple formats
Set-AnsiFormat -Text "Important" -Bold -Underline

# Pipeline support
"Italic Text" | Set-AnsiFormat -Italic
```

**Available Formats:**
- Bold, Italic, Underline, Strikethrough, Dim, Blink, Invisible, Reverse

### Move-AnsiCursor
Move the cursor position.

```powershell
# Move relative
Move-AnsiCursor -Up 3
Move-AnsiCursor -Left 5

# Move to specific position
Move-AnsiCursor -Row 10 -Column 5

# Home position
Move-AnsiCursor -Home

# Save and restore position
Move-AnsiCursor -SavePosition
# ... do some work ...
Move-AnsiCursor -RestorePosition
```

### Clear-AnsiScreen
Clear screen content.

```powershell
# Clear entire screen
Clear-AnsiScreen -All

# Clear current line
Clear-AnsiScreen -CurrentLine

# Clear from cursor to end of line
Clear-AnsiScreen -FromCursorToEndOfLine

# Scroll screen
Clear-AnsiScreen -ScrollUp 5
```

### New-AnsiSequence
Create custom ANSI escape sequences.

```powershell
# Get raw sequence
$redColor = New-AnsiSequence -Code "31m" -Raw

# Execute sequence directly
New-AnsiSequence -Code "2J"  # Clear screen
```

### Set-AnsiTrueColor
Apply 24-bit RGB color formatting to text.

```powershell
# RGB values (0-255)
Set-AnsiTrueColor -Text "Bright Orange" -Red 255 -Green 165 -Blue 0

# Hex color codes
Set-AnsiTrueColor -Text "Custom Color" -HexColor "#FF5733"

# With background color
Set-AnsiTrueColor -Text "Full Custom" -Red 100 -Green 200 -Blue 50 -BackgroundRed 25 -BackgroundGreen 25 -BackgroundBlue 25

# Pipeline with hex colors
"Hello World" | Set-AnsiTrueColor -HexColor "#00FF00" -BackgroundHexColor "#000080"
```

### Set-Ansi256Color
Apply 256-color palette formatting to text.

```powershell
# Use color index (0-255)
Set-Ansi256Color -Text "Bright Orange" -ForegroundColor 208

# With background
Set-Ansi256Color -Text "Custom Colors" -ForegroundColor 82 -BackgroundColor 234

# Pipeline support
"Hello World" | Set-Ansi256Color -ForegroundColor 196

# Display color chart
Get-Ansi256ColorChart -ShowStandard -ShowGrayscale
```

**Color Ranges:**
- 0-15: Standard colors (same as 16-color mode)
- 16-231: 6×6×6 RGB color cube
- 232-255: Grayscale colors

### Set-AnsiCursor
Control cursor visibility and blinking.

```powershell
# Hide/show cursor
Set-AnsiCursor -Hide
Set-AnsiCursor -Show

# Control blinking
Set-AnsiCursor -DisableBlink
Set-AnsiCursor -EnableBlink
```

### Get-AnsiCursorPosition
Query the current cursor position.

```powershell
# Get current position
$pos = Get-AnsiCursorPosition
Write-Host "Cursor is at row $($pos.Row), column $($pos.Column)"

# With custom timeout
Get-AnsiCursorPosition -TimeoutMs 500
```

### Set-AnsiWindowTitle
Set terminal window and tab titles.

```powershell
# Set both window and tab title
Set-AnsiWindowTitle -Title "My PowerShell Session"

# Set only tab title
Set-AnsiWindowTitle -Title "Current Task" -TabOnly

# Set only window title
Set-AnsiWindowTitle -Title "PowerShell Console" -WindowOnly

# Reset to default
Reset-AnsiWindowTitle
```

### Alternate Screen Buffer
Switch between main and alternate screen buffers.

```powershell
# Manual control
Enter-AnsiAlternateScreen -ClearScreen
# ... do work in alternate screen ...
Exit-AnsiAlternateScreen

# Automatic with script block
Use-AnsiAlternateScreen -ClearScreen -SaveCursor -ScriptBlock {
    Write-Host "This appears in alternate screen"
    Read-Host "Press Enter to continue"
}
```

### New-AnsiHyperlink
Create clickable hyperlinks in supported terminals.

```powershell
# Basic hyperlink
New-AnsiHyperlink -Url "https://github.com" -Text "GitHub"

# Use URL as display text
New-AnsiHyperlink -Url "https://www.powershellgallery.com"

# Email link
New-AnsiHyperlink -Url "mailto:admin@example.com" -Text "Contact Admin"

# Write directly to console with formatting
Write-AnsiHyperlink -Url "https://github.com" -Text "GitHub" -ForegroundColor Blue

# Test terminal support
if (Test-AnsiHyperlinkSupport) {
    Write-Host "Terminal supports hyperlinks!"
}
```

## Examples

### Basic Usage
```powershell
# Import the module
Import-Module PSAnsiEscape

# Colorize some text
Write-Host (Set-AnsiColor -Text "Success!" -ForegroundColor Green)
Write-Host (Set-AnsiColor -Text "Warning!" -ForegroundColor Yellow)
Write-Host (Set-AnsiColor -Text "Error!" -ForegroundColor Red)

# Format text
Write-Host (Set-AnsiFormat -Text "Important Notice" -Bold -Underline)
```

### Advanced Example: System Status Dashboard
```powershell
# Create a system status dashboard in alternate screen
Use-AnsiAlternateScreen -ClearScreen -SaveCursor -ScriptBlock {
    # Hide cursor for cleaner display
    Set-AnsiCursor -Hide

    # Set window title
    Set-AnsiWindowTitle -Title "System Dashboard"

    # Create header with RGB colors
    $header = Set-AnsiTrueColor -Text "  SYSTEM STATUS DASHBOARD  " -HexColor "#FFFFFF" -BackgroundHexColor "#0066CC"
    $header = Set-AnsiFormat -Text $header -Bold

    Move-AnsiCursor -Row 2 -Column 20
    Write-Host $header

    # Status items with 256-colors
    Move-AnsiCursor -Row 4 -Column 5
    Write-Host "CPU Usage: " -NoNewline
    Write-Host (Set-Ansi256Color -Text "45%" -ForegroundColor 82) # Bright green

    Move-AnsiCursor -Row 5 -Column 5
    Write-Host "Memory: " -NoNewline
    Write-Host (Set-Ansi256Color -Text "78%" -ForegroundColor 214) # Orange

    Move-AnsiCursor -Row 6 -Column 5
    Write-Host "Disk Space: " -NoNewline
    Write-Host (Set-Ansi256Color -Text "23%" -ForegroundColor 46) # Green

    # Add a hyperlink
    Move-AnsiCursor -Row 8 -Column 5
    Write-Host "For more info: " -NoNewline
    Write-Host (New-AnsiHyperlink -Url "https://docs.microsoft.com/powershell" -Text "PowerShell Docs")

    Move-AnsiCursor -Row 10 -Column 5
    Set-AnsiFormat -Text "Press Enter to continue..." -Italic | Write-Host

    # Show cursor and wait
    Set-AnsiCursor -Show
    Read-Host
}
```

### True Color Gradient Example
```powershell
# Create a color gradient
for ($i = 0; $i -lt 50; $i++) {
    $red = [int](255 * ($i / 50))
    $green = [int](255 * (1 - $i / 50))
    $blue = 100

    $coloredText = Set-AnsiTrueColor -Text "█" -Red $red -Green $green -Blue $blue
    Write-Host $coloredText -NoNewline
}
Write-Host "" # New line
```

### Pipeline Usage
```powershell
"Hello", "World" | ForEach-Object {
    $_ | Set-AnsiColor -ForegroundColor (Get-Random -InputObject @('Red', 'Green', 'Blue', 'Yellow'))
} | ForEach-Object {
    Write-Host $_
}
```

## Requirements

- PowerShell 5.1 or higher
- Terminal that supports ANSI escape sequences

## Compatibility

### Basic Features (Colors, Formatting, Cursor Movement)
- ✅ Windows Terminal
- ✅ PowerShell 7+ integrated console
- ✅ VS Code integrated terminal
- ✅ Most Unix/Linux terminals
- ✅ macOS Terminal
- ⚠️ Windows PowerShell ISE (limited support)
- ❌ Legacy Windows Console (cmd.exe)

### Advanced Features Support

| Feature | Windows Terminal | VS Code | iTerm2 | GNOME Terminal | Legacy Console |
|---------|:----------------:|:-------:|:------:|:--------------:|:--------------:|
| 24-bit RGB Colors | ✅ | ✅ | ✅ | ✅ | ❌ |
| 256 Colors | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| Hyperlinks | ✅ | ✅ | ✅ | ✅ | ❌ |
| Alternate Screen | ✅ | ✅ | ✅ | ✅ | ❌ |
| Window Titles | ✅ | ⚠️ | ✅ | ✅ | ❌ |
| Cursor Position Query | ✅ | ✅ | ✅ | ✅ | ❌ |

**Legend:** ✅ Full Support, ⚠️ Partial Support, ❌ No Support

**Notes:**
- Use `Test-AnsiHyperlinkSupport` to detect hyperlink support
- 256-color support varies on older terminals
- Some features may not work in non-interactive sessions

## License

This project is licensed under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.