# Product and requirements prompts

Read this reference only when creating, reorganizing, or interviewing for product and requirements documents. These are prompts, not mandatory sections. Preserve confirmed product-specific information; omit irrelevant prompts and keep unresolved matters explicit.

## Product definition

Confirm only what is needed to understand the product:

- overview, purpose, problem, and expected value
- target users, personas, usage situations, and alternatives
- goals, non-goals, success metrics, and failure signals
- assumptions, constraints, dependencies, and product principles

Do not turn technology choices or implementation details into product requirements.

## Scope

Separate:

- included now
- explicitly excluded
- deferred or candidate work
- MVP boundaries and release-specific boundaries
- supported devices, browsers, operating systems, and responsive ranges when product behavior depends on them
- public/private exposure, external dependencies, and constraints
- permanent exclusions versus temporary deferrals
- conditions and authority for changing scope

## Functional requirements

For each user-visible capability, clarify as applicable:

- actor, trigger, expected value, and preconditions
- included and excluded behavior
- normal flow, state transitions, persistence, recovery, and deletion
- empty, loading, failure, offline, retry, and partial-success behavior
- acceptance criteria and observable evidence
- authoritative artifact when behavior is already expressed by a schema, test, prototype, or generated contract

Avoid duplicating field-level schemas or endpoint inventories already represented by executable artifacts.

## Quality requirements

Consider performance, availability, maintainability, observability, testability, compatibility, operability, security, privacy, and cost. For each relevant quality:

- state the minimum target or boundary
- state where and when it applies
- distinguish confirmed requirements from deferred targets
- identify how compliance can be observed or tested
- preserve unknowns instead of inventing numbers

## Terminology

Record only domain terms that improve shared understanding:

- canonical term, definition, aliases, and terms to avoid
- mapping between product language, UI labels, API names, and data names where they intentionally differ
- state and operation vocabulary that affects behavior

## Unresolved matters

For every unresolved item, capture the reason it is unresolved, affected scope, decision timing, required evidence, and who or what can resolve it.
