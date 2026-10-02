# Current Task

## Objective

- Make the setup scripts' initial Git commit explicit and opt-in.

## Scope

- `.template/setup.ps1`, `.template/setup.sh`, and setup documentation.

## Constraints

- Preserve canonical project truth.
- Keep changes minimal and verifiable.
- Do not stage or commit workspace files unless the user explicitly requests it.

## Acceptance criteria

- Default setup reports Git status without staging or committing files.
- Matching PowerShell and Bash flags enable the existing initial-commit behavior.
- Setup documentation explains the behavior.

`spec.md` and `plan.md` at the repository root are task-scoped working documents. Update canonical truth only when the task establishes accepted durable behavior.

## Closeout

- Truth updated: no
- Tests or verification: PowerShell parse, all four dry-run profiles, explicit-commit flag acceptance, Git-reset conflict guard, project-truth validation, and diff whitespace checks passed. Bash syntax could not run locally because no WSL distribution is installed.
- Recommendations: none recorded
