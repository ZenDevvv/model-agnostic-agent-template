# Requirements

Record accepted requirements here. Each requirement should be testable or have a clear manual acceptance method.

## Functional requirements

- All generated application source code must be written under `app/`; repository tooling and project-governance files remain in their established top-level locations.
- Supported agents must recognize `adopt` and `/adopt` as a request to ingest the current `app/` baseline into the project-truth workflow.
- Adoption must inventory and read relevant text source, configuration, and documentation files under `app/`, preserve the source files, write an evidence report, and synchronize only confirmed findings into the applicable canonical truth files.
- If `app/` is missing or contains no ingestible files, the agent must report that condition and ask for direction rather than claiming adoption completed.

## Non-functional requirements

- Adoption must keep unknown or ambiguous findings explicit and review-first; it must not silently infer product requirements, security guarantees, or design intent.

## Acceptance criteria

- `adopt` is documented in the universal agent contract, each supported adapter, and the setup workflow documentation.
- The adoption protocol distinguishes evidence in `.project-truth/reports/` from accepted truth in `.project-truth/truth/`.

Requirements are canonical only after they are accepted. Ideas and unapproved recommendations belong in `.project-truth/governance/recommendations.md` or a report. Task-scoped `spec.md` and `plan.md` are working documents; promote durable accepted requirements here.
