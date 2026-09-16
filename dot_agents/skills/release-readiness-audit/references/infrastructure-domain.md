# Infrastructure and domain audit

Use this checklist when a release creates or changes hosting, infrastructure, networking, storage, or public domains. Project documents should record only product-specific constraints and unresolved release blockers; infrastructure code and provider configuration remain authoritative for the current state.

## Infrastructure

- cloud/provider and service ownership are known
- infrastructure as code covers reproducible resources where practical
- environment separation and promotion flow are defined
- network exposure, ingress, egress, firewall, and private boundaries are reviewed
- hosting, database, object storage, cache, queue, and CDN responsibilities are explicit
- state storage, locking, secrets, and access to infrastructure automation are controlled
- backups, restoration, disaster recovery, and rollback are tested in proportion to risk
- cost limits, quotas, scaling assumptions, and shutdown paths are understood
- local development and preview environments do not silently depend on production resources

## Domain and certificates

- registrar ownership, renewal, recovery contacts, and WHOIS/privacy settings are controlled
- canonical domain and subdomain responsibilities are defined
- DNS records and change authority are known
- mail-related DNS is configured when mail is sent
- certificate issuance and renewal are automated or operationally owned
- HTTPS redirects, HSTS, canonical redirects, and public indexing boundaries are reviewed
- preview, staging, and temporary domains are blocked from unintended public discovery when required

Use ADRs for provider, topology, or infrastructure-management choices whose alternatives and consequences matter.
