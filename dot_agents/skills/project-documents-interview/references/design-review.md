# Design documentation review prompts

Read this reference when filling or reviewing design documentation. Design is not optional for a UI product because its principles and intended behavior cannot be reconstructed reliably from CSS or component code alone. Use Storybook as the eventual authority for implemented component variants and states; keep principles, composition rules, and experience intent in design documents.

## Inputs and process

Confirm the relationship among requirements, wireframes, visual explorations, prototypes, design documents, component examples, and implemented screens. Distinguish exploratory artifacts from accepted guidance.

## Foundations

Review as applicable:

- brand assets, tone, voice, and product personality
- themes, color roles, contrast, and semantic feedback
- typography, spacing, sizing, radius, elevation, and layering
- icons, images, illustrations, and content style
- focus appearance, motion principles, and platform considerations

## Interaction guidance

Check progressive disclosure, keyboard and gesture access, accessible names, links and tooltips, destructive action confirmation, pointer/hover/focus states, reduced motion, button hierarchy, validation timing, navigation, empty/loading/error states, and information density.

## Screens and layouts

For each meaningful screen or layout, check route or entry condition, purpose, regions, hierarchy, responsive behavior, viewports, mobile behavior, and all relevant UI states. Avoid restating component internals.

## Components and patterns

Until Storybook exists, preserve component behavior, variants, states, and composition rules in the design documents. When Storybook becomes authoritative, migrate those examples incrementally and leave links plus principles in the document.

Include cross-component patterns only when they matter: notifications, banners, dialogs, confirmations, forms, tables/lists, navigation, search, filtering, pagination or infinite scrolling, and progressive loading.

## Tokens

Record semantic roles and design intent. Let code or generated references own literal token values when possible. Consider color, typography, spacing, size, breakpoints, radius, shadow, z-index, opacity, and motion only as relevant.

## Review coverage

Before treating design guidance as ready, review:

- scope and source-of-truth boundaries
- long text, missing data, failures, and destructive paths
- keyboard use, screen-reader meaning, contrast, and reduced motion
- localization expansion, dark mode, and print only when in scope
- responsibility and handoff among design docs, Storybook, prototype, and implementation
