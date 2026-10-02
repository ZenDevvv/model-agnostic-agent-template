# Current Task

## Objective

- Add the portable `adopt` command/keyword so agents can ingest initial `app/` files into project truth after setup.

## Scope

- Agent operating contract, supported agent adapters, project-truth documentation, and setup workflow documentation.

## Constraints

- Preserve application source during adoption.
- Record evidence before accepting project truth.
- Keep unknown or ambiguous findings review-first and explicit.

## Acceptance criteria

- `adopt` and `/adopt` are discoverable and consistently defined for supported agents.
- Adoption inventories relevant `app/` files, writes a report, and promotes only confirmed findings to canonical truth.
- Empty or missing `app/` is reported without a false success.

`spec.md` and `plan.md` at the repository root are task-scoped working documents. Update canonical truth when the task establishes accepted durable behavior.

## Closeout

- Truth updated: yes
- Tests or verification: PowerShell project-truth validation (including the new adoption-guidance guard), PowerShell setup-script parsing, adoption guidance coverage, and `git diff --check` passed. Bash validation and syntax checking could not run because no Bash/WSL distribution is available in this environment.
- Recommendations: none recorded
