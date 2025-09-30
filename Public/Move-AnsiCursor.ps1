function Move-AnsiCursor {
    <#
    .SYNOPSIS
        Move the cursor position using ANSI escape sequences.
    
    .DESCRIPTION
        This function provides cursor movement capabilities using ANSI escape sequences.
        Supports moving up, down, left, right, and positioning at specific coordinates.
    
    .PARAMETER Up
        Move cursor up by specified number of lines.
    
    .PARAMETER Down
        Move cursor down by specified number of lines.
    
    .PARAMETER Left
        Move cursor left by specified number of columns.
    
    .PARAMETER Right
        Move cursor right by specified number of columns.
    
    .PARAMETER Row
        Move cursor to specific row (1-based).
    
    .PARAMETER Column
        Move cursor to specific column (1-based).
    
    .PARAMETER Home
        Move cursor to home position (1,1).
    
    .PARAMETER SavePosition
        Save the current cursor position.
    
    .PARAMETER RestorePosition
        Restore the previously saved cursor position.
    
    .EXAMPLE
        Move-AnsiCursor -Up 3
        
    .EXAMPLE
        Move-AnsiCursor -Row 10 -Column 5
        
    .EXAMPLE
        Move-AnsiCursor -Home
    #>
    [CmdletBinding(DefaultParameterSetName = 'Direction')]
    param(
        [Parameter(ParameterSetName = 'Direction')]
        [int]$Up,
        
        [Parameter(ParameterSetName = 'Direction')]
        [int]$Down,
        
        [Parameter(ParameterSetName = 'Direction')]
        [int]$Left,
        
        [Parameter(ParameterSetName = 'Direction')]
        [int]$Right,
        
        [Parameter(ParameterSetName = 'Position')]
        [int]$Row,
        
        [Parameter(ParameterSetName = 'Position')]
        [int]$Column,
        
        [Parameter(ParameterSetName = 'Home')]
        [switch]$Home,
        
        [Parameter(ParameterSetName = 'Save')]
        [switch]$SavePosition,
        
        [Parameter(ParameterSetName = 'Restore')]
        [switch]$RestorePosition
    )
    
    switch ($PSCmdlet.ParameterSetName) {
        'Direction' {
            if ($Up -gt 0) { Write-Host "`e[${Up}A" -NoNewline }
            if ($Down -gt 0) { Write-Host "`e[${Down}B" -NoNewline }
            if ($Right -gt 0) { Write-Host "`e[${Right}C" -NoNewline }
            if ($Left -gt 0) { Write-Host "`e[${Left}D" -NoNewline }
        }
        'Position' {
            if ($Row -and $Column) {
                Write-Host "`e[${Row};${Column}H" -NoNewline
            } elseif ($Row) {
                Write-Host "`e[${Row}H" -NoNewline
            } elseif ($Column) {
                Write-Host "`e[${Column}G" -NoNewline
            }
        }
        'Home' {
            Write-Host "`e[H" -NoNewline
        }
        'Save' {
            Write-Host "`e[s" -NoNewline
        }
        'Restore' {
            Write-Host "`e[u" -NoNewline
        }
    }
}