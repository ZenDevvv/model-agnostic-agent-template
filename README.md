# 🚀 Model-Agnostic Agent Template

> A turnkey, production-grade starter template for disciplined, high-performance "vibe coding".  
> Built on 4 Core Pillars: **Graphify**, **Agents**, **Skills**, and **Ponytail** — supplemented by a dedicated **Frontend Design & Motion Suite** (Impeccable, Taste Skill, Emil Kowalski). 100% model-agnostic.

[![Template Repository](https://img.shields.io/badge/GitHub-Template_Repository-blue?logo=github)](https://github.com/ZenDevvv/model-agnostic-agent-template)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Model Agnostic](https://img.shields.io/badge/Models-100%25_Agnostic-success)](README.md#-100-model-agnostic-free-budget--frontier-models)

---

## ⚡ The 4 Core Pillars of this Template

| Pillar | Powered By | What It Does For Your Project |
|---|---|---|
| **1. Structural Awareness** | [Graphify](https://github.com/Graphify-Labs/graphify) | Ingests code (AST across 13+ languages), docs, and diagrams into a knowledge graph. Saves **up to 71.5x tokens** per query vs reading raw files and identifies architectural "God nodes". |
| **2. Specialist Personas** | **Agents** ([addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)) | 4 pre-configured review personas: Senior Staff Code Reviewer, QA Test Engineer, Security Auditor, and Web Performance Auditor. |
| **3. Engineering Lifecycle** | **Skills** ([addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)) | Addy Osmani's 25 production skills. Enforces Red-Green-Refactor TDD, PRDs before code (`/spec`), atomic task planning (`/plan`), and atomic ~100-line changes (`/build auto`). |
| **4. Anti-Bloat Restraint** | [Ponytail](https://github.com/dietrichgebert/ponytail) | The "laziest senior dev in the room." Enforces the 7-rung ladder (YAGNI → Native → 1-liner). Slashes generated lines of code by **~54%** on average while maintaining 100% safety. |

---

## 🎨 Frontend & Design Skills (Anti-Slop, Motion & UX Quality)

To complement the core engineering pillars, this template comes pre-configured with a dedicated design suite to eliminate generic "AI slop" and elevate frontend interfaces:

| Design Skill | Creator | Focus & Capabilities |
|---|---|---|
| **[Impeccable](https://github.com/pbakaus/impeccable)** | Paul Bakaus (ex-Google) | **Design Systems & UX Quality:** Records durable product truth in `PRODUCT.md` (`/impeccable init`), provides 24 UX commands (`/impeccable craft`, `audit`, `bolder`, `quieter`, `polish`), and runs **61 zero-token deterministic rules** auditing contrast and hierarchy. |
| **[Taste Skill](https://github.com/leonxlnx/taste-skill)** | Leon Lin (`leonxlnx`) | **Anti-Slop Art Direction:** 3 tunable 1–10 dials (`DESIGN_VARIANCE`, `MOTION_INTENSITY`, `VISUAL_DENSITY`) and distinct visual genres (Luxury Soft, Minimalist Editorial, Brutalist) that stop models from producing bland cookie-cutter templates. |
| **[Emil Kowalski's Skills](https://github.com/emilkowalski/skills)** | Emil Kowalski (Linear / Vercel) | **Motion Physics & Mobile Polish:** Mathematically correct cubic-bezier deceleration curves, Apple WWDC fluid physics, and mobile-native touch fixes (`100dvh`, tap delay elimination, safe-area padding). |

### 🧊 Optional Creative & 3D Extensions
For projects requiring interactive 3D hero elements, product showcases, or spatial UI without asset bloat:
* **[img2threejs](https://github.com/img2threejs/img2threejs)** — **Reconstruction-by-Code:** Reconstructs 2D reference images directly into pure TypeScript / Three.js code (`THREE.Group`) using an 8-stage quality-gated pipeline. Zero `.glb`/`.obj` file bloat; 100% diffable procedural code with pivots and interaction hooks. See [`docs/img2threejs.md`](docs/img2threejs.md).

---

## 🚀 Quick Start (Starting a New Project)

### 1. Use this Template
Click the green **"Use this template"** button on GitHub, or clone it locally:
```bash
git clone https://github.com/ZenDevvv/model-agnostic-agent-template.git my-new-project
cd my-new-project
```

### 2. Run the One-Click Setup

* **On Windows (PowerShell):**
  ```powershell
  .\setup.ps1
  ```
* **On macOS / Linux / WSL (Bash):**
  ```bash
  chmod +x setup.sh && ./setup.sh
  ```

This automatically:
- Installs and verifies **Graphify** via Python `pip`.
- Installs the post-commit git hook to keep the knowledge graph continuously up to date.
- Installs Addy Osmani's **Agent Skills** into your local agent environment.
- Configures rules for **Cursor**, **Claude Code**, and **Antigravity CLI**.

---

## 💻 The Vibe Coding Workflow

Whenever you develop features or solve problems in this repo, use this battle-tested lifecycle:

```
    STEP 1             STEP 2             STEP 3             STEP 4             STEP 5
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Architectural│    │   Define    │    │    Plan     │    │ Autonomous  │    │  Review &   │
│ Orientation │ ─▶ │ Requirements│ ─▶ │ Tasks       │ ─▶ │ TDD Build   │ ─▶ │ Simplify    │
│  /graphify  │    │    /spec    │    │    /plan    │    │ /build auto │    │ /review     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                                                   │
                                                          Ponytail Ladder ─────────┘
                                                          (Strip bloat & keep 1-liners)
```

### Step 1: Ground the Agent in the Architecture
```text
/graphify .
```
Builds an interactive knowledge graph in `graphify-out/`. Before touching multi-module code, ask:
```text
/graphify query "What connects module X to service Y?"
```

### Step 2: Define Requirements Before Writing Code
```text
/spec
```
The agent drafts a lightweight Product Requirement Document (PRD) with constraints and acceptance criteria. If your prompt is ambiguous, ask the agent to `interview-me` to clarify requirements one question at a time.

### Step 3: Decompose into Atomic Tasks
```text
/plan
```
Decomposes the spec into small, verifiable implementation steps with strict dependency order.

### Step 4: Autonomous Build with Test-Driven Verification
```text
/build auto
```
The agent implements tasks one slice at a time with strict Red-Green-Refactor TDD. **Ponytail's 7-rung ladder** ensures the agent uses native browser/stdlib features instead of inventing unnecessary dependencies or writing 200 lines of boilerplate.

### Step 5: Staff Review & Code Simplification
```text
/review
/code-simplify
/ponytail-review
```
Performs a 5-axis senior staff review, applies Chesterton's Fence to eliminate accidental complexity, and checks for dead code.

### Step 6: Ship
```text
/ship
```
Commits the changes with atomic, descriptive git commit messages.

---

## 📂 Template Repository Structure

```
my-new-project/
├── .agents/
│   └── rules/
│       └── vibe-stack.md        # Antigravity CLI / Gemini CLI workspace rules
├── .cursor/
│   └── rules/
│       ├── ponytail.mdc         # Cursor rule: YAGNI & 7-rung ladder
│       ├── agent-skills.mdc     # Cursor rule: 6-phase SDLC & TDD
│       ├── graphify.mdc         # Cursor rule: Architectural context checking
│       └── design-and-motion.mdc# Cursor rule: Impeccable, Taste dials & Emil motion
├── docs/                        # Deep-dive guides for each pillar
│   ├── tools-for-vibe-coding.md # Master overview and pipeline guide
│   ├── ponytail.md              # Complete Ponytail reference & benchmarks
│   ├── graphify.md              # Complete Graphify reference & AST setup
│   ├── agent-skills.md          # Complete 25-skill SDLC reference
│   ├── emil-skills.md           # Emil Kowalski motion & micro-interaction guide
│   ├── impeccable.md            # Impeccable 24 commands & 61 quality rules
│   ├── taste-skill.md           # Taste Skill anti-slop dials & visual personas
│   ├── img2threejs.md           # (Optional) Procedural 3D UI reconstruction
│   └── omniroute.md             # (Optional) Multi-provider gateway guide
├── AGENTS.md                    # Universal agent directives (Cursor, Codex, OpenCode, etc.)
├── CLAUDE.md                    # Claude Code directives and slash commands
├── GEMINI.md                    # Google Gemini & Antigravity IDE directives
├── setup.ps1                    # One-click Windows setup script
├── setup.sh                     # One-click macOS/Linux setup script
├── .gitignore                   # Configured for Node, Python, and Graphify caches
├── LICENSE                      # MIT License
└── README.md                    # Project documentation
```

---

## 🧠 100% Model-Agnostic (Free, Budget & Frontier Models)

This template **does not lock you into any specific AI vendor or expensive subscription**. It is designed to work with **any model backend**:

| Model Tier | Examples | How This Template Supercharges Them |
|---|---|---|
| **Free & Budget Models** | **Space Bunny**, **Gemini Flash / Flash Lite**, **DeepSeek-V3**, **Qwen 2.5 Coder**, **Llama 3.3**, OpenRouter free tiers | **Solves context and hallucination limits:** Smaller models often hallucinate complex npm/pip APIs or get confused in 50-file codebases. **Ponytail** forces them to write native 1-liners, **Graphify** gives them a compact 71.5x compressed summary, and **Agent Skills** keeps them focused on small, atomic ~100-line tasks. |
| **Frontier Models** | **Claude 3.7 / 3.8 Sonnet**, **GPT-5 / GPT-4o**, **Gemini Pro** | **Enforces architectural discipline:** Prevents frontier models from over-engineering abstractions or making unchecked assumptions during rapid coding sprints. |
| **Local Models** | **Ollama**, **vLLM**, **LM Studio** | **Zero-cloud privacy:** Runs local AST code parsing via Graphify and executes structured prompts locally without breaking token budgets. |

---

## 🛠️ Supported AI Coding Environments

This template works out of the box with:
* **Cursor** (via `.cursor/rules/*.mdc`)
* **Antigravity CLI & Gemini CLI** (via `GEMINI.md` and `.agents/rules/vibe-stack.md`)
* **Claude Code** (via `CLAUDE.md` and native skills)
* **Codex** (via `AGENTS.md`)
* **Cline / Roo Code** (via `AGENTS.md` and OpenAI-compatible endpoints)
* **GitHub Copilot / Windsurf / OpenCode / Aider** (via `AGENTS.md`)

