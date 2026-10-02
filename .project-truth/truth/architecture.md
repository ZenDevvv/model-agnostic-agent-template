# Architecture

Describe the current implemented architecture and its important boundaries here.

## System overview

- `app/` contains application source. `.project-truth/reports/` holds derived adoption evidence, while `.project-truth/truth/` holds only accepted findings promoted from that evidence.

## Modules and responsibilities

- The `adopt` agent workflow inventories the initial `app/` baseline and routes confirmed findings to the relevant project-truth documents.

## Data and integrations

- TBD

## Security and persistence boundaries

- TBD

Keep this document aligned with meaningful code changes. Graphify provides a derived dependency map; it does not replace this accepted architecture record.
