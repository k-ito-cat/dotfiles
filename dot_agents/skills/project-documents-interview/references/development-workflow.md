# Development workflow prompts

Read this reference only when branch strategy, change flow, release, or environment variable management needs to be clarified. Record policies and the location of their authority in `spec/development-workflow.md`. Settings such as branch protection, CI definitions, deploy configuration, and `.env.example` remain the authority for their own values; do not copy them. Commit message rules belong to commit-workflow, and pre-release audits belong to release-readiness-audit.

## Branch strategy

Clarify as applicable:

- branching model and main branch (trunk-based, GitHub Flow, git flow, or other)
- branch types, naming, and expected lifespan
- whether direct changes to the main branch are allowed, and until when
- where branch protection is configured

## Change flow

Clarify as applicable:

- the path from starting work to integration (issue, branch, pull request)
- checks that must pass before integration, and where they are defined
- whether review is required and who reviews
- merge method (squash, rebase, merge commit) and branch cleanup after merge
- the path for urgent fixes

## Versioning, tags, and release

Clarify as applicable:

- whether the product is versioned, and the version format
- when tags are created and who creates them
- where release notes or the changelog live
- what triggers deployment (branch, tag, manual) and where it is defined
- where rollback steps live (operations)

## Environment variables

Clarify only the management method, in about one line (for example, the secret manager used). Variable names, values, and per-environment details stay in their own sources.

## Boundaries

- A technology or strategy selection with rationale belongs in an ADR; the resulting policy may be summarized in `spec/development-workflow.md`.
- Items identical to the shared practice are recorded as such without additional explanation.
- Do not create explanations to fill the template; leave undecided items in the open-issues section with reason and timing.
