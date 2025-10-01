function Set-Ansi256Color {
    <#
    .SYNOPSIS
        Apply 256-color palette formatting to text.
    
    .DESCRIPTION
        This function applies ANSI escape sequences for 256-color palette formatting.
        Supports both foreground and background colors using the extended 256-color palette.
        Colors 0-15 are standard colors, 16-231 are a 6x6x6 RGB cube, and 232-255 are grayscale.
    
    .PARAMETER Text
        The text to colorize.
    
    .PARAMETER ForegroundColor
        Color index (0-255) for foreground color.
    
    .PARAMETER BackgroundColor
        Color index (0-255) for background color.
    
    .PARAMETER Reset
        Whether to add a reset sequence at the end (default: $true).
    
    .EXAMPLE
        Set-Ansi256Color -Text "Bright Orange" -ForegroundColor 208
        
    .EXAMPLE
        Set-Ansi256Color -Text "Custom Colors" -ForegroundColor 82 -BackgroundColor 234
        
    .EXAMPLE
        "Hello World" | Set-Ansi256Color -ForegroundColor 196
        
    .NOTES
        Common color ranges:
        - 0-15: Standard colors (same as 16-color mode)
        - 16-231: 6x6x6 RGB color cube
        - 232-255: Grayscale colors from dark to light
        
        RGB cube calculation: 16 + (36 * r) + (6 * g) + b
        where r, g, b are each 0-5
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Text,
        
        [ValidateRange(0, 255)]
        [int]$ForegroundColor,
        
        [ValidateRange(0, 255)]
        [int]$BackgroundColor,
        
        [bool]$Reset = $true
    )
    
    process {
        $codes = @()
        
        # Add foreground color if specified
        if ($PSBoundParameters.ContainsKey('ForegroundColor')) {
            $codes += "38;5;$ForegroundColor"
        }
        
        # Add background color if specified
        if ($PSBoundParameters.ContainsKey('BackgroundColor')) {
            $codes += "48;5;$BackgroundColor"
        }
        
        if ($codes.Count -gt 0) {
            $ansiSequence = "`e[" + ($codes -join ';') + 'm'
            $result = $ansiSequence + $Text
            
            if ($Reset) {
                $result += "`e[0m"
            }
            
            return $result
        } else {
            return $Text
        }
    }
}

function Get-Ansi256ColorChart {
    <#
    .SYNOPSIS
        Display a chart of available 256 colors with their indices.
    
    .DESCRIPTION
        This helper function displays a visual chart of all 256 colors available
        in the extended color palette, showing both the color and its index number.
    
    .PARAMETER ShowGrayscale
        Also display the grayscale colors (232-255).
    
    .PARAMETER ShowStandard
        Also display the standard 16 colors (0-15).
    
    .EXAMPLE
        Get-Ansi256ColorChart
        Display the full 256-color chart
        
    .EXAMPLE
        Get-Ansi256ColorChart -ShowStandard -ShowGrayscale
        Display all colors including standard and grayscale sections
    #>
    [CmdletBinding()]
    param(
        [switch]$ShowStandard,
        [switch]$ShowGrayscale
    )
    
    Write-Host "256-Color Palette Chart" -ForegroundColor Yellow
    Write-Host "======================" -ForegroundColor Yellow
    
    if ($ShowStandard) {
        Write-Host "`nStandard Colors (0-15):" -ForegroundColor Cyan
        for ($i = 0; $i -lt 16; $i++) {
            $colorText = Set-Ansi256Color -Text (" {0:D3} " -f $i) -BackgroundColor $i -ForegroundColor (if ($i -lt 8) { 255 } else { 0 })
            Write-Host $colorText -NoNewline
            if (($i + 1) % 8 -eq 0) { Write-Host "" }
        }
        Write-Host ""
    }
    
    Write-Host "`n6x6x6 RGB Color Cube (16-231):" -ForegroundColor Cyan
    for ($r = 0; $r -lt 6; $r++) {
        Write-Host "Red level $r" -ForegroundColor White
        for ($g = 0; $g -lt 6; $g++) {
            for ($b = 0; $b -lt 6; $b++) {
                $colorIndex = 16 + (36 * $r) + (6 * $g) + $b
                $colorText = Set-Ansi256Color -Text (" {0:D3} " -f $colorIndex) -BackgroundColor $colorIndex -ForegroundColor (if ($colorIndex -lt 100) { 255 } else { 0 })
                Write-Host $colorText -NoNewline
            }
            Write-Host "  " -NoNewline
        }
        Write-Host ""
    }
    
    if ($ShowGrayscale) {
        Write-Host "`nGrayscale Colors (232-255):" -ForegroundColor Cyan
        for ($i = 232; $i -lt 256; $i++) {
            $colorText = Set-Ansi256Color -Text (" {0:D3} " -f $i) -BackgroundColor $i -ForegroundColor (if ($i -lt 244) { 255 } else { 0 })
            Write-Host $colorText -NoNewline
            if (($i - 231) % 8 -eq 0) { Write-Host "" }
        }
        Write-Host ""
    }
    
    Write-Host "`nUsage: Set-Ansi256Color -Text 'Your Text' -ForegroundColor <0-255>" -ForegroundColor Green
}