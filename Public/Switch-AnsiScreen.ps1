function Enter-AnsiAlternateScreen {
    <#
    .SYNOPSIS
        Switch to the alternate screen buffer.
    
    .DESCRIPTION
        This function switches the terminal to the alternate screen buffer using ANSI escape sequences.
        The alternate screen is like a separate "page" that doesn't affect the main terminal history.
        This is commonly used by applications like text editors, pagers, and interactive programs.
    
    .PARAMETER ClearScreen
        Also clear the alternate screen after switching to it.
    
    .PARAMETER SaveCursor
        Save the current cursor position before switching screens.
    
    .EXAMPLE
        Enter-AnsiAlternateScreen
        Switch to alternate screen
        
    .EXAMPLE
        Enter-AnsiAlternateScreen -ClearScreen
        Switch to alternate screen and clear it
        
    .EXAMPLE
        Enter-AnsiAlternateScreen -SaveCursor -ClearScreen
        Save cursor, switch to alternate screen, and clear it
        
    .NOTES
        Use Exit-AnsiAlternateScreen to return to the main screen.
        Not all terminals support alternate screen buffer.
    #>
    [CmdletBinding()]
    param(
        [switch]$ClearScreen,
        [switch]$SaveCursor
    )
    
    if ($SaveCursor) {
        # Save cursor position
        Write-Host "`e[s" -NoNewline
    }
    
    # Switch to alternate screen buffer
    Write-Host "`e[?1049h" -NoNewline
    
    if ($ClearScreen) {
        # Clear the alternate screen
        Write-Host "`e[2J`e[H" -NoNewline
    }
}

function Exit-AnsiAlternateScreen {
    <#
    .SYNOPSIS
        Switch back to the main screen buffer.
    
    .DESCRIPTION
        This function switches the terminal back to the main screen buffer from the alternate screen.
        This restores the original terminal content that was visible before entering alternate screen.
    
    .PARAMETER RestoreCursor
        Restore the previously saved cursor position after switching screens.
    
    .EXAMPLE
        Exit-AnsiAlternateScreen
        Switch back to main screen
        
    .EXAMPLE
        Exit-AnsiAlternateScreen -RestoreCursor
        Switch back to main screen and restore cursor position
        
    .NOTES
        This should be called after Enter-AnsiAlternateScreen to return to normal terminal operation.
    #>
    [CmdletBinding()]
    param(
        [switch]$RestoreCursor
    )
    
    # Switch back to main screen buffer
    Write-Host "`e[?1049l" -NoNewline
    
    if ($RestoreCursor) {
        # Restore cursor position
        Write-Host "`e[u" -NoNewline
    }
}

function Use-AnsiAlternateScreen {
    <#
    .SYNOPSIS
        Execute a script block in the alternate screen buffer.
    
    .DESCRIPTION
        This function temporarily switches to the alternate screen buffer, executes the provided
        script block, then automatically returns to the main screen. This ensures proper cleanup
        even if errors occur during execution.
    
    .PARAMETER ScriptBlock
        The script block to execute in the alternate screen.
    
    .PARAMETER ClearScreen
        Clear the alternate screen before executing the script block.
    
    .PARAMETER SaveCursor
        Save and restore cursor position when switching screens.
    
    .EXAMPLE
        Use-AnsiAlternateScreen -ScriptBlock {
            Write-Host "This text appears in alternate screen"
            Read-Host "Press Enter to continue"
        }
        
    .EXAMPLE
        Use-AnsiAlternateScreen -ClearScreen -SaveCursor -ScriptBlock {
            for ($i = 1; $i -le 10; $i++) {
                Write-Host "Line $i"
                Start-Sleep -Milliseconds 100
            }
        }
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [scriptblock]$ScriptBlock,
        
        [switch]$ClearScreen,
        [switch]$SaveCursor
    )
    
    try {
        # Enter alternate screen
        $enterParams = @{}
        if ($ClearScreen) { $enterParams['ClearScreen'] = $true }
        if ($SaveCursor) { $enterParams['SaveCursor'] = $true }
        
        Enter-AnsiAlternateScreen @enterParams
        
        # Execute the script block
        & $ScriptBlock
    }
    finally {
        # Always exit alternate screen, even if an error occurred
        $exitParams = @{}
        if ($SaveCursor) { $exitParams['RestoreCursor'] = $true }
        
        Exit-AnsiAlternateScreen @exitParams
    }
}