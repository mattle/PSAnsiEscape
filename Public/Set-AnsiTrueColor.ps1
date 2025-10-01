function Set-AnsiTrueColor {
    <#
    .SYNOPSIS
        Apply 24-bit RGB color formatting to text.
    
    .DESCRIPTION
        This function applies ANSI escape sequences for 24-bit true color (RGB) formatting.
        Supports both foreground and background colors with full RGB range (0-255 per channel).
        Requires a terminal that supports 24-bit color (most modern terminals do).
    
    .PARAMETER Text
        The text to colorize.
    
    .PARAMETER Red
        Red color component (0-255) for foreground color.
    
    .PARAMETER Green
        Green color component (0-255) for foreground color.
    
    .PARAMETER Blue
        Blue color component (0-255) for foreground color.
    
    .PARAMETER BackgroundRed
        Red color component (0-255) for background color.
    
    .PARAMETER BackgroundGreen
        Green color component (0-255) for background color.
    
    .PARAMETER BackgroundBlue
        Blue color component (0-255) for background color.
    
    .PARAMETER HexColor
        Hex color code for foreground (e.g., "#FF5733" or "FF5733").
    
    .PARAMETER BackgroundHexColor
        Hex color code for background (e.g., "#FF5733" or "FF5733").
    
    .PARAMETER Reset
        Whether to add a reset sequence at the end (default: $true).
    
    .EXAMPLE
        Set-AnsiTrueColor -Text "Bright Red Text" -Red 255 -Green 0 -Blue 0
        
    .EXAMPLE
        Set-AnsiTrueColor -Text "Custom Color" -HexColor "#FF5733"
        
    .EXAMPLE
        Set-AnsiTrueColor -Text "Full Custom" -Red 100 -Green 200 -Blue 50 -BackgroundRed 25 -BackgroundGreen 25 -BackgroundBlue 25
        
    .EXAMPLE
        "Hello World" | Set-AnsiTrueColor -HexColor "#00FF00" -BackgroundHexColor "#000080"
    #>
    [CmdletBinding(DefaultParameterSetName = 'RGB')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Text,
        
        [Parameter(ParameterSetName = 'RGB')]
        [ValidateRange(0, 255)]
        [int]$Red,
        
        [Parameter(ParameterSetName = 'RGB')]
        [ValidateRange(0, 255)]
        [int]$Green,
        
        [Parameter(ParameterSetName = 'RGB')]
        [ValidateRange(0, 255)]
        [int]$Blue,
        
        [Parameter(ParameterSetName = 'RGB')]
        [ValidateRange(0, 255)]
        [int]$BackgroundRed,
        
        [Parameter(ParameterSetName = 'RGB')]
        [ValidateRange(0, 255)]
        [int]$BackgroundGreen,
        
        [Parameter(ParameterSetName = 'RGB')]
        [ValidateRange(0, 255)]
        [int]$BackgroundBlue,
        
        [Parameter(ParameterSetName = 'Hex')]
        [ValidatePattern('^#?[0-9A-Fa-f]{6}$')]
        [string]$HexColor,
        
        [Parameter(ParameterSetName = 'Hex')]
        [ValidatePattern('^#?[0-9A-Fa-f]{6}$')]
        [string]$BackgroundHexColor,
        
        [bool]$Reset = $true
    )
    
    process {
        $codes = @()
        
        # Helper function to convert hex to RGB
        function ConvertHexToRGB {
            param([string]$HexValue)
            
            $hex = $HexValue -replace '^#', ''
            $r = [Convert]::ToInt32($hex.Substring(0, 2), 16)
            $g = [Convert]::ToInt32($hex.Substring(2, 2), 16)
            $b = [Convert]::ToInt32($hex.Substring(4, 2), 16)
            
            return @($r, $g, $b)
        }
        
        if ($PSCmdlet.ParameterSetName -eq 'Hex') {
            if ($HexColor) {
                $rgb = ConvertHexToRGB -HexValue $HexColor
                $Red = $rgb[0]
                $Green = $rgb[1]
                $Blue = $rgb[2]
            }
            
            if ($BackgroundHexColor) {
                $bgRgb = ConvertHexToRGB -HexValue $BackgroundHexColor
                $BackgroundRed = $bgRgb[0]
                $BackgroundGreen = $bgRgb[1]
                $BackgroundBlue = $bgRgb[2]
            }
        }
        
        # Add foreground color if specified
        if ($PSBoundParameters.ContainsKey('Red') -or $PSBoundParameters.ContainsKey('HexColor')) {
            $codes += "38;2;$Red;$Green;$Blue"
        }
        
        # Add background color if specified
        if ($PSBoundParameters.ContainsKey('BackgroundRed') -or $PSBoundParameters.ContainsKey('BackgroundHexColor')) {
            $codes += "48;2;$BackgroundRed;$BackgroundGreen;$BackgroundBlue"
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