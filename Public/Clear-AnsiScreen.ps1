function Clear-AnsiScreen {
    <#
    .SYNOPSIS
        Clear screen content using ANSI escape sequences.
    
    .DESCRIPTION
        This function provides screen clearing capabilities using ANSI escape sequences.
        Supports clearing entire screen, from cursor to end, or specific lines.
    
    .PARAMETER All
        Clear the entire screen.
    
    .PARAMETER FromCursor
        Clear from cursor position to end of screen.
    
    .PARAMETER ToCursor
        Clear from beginning of screen to cursor position.
    
    .PARAMETER CurrentLine
        Clear the current line.
    
    .PARAMETER FromCursorToEndOfLine
        Clear from cursor to end of current line.
    
    .PARAMETER FromStartOfLineToCursor
        Clear from start of line to cursor position.
    
    .PARAMETER ScrollUp
        Scroll screen up by specified number of lines.
    
    .PARAMETER ScrollDown
        Scroll screen down by specified number of lines.
    
    .EXAMPLE
        Clear-AnsiScreen -All
        
    .EXAMPLE
        Clear-AnsiScreen -CurrentLine
        
    .EXAMPLE
        Clear-AnsiScreen -ScrollUp 5
    #>
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'Screen')]
        [switch]$All,
        
        [Parameter(ParameterSetName = 'Screen')]
        [switch]$FromCursor,
        
        [Parameter(ParameterSetName = 'Screen')]
        [switch]$ToCursor,
        
        [Parameter(ParameterSetName = 'Line')]
        [switch]$CurrentLine,
        
        [Parameter(ParameterSetName = 'Line')]
        [switch]$FromCursorToEndOfLine,
        
        [Parameter(ParameterSetName = 'Line')]
        [switch]$FromStartOfLineToCursor,
        
        [Parameter(ParameterSetName = 'Scroll')]
        [int]$ScrollUp,
        
        [Parameter(ParameterSetName = 'Scroll')]
        [int]$ScrollDown
    )
    
    switch ($PSCmdlet.ParameterSetName) {
        'Screen' {
            if ($All) { Write-Host "`e[2J" -NoNewline }
            elseif ($FromCursor) { Write-Host "`e[0J" -NoNewline }
            elseif ($ToCursor) { Write-Host "`e[1J" -NoNewline }
        }
        'Line' {
            if ($CurrentLine) { Write-Host "`e[2K" -NoNewline }
            elseif ($FromCursorToEndOfLine) { Write-Host "`e[0K" -NoNewline }
            elseif ($FromStartOfLineToCursor) { Write-Host "`e[1K" -NoNewline }
        }
        'Scroll' {
            if ($ScrollUp -gt 0) { Write-Host "`e[${ScrollUp}S" -NoNewline }
            if ($ScrollDown -gt 0) { Write-Host "`e[${ScrollDown}T" -NoNewline }
        }
    }
}