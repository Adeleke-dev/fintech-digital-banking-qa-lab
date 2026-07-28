# Corrective and Preventive Actions (CAPA)

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document records the Corrective and Preventive Actions created from the Sprint 1 Root Cause Analysis.

Corrective actions address confirmed defects and restore the system to the expected state.

Preventive actions strengthen requirements, design, development, testing, database controls, monitoring, and release governance so similar defects are less likely to recur.

---

# CAPA Objectives

The CAPA programme aims to:

* Resolve confirmed financial and security defects.
* Restore transaction and wallet integrity.
* Prevent repeated debit or credit.
* Strengthen reversal and refund controls.
* Improve authentication and authorisation.
* Expand automated regression coverage.
* Improve monitoring and exception management.
* verify that completed actions are effective.

---

# Definitions

## Correction

An immediate action that fixes the visible problem.

Example:

> Restore the balance of a customer whose failed transfer was not reversed.

## Corrective Action

An action that removes the confirmed cause of an existing defect.

Example:

> Update the transfer failure handler so every failed post-debit transfer invokes the reversal service.

## Preventive Action

An action that reduces the likelihood of similar defects occurring elsewhere or in future releases.

Example:

> Add mandatory failure-after-debit scenarios to every money-movement feature.

---

# Priority Classification

| Priority | Meaning                                           |
| -------- | ------------------------------------------------- |
| Critical | Required before production approval               |
| High     | Required during the current release cycle         |
| Medium   | Required as a planned process improvement         |
| Low      | Improvement that can follow release stabilisation |

---

# CAPA Status Legend

| Status                 | Meaning                                          |
| ---------------------- | ------------------------------------------------ |
| Proposed               | Action has been identified                       |
| Approved               | Owner and implementation approach agreed         |
| In Progress            | Work has started                                 |
| Ready for Verification | Implementation completed and awaiting validation |
| Verified               | QA confirmed effectiveness                       |
| Closed                 | Action and evidence formally accepted            |
| Deferred               | Action moved to a later approved date            |

---

# CAPA Master Register

| Action ID | Type       | Related Defect | Action                                                | Owner               | Priority | Status                 |
| --------- | ---------- | -------------- | ----------------------------------------------------- | ------------------- | -------- | ---------------------- |
| CA-001    | Corrective | BUG-001        | Implement atomic callback idempotency                 | Backend Team        | Critical | Ready for Verification |
| PA-001    | Preventive | BUG-001        | Add unique provider-reference constraint              | Backend/Data Team   | Critical | In Progress            |
| PA-002    | Preventive | BUG-001        | Add duplicate-callback tests to CI                    | SDET                | Critical | Proposed               |
| CA-002    | Corrective | BUG-002        | Trigger reversal after failed post-debit transfer     | Backend Team        | Critical | In Progress            |
| PA-003    | Preventive | BUG-002        | Monitor failed debited transactions without reversals | Backend/Operations  | Critical | Proposed               |
| PA-004    | Preventive | BUG-002        | Add compensation-path design checklist                | QA Lead/Engineering | High     | Approved               |
| CA-003    | Corrective | BUG-003        | Enforce JWT expiry on all protected APIs              | Security/Backend    | Critical | Verified               |
| PA-005    | Preventive | BUG-003        | Add expired-token tests to CI                         | SDET                | High     | Verified               |
| CA-004    | Corrective | BUG-005        | Implement cumulative daily transfer-limit validation  | Backend Team        | High     | In Progress            |
| PA-006    | Preventive | BUG-005        | Define business-day, time-zone, and status rules      | Product/Risk/QA     | High     | Approved               |
| CA-005    | Corrective | BUG-006        | Enforce beneficiary ownership in repository query     | Backend Team        | Critical | Verified               |
| PA-007    | Preventive | BUG-006        | Add cross-user authorisation suite                    | QA/Security         | Critical | Verified               |
| CA-006    | Corrective | BUG-007        | Enforce remaining refundable balance                  | Backend Team        | Critical | In Progress            |
| PA-008    | Preventive | BUG-007        | Add refund reconciliation checks                      | QA/Data             | Critical | Proposed               |
| PA-009    | Preventive | BUG-007        | Clarify fee and refund business rules                 | Product/Finance/QA  | Critical | Approved               |
| CA-007    | Corrective | BUG-008        | Decouple notification failure from financial status   | Backend Team        | High     | Ready for Verification |
| PA-010    | Preventive | BUG-008        | Introduce asynchronous notification retries           | Backend/Platform    | High     | Proposed               |

---

# Action Plan 1 — Duplicate Wallet Credit

## Related Defect

**BUG-001 — Duplicate wallet credit after repeated provider callback**

## Immediate Correction

* Identify affected transaction and wallet.
* Remove or offset the duplicate credit through an authorised adjustment.
* Preserve original and adjustment records for audit purposes.
* Confirm the corrected wallet balance.

## Corrective Action CA-001

### Action

Implement atomic idempotency for funding callbacks.

### Required Changes

* Check whether the provider reference has already been processed.
* Reject or safely acknowledge repeated callbacks.
* Update transaction status and credit wallet within one database transaction.
* Create only one ledger credit entry.
* Return the same logical outcome for repeated delivery.

### Owner

Backend Team

### Acceptance Criteria

* Repeated callback does not create a second credit.
* Wallet balance changes once.
* Only one successful credit ledger entry exists.
* Transaction remains traceable.
* Duplicate event is logged.

### Verification

* Postman duplicate-callback test
* SQL duplicate provider-reference query
* Wallet balance comparison
* Ledger-entry count validation

## Preventive Action PA-001

Add a unique database constraint for the provider reference.

### Effectiveness Measure

A second record using the same eligible provider reference must be rejected.

## Preventive Action PA-002

Add duplicate and concurrent callback tests to CI.

### Effectiveness Measure

Tests consistently pass under sequential and near-simultaneous callback delivery.

---

# Action Plan 2 — Failed Transfer Not Reversed

## Related Defect

**BUG-002 — Failed external transfer did not trigger wallet reversal**

## Immediate Correction

* Identify all failed debited transfers.
* Reconcile customer balances.
* Create approved reversal adjustments.
* Notify affected customers where required.
* Record operational actions in the audit trail.

## Corrective Action CA-002

### Action

Invoke the reversal service for every failed external transfer where debit has already occurred.

### Required Changes

* Track whether debit was applied.
* Distinguish failure before debit from failure after debit.
* Create reversal transaction linked to the original transfer.
* Restore wallet balance.
* Write matching ledger entries.
* Prevent terminal closure while debit remains unrecovered.

### Owner

Backend Team

### Acceptance Criteria

* Failed pre-debit transfer does not change wallet balance.
* Failed post-debit transfer restores the full amount.
* Reversal links to the original transaction.
* No duplicate reversal occurs.
* Ledger and wallet reconcile.

### Verification

* API failure simulation
* Original and reversal transaction query
* Wallet before-and-after comparison
* Ledger reconciliation
* Repeated failure-event test

## Preventive Action PA-003

Add automated monitoring for failed debited transfers without linked reversals.

### Alert Condition

A transaction is:

* `FAILED`
* debit has been applied
* no successful linked reversal exists
* recovery SLA has expired

### Effectiveness Measure

A controlled test exception generates an alert and investigation record.

## Preventive Action PA-004

Add mandatory compensation-path review to financial feature design.

### Required Questions

* Can failure occur after debit?
* Which service owns recovery?
* Is compensation automatic?
* Is the compensation idempotent?
* How is recovery reconciled?

---

# Action Plan 3 — Expired JWT Accepted

## Related Defect

**BUG-003 — Expired JWT accessed protected API**

## Corrective Action CA-003

### Action

Enforce expiry validation consistently across protected endpoints.

### Required Changes

* Validate signature and expiration.
* Reject expired tokens using `401 Unauthorized`.
* Standardise middleware configuration.
* Confirm every protected route uses the approved authentication guard.

### Owner

Security and Backend Teams

### Acceptance Criteria

* Expired token cannot access any protected resource.
* No sensitive data is returned.
* No state-changing action executes.
* Security event is logged according to policy.

### Verification Result

**Verified**

## Preventive Action PA-005

Add automated tests for:

* Missing token
* Invalid token
* Expired token
* Tampered token
* Valid token
* Logged-out or revoked session where supported

### Effectiveness Measure

Security suite passes in CI and deployment smoke tests.

---

# Action Plan 4 — Daily Transfer Limit Bypass

## Related Defect

**BUG-005 — Daily transfer limit ignored cumulative transfers**

## Corrective Action CA-004

### Action

Calculate the eligible cumulative daily transfer total before approving a new transfer.

### Required Changes

* Query successful or otherwise eligible transfers for the defined business day.
* Add the requested transfer amount.
* Reject when the total would exceed the limit.
* Use the approved business time zone.
* Exclude failed and reversed transactions according to policy.
* Protect against concurrent requests bypassing the limit.

### Owner

Backend Team

### Acceptance Criteria

* Transfers below the daily limit succeed.
* Transfer reaching the exact limit follows the approved rule.
* Transfer exceeding the limit is rejected.
* Rejected request does not debit the wallet.
* Concurrent requests cannot bypass the limit.

### Verification

* Boundary-value API tests
* Multiple-small-transfer scenario
* Concurrent-request test
* SQL daily-total query
* Wallet validation

## Preventive Action PA-006

Create an approved transfer-limit rule specification.

### Specification Must Define

* Per-transaction limit
* Daily limit
* Applicable transaction types
* Eligible statuses
* Business time zone
* Reset time
* Treatment of reversals and refunds
* Customer-tier differences where applicable

---

# Action Plan 5 — Cross-Customer Beneficiary Access

## Related Defect

**BUG-006 — Customer accessed another customer’s beneficiary**

## Corrective Action CA-005

### Action

Scope beneficiary access by both resource ID and authenticated user ID.

### Required Changes

* Read authenticated user identity from trusted token context.
* Query beneficiary using `beneficiary_id` and `user_id`.
* Reject access where ownership does not match.
* Review update and delete operations for the same issue.
* Review other customer-owned resources.

### Owner

Backend Team

### Acceptance Criteria

* Customer accesses only owned beneficiaries.
* Cross-user read, update, and delete attempts fail.
* No sensitive beneficiary data is exposed.
* Authorisation failure is logged.

### Verification Result

**Verified**

## Preventive Action PA-007

Create a reusable cross-user authorisation regression suite.

### Covered Resources

* Wallet
* Transaction
* Beneficiary
* Notification
* Funding record
* Bill-payment record
* Profile or personal information

### Effectiveness Measure

All cross-customer access attempts are rejected in CI.

---

# Action Plan 6 — Refund Exceeded Original Amount

## Related Defect

**BUG-007 — Refund amount exceeded original transaction amount**

## Immediate Correction

* Identify affected refunds.
* Compare original payment, fees, previous refunds, and wallet credits.
* Correct balances through approved financial adjustments.
* Preserve full audit history.
* Reconcile internal records with provider or biller records.

## Corrective Action CA-006

### Action

Enforce the remaining refundable balance.

### Required Changes

* Determine eligible refundable amount from the original transaction.
* Track previous successful refunds.
* Calculate remaining refundable balance.
* Reject zero, negative, or excessive refunds.
* Link refund to original transaction.
* Make refund request idempotent.
* Credit wallet and create ledger entry atomically.

### Owner

Backend Team

### Acceptance Criteria

For an original eligible amount of ₦8,000:

* Full refund cannot exceed ₦8,000.
* Partial refunds may total up to ₦8,000 only.
* A refund exceeding the remaining balance is rejected.
* Duplicate refund request does not create another credit.
* Refund and original transaction reconcile.

### Verification

* Full refund test
* Partial refund test
* Repeated partial refund test
* Over-refund rejection
* Duplicate refund request
* SQL cumulative refund query
* Wallet and ledger reconciliation

## Preventive Action PA-008

Add automated refund reconciliation.

### Control

For each original transaction:

```text
Total successful refunds ≤ Eligible refundable amount
```

### Effectiveness Measure

Exception query returns no invalid records.

## Preventive Action PA-009

Approve a clear fee and refund policy.

### Policy Must Define

* Whether service fees are refundable
* Whether provider fees are refundable
* Full and partial refund rules
* Refund expiry period
* Cumulative refund limit
* Treatment of settled and unsettled transactions
* Authorised roles that can initiate refunds

---

# Action Plan 7 — Notification Failure Changed Financial Status

## Related Defect

**BUG-008 — Notification failure changed transaction status**

## Corrective Action CA-007

### Action

Separate notification processing from the committed financial outcome.

### Required Changes

* Persist final financial state before notification delivery.
* Handle notification exception separately.
* Record notification status independently.
* Queue failed notification for retry.
* Prevent notification retry from reprocessing the transaction.

### Owner

Backend Team

### Acceptance Criteria

* Successful transaction remains `SUCCESSFUL` when notification fails.
* Wallet and ledger remain correct.
* Failed notification is recorded.
* Notification can be retried.
* Retry does not create another financial effect.

### Verification

* Disable notification provider.
* Complete successful funding or transfer.
* Confirm transaction remains successful.
* Confirm failed notification record.
* Trigger retry and verify no duplicate financial processing.

## Preventive Action PA-010

Move notification delivery to an asynchronous queue or event-driven workflow.

### Effectiveness Measure

Notification service outage does not delay, roll back, or modify committed financial transactions.

---

# Cross-Cutting Preventive Actions

## 1. Financial Invariant Checklist

Every money-movement feature must define:

* Debit effect
* Credit effect
* Duplicate-request behaviour
* Failure before debit
* Failure after debit
* Reversal behaviour
* Refund behaviour
* Ledger entries
* Transaction linkage
* Reconciliation query
* Monitoring condition
* Audit-trail requirements

## 2. Shift-Left QA Review

QA should review:

* Requirements
* Acceptance criteria
* API contracts
* Transaction state diagrams
* Database relationships
* Failure and recovery logic

before implementation begins.

## 3. Database Safeguards

Use appropriate:

* Unique constraints
* Foreign keys
* Check constraints
* Atomic transactions
* Ownership filters
* Immutable audit records

Application validation should not be the only protection for financial integrity.

## 4. Provider Failure Simulation

Mocks and sandboxes should support:

* Duplicate callback
* Delayed callback
* Timeout
* Failure before debit
* Failure after debit
* Repeated failure response
* Conflicting status response
* Provider recovery after temporary outage

## 5. Automated Financial Regression

CI should prioritise:

* Duplicate debit and credit prevention
* Reversal
* Refund
* Transfer limits
* Idempotency
* Object ownership
* Expired-token access
* Wallet and ledger reconciliation
* Notification isolation

## 6. Operational Monitoring

Create alerts or exception reports for:

* Duplicate provider reference
* Failed debited transaction without reversal
* Pending transaction beyond SLA
* Over-refund
* Wallet-ledger mismatch
* Daily-limit breach
* Repeated authorisation failures
* Notification retry exhaustion

---

# CAPA Verification Plan

| Verification ID | Action Area            | Verification Method                    | Expected Outcome          |
| --------------- | ---------------------- | -------------------------------------- | ------------------------- |
| VER-001         | Callback idempotency   | Repeat callback 2–5 times              | One credit only           |
| VER-002         | Transfer recovery      | Fail provider after debit              | Full reversal created     |
| VER-003         | JWT expiry             | Call protected APIs with expired token | All rejected              |
| VER-004         | Daily limit            | Submit cumulative transfers            | Limit enforced            |
| VER-005         | Ownership              | Access another customer’s records      | All denied                |
| VER-006         | Refund control         | Attempt refund above remaining amount  | Request rejected          |
| VER-007         | Notification isolation | Disable notification service           | Financial state unchanged |
| VER-008         | Reconciliation         | Run SQL exception queries              | No invalid records        |
| VER-009         | Monitoring             | Create controlled exception            | Alert generated           |
| VER-010         | CI regression          | Execute automated critical suite       | All critical tests pass   |

---

# CAPA Closure Criteria

An action may be closed only when:

* Implementation is complete.
* Required reviews are complete.
* Test evidence is attached.
* Regression tests pass.
* SQL validation passes where applicable.
* Monitoring is verified where applicable.
* Documentation is updated.
* Product or business rule changes are approved.
* QA confirms the action addresses the root cause.
* No recurrence is observed during the defined verification period.

---

# Governance and Follow-Up

| Review                            | Purpose                                                |
| --------------------------------- | ------------------------------------------------------ |
| Daily Critical Action Review      | Track release-blocking corrective actions              |
| Sprint CAPA Review                | Review progress and blockers                           |
| Release Readiness Review          | Confirm critical actions before Go/No-Go               |
| Post-Release Effectiveness Review | Confirm controls work under production-like conditions |
| Quarterly Quality Review          | Identify recurring defect themes                       |

---

# QA Engineer, Senior QA, and SDET Responsibilities

## QA Engineer

* Retests the defect.
* Captures evidence.
* Runs targeted regression.
* Verifies expected behaviour.

## Senior QA Engineer

* Confirms the action addresses the root cause.
* Coordinates cross-layer validation.
* Reviews business and financial impact.
* Tracks CAPA effectiveness.

## SDET

* Automates preventive regression.
* Adds failure simulation.
* Integrates tests into CI/CD.
* Improves diagnostic logs and monitoring checks.

---

# Common Interview Questions

## What is the difference between corrective and preventive action?

Corrective action removes the cause of an existing defect. Preventive action introduces controls that reduce the likelihood of similar defects occurring in the future.

## How do you know a CAPA action is effective?

Effectiveness is demonstrated through retesting, regression, database validation, monitoring, and evidence that the defect does not recur under the same or related conditions.

## Who owns CAPA?

Ownership depends on the action. Engineering may own code changes, Product may own requirement clarification, QA may own regression coverage, and Operations may own monitoring. QA often coordinates verification.

## Can a defect be closed before preventive actions are complete?

The individual defect may be fixed and verified, but the RCA or CAPA record should remain open until required preventive actions are implemented or formally accepted.

---

# Recruiter Talking Points

This document demonstrates the ability to:

* Convert RCA findings into owned improvement actions.
* Separate correction, corrective action, and preventive action.
* Define measurable acceptance and effectiveness criteria.
* Coordinate actions across Product, Engineering, QA, Security, Data, and Operations.
* Connect defect remediation to regression, automation, monitoring, and release readiness.
* Prevent recurrence rather than repeatedly retesting the same issue.
