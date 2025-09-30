# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

PSAnsiEscape is a PowerShell module that provides simple functions for using ANSI escape sequences in the terminal. It enables colors, text formatting, cursor movement, and screen manipulation through a clean PowerShell API.

## Essential Commands

### Module Testing and Development
```powershell
# Import the module for testing (from the project directory)
Import-Module .\PSAnsiEscape.psd1 -Force

# Test basic functionality
.\Examples\BasicExamples.ps1

# Manual testing of individual functions
Set-AnsiColor -Text "Test" -ForegroundColor Red
Set-AnsiFormat -Text "Test" -Bold
Move-AnsiCursor -Home
Clear-AnsiScreen -CurrentLine
```

### Module Installation Testing
```powershell
# Test module installation locally
$ModulePath = "$env:PSModulePath".Split(';')[0]
Copy-Item -Path . -Destination "$ModulePath\PSAnsiEscape" -Recurse -Force
Import-Module PSAnsiEscape
```

### Function Validation
```powershell
# Check all exported functions are working
Get-Command -Module PSAnsiEscape
Get-Help Set-AnsiColor -Examples
```

## Architecture Overview

### Module Structure
- **PSAnsiEscape.psd1**: Module manifest defining metadata, exports, and compatibility
- **PSAnsiEscape.psm1**: Root module that dot-sources all public functions
- **Public/**: Contains all user-facing functions (auto-imported by root module)
- **Examples/**: Demonstration scripts showing module usage

### Core Design Patterns

**Function Organization**: Each public function is in its own file in the `Public/` directory. The root module automatically dot-sources all `.ps1` files from this directory.

**ANSI Sequence Generation**: All functions follow a consistent pattern:
1. Build ANSI codes using escape character `` `e[ ``
2. Combine codes with semicolon separators
3. Append 'm' for formatting codes or specific letters for control sequences
4. Optionally append reset sequence `` `e[0m ``

**Parameter Sets**: Complex functions like `Move-AnsiCursor` and `Clear-AnsiScreen` use PowerShell parameter sets to group related functionality and prevent conflicting parameters.

**Pipeline Support**: Color and format functions support pipeline input via `ValueFromPipeline = $true` for chaining operations.

### Function Categories

**Color Functions** (`Set-AnsiColor`):
- Maps color names to ANSI codes (30-37 for standard, 90-97 for bright)
- Background colors add 10 to foreground codes
- Supports both standard and bright color variants

**Format Functions** (`Set-AnsiFormat`):
- Uses switch parameters for formatting options
- Maps to ANSI formatting codes (1=Bold, 3=Italic, 4=Underline, etc.)

**Cursor Functions** (`Move-AnsiCursor`):
- Directional movement (A=Up, B=Down, C=Right, D=Left)
- Absolute positioning (H=Home, G=Column)
- State management (s=Save, u=Restore)

**Screen Functions** (`Clear-AnsiScreen`):
- Screen clearing (J codes: 0=from cursor, 1=to cursor, 2=all)
- Line clearing (K codes: 0=to end, 1=to start, 2=entire line)
- Scrolling (S=up, T=down)

**Utility Functions** (`New-AnsiSequence`):
- Raw sequence generation for advanced use cases
- Can return sequences or execute them directly

### Key Implementation Details

**No Dependencies**: Module uses only built-in PowerShell features and ANSI standard sequences.

**Cross-Platform Compatibility**: Works on PowerShell 5.1+ (Windows PowerShell) and PowerShell 7+ (PowerShell Core) across Windows, macOS, and Linux.

**Terminal Compatibility**: Designed for modern terminals that support ANSI sequences (Windows Terminal, PowerShell 7, most Unix terminals).

**Reset Handling**: Most functions include automatic reset sequences to prevent formatting from bleeding into subsequent output.

## Development Guidelines

### Adding New Functions
1. Create new `.ps1` file in `Public/` directory
2. Follow existing parameter and documentation patterns
3. Add function name to `FunctionsToExport` in `PSAnsiEscape.psd1`
4. Add function name to `$PublicFunctions` array in `PSAnsiEscape.psm1`
5. Include comprehensive comment-based help with examples

### ANSI Code Reference
- Colors: 30-37 (standard), 90-97 (bright), +10 for background
- Formats: 1=Bold, 2=Dim, 3=Italic, 4=Underline, 7=Reverse, 9=Strikethrough
- Cursor: A=Up, B=Down, C=Right, D=Left, H=Position, s=Save, u=Restore
- Clear: J=Screen, K=Line, S=Scroll Up, T=Scroll Down

### Testing Approach
Since there are no formal tests, validate functionality by:
1. Running the `BasicExamples.ps1` script
2. Testing in different PowerShell versions (5.1, 7+)
3. Testing in different terminals (Windows Terminal, PowerShell ISE, Unix terminals)
4. Verifying ANSI sequences don't break in unsupported terminals

### PowerShell Best Practices Applied
- Parameter validation using `ValidateSet`
- Pipeline support with `ValueFromPipeline`
- Parameter sets for mutually exclusive options
- Comprehensive comment-based help
- Consistent error handling and output

## Module Distribution

The module is structured for easy distribution via PowerShell Gallery or manual installation. The manifest file (`PSAnsiEscape.psd1`) contains all necessary metadata for publishing.