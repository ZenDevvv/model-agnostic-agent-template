# Current Task

## Objective

- Make `app/` the explicit required location for generated application source code.

## Scope

- Agent operating contract and canonical project-truth documentation.

## Constraints

- Keep repository tooling, agent instructions, project-truth records, and task-scoped documents in their established top-level locations.

## Acceptance criteria

- `AGENTS.md` unambiguously requires generated application source code to be written under `app/`.
- Canonical project-truth documentation preserves the same repository boundary.

`spec.md` and `plan.md` at the repository root are task-scoped working documents. Update canonical truth when the task establishes accepted durable behavior.

## Closeout

- Truth updated: yes
- Tests or verification: `git diff --check` passed; the new application-location requirement was confirmed in `AGENTS.md` and canonical project-truth files.
- Recommendations: none recorded.
