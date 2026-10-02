<#
.SYNOPSIS
  One-Click Vibe Coding Stack Setup Script (Windows PowerShell)
  Installs & Configures: Ponytail, Graphify, and Addy Osmani's Agent Skills.
#>

[CmdletBinding()]
param(
    [switch]$KeepOrigin
)

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
        python -m pip install --quiet --upgrade graphifyy
        python -m graphify install
        Write-Host "   [+] Graphify installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "   [!] Could not automatically install graphifyy via pip. Run 'pip install graphifyy' manually." -ForegroundColor DarkYellow
    }
} else {
    Write-Host "   [!] Python not found on PATH. Install Python 3.10+ to enable Graphify." -ForegroundColor Red
}

# 2. Check Git, Detach from Template, & Install Graphify Post-Commit Hook
Write-Host "`n[2/5] Checking Git Repository..." -ForegroundColor Yellow
$originUrl = (git remote get-url origin 2>$null)

if ($originUrl -like "*model-agnostic-agent-template*" -and -not $KeepOrigin) {
    Write-Host "   [*] Detected clone of template repository ($originUrl)." -ForegroundColor Yellow
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
        python -m graphify hook install 2>$null
        Write-Host "   [+] Installed Graphify post-commit hook." -ForegroundColor Green
    } catch {
        try {
            graphify hook install 2>$null
            Write-Host "   [+] Installed Graphify post-commit hook." -ForegroundColor Green
        } catch {
            Write-Host "   [i] Graphify hook will be available after restarting terminal." -ForegroundColor Gray
        }
    }
}

# 3. Setup Agent Skills
Write-Host "`n[3/5] Installing Engineering & Design Skills..." -ForegroundColor Yellow
$npxCmd = Get-Command npx -ErrorAction SilentlyContinue
if ($npxCmd) {
    # Suppress interactive npm prompts
    $env:CI = "true"

    try {
        Write-Host "   Installing Addy Osmani's Agent Skills..." -ForegroundColor Gray
        npx --yes skills add addyosmani/agent-skills --all
        Write-Host "   [+] Agent Skills installed." -ForegroundColor Green
    } catch {
        Write-Host "   [!] Agent Skills install skipped or failed." -ForegroundColor DarkYellow
    }

    try {
        Write-Host "   Installing Taste Skill (Anti-Slop & Dials)..." -ForegroundColor Gray
        npx --yes skills add https://github.com/Leonxlnx/taste-skill --all
        Write-Host "   [+] Taste Skill installed." -ForegroundColor Green
    } catch {
        Write-Host "   [!] Taste Skill install skipped." -ForegroundColor DarkYellow
    }

    try {
        Write-Host "   Installing Emil Kowalski's Design & Motion Skills..." -ForegroundColor Gray
        npx --yes skills@latest add emilkowalski/skills --all
        Write-Host "   [+] Emil Kowalski Skills installed." -ForegroundColor Green
    } catch {
        Write-Host "   [!] Emil Kowalski Skills install skipped." -ForegroundColor DarkYellow
    }

    try {
        Write-Host "   Installing Impeccable (Design Guidance & 61 Quality Rules)..." -ForegroundColor Gray
        npx --yes impeccable install --yes --scope=project
        Write-Host "   [+] Impeccable installed." -ForegroundColor Green
    } catch {
        Write-Host "   [!] Impeccable install skipped. You can run 'npx impeccable install' manually." -ForegroundColor DarkYellow
    }

    $env:CI = $null
} else {
    Write-Host "   [!] Node.js / npx not found on PATH. Install Node.js 18+ to enable skills CLI." -ForegroundColor Red
}

# 4. Check for Antigravity CLI / Claude Code
Write-Host "`n[4/5] Checking Agent Environments..." -ForegroundColor Yellow
$agyCmd = Get-Command agy -ErrorAction SilentlyContinue
if ($agyCmd) {
    Write-Host "   Found Antigravity CLI (agy)! Installing plugins..." -ForegroundColor Green
    agy plugin install https://github.com/DietrichGebert/ponytail --silent
    agy plugin install https://github.com/addyosmani/agent-skills.git --silent
    Write-Host "   [+] Antigravity CLI plugins installed." -ForegroundColor Green
}

# 5. Finalize Git Repository
Write-Host "`n[5/5] Finalizing Git Baseline..." -ForegroundColor Yellow
if (Test-Path ".git") {
    try {
        git add . 2>$null
        git commit -m "feat: initial project setup with agent skills and tools" --quiet 2>$null
        Write-Host "   [+] Staged and committed initial stack to Git." -ForegroundColor Green
    } catch {
        Write-Host "   [i] Note: Nothing to commit or git baseline already set." -ForegroundColor Gray
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
