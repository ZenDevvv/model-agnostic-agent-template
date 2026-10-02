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

# 2. Check Git, Detach from Template, & Commit Hook
echo -e "\n\033[1;33m2️⃣ Checking Git Repository...\033[0m"
origin_url=$(git remote get-url origin 2>/dev/null || echo "")

if [[ "$origin_url" == *"model-agnostic-agent-template"* && "$1" != "--keep-origin" ]]; then
    echo -e "\033[1;33m   🔄 Detected clone of template repository ($origin_url).\033[0m"
    echo -e "\033[1;36m   Disconnecting from template and initializing fresh Git repository for your project...\033[0m"
    rm -rf .git
    (git init -b main >/dev/null 2>&1 || git init >/dev/null 2>&1)
    echo -e "\033[1;32m   ✅ Initialized fresh, detached Git repository (main).\033[0m"
elif [ ! -d ".git" ]; then
    echo -e "\033[1;36m   Initializing fresh Git repository for your project...\033[0m"
    (git init -b main >/dev/null 2>&1 || git init >/dev/null 2>&1)
    echo -e "\033[1;32m   ✅ Initialized fresh Git repository (main).\033[0m"
fi

if [ -d ".git" ]; then
    graphify hook install || true
    echo -e "\033[1;32m   ✅ Installed Graphify post-commit hook.\033[0m"
fi

# 3. Engineering & Design Skills
echo -e "\n\033[1;33m3️⃣ Installing Engineering & Design Skills...\033[0m"
if command -v npx &>/dev/null; then
    echo "   Installing Addy Osmani's Agent Skills..."
    npx skills add addyosmani/agent-skills || true

    echo "   Installing Taste Skill (Anti-Slop & Dials)..."
    npx skills add https://github.com/Leonxlnx/taste-skill || true

    echo "   Installing Emil Kowalski's Design & Motion Skills..."
    npx skills@latest add emilkowalski/skills || true

    echo "   Installing Impeccable (Design Guidance & 61 Quality Rules)..."
    npx impeccable install --scope=project || true

    echo -e "\033[1;32m   ✅ Engineering & Design Skills installed.\033[0m"
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

# 5. Finalize Git Repository
echo -e "\n\033[1;33m5️⃣ Finalizing Git Baseline...\033[0m"
if [ -d ".git" ]; then
    git add .
    git commit -m "feat: initial project setup with agent skills and tools" --quiet || true
    echo -e "\033[1;32m   ✅ Initial stack and agent skills committed to Git.\033[0m"
fi

echo -e "\n\033[1;32m==========================================================\033[0m"
echo -e "\033[1;32m   🎉 Vibe Coding Stack Ready!                           \033[0m"
echo -e "\033[1;32m==========================================================\033[0m"
echo "Available workflows:"
echo " • /graphify .        -> Build & inspect codebase knowledge graph"
echo " • /spec              -> Write PRD and clarify goals before coding"
echo " • /plan              -> Decompose spec into atomic, verifiable tasks"
echo " • /build auto        -> Autonomous vertical-slice TDD implementation"
echo " • /impeccable init   -> Gather product truth into PRODUCT.md"
echo " • /impeccable craft  -> Shape-then-build interactive visual flow"
echo " • /impeccable audit  -> 61 zero-token deterministic design checks"
echo " • /animate           -> Build fluid motion with decelerating curves"
echo " • /review            -> 5-axis Senior Staff quality review"
echo " • /ponytail-review   -> Strip code bloat, enforce native 1-liners"
echo " • /ship              -> Commit atomic changes and prepare release"
echo -e "\033[1;32m==========================================================\033[0m"

