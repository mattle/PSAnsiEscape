function Set-AnsiWindowTitle {
    <#
    .SYNOPSIS
        Set the terminal window or tab title.
    
    .DESCRIPTION
        This function uses ANSI escape sequences to set the terminal window title,
        tab title, or both. Works with most modern terminal emulators.
    
    .PARAMETER Title
        The title text to set.
    
    .PARAMETER WindowOnly
        Set only the window title (not the tab title).
    
    .PARAMETER TabOnly
        Set only the tab title (not the window title).
    
    .PARAMETER Both
        Set both window and tab title (default behavior).
    
    .EXAMPLE
        Set-AnsiWindowTitle -Title "My PowerShell Session"
        Set both window and tab title
        
    .EXAMPLE
        Set-AnsiWindowTitle -Title "Current Task" -TabOnly
        Set only the tab title
        
    .EXAMPLE
        Set-AnsiWindowTitle -Title "PowerShell Console" -WindowOnly
        Set only the window title
        
    .NOTES
        This function uses OSC (Operating System Command) escape sequences:
        - ESC]0;title\BEL or ESC]0;title\ESC\ - Set both window and tab title
        - ESC]1;title\BEL or ESC]1;title\ESC\ - Set tab title only
        - ESC]2;title\BEL or ESC]2;title\ESC\ - Set window title only
        
        Compatibility varies by terminal emulator. Most modern terminals support this.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Both')]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,
        
        [Parameter(ParameterSetName = 'WindowOnly')]
        [switch]$WindowOnly,
        
        [Parameter(ParameterSetName = 'TabOnly')]
        [switch]$TabOnly,
        
        [Parameter(ParameterSetName = 'Both')]
        [switch]$Both
    )
    
    # Escape any special characters in the title
    $escapedTitle = $Title -replace '[\x00-\x1F\x7F]', ''
    
    switch ($PSCmdlet.ParameterSetName) {
        'WindowOnly' {
            # Set window title only (OSC 2)
            Write-Host "`e]2;$escapedTitle`e\" -NoNewline
        }
        'TabOnly' {
            # Set tab title only (OSC 1)
            Write-Host "`e]1;$escapedTitle`e\" -NoNewline
        }
        'Both' {
            # Set both window and tab title (OSC 0)
            Write-Host "`e]0;$escapedTitle`e\" -NoNewline
        }
    }
}

function Reset-AnsiWindowTitle {
    <#
    .SYNOPSIS
        Reset the terminal window title to default.
    
    .DESCRIPTION
        This function resets the terminal window title back to its default value.
        The default is typically the terminal application name or current directory.
    
    .EXAMPLE
        Reset-AnsiWindowTitle
        Reset window title to default
    #>
    [CmdletBinding()]
    param()
    
    # Reset to default title (empty string usually triggers default behavior)
    Write-Host "`e]0;`e\" -NoNewline
}