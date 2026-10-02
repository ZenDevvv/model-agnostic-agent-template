# Claude Code Adapter

This repository's canonical operating contract is [AGENTS.md](AGENTS.md). Read it before making changes.

Claude-specific entry points:

- `/graphify` — inspect or refresh derived architectural context.
- `/spec` and `/plan` — create task-scoped specification and implementation plan.
- `/build`, `/test`, `/review`, `/code-simplify`, `/ship` — execute and verify the lifecycle defined in `AGENTS.md`.
- `/impeccable` — review or generate design guidance; accepted design truth belongs in `.project-truth/truth/design.md`.

Canonical project truth is in `.project-truth/truth/`. Workspace context is in `.project-truth/workspace/`. Governance and reports never override canonical truth.
