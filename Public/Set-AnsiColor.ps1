function Set-AnsiColor {
    <#
    .SYNOPSIS
        Apply ANSI color formatting to text.
    
    .DESCRIPTION
        This function applies ANSI escape sequences to colorize text in the terminal.
        Supports both foreground and background colors using standard ANSI color codes.
    
    .PARAMETER Text
        The text to colorize.
    
    .PARAMETER ForegroundColor
        The foreground color to apply.
    
    .PARAMETER BackgroundColor
        The background color to apply.
    
    .PARAMETER Reset
        Whether to add a reset sequence at the end (default: $true).
    
    .EXAMPLE
        Set-AnsiColor -Text "Hello World" -ForegroundColor Red
        
    .EXAMPLE
        Set-AnsiColor -Text "Important Message" -ForegroundColor White -BackgroundColor Red
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Text,
        
        [ValidateSet('Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
                     'BrightBlack', 'BrightRed', 'BrightGreen', 'BrightYellow', 
                     'BrightBlue', 'BrightMagenta', 'BrightCyan', 'BrightWhite')]
        [string]$ForegroundColor,
        
        [ValidateSet('Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White',
                     'BrightBlack', 'BrightRed', 'BrightGreen', 'BrightYellow', 
                     'BrightBlue', 'BrightMagenta', 'BrightCyan', 'BrightWhite')]
        [string]$BackgroundColor,
        
        [bool]$Reset = $true
    )
    
    process {
        $ansiSequence = "`e["
        $codes = @()
        
        # Define color codes
        $colorMap = @{
            'Black'         = 30
            'Red'           = 31
            'Green'         = 32
            'Yellow'        = 33
            'Blue'          = 34
            'Magenta'       = 35
            'Cyan'          = 36
            'White'         = 37
            'BrightBlack'   = 90
            'BrightRed'     = 91
            'BrightGreen'   = 92
            'BrightYellow'  = 93
            'BrightBlue'    = 94
            'BrightMagenta' = 95
            'BrightCyan'    = 96
            'BrightWhite'   = 97
        }
        
        if ($ForegroundColor) {
            $codes += $colorMap[$ForegroundColor]
        }
        
        if ($BackgroundColor) {
            $codes += ($colorMap[$BackgroundColor] + 10)
        }
        
        if ($codes.Count -gt 0) {
            $ansiSequence += ($codes -join ';') + 'm'
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