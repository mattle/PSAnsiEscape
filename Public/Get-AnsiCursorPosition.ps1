function Get-AnsiCursorPosition {
    <#
    .SYNOPSIS
        Get the current cursor position from the terminal.
    
    .DESCRIPTION
        This function queries the terminal for the current cursor position using ANSI escape sequences.
        Returns a PSCustomObject with Row and Column properties.
        Note: This function requires a terminal that supports ANSI response sequences.
    
    .PARAMETER TimeoutMs
        Timeout in milliseconds to wait for terminal response (default: 1000ms).
    
    .EXAMPLE
        $pos = Get-AnsiCursorPosition
        Write-Host "Cursor is at row $($pos.Row), column $($pos.Column)"
        
    .EXAMPLE
        Get-AnsiCursorPosition -TimeoutMs 500
        Get cursor position with 500ms timeout
        
    .OUTPUTS
        PSCustomObject with Row and Column properties, or $null if unable to get position
    #>
    [CmdletBinding()]
    param(
        [int]$TimeoutMs = 1000
    )
    
    try {
        # Check if we can access the console
        if (-not [Console]::KeyAvailable) {
            # Send cursor position request
            Write-Host "`e[6n" -NoNewline
            
            $response = ""
            $startTime = Get-Date
            
            # Read response with timeout
            while ((Get-Date).Subtract($startTime).TotalMilliseconds -lt $TimeoutMs) {
                if ([Console]::KeyAvailable) {
                    $key = [Console]::ReadKey($true)
                    $response += $key.KeyChar
                    
                    # Check if we have a complete response (ends with 'R')
                    if ($response -match '\e\[(\d+);(\d+)R$') {
                        $row = [int]$matches[1]
                        $column = [int]$matches[2]
                        
                        return [PSCustomObject]@{
                            Row = $row
                            Column = $column
                        }
                    }
                }
                Start-Sleep -Milliseconds 10
            }
        }
        
        Write-Warning "Unable to get cursor position. Terminal may not support cursor position reporting or timeout occurred."
        return $null
    }
    catch {
        Write-Warning "Error getting cursor position: $($_.Exception.Message)"
        return $null
    }
}