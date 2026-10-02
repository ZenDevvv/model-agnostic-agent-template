#!/usr/bin/env bash
# One-Click Vibe Coding Stack Setup Script (Bash / macOS / Linux / WSL)
# Installs & Configures: Ponytail, Graphify, and Addy Osmani's Agent Skills.

set -e

DESIGN_PROFILE="motion"
DRY_RUN=false
if [[ "${1:-}" == "--design-profile" ]]; then
    DESIGN_PROFILE="${2:-motion}"
    shift 2
elif [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    shift
fi
if [[ "${1:-}" == "--dry-run" ]]; then DRY_RUN=true; fi

if [[ -t 0 && -z "${CI:-}" && "$DRY_RUN" == false && "$DESIGN_PROFILE" == "motion" ]]; then
    echo "Design profile (default: motion):"
    echo "  [1] motion   - Taste + Emil motion/mobile + Impeccable (recommended)"
    echo "  [2] frontend - Taste + Impeccable"
    echo "  [3] minimal  - Impeccable only"
    echo "  [4] custom   - Choose each design skill"
    read -r -p "Choose 1-4, or press Enter for motion: " choice
    case "$choice" in
        2) DESIGN_PROFILE="frontend" ;;
        3) DESIGN_PROFILE="minimal" ;;
        4) DESIGN_PROFILE="custom" ;;
    esac
fi

INSTALL_IMPECCABLE=true
INSTALL_TASTE=false
INSTALL_EMIL=false
[[ "$DESIGN_PROFILE" == "motion" || "$DESIGN_PROFILE" == "frontend" ]] && INSTALL_TASTE=true
[[ "$DESIGN_PROFILE" == "motion" ]] && INSTALL_EMIL=true
if [[ "$DESIGN_PROFILE" == "custom" && "$DRY_RUN" == false ]]; then
    read -r -p "Install Impeccable quality checks? [Y/n] " answer
    [[ "$answer" =~ ^(n|no)$ ]] && INSTALL_IMPECCABLE=false
    read -r -p "Install Taste Skill visual direction? [y/N] " answer
    [[ "$answer" =~ ^(y|yes)$ ]] && INSTALL_TASTE=true
    read -r -p "Install Emil motion/mobile skills? [y/N] " answer
    [[ "$answer" =~ ^(y|yes)$ ]] && INSTALL_EMIL=true
fi

if [[ "$DRY_RUN" == true ]]; then
    echo "Dry run: no installation, Git, or commit actions will be performed."
    echo "Design profile: $DESIGN_PROFILE"
    echo "  Impeccable: $INSTALL_IMPECCABLE"
    echo "  Taste Skill: $INSTALL_TASTE"
    echo "  Emil motion/mobile: $INSTALL_EMIL"
    exit 0
fi
# Ensure script executes in the project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$(basename "$SCRIPT_DIR")" == ".template" ]]; then
    cd "$SCRIPT_DIR/.."
fi

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

    if [[ "$INSTALL_TASTE" == true ]]; then
        echo "   Installing Taste Skill (visual direction)..."
        npx --yes skills add https://github.com/Leonxlnx/taste-skill --skill "design-taste-frontend" || true
    fi

    if [[ "$INSTALL_EMIL" == true ]]; then
        echo "   Installing Emil Kowalski's Motion & Mobile Native Skills..."
        npx --yes skills@latest add emilkowalski/skills --skill "animate" --skill "mobile-native" --skill "review-animations" || true
    fi

    if [[ "$INSTALL_IMPECCABLE" == true ]]; then
        echo "   Installing Impeccable (design guidance & quality rules)..."
        npx --yes impeccable install --yes --scope=project || true
    fi

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
