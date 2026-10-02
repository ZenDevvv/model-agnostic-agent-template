# Project Truth System

This directory is the lightweight project-truth layer for the template. It is inspired by WWG (Wiki, Workspace, Governance), but intentionally contains only the surfaces needed for a small, model-agnostic project.

## Layers

- `truth/` — canonical product, requirement, terminology, architecture, decision, principle, and design documents.
- `workspace/` — compact context and the current task an agent should load before working.
- `governance/` — drift, testing, and recommendation rules.
- `reports/` — temporary investigation and handoff output. Reports never override canonical truth.

Update canonical truth when accepted behavior, scope, terminology, architecture, design direction, or safety boundaries change. Keep implementation history and temporary notes in reports or decisions instead.
