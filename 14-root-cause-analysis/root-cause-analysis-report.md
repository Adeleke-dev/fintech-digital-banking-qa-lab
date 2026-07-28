# Root Cause Analysis Report

## Project

**Fintech Digital Banking QA Lab**

---

# Document Control

| Item         | Details                                                |
| ------------ | ------------------------------------------------------ |
| Report Type  | Consolidated Root Cause Analysis                       |
| Release      | v1.0.0-RC1                                             |
| Sprint       | Sprint 1                                               |
| Environment  | QA / Staging                                           |
| Prepared By  | QA Lead                                                |
| Participants | QA, Backend Engineering, Product, Operations, Security |
| RCA Status   | Open — preventive actions pending verification         |

---

# Executive Summary

This Root Cause Analysis investigates the most significant defects identified during Sprint 1 testing of the Fintech Digital Banking platform.

The investigation focused on failures affecting:

* Financial integrity
* Customer fund recovery
* Transaction idempotency
* Authentication and authorisation
* Transfer limits
* Refund calculations
* Service isolation
* Reconciliation and auditability

The highest-priority defects were:

* **BUG-002:** Failed external transfer did not trigger wallet reversal.
* **BUG-007:** Refund amount exceeded the original transaction amount.

Both defects prevented production approval because they could directly affect customer funds and create reconciliation discrepancies.

The investigation found that the defects were not caused by a single isolated failure. They resulted from combined gaps in requirements, transaction design, validation logic, integration testing, test data, observability, and release controls.

---

# RCA Objectives

This report aims to:

1. Establish what happened.
2. Identify the technical root causes.
3. Identify contributing process and testing factors.
4. Explain why existing controls did not prevent the defects.
5. Define corrective actions.
6. Define preventive actions.
7. Update regression and automation coverage.
8. Reduce the probability of recurrence.

---

# Investigation Scope

The following defects were reviewed:

| Bug ID  | Defect                                                    | Severity | Release Impact  |
| ------- | --------------------------------------------------------- | -------- | --------------- |
| BUG-001 | Duplicate wallet credit after repeated callback           | Critical | Release blocker |
| BUG-002 | Failed external transfer not reversed                     | Critical | Release blocker |
| BUG-003 | Expired JWT accessed protected API                        | Critical | Release blocker |
| BUG-005 | Daily transfer limit ignored cumulative transfers         | High     | High risk       |
| BUG-006 | Cross-customer beneficiary access                         | Critical | Release blocker |
| BUG-007 | Refund exceeded original transaction amount               | Critical | Release blocker |
| BUG-008 | Notification failure changed financial transaction status | High     | High risk       |

---

# Evidence Reviewed

The RCA team reviewed:

* Defect reports
* Postman request and response evidence
* Database query results
* Wallet and ledger records
* Transaction status history
* Provider callback payloads
* Application logs
* Audit records
* Regression execution results
* UAT feedback
* Business requirements
* User stories and acceptance criteria
* Source-code review findings
* Test data and provider-mock behaviour

---

# Incident 1 — Duplicate Wallet Credit

## Defect Reference

**BUG-001 — Duplicate wallet credit after payment gateway callback retry**

## What Happened

A successful wallet-funding callback was processed twice using the same provider reference.

The first callback correctly:

* Updated the funding transaction to `SUCCESSFUL`.
* Created a wallet credit entry.
* Increased the wallet balance.

The repeated callback performed the same financial operations again, resulting in a second wallet credit.

## Customer and Business Impact

* Customer balance increased by more than the amount paid.
* Platform incurred direct financial exposure.
* Provider and internal records no longer reconciled.
* Operations required manual investigation and correction.

## Root Cause

The callback handler did not enforce idempotent processing before creating the financial credit.

It checked whether the callback represented success but did not atomically verify whether the provider reference had already been processed.

## Contributing Factors

* No unique database constraint on the provider reference.
* Transaction status check and wallet credit were not performed atomically.
* Provider callback retry behaviour was not included in the initial acceptance criteria.
* Duplicate callbacks were not represented in the first integration-test cycle.
* Logging did not clearly identify repeated provider events.

## Why Existing Controls Failed

The application relied on the assumption that each callback would be delivered once.

The provider mock initially sent only one callback per transaction, so the defect was not exposed during early happy-path testing.

## Corrective Action

* Add idempotency validation to the callback handler.
* Reject or safely acknowledge previously processed provider references.
* Add a unique constraint on the provider reference.
* Ensure status update and wallet credit occur within one database transaction.

## Preventive Action

* Add duplicate-callback API tests.
* Add database queries that detect duplicate provider references.
* Add idempotency checks to the code-review checklist.
* Include callback retries in provider-mock behaviour.

---

# Incident 2 — Failed External Transfer Not Reversed

## Defect Reference

**BUG-002 — Failed external transfer did not trigger wallet reversal**

## What Happened

The customer's wallet was debited before the external transfer provider returned its final response.

The provider later returned a failure, but the platform updated the transfer status without creating the required reversal.

The customer remained debited even though the external transfer was unsuccessful.

## Customer and Business Impact

* Customer funds remained unavailable.
* Customer could not complete the intended transfer.
* Support and Operations required manual intervention.
* Wallet and provider records did not reconcile.
* The issue created potential complaint and regulatory exposure.

## Root Cause

The transfer-processing flow did not define a guaranteed compensation path for failures occurring after wallet debit.

The implementation updated the transaction to `FAILED`, but the failure branch did not invoke the reversal service.

## Contributing Factors

* Requirements did not clearly distinguish failure before debit from failure after debit.
* Transaction-state design did not enforce `FAILED_AFTER_DEBIT → REVERSAL_REQUIRED`.
* Reversal creation and original transaction update were separate operations.
* Provider-failure test data focused primarily on failures before debit.
* No alert existed for failed debited transactions without reversals.
* Ownership of compensation logic was unclear between transfer and transaction services.

## Why Existing Controls Failed

Functional testing confirmed that the transfer status became `FAILED`, but early tests did not compare the wallet balance before and after the provider failure.

The absence of a database reconciliation check allowed the transaction status to appear technically correct while the financial state remained wrong.

## Corrective Action

* Invoke the reversal service whenever a provider failure occurs after wallet debit.
* Link reversal records to the original transfer.
* Process failure status, reversal creation, and wallet restoration atomically where possible.
* Prevent a transaction from reaching a final failed state while an unrecovered debit exists.

## Preventive Action

* Add a mandatory `debit_applied` or equivalent recovery indicator.
* Add monitoring for failed transactions without linked reversals.
* Add targeted API and SQL regression tests.
* Add recovery scenarios to acceptance criteria.
* Define clear ownership for financial compensation workflows.

---

# Incident 3 — Expired JWT Accepted

## Defect Reference

**BUG-003 — Expired JWT token accessed protected Wallet API**

## What Happened

A customer used an expired JWT to request wallet-balance data.

The API returned a successful response rather than rejecting the expired token.

## Customer and Business Impact

* Expired sessions retained access to sensitive financial data.
* Account compromise risk increased.
* Security and compliance expectations were violated.

## Root Cause

The token-validation middleware verified token structure and signature but did not enforce expiration consistently.

## Contributing Factors

* Expiration validation was disabled or incorrectly configured.
* Unit tests covered valid and invalid signatures but not expired tokens.
* The QA environment used long token lifetimes during early testing.
* No standard security regression pack existed initially.

## Corrective Action

* Enforce JWT expiration during token verification.
* Return `401 Unauthorized` for expired sessions.
* Confirm protected endpoints use the same authentication middleware.

## Preventive Action

* Add expired-token tests to API regression.
* Add authentication middleware unit tests.
* Standardise token configuration across environments.
* Add session-security checks to smoke testing.

---

# Incident 4 — Daily Transfer Limit Bypass

## Defect Reference

**BUG-005 — Daily transfer limit validation ignored cumulative transfers**

## What Happened

The platform validated each transfer against the per-transaction limit but failed to calculate the customer's total successful transfers for the current day.

Multiple transfers were therefore allowed even when their combined value exceeded the daily limit.

## Customer and Business Impact

* Customers could exceed risk and policy limits.
* Fraud exposure increased.
* Compliance controls were weakened.
* Manual transaction review could increase.

## Root Cause

The validation logic checked only the current transfer amount and did not aggregate the customer's daily transfer total.

## Contributing Factors

* Requirement wording focused on maximum transfer amount without detailing cumulative calculation.
* Boundary testing covered one transfer above the limit but not multiple smaller transfers.
* Daily totals were not included in the API validation service.
* Time-zone and transaction-status rules were not explicitly documented.

## Corrective Action

* Calculate the sum of eligible transactions for the defined business day.
* Reject a new transfer when existing daily total plus requested amount exceeds the limit.
* Include only relevant statuses according to business rules.

## Preventive Action

* Add boundary scenarios at exactly and above the daily limit.
* Add SQL checks for users exceeding the configured limit.
* Document time-zone and status rules.
* Add automated cumulative-limit tests.

---

# Incident 5 — Cross-Customer Beneficiary Access

## Defect Reference

**BUG-006 — Customer accessed another customer's beneficiary**

## What Happened

An authenticated customer supplied another customer's beneficiary identifier and received the beneficiary details.

## Customer and Business Impact

* Customer financial information was exposed.
* Broken object-level authorisation was present.
* Privacy and security obligations were violated.
* The issue could support fraudulent activity.

## Root Cause

The beneficiary lookup queried by beneficiary ID but did not also enforce ownership using the authenticated user's ID.

## Contributing Factors

* Authentication was implemented, but resource-level authorisation was assumed.
* Service methods accepted resource IDs without ownership context.
* Happy-path tests used only records owned by the authenticated customer.
* No central object-ownership guard or repository pattern existed.

## Corrective Action

* Query beneficiary using both beneficiary ID and authenticated user ID.
* Return the defined authorisation or not-found response when ownership fails.
* Review similar endpoints for object-level authorisation gaps.

## Preventive Action

* Add cross-user tests for every customer-owned resource.
* Add ownership validation to code-review standards.
* Create reusable authorisation helpers.
* Add API security regression to CI.

---

# Incident 6 — Refund Exceeded Original Amount

## Defect Reference

**BUG-007 — Refund amount exceeded original transaction amount**

## What Happened

A refund request for an original bill payment of ₦8,000 produced a refund of ₦8,500.

The additional amount was caused by the refund calculation including a fee component that had already been accounted for separately.

## Customer and Business Impact

* Customer received more money than the eligible amount.
* Platform suffered direct financial loss.
* Original and refund records failed to reconcile.
* Financial reporting became inaccurate.

## Root Cause

The refund service trusted a derived refund amount rather than validating the requested or calculated amount against the eligible amount on the original transaction.

## Contributing Factors

* Refund eligibility rules were not precisely documented.
* Gross amount, service fee, and settled amount were not clearly separated.
* No invariant enforced `refund_total ≤ refundable_amount`.
* Database schema allowed the refund amount without a constraint or validation layer.
* Test data covered full refund but not fee-related calculations.
* SQL validation was introduced after the initial implementation.

## Why Existing Controls Failed

The API returned success and created a valid-looking refund record.

Without comparing the refund amount directly to the original transaction and ledger entries, the over-refund was not visible through status validation alone.

## Corrective Action

* Calculate refund from the original transaction's eligible refundable amount.
* Reject any refund that exceeds the remaining refundable balance.
* Track cumulative refunds for partial-refund support.
* Link every refund to the original transaction.
* Validate the wallet credit before committing.

## Preventive Action

* Add database and service-level invariants.
* Add full, partial, repeated, and over-refund tests.
* Add SQL reconciliation for refunds.
* Require Product approval for fee and refund rules.
* Add refund logic to critical code-review checklist.

---

# Incident 7 — Notification Failure Changed Transaction Status

## Defect Reference

**BUG-008 — Notification failure changed transaction status to FAILED**

## What Happened

A wallet-funding transaction completed successfully.

The notification service then failed. Because the notification call was executed inside the same error-handling block as the financial workflow, the overall transaction was marked `FAILED`.

## Customer and Business Impact

* Customer saw an incorrect financial status.
* Support investigation was required.
* Financial truth became dependent on a non-financial service.
* Reconciliation and notification records disagreed.

## Root Cause

The transaction and notification services were tightly coupled, and notification failure was allowed to overwrite the financial outcome.

## Contributing Factors

* Notification was implemented synchronously.
* Error handling used one shared exception path.
* Service boundaries were not clearly defined.
* Integration tests did not initially simulate notification outage after successful transaction processing.

## Corrective Action

* Persist the final financial status before initiating notification.
* Handle notification failure separately.
* Store failed notification for retry.
* Prevent notification exceptions from changing transaction state.

## Preventive Action

* Use asynchronous messaging or queue-based notification processing.
* Add service-isolation tests.
* Add monitoring for notification failures.
* Document financial source-of-truth rules.

---

# Cross-Defect Root Cause Themes

The investigation identified several repeated themes.

## 1. Incomplete Failure-State Requirements

Successful flows were documented in more detail than failure and recovery flows.

This affected:

* Reversals
* Refunds
* Duplicate callbacks
* Provider timeouts
* Notification failures

## 2. Weak Financial Invariants

The system did not consistently enforce rules such as:

* One provider event creates one financial impact.
* Failed debited transactions must be reversed.
* Refunds cannot exceed eligible original amounts.
* Customer-owned records require ownership checks.
* Notification state cannot redefine financial state.

## 3. Insufficient Atomicity

Some financial workflows used separate database operations without guaranteed rollback or compensation.

## 4. Limited Early Integration Testing

Early tests focused on successful provider responses and did not fully simulate retries, delayed callbacks, failures after debit, or dependent-service outages.

## 5. Delayed Database Validation

API status validation occurred before strong SQL and ledger reconciliation checks were introduced.

## 6. Observability Gaps

The system lacked alerts or reports for:

* Duplicate callbacks
* Failed debited transactions without reversals
* Stuck pending transactions
* Refund totals above eligible amounts
* Missing ownership checks

---

# Root Cause Summary

| Defect  | Primary Root Cause                         | Key Preventive Control                          |
| ------- | ------------------------------------------ | ----------------------------------------------- |
| BUG-001 | Missing idempotent callback processing     | Unique provider reference and atomic processing |
| BUG-002 | Missing compensation path after debit      | Enforced reversal workflow and monitoring       |
| BUG-003 | Expiration not enforced consistently       | Standard token validation and regression        |
| BUG-005 | Daily limit calculated per request only    | Cumulative daily aggregation                    |
| BUG-006 | Missing object ownership filter            | User-scoped resource queries                    |
| BUG-007 | Refund not bounded by original eligibility | Refund invariant and reconciliation             |
| BUG-008 | Notification coupled to financial state    | Service isolation and retry queue               |

---

# Corrective Action Summary

| Action ID | Corrective Action                                     | Owner            | Priority |
| --------- | ----------------------------------------------------- | ---------------- | -------- |
| CA-001    | Implement callback idempotency                        | Backend Team     | Critical |
| CA-002    | Implement automatic transfer reversal                 | Backend Team     | Critical |
| CA-003    | Enforce JWT expiration                                | Security/Backend | Critical |
| CA-004    | Implement cumulative daily-limit validation           | Backend Team     | High     |
| CA-005    | Add beneficiary ownership enforcement                 | Backend Team     | Critical |
| CA-006    | Correct refund calculation and eligibility validation | Backend Team     | Critical |
| CA-007    | Decouple notification failure from transaction state  | Backend Team     | High     |

---

# Preventive Action Summary

| Action ID | Preventive Action                                                  | Owner                 | Verification       |
| --------- | ------------------------------------------------------------------ | --------------------- | ------------------ |
| PA-001    | Add financial-invariant checklist to requirements and code review  | QA Lead / Engineering | Review audit       |
| PA-002    | Add API idempotency and recovery tests to CI                       | SDET                  | Pipeline pass      |
| PA-003    | Add ledger reconciliation SQL checks                               | QA / Data             | Query results      |
| PA-004    | Expand provider mocks for retries, timeouts, and delayed responses | QA / Backend          | Integration tests  |
| PA-005    | Add monitoring for stuck and unrecovered transactions              | Operations / Backend  | Alert test         |
| PA-006    | Add cross-user authorisation regression                            | QA / Security         | Security suite     |
| PA-007    | Add refund and reversal acceptance criteria templates              | Product / QA          | Requirement review |

---

# Effectiveness Measures

Preventive actions will be considered effective when:

* Duplicate callbacks produce one financial impact.
* Every failed debited transfer has a linked successful reversal.
* Expired sessions cannot access any protected endpoint.
* Daily limits remain enforced across multiple transfers.
* Cross-customer resource access is rejected.
* Refund totals never exceed refundable amounts.
* Notification failures do not alter financial statuses.
* Targeted regression and UAT pass.
* Reconciliation queries return no exceptions.

---

# Updated Regression Coverage

The following regression tests must remain mandatory:

* Duplicate funding callback
* Failed transfer after debit
* Reversal linkage and wallet restoration
* Full and partial refund validation
* Over-refund rejection
* Expired-token access
* Cross-user wallet, transaction, and beneficiary access
* Cumulative daily transfer limit
* Notification service outage
* Wallet and ledger reconciliation

---

# Release Impact

The RCA supports the existing **NO-GO** recommendation for v1.0.0-RC1.

Production approval should be reconsidered only after:

1. Critical corrective actions are implemented.
2. Targeted regression passes.
3. SQL reconciliation passes.
4. Focused UAT passes.
5. Product and QA approve the updated financial behaviour.
6. Preventive controls are assigned and tracked.

---

# Lessons for the Team

* Financial success states are not enough; every debit requires a defined recovery path.
* Provider events must always be treated as retryable.
* API success must be validated against wallet, ledger, and transaction records.
* Security testing must include ownership, not only authentication.
* Notification systems must not control financial truth.
* Requirements for reversals, refunds, timeouts, and duplicate requests must be explicit before implementation.

---

# QA Lead Conclusion

The defects identified during Sprint 1 were caused by a combination of technical and process weaknesses rather than individual mistakes.

The most important improvement is to treat financial invariants, failure recovery, idempotency, authorisation, and reconciliation as design requirements rather than optional test considerations.

Implementing the corrective and preventive actions in this report will improve product reliability, reduce financial exposure, strengthen release governance, and provide better automated protection against recurrence.

---

# Recruiter Talking Points

This report demonstrates the ability to:

* Investigate defects across requirements, code, APIs, databases, and integrations.
* Separate symptoms, contributing factors, and confirmed root causes.
* Connect technical defects to customer and financial impact.
* Define corrective and preventive actions.
* Convert incident findings into regression, monitoring, and automation controls.
* Facilitate evidence-based RCA without assigning blame.
