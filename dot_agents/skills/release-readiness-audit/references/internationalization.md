# Internationalization audit

Use this checklist only when multiple languages, locales, regions, or future localization materially affect the product.

- supported, fallback, and explicitly unsupported languages/locales are stated
- translation resources and ownership are defined
- locale selection, persistence, routing, and canonical/alternate URLs are defined
- dates, times, time zones, numbers, currencies, names, addresses, and units are formatted intentionally
- plural, gender, honorific, interpolation, and message-format requirements are handled
- right-to-left layout and font coverage are reviewed when relevant
- content expansion, truncation, wrapping, and responsive behavior are tested
- missing translations and fallback behavior are observable
- translated metadata, errors, email, and generated content are included or explicitly excluded
- extraction, translation, review, release, and rollback workflow is understood
- deferred localization work is distinguished from a permanent single-language policy

Keep literal message catalogs in localization resources. Put durable product language policy in product or design documentation and rationale-heavy choices in ADRs.
