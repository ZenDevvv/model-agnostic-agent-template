#!/usr/bin/env bash
# One-Click Vibe Coding Stack Setup Script (Bash / macOS / Linux / WSL)
# Installs & Configures: Ponytail, Graphify, and Addy Osmani's Agent Skills.

set -e

echo -e "\033[1;36m==========================================================\033[0m"
echo -e "\033[1;36m   🚀 Initializing Vibe Coding Supercharged Template      \033[0m"
echo -e "\033[1;36m      Stack: Ponytail + Graphify + Agent Skills           \033[0m"
echo -e "\033[1;36m==========================================================\033[0m\n"

# 1. Check Python & Graphify
echo -e "\033[1;33m1️⃣ Checking Python & Graphify...\033[0m"
if command -v python3 &>/dev/null; then
    echo "Found Python: $(python3 --version)"
    pip3 install --quiet --upgrade graphifyy || pip install --quiet --upgrade graphifyy
    graphify install || true
    echo -e "\033[1;32m   ✅ Graphify installed.\033[0m"
else
    echo -e "\033[1;31m   ⚠️ python3 not found. Please install Python 3.10+.\033[0m"
fi

# 2. Check Git & Commit Hook
echo -e "\n\033[1;33m2️⃣ Checking Git Repository...\033[0m"
if [ -d ".git" ]; then
    graphify hook install || true
    echo -e "\033[1;32m   ✅ Installed Graphify post-commit hook.\033[0m"
else
    echo "   ℹ️ Not a git repo yet. Run 'git init' and 'graphify hook install' when ready."
fi

# 3. Agent Skills (Addy Osmani)
echo -e "\n\033[1;33m3️⃣ Installing Agent Skills (Addy Osmani)...\033[0m"
if command -v npx &>/dev/null; then
    npx skills add addyosmani/agent-skills || true
    echo -e "\033[1;32m   ✅ Agent Skills installed.\033[0m"
else
    echo -e "\033[1;31m   ⚠️ npx not found. Please install Node.js 18+.\033[0m"
fi

# 4. Agent Environments
echo -e "\n\033[1;33m4️⃣ Checking Agent Environments...\033[0m"
if command -v agy &>/dev/null; then
    echo "   Found Antigravity CLI (agy)! Installing plugins..."
    agy plugin install https://github.com/DietrichGebert/ponytail || true
    agy plugin install https://github.com/addyosmani/agent-skills.git || true
fi

echo -e "\n\033[1;32m==========================================================\033[0m"
echo -e "\033[1;32m   🎉 Vibe Coding Stack Ready!                           \033[0m"
echo -e "\033[1;32m==========================================================\033[0m"
echo "Available workflows:"
echo " • /graphify .        -> Build & inspect codebase knowledge graph"
echo " • /spec              -> Write PRD and clarify goals before coding"
echo " • /plan              -> Decompose spec into atomic, verifiable tasks"
echo " • /build auto        -> Autonomous vertical-slice TDD implementation"
echo " • /test              -> Verify with tests and browser DevTools"
echo " • /review            -> 5-axis Senior Staff quality review"
echo " • /ponytail-review   -> Strip code bloat, enforce native 1-liners"
echo " • /ship              -> Commit atomic changes and prepare release"
echo -e "\033[1;32m==========================================================\033[0m"
