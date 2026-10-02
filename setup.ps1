<#
.SYNOPSIS
  One-Click Vibe Coding Stack Setup Script (Windows PowerShell)
  Installs & Configures: Ponytail, Graphify, and Addy Osmani's Agent Skills.
#>

[CmdletBinding()]
param(
    [switch]$KeepOrigin
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   🚀 Initializing Vibe Coding Supercharged Template      " -ForegroundColor Cyan
Write-Host "      Stack: Ponytail + Graphify + Agent Skills           " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check Python & Install Graphify
Write-Host "1️⃣ Checking Python & Graphify..." -ForegroundColor Yellow
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if ($pythonCmd) {
    Write-Host "   Found Python: $($pythonCmd.Source)" -ForegroundColor Green
    try {
        Write-Host "   Installing/Updating graphifyy via pip..." -ForegroundColor Gray
        python -m pip install --quiet --upgrade graphifyy
        python -m graphify install
        Write-Host "   ✅ Graphify installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "   ⚠️ Could not automatically install graphifyy via pip. Run 'pip install graphifyy' manually." -ForegroundColor DarkYellow
    }
} else {
    Write-Host "   ⚠️ Python not found on PATH. Install Python 3.10+ to enable Graphify." -ForegroundColor Red
}

# 2. Check Git, Detach from Template, & Install Graphify Post-Commit Hook
Write-Host "`n2️⃣ Checking Git Repository..." -ForegroundColor Yellow
$originUrl = (git remote get-url origin 2>$null)

if ($originUrl -like "*model-agnostic-agent-template*" -and -not $KeepOrigin) {
    Write-Host "   🔄 Detected clone of template repository ($originUrl)." -ForegroundColor Yellow
    Write-Host "   Disconnecting from template and initializing fresh Git repository for your project..." -ForegroundColor Cyan
    try {
        if (Test-Path ".git") {
            Get-ChildItem -Path ".git" -Recurse -Force | ForEach-Object { $_.Attributes = 'Normal' }
            Remove-Item -Path ".git" -Recurse -Force
        }
        git init -b main | Out-Null
        Write-Host "   ✅ Initialized fresh, detached Git repository (main)." -ForegroundColor Green
    } catch {
        Write-Host "   ⚠️ Could not reset .git automatically: $_" -ForegroundColor DarkYellow
    }
} elseif (-not (Test-Path ".git")) {
    Write-Host "   Initializing fresh Git repository for your project..." -ForegroundColor Cyan
    try {
        git init -b main | Out-Null
        Write-Host "   ✅ Initialized fresh Git repository (main)." -ForegroundColor Green
    } catch {
        Write-Host "   ℹ️ Note: Install Git to enable version control." -ForegroundColor Gray
    }
}

if (Test-Path ".git") {
    try {
        graphify hook install
        Write-Host "   ✅ Installed Graphify post-commit hook." -ForegroundColor Green
    } catch {
        Write-Host "   ℹ️ Note: Run 'graphify hook install' once graphify is on your PATH." -ForegroundColor Gray
    }
}

# 3. Setup Agent Skills
Write-Host "`n3️⃣ Installing Engineering & Design Skills..." -ForegroundColor Yellow
$npxCmd = Get-Command npx -ErrorAction SilentlyContinue
if ($npxCmd) {
    try {
        Write-Host "   Installing Addy Osmani's Agent Skills..." -ForegroundColor Gray
        npx skills add addyosmani/agent-skills
        Write-Host "   ✅ Agent Skills installed." -ForegroundColor Green
    } catch {
        Write-Host "   ⚠️ Agent Skills install skipped or failed." -ForegroundColor DarkYellow
    }

    try {
        Write-Host "   Installing Taste Skill (Anti-Slop & Dials)..." -ForegroundColor Gray
        npx skills add https://github.com/Leonxlnx/taste-skill
        Write-Host "   ✅ Taste Skill installed." -ForegroundColor Green
    } catch {
        Write-Host "   ⚠️ Taste Skill install skipped." -ForegroundColor DarkYellow
    }

    try {
        Write-Host "   Installing Emil Kowalski's Design & Motion Skills..." -ForegroundColor Gray
        npx skills@latest add emilkowalski/skills
        Write-Host "   ✅ Emil Kowalski Skills installed." -ForegroundColor Green
    } catch {
        Write-Host "   ⚠️ Emil Kowalski Skills install skipped." -ForegroundColor DarkYellow
    }

    try {
        Write-Host "   Installing Impeccable (Design Guidance & 61 Quality Rules)..." -ForegroundColor Gray
        npx impeccable install --scope=project
        Write-Host "   ✅ Impeccable installed." -ForegroundColor Green
    } catch {
        Write-Host "   ⚠️ Impeccable install skipped. You can run 'npx impeccable install' manually." -ForegroundColor DarkYellow
    }
} else {
    Write-Host "   ⚠️ Node.js / npx not found on PATH. Install Node.js 18+ to enable skills CLI." -ForegroundColor Red
}

# 4. Check for Antigravity CLI / Claude Code
Write-Host "`n4️⃣ Checking Agent Environments..." -ForegroundColor Yellow
$agyCmd = Get-Command agy -ErrorAction SilentlyContinue
if ($agyCmd) {
    Write-Host "   Found Antigravity CLI (agy)! Installing plugins..." -ForegroundColor Green
    agy plugin install https://github.com/DietrichGebert/ponytail --silent
    agy plugin install https://github.com/addyosmani/agent-skills.git --silent
    Write-Host "   ✅ Antigravity CLI plugins installed." -ForegroundColor Green
}

# 5. Finalize Git Repository
Write-Host "`n5️⃣ Finalizing Git Baseline..." -ForegroundColor Yellow
if (Test-Path ".git") {
    try {
        git add .
        git commit -m "feat: initial project setup with agent skills and tools" --quiet
        Write-Host "   ✅ Staged and committed initial stack to Git." -ForegroundColor Green
    } catch {
        Write-Host "   ℹ️ Note: Nothing to commit or git error: $_" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host "   🎉 Vibe Coding Stack Ready!                           " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
Write-Host "Pre-configured workflows in your new project:"
Write-Host " • /graphify .        -> Build & inspect codebase knowledge graph"
Write-Host " • /spec              -> Write PRD and clarify goals before coding"
Write-Host " • /plan              -> Decompose spec into atomic, verifiable tasks"
Write-Host " • /build auto        -> Autonomous vertical-slice TDD implementation"
Write-Host " • /impeccable init   -> Gather product truth into PRODUCT.md"
Write-Host " • /impeccable craft  -> Shape-then-build interactive visual flow"
Write-Host " • /impeccable audit  -> 61 zero-token deterministic design checks"
Write-Host " • /animate           -> Build fluid motion with decelerating curves"
Write-Host " • /review            -> 5-axis Senior Staff quality review"
Write-Host " • /ponytail-review   -> Strip code bloat, enforce native 1-liners"
Write-Host " • /ship              -> Commit atomic changes and prepare release"
Write-Host "==========================================================" -ForegroundColor Green

