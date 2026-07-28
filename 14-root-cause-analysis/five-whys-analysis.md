# Five Whys Analysis

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document applies the **Five Whys** technique to selected critical and high-risk defects identified during Sprint 1.

The Five Whys technique begins with the visible problem and repeatedly asks **“Why did this happen?”** until the investigation reaches an underlying technical, process, design, requirement, or control failure.

The purpose is not to force every analysis to contain exactly five questions. The investigation should stop when the identified cause is:

* Supported by evidence
* Actionable
* Within the organisation’s control
* Deep enough to prevent recurrence

---

# Analysis Principles

The analysis follows these principles:

* Focus on system and process weaknesses rather than blame.
* Use evidence from logs, APIs, database records, tests, and requirements.
* Separate the customer-visible symptom from the underlying cause.
* Identify contributing factors when more than one cause exists.
* Define both corrective and preventive actions.
* Validate preventive actions through regression or automation.

---

# Five Whys Summary

| Bug ID  | Visible Problem                                  | Confirmed Root Cause                                              |
| ------- | ------------------------------------------------ | ----------------------------------------------------------------- |
| BUG-001 | Wallet credited twice                            | Callback processing lacked atomic idempotency                     |
| BUG-002 | Failed transfer was not reversed                 | No guaranteed compensation path existed after debit               |
| BUG-003 | Expired JWT accessed protected API               | Token expiry was not consistently enforced                        |
| BUG-005 | Daily transfer limit was bypassed                | Validation checked one request rather than cumulative daily total |
| BUG-006 | Customer accessed another customer’s beneficiary | Resource query did not enforce ownership                          |
| BUG-007 | Refund exceeded original amount                  | Refund was not bounded by original refundable value               |
| BUG-008 | Notification failure changed transaction status  | Notification and financial processing shared one failure path     |

---

# Analysis 1 — Duplicate Wallet Credit

## Problem Statement

A customer’s wallet was credited twice after the payment provider resent the same successful callback.

## Why 1

**Why was the wallet credited twice?**

Because the callback handler processed both callback requests as new successful funding events.

## Why 2

**Why did the handler process the repeated callback as a new event?**

Because it did not confirm that the provider reference had already been processed before applying another wallet credit.

## Why 3

**Why was the processed provider reference not reliably checked?**

Because the status check, ledger credit, and wallet update were implemented as separate operations without an atomic idempotency control.

## Why 4

**Why was there no atomic idempotency control?**

Because callback retry behaviour was treated as an edge case rather than a normal provider behaviour during requirement and design review.

## Why 5

**Why was callback retry behaviour not treated as a core requirement?**

Because the integration design focused mainly on the successful single-callback path, and no mandatory fintech idempotency checklist existed.

## Root Cause

The wallet-funding callback flow lacked **atomic idempotency**, supported by a unique provider-reference constraint and a transaction-safe processed-event check.

## Contributing Factors

* Provider mock originally sent callbacks only once.
* Duplicate-callback acceptance criteria were missing.
* No unique database constraint existed.
* Early integration testing focused on happy paths.
* Logs did not clearly identify duplicate provider events.

## Corrective Action

* Add an idempotency check before financial processing.
* Add a unique provider-reference constraint.
* Process status update, ledger credit, and wallet update atomically.
* Return a safe success acknowledgement for already processed callbacks.

## Preventive Action

* Add duplicate callback tests to API regression and CI.
* Add idempotency to payment-integration design reviews.
* Add database duplicate-detection checks.
* Configure provider mocks to retry callbacks.

## Effectiveness Check

The same callback should be submitted multiple times while confirming:

* One transaction remains successful.
* One credit ledger entry exists.
* Wallet balance changes once.
* Duplicate events are logged without additional financial impact.

---

# Analysis 2 — Failed External Transfer Not Reversed

## Problem Statement

A customer’s wallet remained debited after an external transfer failed at the provider.

## Why 1

**Why did the customer remain debited?**

Because no reversal was created after the provider returned a failed transfer result.

## Why 2

**Why was no reversal created?**

Because the failure handler updated the transfer status to `FAILED` but did not invoke the reversal service.

## Why 3

**Why did the failure handler not invoke the reversal service?**

Because the implementation did not distinguish between:

* Failure before debit
* Failure after debit

Both paths used the same generic failure handling.

## Why 4

**Why were the two failure paths not distinguished?**

Because requirements and transaction-state design did not explicitly define a mandatory compensation path after debit.

## Why 5

**Why was the compensation requirement missing?**

Because successful transfer completion received more design attention than financial recovery, and no mandatory recovery-rule review existed for money-movement features.

## Root Cause

The external-transfer design lacked a guaranteed **compensation workflow** for failures occurring after wallet debit.

## Contributing Factors

* No `debit_applied` or reversal-required indicator.
* Reversal and status update were separate operations.
* Provider-failure tests focused on pre-debit failure.
* No alert detected failed debited transfers without reversals.
* Ownership was unclear between transfer and transaction services.

## Corrective Action

* Trigger reversal whenever failure occurs after debit.
* Link reversal to the original transaction.
* Restore wallet balance and update status safely.
* Prevent final closure while an unrecovered debit exists.

## Preventive Action

* Add failure-before-debit and failure-after-debit acceptance criteria.
* Add API and SQL regression for both paths.
* Monitor failed transactions without linked reversals.
* Add financial recovery to design and code-review checklists.

## Effectiveness Check

Simulate provider failure after debit and confirm:

* Original transfer is marked failed or reversed according to the defined lifecycle.
* Customer balance returns to the original amount.
* A linked reversal record exists.
* Ledger entries reconcile.
* No manual intervention is required.

---

# Analysis 3 — Expired JWT Accepted

## Problem Statement

An expired JWT was accepted by the wallet-balance API.

## Why 1

**Why did the API accept an expired token?**

Because the authentication middleware did not reject the token based on expiration.

## Why 2

**Why was expiration not enforced?**

Because token verification validated the signature but the expiry validation setting was disabled, bypassed, or inconsistently configured.

## Why 3

**Why was configuration inconsistent?**

Because authentication configuration differed between local, QA, and intended production environments.

## Why 4

**Why was the difference not detected earlier?**

Because automated security tests covered missing and malformed tokens but not expired tokens.

## Why 5

**Why were expired-token tests missing?**

Because session expiry was treated as configuration behaviour rather than a testable security requirement.

## Root Cause

JWT expiry was not consistently enforced as a mandatory authentication rule across environments and automated tests.

## Contributing Factors

* QA token lifetime was unusually long.
* Middleware unit tests did not cover expiry.
* No environment-configuration validation existed.
* Security regression was introduced later.

## Corrective Action

* Enforce expiry validation.
* Standardise authentication configuration.
* Return `401 Unauthorized` for expired tokens.
* Confirm all protected endpoints use the same middleware.

## Preventive Action

* Add expired-token tests to CI.
* Add environment configuration validation.
* Include session expiry in smoke and regression suites.
* Add authentication middleware unit coverage.

## Effectiveness Check

Use an expired token against every protected API and confirm:

* Access is rejected.
* No financial data is returned.
* No financial action occurs.
* The authentication failure is logged appropriately.

---

# Analysis 4 — Daily Transfer Limit Bypass

## Problem Statement

A customer exceeded the daily transfer limit by making several smaller transfers.

## Why 1

**Why could the customer exceed the daily limit?**

Because the platform approved each transfer independently.

## Why 2

**Why was each transfer approved independently?**

Because validation compared only the current transfer amount against the per-transaction limit.

## Why 3

**Why was the customer’s existing daily total not included?**

Because the transfer-limit service did not query and aggregate eligible transactions for the business day.

## Why 4

**Why was cumulative aggregation not implemented?**

Because requirement wording described the limit value but did not specify cumulative calculation, status eligibility, or time-zone rules.

## Why 5

**Why were those rules not clarified before implementation?**

Because transfer-limit acceptance criteria were not reviewed jointly by Product, QA, Engineering, and risk stakeholders.

## Root Cause

The daily-limit rule was implemented as a **single-request validation** instead of a cumulative business-day control.

## Contributing Factors

* Boundary tests covered one large transfer only.
* Time-zone rules were undefined.
* Pending, successful, failed, and reversed transaction treatment was unclear.
* No database query identified customers over the daily limit.

## Corrective Action

* Calculate the eligible daily transfer total.
* Add the requested amount to the existing total.
* Reject the request when the new total exceeds the configured limit.
* Apply the approved business time zone and status rules.

## Preventive Action

* Add boundary tests below, at, and above the limit.
* Add multiple-small-transfer tests.
* Add SQL monitoring for limit breaches.
* Make transfer-limit rules configuration-driven and documented.

## Effectiveness Check

Execute several transfers whose combined value approaches and exceeds the limit, confirming:

* Transfers below the limit succeed.
* A transfer reaching the exact allowed limit follows the defined rule.
* Any request exceeding the cumulative limit is rejected.
* Rejected requests do not debit the wallet.

---

# Analysis 5 — Cross-Customer Beneficiary Access

## Problem Statement

Customer A retrieved Customer B’s saved beneficiary by supplying the beneficiary ID.

## Why 1

**Why could Customer A retrieve Customer B’s beneficiary?**

Because the API returned the beneficiary record based only on its ID.

## Why 2

**Why was ownership not checked?**

Because the service query did not include the authenticated customer’s user ID.

## Why 3

**Why did the service not include ownership context?**

Because authentication was assumed to be sufficient protection after the request passed the JWT guard.

## Why 4

**Why was authentication confused with authorisation?**

Because no reusable object-level authorisation pattern or ownership-review checklist existed.

## Why 5

**Why was this not detected during early testing?**

Because happy-path tests used beneficiaries belonging to the authenticated customer and no cross-user test data was included.

## Root Cause

The beneficiary endpoint lacked **object-level authorisation** and queried resources without enforcing customer ownership.

## Contributing Factors

* Service accepted only the beneficiary ID.
* No ownership helper or policy existed.
* Cross-user test accounts were not part of the initial data set.
* Similar customer-owned endpoints were not reviewed together.

## Corrective Action

* Query using beneficiary ID and authenticated user ID.
* Deny or mask access when ownership does not match.
* Review related customer-owned resources for the same pattern.

## Preventive Action

* Add cross-user tests for wallets, beneficiaries, transactions, and notifications.
* Add object ownership to API-security reviews.
* Introduce reusable ownership guards or scoped repositories.
* Include broken object-level authorisation tests in CI.

## Effectiveness Check

Authenticate as one customer and attempt access to another customer’s resources, confirming:

* Access is denied.
* No sensitive record is returned.
* No update or deletion occurs.
* The event is logged according to policy.

---

# Analysis 6 — Refund Exceeded Original Amount

## Problem Statement

A bill payment of ₦8,000 produced a refund of ₦8,500.

## Why 1

**Why was the refund larger than the original eligible amount?**

Because the refund calculation added a fee component to the transaction amount.

## Why 2

**Why was the fee added incorrectly?**

Because the service used a derived gross amount rather than the original transaction’s refundable amount.

## Why 3

**Why did the service trust the derived amount?**

Because no validation enforced that the refund amount must not exceed the remaining refundable balance.

## Why 4

**Why was that invariant missing?**

Because refund requirements did not clearly distinguish:

* Transaction amount
* Service fee
* Settled amount
* Refundable amount
* Previously refunded amount

## Why 5

**Why were these values not clarified before implementation?**

Because refund logic was treated as a simple credit operation rather than a controlled financial lifecycle requiring Product, Finance, Engineering, and QA review.

## Root Cause

The refund workflow lacked a defined and enforced **refundable-amount invariant** based on the original transaction and previous refunds.

## Contributing Factors

* Fee handling was ambiguous.
* No cumulative refund tracking existed.
* Test data covered full refund only.
* SQL reconciliation was introduced later.
* No service or database safeguard rejected over-refunds.

## Corrective Action

* Store or derive the eligible refundable amount from the original transaction.
* Calculate remaining refundable balance.
* Reject over-refund attempts.
* Link every refund to the original transaction.
* Validate wallet credit and ledger entry before commit.

## Preventive Action

* Add full, partial, repeated, zero, and over-refund tests.
* Add refund invariants to requirements and code review.
* Add SQL reconciliation for cumulative refunds.
* Require business approval for fee-refund behaviour.
* Add automated refund coverage to CI.

## Effectiveness Check

For an original transaction of ₦8,000, confirm:

* A full refund cannot exceed ₦8,000.
* Multiple partial refunds cannot cumulatively exceed ₦8,000.
* Repeated use of the same refund request is idempotent.
* Wallet, transaction, and ledger values reconcile.

---

# Analysis 7 — Notification Failure Changed Transaction Status

## Problem Statement

A successful funding transaction was marked `FAILED` when notification delivery failed.

## Why 1

**Why did the transaction become failed?**

Because the notification exception was caught by the same error handler as the financial transaction.

## Why 2

**Why did both services share the same error handler?**

Because notification sending was performed synchronously inside the transaction-processing workflow.

## Why 3

**Why was notification processing synchronous?**

Because the initial design treated notification delivery as part of completing the transaction request.

## Why 4

**Why was notification treated as part of financial completion?**

Because the source-of-truth boundary between financial processing and customer communication was not explicitly defined.

## Why 5

**Why was this design weakness not detected earlier?**

Because integration tests covered successful notification delivery but not notification failure after a successful financial commit.

## Root Cause

The system tightly coupled a non-financial notification service to the financial transaction’s final outcome.

## Contributing Factors

* One shared exception path.
* No notification retry queue.
* Financial status persisted after notification attempt rather than before it.
* Notification outage simulation was absent from early tests.

## Corrective Action

* Persist financial success before sending notifications.
* Handle notification failure independently.
* Record failed delivery for retry.
* Prevent notification exceptions from changing transaction status.

## Preventive Action

* Use asynchronous notification processing.
* Add service-isolation integration tests.
* Define financial source-of-truth rules.
* Monitor notification delivery independently from financial success.

## Effectiveness Check

Disable the notification service and complete a successful transaction, confirming:

* Financial status remains `SUCCESSFUL`.
* Wallet and ledger remain accurate.
* Notification status is recorded as failed.
* Retry can occur without reprocessing the financial transaction.

---

# Cross-Defect Five Whys Findings

The analyses identified recurring organisational and technical themes.

## Theme 1 — Happy-Path Bias

Requirements and initial tests described successful processing more thoroughly than:

* Retries
* Timeouts
* Failures after debit
* Partial failure
* Recovery
* Dependent-service outages

## Theme 2 — Missing Financial Invariants

Key safeguards were not consistently defined or enforced:

* One provider event creates one financial impact.
* Failed debited transfers require compensation.
* Refunds cannot exceed refundable balances.
* Customer-owned records require ownership validation.
* Non-financial services cannot redefine financial outcomes.

## Theme 3 — Late Cross-Layer Validation

Some defects remained hidden until API results were compared with:

* Wallet balances
* Ledger entries
* Original transactions
* Linked refunds and reversals
* Audit records

## Theme 4 — Limited Failure Simulation

Provider mocks and test environments initially represented straightforward success and failure responses but not realistic retry, delay, and partial-failure behaviour.

## Theme 5 — Missing Standard Review Controls

The project lacked mandatory checklists for:

* Financial idempotency
* Failure recovery
* Resource ownership
* Refund eligibility
* Service isolation
* Reconciliation readiness

---

# Preventive Framework

Based on the Five Whys findings, every future financial feature should answer these questions before implementation:

1. What happens if the same request is received more than once?
2. What happens if failure occurs before debit?
3. What happens if failure occurs after debit?
4. What financial invariant must always remain true?
5. How is the customer’s balance restored?
6. How is the action linked to the original transaction?
7. How will the database prove the outcome?
8. How will Operations detect an exception?
9. Which customer owns the requested resource?
10. Which automated regression prevents recurrence?

---

# Action Tracking

| Action                                 | Owner               | Verification                            |
| -------------------------------------- | ------------------- | --------------------------------------- |
| Implement callback idempotency         | Backend Team        | Duplicate callback regression           |
| Add transfer compensation workflow     | Backend Team        | Reversal API and SQL tests              |
| Enforce JWT expiry consistently        | Security/Backend    | Expired-token suite                     |
| Add cumulative daily-limit calculation | Backend Team        | Limit boundary regression               |
| Enforce beneficiary ownership          | Backend Team        | Cross-user API tests                    |
| Add refund eligibility invariant       | Backend Team        | Refund reconciliation tests             |
| Decouple notifications                 | Backend Team        | Service-isolation test                  |
| Expand provider mocks                  | QA/SDET             | Retry, timeout, and failure simulations |
| Add financial review checklist         | QA Lead/Engineering | Review audit                            |
| Add monitoring for exceptions          | Operations/Backend  | Alert verification                      |

---

# QA Lead Conclusion

The Five Whys analysis shows that the critical Sprint 1 defects were not random implementation mistakes.

They resulted from deeper gaps in:

* Failure-state requirements
* Financial safeguards
* Service boundaries
* Object-level authorisation
* Provider simulation
* Cross-layer validation
* Review standards

The strongest preventive response is therefore not only to fix each defect individually, but to introduce repeatable controls across requirements, architecture, coding, testing, monitoring, and release governance.

---

# Recruiter Talking Points

This document demonstrates the ability to:

* Apply the Five Whys technique to technical and financial defects.
* Move from a visible symptom to an actionable root cause.
* Avoid blame-oriented analysis.
* Connect requirements, architecture, code, tests, and monitoring.
* Define measurable corrective and preventive actions.
* Translate RCA findings into regression and automation controls.
