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
    python3 -m graphify install || graphify install || true
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
    python3 -m graphify hook install 2>/dev/null || graphify hook install 2>/dev/null || true
    echo -e "\033[1;32m   ✅ Installed Graphify post-commit hook.\033[0m"
fi

# 3. Engineering & Design Skills
echo -e "\n\033[1;33m3️⃣ Installing Engineering & Design Skills...\033[0m"
if command -v npx &>/dev/null; then
    export CI=true

    echo "   Installing Addy Osmani's Agent Skills..."
    npx --yes skills add addyosmani/agent-skills --all || true

    echo "   Installing Taste Skill (Anti-Slop & Dials)..."
    npx --yes skills add https://github.com/Leonxlnx/taste-skill --all || true

    echo "   Installing Emil Kowalski's Design & Motion Skills..."
    npx --yes skills@latest add emilkowalski/skills --all || true

    echo "   Installing Impeccable (Design Guidance & 61 Quality Rules)..."
    npx --yes impeccable install --yes --scope=project || true

    unset CI
    echo -e "\033[1;32m   ✅ Engineering & Design Skills installed.\033[0m"
else
    echo -e "\033[1;31m   ⚠️ npx not found. Please install Node.js 18+.\033[0m"
fi

# 4. Agent Environments
echo -e "\n\033[1;33m4️⃣ Checking Agent Environments...\033[0m"
if command -v agy &>/dev/null; then
    echo "   Found Antigravity CLI (agy)! Installing plugins..."
    agy plugin install https://github.com/DietrichGebert/ponytail --silent || true
    agy plugin install https://github.com/addyosmani/agent-skills.git --silent || true
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
echo ""
echo -e "\033[1;36m👉 WHAT TO DO NEXT (No terminal commands needed!):\033[0m"
echo "   1. Open your AI coding assistant (Antigravity / Cursor / Claude)."
echo "   2. In the AI chat, simply describe what you want to build:"
echo -e "\033[1;33m      Example: 'I want to build a modern personal portfolio.'\033[0m"
echo ""
echo "   The AI will automatically handle planning, design, and"
echo "   code quality in the background."
echo ""
echo -e "\033[0;90m💡 Optional shortcuts for advanced users:\033[0m"
echo -e "\033[0;90m   /spec   -> Write a PRD before writing code\033[0m"
echo -e "\033[0;90m   /plan   -> Break tasks into small verifiable steps\033[0m"
echo -e "\033[0;90m   /review -> Senior Staff quality review\033[0m"
echo -e "\033[1;32m==========================================================\033[0m"
