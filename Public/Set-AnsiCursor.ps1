function Set-AnsiCursor {
    <#
    .SYNOPSIS
        Control cursor visibility and blinking behavior.
    
    .DESCRIPTION
        This function provides control over cursor appearance using ANSI escape sequences.
        Allows showing/hiding the cursor and enabling/disabling cursor blinking.
    
    .PARAMETER Show
        Show the cursor (make it visible).
    
    .PARAMETER Hide
        Hide the cursor (make it invisible).
    
    .PARAMETER EnableBlink
        Enable cursor blinking.
    
    .PARAMETER DisableBlink
        Disable cursor blinking.
    
    .EXAMPLE
        Set-AnsiCursor -Hide
        Hides the cursor
        
    .EXAMPLE
        Set-AnsiCursor -Show
        Shows the cursor
        
    .EXAMPLE
        Set-AnsiCursor -DisableBlink
        Disables cursor blinking
        
    .EXAMPLE
        Set-AnsiCursor -Show -DisableBlink
        Shows cursor and disables blinking
    #>
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'Visibility')]
        [switch]$Show,
        
        [Parameter(ParameterSetName = 'Visibility')]
        [switch]$Hide,
        
        [Parameter(ParameterSetName = 'Blinking')]
        [switch]$EnableBlink,
        
        [Parameter(ParameterSetName = 'Blinking')]
        [switch]$DisableBlink,
        
        [Parameter(ParameterSetName = 'Combined')]
        [switch]$ShowAndEnableBlink,
        
        [Parameter(ParameterSetName = 'Combined')]
        [switch]$ShowAndDisableBlink,
        
        [Parameter(ParameterSetName = 'Combined')]
        [switch]$HideAndEnableBlink,
        
        [Parameter(ParameterSetName = 'Combined')]
        [switch]$HideAndDisableBlink
    )
    
    switch ($PSCmdlet.ParameterSetName) {
        'Visibility' {
            if ($Show) {
                Write-Host "`e[?25h" -NoNewline
            }
            if ($Hide) {
                Write-Host "`e[?25l" -NoNewline
            }
        }
        'Blinking' {
            if ($EnableBlink) {
                Write-Host "`e[?12h" -NoNewline
            }
            if ($DisableBlink) {
                Write-Host "`e[?12l" -NoNewline
            }
        }
        'Combined' {
            if ($ShowAndEnableBlink) {
                Write-Host "`e[?25h`e[?12h" -NoNewline
            }
            elseif ($ShowAndDisableBlink) {
                Write-Host "`e[?25h`e[?12l" -NoNewline
            }
            elseif ($HideAndEnableBlink) {
                Write-Host "`e[?25l`e[?12h" -NoNewline
            }
            elseif ($HideAndDisableBlink) {
                Write-Host "`e[?25l`e[?12l" -NoNewline
            }
        }
    }
}