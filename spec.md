# Opt-In Initial Commit

## Objective

Prevent setup from automatically staging and committing every workspace file.

## Constraints

- Preserve the existing initial commit message when the user explicitly opts in.
- Do not stage files by default.
- Keep PowerShell and Bash flags behaviorally equivalent.

## Acceptance criteria

- Default setup shows `git status --short` and does not stage or commit files.
- `-CommitInitialSetup` and `--commit-initial-setup` enable the existing stage-and-commit behavior.
- Documentation explains the default and both opt-in flags.
