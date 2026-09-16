# Architecture and contract prompts

Read this reference only when architecture, API, validation, error handling, or implementation conventions are genuinely needed. Prefer executable artifacts and the implementation as the current-state authority; use ADRs for decisions and rationale.

## Architecture boundaries

Clarify as applicable:

- major components and responsibilities
- routing, data flow, and dependency direction
- synchronous and asynchronous communication
- external systems and failure boundaries
- cache, consistency, persistence, and recovery assumptions
- diagrams that explain relationships not obvious from the repository

Do not copy a directory tree or dependency inventory that can be read from the codebase.

## API and contract boundary

Identify the contract kind and its executable authority, such as OpenAPI, GraphQL schema, protobuf, or a shared validation schema. Then consider:

- authentication and authorization boundary
- public versus internal exposure
- contract generation and lifecycle
- compatibility and versioning policy
- pagination, ordering, filtering, and search semantics
- change, deprecation, and migration policy
- idempotency, concurrency, rate limits, streaming, and webhooks only where relevant

Do not maintain a handwritten endpoint catalog when the executable contract provides it. Put the reason for choosing a contract style or pagination strategy in an ADR.

## Validation

Check responsibility at each boundary:

- client input, transport, application/domain, and persistence validation
- shared schema versus boundary-specific rules
- empty, null, missing, malformed, and normalized values
- persistence integrity and cross-record invariants
- stable error representation and when validation runs

Keep reusable schemas and tests authoritative. Document only product rules or boundaries not evident there.

## Error handling

Consider:

- error classifications and stable machine-readable keys
- user-facing copy ownership
- retry, timeout, offline, undo, and recovery behavior
- transport status mapping where it is a public contract
- logging and observability boundaries without exposing sensitive data

## Project implementation conventions

Add project-specific conventions only when tools cannot enforce them and repository conventions do not make them obvious. Possible topics include naming, module boundaries, dependency direction, error construction, async behavior, logging, comments, tests, accessibility implementation, generated code, and exceptions.

Technology selections belong in ADRs. Installed versions and current dependencies belong in manifests and lockfiles. A short architectural orientation may link to those sources but must not duplicate them.
