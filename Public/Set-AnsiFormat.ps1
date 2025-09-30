function Set-AnsiFormat {
    <#
    .SYNOPSIS
        Apply ANSI text formatting to text.
    
    .DESCRIPTION
        This function applies ANSI escape sequences for text formatting like bold, italic, underline, etc.
    
    .PARAMETER Text
        The text to format.
    
    .PARAMETER Bold
        Make the text bold.
    
    .PARAMETER Italic
        Make the text italic.
    
    .PARAMETER Underline
        Underline the text.
    
    .PARAMETER Strikethrough
        Add strikethrough to the text.
    
    .PARAMETER Dim
        Make the text dim/faint.
    
    .PARAMETER Blink
        Make the text blink.
    
    .PARAMETER Reverse
        Reverse foreground and background colors.
    
    .PARAMETER Reset
        Whether to add a reset sequence at the end (default: $true).
    
    .EXAMPLE
        Set-AnsiFormat -Text "Bold Text" -Bold
        
    .EXAMPLE
        Set-AnsiFormat -Text "Important" -Bold -Underline
        
    .EXAMPLE
        Set-AnsiFormat -Text "Attention!" -Blink
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Text,
        
        [switch]$Bold,
        [switch]$Italic,
        [switch]$Underline,
        [switch]$Strikethrough,
        [switch]$Dim,
        [switch]$Blink,
        [switch]$Reverse,
        
        [bool]$Reset = $true
    )
    
    process {
        $codes = @()
        
        if ($Bold) { $codes += '1' }
        if ($Dim) { $codes += '2' }
        if ($Italic) { $codes += '3' }
        if ($Underline) { $codes += '4' }
        if ($Blink) { $codes += '5' }
        if ($Reverse) { $codes += '7' }
        if ($Strikethrough) { $codes += '9' }
        
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