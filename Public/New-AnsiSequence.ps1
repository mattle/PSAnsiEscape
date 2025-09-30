function New-AnsiSequence {
    <#
    .SYNOPSIS
        Create custom ANSI escape sequences.
    
    .DESCRIPTION
        This function allows creating custom ANSI escape sequences by specifying
        the escape code directly. Useful for advanced ANSI operations not covered
        by other functions.
    
    .PARAMETER Code
        The ANSI code to create (without the ESC[ prefix).
    
    .PARAMETER Raw
        Return just the escape sequence without executing it.
    
    .EXAMPLE
        New-AnsiSequence -Code "31m" -Raw
        Returns: "`e[31m"
        
    .EXAMPLE
        New-AnsiSequence -Code "2J"
        Executes the clear screen command
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Code,
        
        [switch]$Raw
    )
    
    $sequence = "`e[${Code}"
    
    if ($Raw) {
        return $sequence
    } else {
        Write-Host $sequence -NoNewline
    }
}