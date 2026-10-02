<#
.SYNOPSIS
  One-Click Vibe Coding Stack Setup Script (Windows PowerShell)
  Installs & Configures: Ponytail, Graphify, and Addy Osmani's Agent Skills.
#>

[CmdletBinding()]
param(
    [switch]$KeepOrigin,
    [switch]$ResetGit,
    [switch]$CommitInitialSetup,
    [ValidateSet("motion", "frontend", "minimal", "custom")]
    [string]$DesignProfile = "motion",
    [switch]$DryRun
)

function Invoke-RequiredCommand {
    param(
        [Parameter(Mandatory)] [string]$FilePath,
        [Parameter(Mandatory)] [string[]]$ArgumentList
    )

    & $FilePath @ArgumentList
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE`: $FilePath $($ArgumentList -join ' ')"
    }
}

if ($KeepOrigin -and $ResetGit) {
    throw "Choose either -KeepOrigin or -ResetGit, not both."
}

# Ensure script executes in the project root
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ((Split-Path $ScriptDir -Leaf) -eq ".template") {
    Set-Location (Split-Path $ScriptDir -Parent)
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   >> Initializing Vibe Coding Supercharged Template      " -ForegroundColor Cyan
Write-Host "      Stack: Ponytail + Graphify + Agent Skills           " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# Motion is the recommended default. Use -DesignProfile for automation.
if (-not $PSBoundParameters.ContainsKey("DesignProfile") -and -not $env:CI) {
    Write-Host "Design profile (default: motion):" -ForegroundColor Cyan
    Write-Host "  [1] motion   - Taste + Emil motion/mobile + Impeccable (recommended)"
    Write-Host "  [2] frontend - Taste + Impeccable"
    Write-Host "  [3] minimal  - Impeccable only"
    Write-Host "  [4] custom   - Choose each design skill"
    $choice = Read-Host "Choose 1-4, or press Enter for motion"
    switch ($choice) {
        "2" { $DesignProfile = "frontend" }
        "3" { $DesignProfile = "minimal" }
        "4" { $DesignProfile = "custom" }
        default { $DesignProfile = "motion" }
    }
}
$installImpeccable = $true
$installTaste = $DesignProfile -in @("motion", "frontend")
$installEmil = $DesignProfile -eq "motion"
if ($DesignProfile -eq "custom" -and -not $DryRun) {
    $installImpeccable = (Read-Host "Install Impeccable quality checks? [Y/n]") -notmatch "^(n|no)$"
    $installTaste = (Read-Host "Install Taste Skill visual direction? [y/N]") -match "^(y|yes)$"
    $installEmil = (Read-Host "Install Emil motion/mobile skills? [y/N]") -match "^(y|yes)$"
}

if ($DryRun) {
    Write-Host "Dry run: no installation, Git, or commit actions will be performed." -ForegroundColor Yellow
    Write-Host "Design profile: $DesignProfile"
    Write-Host "  Impeccable: $installImpeccable"
    Write-Host "  Taste Skill: $installTaste"
    Write-Host "  Emil motion/mobile: $installEmil"
    exit 0
}
# 1. Check Python & Install Graphify
Write-Host "[1/5] Checking Python & Graphify..." -ForegroundColor Yellow
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if ($pythonCmd) {
    Write-Host "   Found Python: $($pythonCmd.Source)" -ForegroundColor Green
    # Add Python Scripts folder to current session PATH so CLI tools are discoverable
    try {
        $pyScripts = python -c "import sysconfig; print(sysconfig.get_path('scripts'))" 2>$null
        if ($pyScripts -and (Test-Path $pyScripts)) {
            $env:PATH = "$pyScripts;$env:PATH"
        }
    } catch {}

    try {
        Write-Host "   Installing/Updating graphifyy via pip..." -ForegroundColor Gray
        Invoke-RequiredCommand python @('-m', 'pip', 'install', '--quiet', '--upgrade', 'graphifyy')
        Invoke-RequiredCommand python @('-m', 'graphify', 'install')
        Write-Host "   [+] Graphify installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "   [!] Could not automatically install graphifyy via pip. Run 'pip install graphifyy' manually." -ForegroundColor DarkYellow
    }
} else {
    Write-Host "   [!] Python not found on PATH. Install Python 3.10+ to enable Graphify." -ForegroundColor Red
}

# 2. Check Git, optionally detach from template, & install Graphify post-commit hook
Write-Host "`n[2/5] Checking Git Repository..." -ForegroundColor Yellow
$originUrl = (git remote get-url origin 2>$null)

if ($originUrl -like "*model-agnostic-agent-template*") {
    Write-Host "   [*] Detected clone of template repository ($originUrl)." -ForegroundColor Yellow
    $resetTemplateGit = $false

    if ($KeepOrigin) {
        Write-Host "   Keeping the existing Git repository by request." -ForegroundColor Gray
    } elseif ($ResetGit) {
        $resetTemplateGit = $true
    } elseif (-not $env:CI -and -not [Console]::IsInputRedirected) {
        Write-Host "   Choose Git setup:" -ForegroundColor Cyan
        Write-Host "     [1] Start fresh - delete Git history and the template remote (default)"
        Write-Host "     [2] Keep existing - preserve Git history and remotes"
        $gitChoice = Read-Host "Choose 1-2, or press Enter to start fresh"
        if ([string]::IsNullOrWhiteSpace($gitChoice) -or $gitChoice -eq "1") {
            $resetTemplateGit = $true
        } elseif ($gitChoice -eq "2") {
            Write-Host "   Keeping the existing Git repository." -ForegroundColor Gray
        } else {
            Write-Host "   Unrecognized choice; keeping the existing Git repository." -ForegroundColor DarkYellow
        }
    } else {
        Write-Host "   Non-interactive setup keeps the existing Git repository. Use -ResetGit to start fresh." -ForegroundColor Gray
    }

    if ($resetTemplateGit) {
        Write-Host "   Disconnecting from template and initializing fresh Git repository for your project..." -ForegroundColor Cyan
        try {
            if (Test-Path ".git") {
                Get-ChildItem -Path ".git" -Recurse -Force | ForEach-Object { $_.Attributes = 'Normal' }
                Remove-Item -Path ".git" -Recurse -Force
            }
            git init -b main | Out-Null
            git config core.autocrlf true
            git config core.safecrlf false
            Write-Host "   [+] Initialized fresh, detached Git repository (main)." -ForegroundColor Green
        } catch {
            Write-Host "   [!] Could not reset .git automatically: $_" -ForegroundColor DarkYellow
        }
    }
} elseif (-not (Test-Path ".git")) {
    Write-Host "   Initializing fresh Git repository for your project..." -ForegroundColor Cyan
    try {
        git init -b main | Out-Null
        git config core.autocrlf true
        git config core.safecrlf false
        Write-Host "   [+] Initialized fresh Git repository (main)." -ForegroundColor Green
    } catch {
        Write-Host "   [i] Note: Install Git to enable version control." -ForegroundColor Gray
    }
} else {
    git config core.autocrlf true 2>$null
    git config core.safecrlf false 2>$null
}

if (Test-Path ".git") {
    try {
        Invoke-RequiredCommand python @('-m', 'graphify', 'hook', 'install')
        Write-Host "   [+] Installed Graphify post-commit hook." -ForegroundColor Green
    } catch {
        try {
            Invoke-RequiredCommand graphify @('hook', 'install')
            Write-Host "   [+] Installed Graphify post-commit hook." -ForegroundColor Green
        } catch {
            Write-Host "   [i] Graphify hook will be available after restarting terminal." -ForegroundColor Gray
        }
    }
}

# 3. Setup Agent Skills
Write-Host "`n[3/5] Installing Engineering & Design Skills..." -ForegroundColor Yellow
$npxCmd = Get-Command npx -ErrorAction SilentlyContinue
$agyCmd = Get-Command agy -ErrorAction SilentlyContinue
if ($npxCmd) {
    # Suppress interactive npm prompts
    $env:CI = "true"

    if ($agyCmd) {
        Write-Host "   [i] Addy Agent Skills deferred to the Antigravity plugin (avoids duplicate installation)." -ForegroundColor DarkGray
    } else {
        try {
            Write-Host "   Installing Addy Osmani's Agent Skills..." -ForegroundColor Gray
            Invoke-RequiredCommand npx @('--yes', 'skills', 'add', 'addyosmani/agent-skills', '--all')
            Write-Host "   [+] Agent Skills installed." -ForegroundColor Green
        } catch {
            Write-Host "   [!] Agent Skills install skipped or failed." -ForegroundColor DarkYellow
        }
    }

    try {
        if ($installTaste) {
            Write-Host "   Installing Taste Skill (visual direction)..." -ForegroundColor Gray
            Invoke-RequiredCommand npx @('--yes', 'skills', 'add', 'https://github.com/Leonxlnx/taste-skill', '--skill', 'design-taste-frontend', '--agent', '*', '--yes')
            Write-Host "   [+] Taste Skill installed." -ForegroundColor Green
        } else {
            Write-Host "   [i] Taste Skill skipped by profile." -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "   [!] Taste Skill install skipped." -ForegroundColor DarkYellow
    }

    try {
        if ($installEmil) {
            Write-Host "   Installing Emil Kowalski's Motion & Mobile Native Skills..." -ForegroundColor Gray
            Invoke-RequiredCommand npx @('--yes', 'skills@latest', 'add', 'emilkowalski/skills', '--skill', 'animate', '--skill', 'mobile-native', '--skill', 'review-animations', '--agent', '*', '--yes')
            Write-Host "   [+] Emil Kowalski Skills installed." -ForegroundColor Green
        } else {
            Write-Host "   [i] Emil motion/mobile skills skipped by profile." -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "   [!] Emil Kowalski Skills install skipped." -ForegroundColor DarkYellow
    }

    try {
        if ($installImpeccable) {
            Write-Host "   Installing Impeccable (design guidance & quality rules)..." -ForegroundColor Gray
            Invoke-RequiredCommand npx @('--yes', 'impeccable', 'install', '--yes', '--scope=project')
            Write-Host "   [+] Impeccable installed." -ForegroundColor Green
        } else {
            Write-Host "   [i] Impeccable skipped by profile." -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "   [!] Impeccable install skipped. You can run 'npx impeccable install' manually." -ForegroundColor DarkYellow
    }

    $env:CI = $null
} else {
    Write-Host "   [!] Node.js / npx not found on PATH. Install Node.js 18+ to enable skills CLI." -ForegroundColor Red
}

# 4. Check for Antigravity CLI / Claude Code
Write-Host "`n[4/5] Checking Agent Environments..." -ForegroundColor Yellow
if ($agyCmd) {
    Write-Host "   Found Antigravity CLI (agy)! Installing plugins..." -ForegroundColor Green
    try {
        Invoke-RequiredCommand agy @('plugin', 'install', 'https://github.com/DietrichGebert/ponytail', '--silent')
        Invoke-RequiredCommand agy @('plugin', 'install', 'https://github.com/addyosmani/agent-skills.git', '--silent')
    } catch {
        Write-Host "   [!] Antigravity plugin installation failed: $_" -ForegroundColor DarkYellow
    }
    Write-Host "   Antigravity plugin phase complete; review any warnings above." -ForegroundColor Gray
}

# 5. Review Git Repository
Write-Host "`n[5/5] Reviewing Git Repository..." -ForegroundColor Yellow
if (Test-Path ".git") {
    if ($CommitInitialSetup) {
        try {
            Invoke-RequiredCommand git @('add', '.')
            Invoke-RequiredCommand git @('commit', '-m', 'feat: initial project setup with agent skills and tools', '--quiet')
            Write-Host "   [+] Staged and committed initial stack to Git." -ForegroundColor Green
        } catch {
            Write-Host "   [i] Note: Nothing to commit or git baseline already set." -ForegroundColor Gray
        }
    } else {
        try {
            $changes = @(git status --short)
            if ($LASTEXITCODE -ne 0) {
                throw "git status failed with exit code $LASTEXITCODE."
            }
            if ($changes) {
                Write-Host "   Current uncommitted changes:" -ForegroundColor Yellow
                $changes | ForEach-Object { Write-Host "     $_" }
            } else {
                Write-Host "   Working tree is clean." -ForegroundColor Green
            }
            Write-Host "   No files were staged or committed. Use -CommitInitialSetup to create the initial commit." -ForegroundColor Gray
        } catch {
            Write-Host "   [i] Could not read Git status: $_" -ForegroundColor Gray
        }
    }
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host "   🎉 Vibe Coding Stack Ready!                            " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "👉 WHAT TO DO NEXT (No terminal commands needed!):" -ForegroundColor Cyan
Write-Host "   1. Open your AI coding assistant (Antigravity / Cursor / Claude)."
Write-Host "   2. In the AI chat, simply describe what you want to build:"
Write-Host "      Example: 'I want to build a modern personal portfolio.'" -ForegroundColor Yellow
Write-Host ""
Write-Host "   The AI will automatically handle planning, design, and"
Write-Host "   code quality in the background."
Write-Host ""
Write-Host "💡 Optional shortcuts for advanced users:" -ForegroundColor DarkGray
Write-Host "   /spec   -> Write a PRD before writing code" -ForegroundColor DarkGray
Write-Host "   /plan   -> Break tasks into small verifiable steps" -ForegroundColor DarkGray
Write-Host "   /review -> Senior Staff quality review" -ForegroundColor DarkGray
Write-Host "==========================================================" -ForegroundColor Green
