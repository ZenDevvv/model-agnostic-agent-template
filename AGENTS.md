# Global Agent Directives & Vibe Coding Workflow

This repository uses a combined **Vibe Coding Stack** integrating:
1. **Ponytail** (Anti-Overengineering & Simplicity Ladder)
2. **Graphify** (Multimodal Knowledge Graph & Structural Grounding)
3. **Agent Skills** (Production-Grade SDLC Gates & TDD Discipline)

All AI agents (Claude Code, Cursor, Codex, Antigravity CLI, Copilot, Cline, etc.) must adhere to these directives on every task.

---

## 🧭 Phase 1: Architectural Orientation (Graphify)

Before modifying multiple files or designing features in this codebase:
1. **Check for Knowledge Graph:** Check if `graphify-out/GRAPH_REPORT.md` or `graphify-out/wiki/index.md` exists.
2. **Consult the Graph:** Use the graph report to identify **God Nodes** (architectural hubs) and cross-module dependencies to avoid unintended regressions.
3. **Trace Paths:** For cross-module features, trace connections first (e.g. `graphify path "ComponentA" "ServiceB"`).
4. **Update on Change:** Run `/graphify . --update` or ensure the post-commit git hook is installed (`graphify hook install`).

---

## 🪜 Phase 2: Restraint & Simplicity (Ponytail)

*"The best code is the code you never wrote."*

Before writing or suggesting any code, stop at the **first rung that holds**:
```
1. Does this need to exist?   ──▶ NO: Skip it (YAGNI).
2. Already in this codebase?  ──▶ Reuse it, don't rewrite.
3. Stdlib does it?            ──▶ Use standard library.
4. Native platform feature?   ──▶ Use browser/OS built-in (e.g. <input type="date">, CSS grid, <dialog>).
5. Installed dependency?      ──▶ Use what is already in package.json / requirements.txt.
6. One line?                  ──▶ Write a one-liner.
7. Only then:                 ──▶ The minimum necessary code that works.
```

### Safety Non-Negotiables
Ponytail cuts bloat, not security:
- **Never cut:** trust-boundary validation, input sanitization, error handling, data-loss protection, or accessibility (WCAG AA).
- **Always cut:** custom date/color pickers, reinvented debounce utilities, custom modal frameworks, and bloated state machines when native platform features exist.

---

## 🔄 Phase 3: Software Engineering Lifecycle (Agent Skills)

Follow Addy Osmani's 6-phase engineering lifecycle for all non-trivial tasks:

```
  DEFINE           PLAN            BUILD           VERIFY          REVIEW           SHIP
┌────────┐      ┌────────┐      ┌────────┐      ┌────────┐      ┌────────┐      ┌────────┐
│  Idea  │ ───▶ │  Spec  │ ───▶ │  Code  │ ───▶ │  Test  │ ───▶ │   QA   │ ───▶ │   Go   │
│ Refine │      │  PRD   │      │  Impl  │      │ Debug  │      │  Gate  │      │  Live  │
└────────┘      └────────┘      └────────┘      └────────┘      └────────┘      └────────┘
  /spec           /plan           /build          /test          /review          /ship
```

### 1. DEFINE (`/spec`)
- **Spec before code:** Write a lightweight PRD with objectives, boundaries, and acceptance criteria.
- **Clarify ambiguities:** If requirements are vague, interrogate the user with one question at a time (`interview-me`) until 95% confidence is reached.
- **Set constraints:** Define quality bars and test thresholds before implementing.

### 2. PLAN (`/plan`)
- Decompose specs into atomic, verifiable tasks with dependency ordering.
- Keep each task small and testable.

### 3. BUILD (`/build` / `/build auto`)
- **Incremental implementation:** Thin vertical slices. One slice at a time.
- **TDD (Red-Green-Refactor):** Write a failing test first. Implement only enough code to pass. Refactor cleanly.
- **No test dodging:** Never silence linters, delete assertions, or skip tests to fake a green result.
- **Doubt-driven development:** For irreversible or security-sensitive changes, adversarially verify assumptions (`CLAIM` → `DOUBT` → `RECONCILE`).

### 4. VERIFY (`/test`)
- Prove it works with unit tests and browser DevTools verification (inspect DOM, console, network).
- Debug with the 5-step triage: Reproduce → Localize → Reduce → Fix → Guard.

### 5. REVIEW (`/review` & `/code-simplify`)
- **Senior Staff Standard:** Review changes across 5 axes: Correctness, Security, Performance, Maintainability, Simplicity.
- **Sizing:** Keep changes around ~100 lines per commit.
- **Chesterton's Fence:** Simplify the code (`/code-simplify`) without altering expected behavior or removing necessary guards.

### 6. SHIP (`/ship`)
- Trunk-based commits with descriptive messages.
- Treat every git commit as a safe rollback point.

---

## 🤖 Model-Agnostic Guidelines (Free, Budget & Frontier Models)

This template is 100% **model-agnostic**. It operates across any LLM backend (Gemini, Claude, GPT, Codex, DeepSeek, Qwen, Space Bunny, Llama, Ollama, etc.).

### 🌟 If Running Free or Budget Models (Gemini Flash, DeepSeek-V3, Qwen 2.5 Coder, Space Bunny, Llama):
Lightweight and free models thrive when tasks are scoped cleanly:
1. **Never attempt multi-file rewrites in one turn:** Limit changes strictly to atomic slices of ~50 to 100 lines.
2. **Lean heavily on Ponytail's one-liners:** Smaller models frequently hallucinate non-existent package APIs or complex imports. Using native platform features (`fetch`, native DOM, standard library) prevents hallucination and syntax errors.
3. **Never ingest the whole codebase raw:** When context windows are limited, rely entirely on `graphify-out/GRAPH_REPORT.md` or `graphify-out/wiki/index.md` rather than reading dozens of source files.
4. **Enforce Step-by-Step (`/plan`):** Do not skip the plan. Break tasks down so the model is only solving one isolated problem per step.

### 🏛️ If Running Frontier Models (Claude 3.7/3.8 Sonnet, GPT-5, Gemini Pro):
1. Use deliberate reasoning to trace cross-module implications in the knowledge graph.
2. Apply `/review` and adversarial doubt verification before submitting pull requests.

