# Fishbone Analysis

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document uses the **Fishbone Analysis**, also known as the **Ishikawa Diagram** or **Cause-and-Effect Analysis**, to organise the contributing factors behind the critical Sprint 1 fintech defects.

Unlike the Five Whys technique, which follows one chain of questioning, Fishbone Analysis examines the problem from several dimensions at the same time.

The analysis covers:

* Requirements
* People and Communication
* Process
* Application Design
* Development
* Testing
* Data and Database
* Tools and Environment
* Monitoring and Operations

---

# Problem Statement

## Primary Effect

**Critical financial and security defects were discovered late in the release cycle, resulting in a NO-GO production recommendation.**

The main failures included:

* Duplicate wallet credit
* Failed transfer without reversal
* Expired JWT access
* Daily transfer-limit bypass
* Cross-customer beneficiary access
* Refund exceeding original amount
* Notification failure changing financial status

---

# Fishbone Structure

```text
Requirements ───────────────┐
People & Communication ─────┤
Process ────────────────────┤
Application Design ─────────┤
Development ────────────────┤
Testing ────────────────────┼──► Critical financial and security defects
Data & Database ────────────┤     discovered late in the release cycle
Tools & Environment ────────┤
Monitoring & Operations ────┘
```

---

# 1. Requirements Causes

## Identified Factors

* Happy-path business rules were clearer than failure-state rules.
* Reversal requirements did not distinguish failure before debit from failure after debit.
* Refund requirements did not clearly separate:

  * Transaction amount
  * Service fee
  * Settled amount
  * Refundable amount
  * Previously refunded amount
* Duplicate provider callbacks were not initially treated as normal payment-provider behaviour.
* Daily transfer-limit rules did not define cumulative calculation.
* Time-zone rules for daily limits were unclear.
* Ownership requirements for customer-specific resources were assumed rather than documented.
* Notification failure behaviour was not explicitly defined.
* Acceptance criteria did not consistently include reconciliation outcomes.

## Defects Influenced

* BUG-001
* BUG-002
* BUG-005
* BUG-006
* BUG-007
* BUG-008

## Recommended Controls

* Add failure and recovery criteria to every financial user story.
* Introduce a standard fintech acceptance-criteria checklist.
* Require Product, QA, Engineering, Finance, and Risk review for money-movement rules.
* Define the financial source of truth before implementation.
* Document business-day, status, fee, reversal, and refund rules explicitly.

---

# 2. People and Communication Causes

## Identified Factors

* Product and Engineering held different assumptions about refund calculation.
* Ownership of transfer compensation logic was unclear.
* Authentication was sometimes treated as sufficient authorisation.
* QA was involved after some core design decisions had already been made.
* Operations requirements for reconciliation and exception handling were not captured early.
* Provider retry behaviour was not fully communicated.
* Financial-risk scenarios were not reviewed jointly by all stakeholders.
* Notification service ownership and transaction-service ownership were not clearly separated.

## Defects Influenced

* BUG-001
* BUG-002
* BUG-005
* BUG-006
* BUG-007
* BUG-008

## Recommended Controls

* Run a pre-development quality and risk workshop.
* Use shared definitions for debit, credit, reversal, refund, settlement, and failure.
* Assign one accountable owner for each financial recovery workflow.
* Include QA and Operations during design reviews.
* Document assumptions and convert them into testable acceptance criteria.
* Escalate unresolved financial-rule ambiguity before coding begins.

---

# 3. Process Causes

## Identified Factors

* No mandatory financial-invariant review existed.
* Code review did not consistently check:

  * Idempotency
  * Reversal handling
  * Refund limits
  * Resource ownership
  * Transaction atomicity
* Negative and failure-path testing occurred later than happy-path testing.
* Database validation was introduced after API validation.
* Provider failure simulations were not part of early sprint testing.
* Release gates focused on test completion but initially lacked specific financial-integrity gates.
* Security regression did not initially include object-level authorisation.
* Corrective actions from early defects were not immediately converted into broader preventive controls.

## Defects Influenced

All reviewed defects.

## Recommended Controls

* Introduce financial-invariant, security, and recovery checklists.
* Shift negative, integration, and database testing earlier.
* Add mandatory API-to-database validation for financial workflows.
* Require defect-based regression updates before defect closure.
* Add financial-integrity gates to Definition of Done.
* Include critical-path automated tests in CI.
* Track preventive actions through completion and effectiveness review.

---

# 4. Application Design Causes

## Identified Factors

* Callback processing was not designed as idempotent.
* Transfer workflows lacked a guaranteed compensation path.
* Notification processing was tightly coupled to financial processing.
* Transaction-state transitions did not enforce financial recovery requirements.
* Object ownership was not enforced consistently at the service or repository layer.
* Refund design did not maintain a remaining refundable balance.
* Daily-limit validation was designed around a single transaction request.
* Financial operations were split across multiple non-atomic steps.
* Source-of-truth responsibilities were not clearly defined across services.

## Defects Influenced

* BUG-001
* BUG-002
* BUG-005
* BUG-006
* BUG-007
* BUG-008

## Recommended Controls

* Use explicit transaction-state machines.
* Design compensation workflows before implementation.
* Make provider callback processing idempotent.
* Isolate notification delivery from financial status.
* Scope customer-owned queries by authenticated user.
* Model refundable and already-refunded values.
* Use atomic database transactions for related financial changes.
* Define invariants that cannot be violated regardless of service failure.

---

# 5. Development Causes

## Identified Factors

* Provider reference was not checked atomically before credit.
* No unique provider-reference constraint existed.
* Failure handler marked transfer failed without invoking reversal.
* JWT middleware did not consistently enforce expiration.
* Transfer-limit service checked only the requested amount.
* Beneficiary query used resource ID without owner ID.
* Refund service trusted a derived amount without upper-bound validation.
* Notification exception reused the financial transaction’s failure handler.
* Some financial updates were committed before all related checks completed.
* Validation logic relied too heavily on application code without database safeguards.

## Defects Influenced

All reviewed defects.

## Recommended Controls

* Add defensive validation at service and database levels.
* Use unique constraints for externally supplied identifiers.
* Add ownership scoping to repositories.
* Use typed state transitions and explicit failure branches.
* Add compensation and rollback logic.
* Add invariant-focused unit and integration tests.
* Standardise authentication middleware.
* Separate non-financial exceptions from financial state changes.

---

# 6. Testing Causes

## Identified Factors

* Early testing focused on successful paths.
* Duplicate callback testing was absent initially.
* Failure-after-debit scenarios were underrepresented.
* Expired-token testing was missing from early automation.
* Daily-limit tests used one transfer instead of cumulative transfers.
* Cross-user test data was not part of the first security cycle.
* Refund tests focused on one full-refund scenario.
* Notification outage was not simulated after successful transaction processing.
* Database and ledger reconciliation occurred later.
* Provider mocks did not reproduce retry and delay behaviour realistically.

## Defects Influenced

All reviewed defects.

## Recommended Controls

* Add risk-based negative scenarios before implementation completion.
* Maintain separate customer accounts for authorisation testing.
* Validate every financial action through UI, API, database, and ledger.
* Add callback retries, timeouts, and delayed responses to mocks.
* Add full, partial, repeated, and over-refund tests.
* Add failure-before-debit and failure-after-debit transfer tests.
* Add expired-token and ownership tests to CI.
* Use defect patterns to expand regression coverage across related modules.

---

# 7. Data and Database Causes

## Identified Factors

* Provider-reference uniqueness was not enforced in the database.
* Refund records did not maintain remaining refundable balance.
* Ledger and wallet changes were not always handled atomically.
* No database constraint protected against duplicate financial processing.
* No scheduled query identified failed debited transactions without reversals.
* Daily transfer totals were not readily available to the validation service.
* Ownership relationships were not consistently enforced at query level.
* Test data did not include sufficient failure, retry, and cross-user combinations.

## Defects Influenced

* BUG-001
* BUG-002
* BUG-005
* BUG-006
* BUG-007

## Recommended Controls

* Add unique constraints where financially appropriate.
* Add foreign keys and ownership-aware repository queries.
* Maintain cumulative refund and reversal relationships.
* Run financial operations inside database transactions.
* Add reconciliation queries for:

  * Duplicate provider references
  * Unreversed failed debits
  * Over-refunds
  * Orphan ledger records
  * Daily-limit breaches
* Maintain a reusable fintech test-data catalogue.

---

# 8. Tools and Environment Causes

## Identified Factors

* Provider mocks initially returned predictable single responses.
* Retry, timeout, delayed callback, and partial-failure simulations were limited.
* QA token configuration made expiry defects harder to observe.
* Third-party sandbox instability blocked some regression scenarios.
* Logs did not always contain enough correlation data.
* Test environments did not consistently match intended production configuration.
* No automated data-reset strategy existed for repeatable financial tests.
* Manual environment preparation increased inconsistency.

## Defects Influenced

* BUG-001
* BUG-002
* BUG-003
* BUG-008

## Recommended Controls

* Expand provider mocks to simulate realistic behaviour.
* Align security configuration across environments.
* Add transaction, request, provider, and correlation IDs to logs.
* Create repeatable environment-health checks.
* Automate test data seeding and cleanup.
* Add dependency availability checks before regression.
* Use contract tests for critical third-party integrations.

---

# 9. Monitoring and Operations Causes

## Identified Factors

The system lacked alerts or scheduled exception reports for:

* Duplicate provider callbacks
* Failed debited transactions without reversals
* Transactions pending beyond SLA
* Refund totals above the eligible amount
* Daily transfer-limit breaches
* Notification failures
* Wallet and ledger mismatch
* Repeated authorisation failures

Operational playbooks for manual recovery and customer communication were also incomplete.

## Defects Influenced

* BUG-001
* BUG-002
* BUG-005
* BUG-007
* BUG-008

## Recommended Controls

* Add real-time alerts for critical financial exceptions.
* Create reconciliation dashboards.
* Define operational recovery playbooks.
* Add stuck-transaction queues for investigation.
* Monitor duplicate and repeated requests.
* Record complete audit events for financial state changes.
* Track notification failures separately from transaction failures.

---

# Fishbone Cause Matrix

| Category     | Major Cause                                            | Affected Risks                                  |
| ------------ | ------------------------------------------------------ | ----------------------------------------------- |
| Requirements | Failure and recovery rules incomplete                  | Financial loss, incorrect states                |
| People       | Different assumptions and unclear ownership            | Delayed resolution, inconsistent implementation |
| Process      | No mandatory invariant and recovery reviews            | Recurring defects                               |
| Design       | Weak idempotency, compensation, and service boundaries | Duplicate processing, missing recovery          |
| Development  | Missing validation and ownership checks                | Financial and security failures                 |
| Testing      | Happy-path bias and limited failure simulation         | Late defect detection                           |
| Data         | Missing constraints and reconciliation controls        | Duplicate and inconsistent records              |
| Tools        | Unrealistic mocks and environment mismatch             | Integration gaps                                |
| Monitoring   | Missing exception alerts                               | Delayed detection and manual recovery           |

---

# Most Significant Root-Cause Branches

The highest-impact branches were:

## 1. Application Design

Many defects were made possible because important financial rules were not enforced structurally.

Examples:

* Duplicate callbacks could create multiple credits.
* Failed debits could reach a terminal state without compensation.
* Refunds could exceed eligible amounts.
* Notifications could overwrite financial truth.

## 2. Requirements

Failure, recovery, retry, ownership, and reconciliation rules were less detailed than successful workflows.

## 3. Testing

The defects were eventually detected through strong QA activities, but several would have been found earlier if failure simulation and database validation had started sooner.

## 4. Process

There was no mandatory cross-functional checklist requiring every financial feature to define:

* Idempotency
* Debit and credit effect
* Failure recovery
* Reversal and refund rules
* Ownership
* Audit trail
* Reconciliation
* Monitoring

---

# Preventive Quality Checklist

Before approving any future financial feature, the team must answer:

1. Can the same request or callback arrive multiple times?
2. How is duplicate financial impact prevented?
3. Can failure happen after money moves?
4. How are customer funds restored?
5. Which service owns compensation?
6. What transaction states are allowed?
7. What database constraints protect financial integrity?
8. How is customer ownership enforced?
9. How will QA validate the database and ledger?
10. How will Operations detect and recover exceptions?
11. Which tests run automatically in CI?
12. What evidence is required before release approval?

---

# Recommended Improvement Plan

| Improvement                                         | Owner                  | Priority | Success Measure                 |
| --------------------------------------------------- | ---------------------- | -------- | ------------------------------- |
| Add fintech acceptance-criteria checklist           | Product and QA         | Critical | All financial stories reviewed  |
| Introduce financial-invariant code-review checklist | Engineering            | Critical | Review compliance confirmed     |
| Expand provider failure simulations                 | QA and Backend         | High     | Retry and timeout tests pass    |
| Add API and database integration tests              | SDET                   | Critical | CI financial suite passes       |
| Add operational exception monitoring                | Operations and Backend | Critical | Alerts verified                 |
| Standardise object ownership controls               | Security and Backend   | Critical | Cross-user tests pass           |
| Add refund and reversal reconciliation              | QA and Data            | Critical | No reconciliation exceptions    |
| Align environment security settings                 | Platform Team          | High     | Configuration validation passes |

---

# QA Lead Conclusion

The Fishbone Analysis confirms that the Sprint 1 defects were not caused by one person or one isolated mistake.

They resulted from interacting weaknesses across:

* Requirements
* Design
* Development
* Testing
* Data
* Tools
* Communication
* Operations

The most important lesson is that fintech quality cannot depend on a single layer of protection.

Customer funds and financial records must be protected through multiple controls:

* Clear requirements
* Safe architecture
* Defensive code
* Database constraints
* Risk-based testing
* Reconciliation
* Monitoring
* Release governance

---

# Recruiter Talking Points

This document demonstrates the ability to:

* Facilitate a structured Fishbone Analysis.
* Evaluate technical and non-technical contributing factors.
* Avoid blame-based RCA.
* Connect defects to weaknesses across the software delivery lifecycle.
* Recommend preventive controls across Product, Engineering, QA, Data, Security, and Operations.
* Convert analysis into measurable improvement actions.
