function New-AnsiHyperlink {
    <#
    .SYNOPSIS
        Create clickable hyperlinks in supported terminals.
    
    .DESCRIPTION
        This function creates ANSI hyperlink escape sequences that make text clickable in
        terminals that support hyperlinks (such as Windows Terminal, iTerm2, and others).
        When clicked, the link will open in the default browser or application.
    
    .PARAMETER Url
        The URL to link to (must be a valid URL).
    
    .PARAMETER Text
        The text to display for the hyperlink. If not specified, the URL is used as the display text.
    
    .PARAMETER Id
        Optional ID for the hyperlink (used for terminal-specific features).
    
    .EXAMPLE
        New-AnsiHyperlink -Url "https://github.com" -Text "GitHub"
        Creates a clickable link that displays "GitHub" and opens https://github.com
        
    .EXAMPLE
        New-AnsiHyperlink -Url "https://www.powershellgallery.com"
        Creates a clickable link using the URL as the display text
        
    .EXAMPLE
        "Visit our website" | New-AnsiHyperlink -Url "https://example.com"
        Creates a hyperlink using pipeline input as the display text
        
    .EXAMPLE
        New-AnsiHyperlink -Url "mailto:admin@example.com" -Text "Contact Admin"
        Creates a clickable email link
        
    .NOTES
        Hyperlink support varies by terminal:
        - Windows Terminal: Full support
        - iTerm2: Full support  
        - GNOME Terminal: Full support
        - VS Code Terminal: Full support
        - Traditional Windows Console: No support (displays as plain text)
        
        The hyperlink format is: ESC]8;;URL\ESC\TEXT\ESC]8;;\ESC\
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Url,
        
        [Parameter(ValueFromPipeline = $true)]
        [string]$Text,
        
        [string]$Id
    )
    
    process {
        # Use URL as display text if no text is provided
        if (-not $Text) {
            $Text = $Url
        }
        
        # Validate URL format (basic validation)
        if ($Url -notmatch '^(https?|ftp|mailto|file)://.*|^mailto:.*') {
            Write-Warning "URL '$Url' may not be valid. Supported schemes: http, https, ftp, file, mailto"
        }
        
        # Build the hyperlink escape sequence
        $linkStart = "`e]8;"
        
        # Add ID if provided
        if ($Id) {
            $linkStart += "id=$Id"
        }
        
        $linkStart += ";$Url`e\"
        $linkEnd = "`e]8;;`e\"
        
        # Return the complete hyperlink
        return "$linkStart$Text$linkEnd"
    }
}


function Write-AnsiHyperlink {
    <#
    .SYNOPSIS
        Write a hyperlink directly to the console with optional formatting.
    
    .DESCRIPTION
        This function combines New-AnsiHyperlink with Write-Host to output formatted
        hyperlinks directly to the console with color and formatting options.
    
    .PARAMETER Url
        The URL to link to.
    
    .PARAMETER Text
        The text to display for the hyperlink.
    
    .PARAMETER ForegroundColor
        The foreground color for the hyperlink text.
    
    .PARAMETER BackgroundColor
        The background color for the hyperlink text.
    
    .PARAMETER NoNewline
        Do not add a newline after the hyperlink.
    
    .EXAMPLE
        Write-AnsiHyperlink -Url "https://github.com" -Text "GitHub" -ForegroundColor Blue
        Write a blue-colored hyperlink to the console
        
    .EXAMPLE
        Write-AnsiHyperlink -Url "https://example.com" -ForegroundColor Cyan -NoNewline
        Write a cyan hyperlink without a trailing newline
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Url,
        
        [string]$Text,
        
        [System.ConsoleColor]$ForegroundColor,
        
        [System.ConsoleColor]$BackgroundColor,
        
        [switch]$NoNewline
    )
    
    $hyperlink = New-AnsiHyperlink -Url $Url -Text $Text
    
    $writeHostParams = @{
        Object = $hyperlink
        NoNewline = $NoNewline
    }
    
    if ($ForegroundColor) {
        $writeHostParams['ForegroundColor'] = $ForegroundColor
    }
    
    if ($BackgroundColor) {
        $writeHostParams['BackgroundColor'] = $BackgroundColor
    }
    
    Write-Host @writeHostParams
}