# Payment Failure Testing Guide

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

Payment failure testing verifies that the platform handles unsuccessful, delayed, duplicated, interrupted, and partially completed payment events safely.

In fintech systems, failures are normal. They may occur because of:

* Network instability
* Provider timeout
* Bank rejection
* Card decline
* Duplicate callback
* Delayed confirmation
* Service outage
* Database error
* Retry logic
* Partial completion
* Customer interruption
* Invalid provider response

The main goal is not only to confirm that a payment fails correctly. It is to confirm that customer funds, transaction records, wallet balances, ledger entries, refunds, reversals, and notifications remain accurate after the failure.

---

# Purpose

This guide helps QA Engineers:

* Understand payment failure patterns.
* Design failure and recovery scenarios.
* Validate transaction states.
* Prevent double debit and double credit.
* Test retries and duplicate requests.
* Verify reversals and refunds.
* Validate wallet and ledger consistency.
* Confirm third-party failure handling.
* Assess release risk.

---

# Core Payment Safety Questions

For every payment workflow, ask:

1. Did money move before the failure?
2. Was the customer debited?
3. Was the receiver or merchant credited?
4. Is a reversal required?
5. Can the request be safely retried?
6. Could a duplicate request create another debit?
7. Did the provider and platform record the same status?
8. Is the wallet balance correct?
9. Does the ledger reconcile?
10. Is the failure visible to Operations?
11. Was the customer notified accurately?
12. Is the full event traceable?

---

# Payment Failure Lifecycle

```text
Payment Initiated
        │
        ▼
Validation
        │
        ▼
Payment Processing
        │
 ┌──────┼───────────┐
 ▼      ▼           ▼
Success Failure    Timeout
 │       │           │
 ▼       ▼           ▼
Confirm Determine   Keep Pending
Payment Financial   or Query Provider
        Impact          │
          │             ▼
          ▼        Resolve Final State
   Reverse if Needed
```

---

# Payment Failure Categories

## 1. Validation Failure

The request is rejected before financial processing begins.

Examples:

* Invalid amount
* Missing required field
* Unsupported currency
* Invalid beneficiary
* Transfer above limit
* Insufficient balance

Expected outcome:

* No debit
* No credit
* No provider request
* Clear validation error
* Audit event where required

---

## 2. Authentication or Authorisation Failure

The user is not allowed to perform the action.

Examples:

* Missing token
* Expired token
* Suspended account
* Customer attempts to use another customer’s wallet
* Unauthorised role initiates refund

Expected outcome:

* Request rejected
* No financial impact
* No sensitive data exposed
* Security event logged

---

## 3. Provider Decline

The external provider returns a confirmed rejection.

Examples:

* Card declined
* Invalid bank account
* Insufficient bank funds
* Provider fraud rule triggered
* Biller rejects account details

Expected outcome depends on processing stage:

* If no debit occurred: no reversal required.
* If debit occurred: full reversal required.
* Transaction status updated accurately.
* Failure reason stored safely.
* Customer notification matches the result.

---

## 4. Provider Timeout

The platform sends a request but does not receive a final response within the expected period.

A timeout does not always mean the payment failed.

The provider may have:

* Processed the payment successfully.
* Rejected the payment.
* Received nothing.
* Processed it but delayed the response.

Expected outcome:

* Do not assume success.
* Do not assume final failure too early.
* Keep transaction traceable as `PENDING` or `PROCESSING`.
* Query provider status or wait for callback.
* Prevent duplicate retry from creating another financial effect.
* Apply recovery based on the confirmed final state.

---

## 5. Network Interruption

Connection fails between:

* Customer and platform
* Platform and provider
* Provider and callback endpoint
* Service and database

Expected outcome:

* Request can be traced using a reference or idempotency key.
* Retry is safe.
* No duplicate debit or credit occurs.
* Financial state remains recoverable.

---

## 6. Duplicate Request

The same payment request is submitted more than once.

Common causes:

* Customer taps the button repeatedly.
* Mobile app retries after timeout.
* Browser refreshes.
* Message queue redelivers an event.
* Provider resends a callback.

Expected outcome:

* One financial transaction.
* One debit or credit.
* Same logical response for the repeated request.
* Duplicate attempt recorded where appropriate.

---

## 7. Partial Failure

One part of the payment succeeds while another part fails.

Examples:

* Wallet debited, provider transfer fails.
* Provider confirms success, ledger update fails.
* Wallet credited, notification fails.
* Transaction record created, audit log fails.
* Receiver credited, sender status remains pending.

Partial failures are among the highest-risk fintech defects because the system may appear to have one state while the money has another.

---

## 8. Delayed Callback

The provider processes the transaction but sends confirmation later.

Expected outcome:

* Transaction remains pending within SLA.
* Customer is not credited or debited twice.
* Delayed callback updates the existing transaction.
* Reconciliation identifies overdue records.
* Callback is handled idempotently.

---

## 9. Conflicting Provider Response

The provider sends inconsistent information.

Examples:

* Initial response says pending, callback says failed.
* Callback says successful, later status query says reversed.
* Two callbacks contain different final statuses.

Expected outcome:

* Approved status-transition rules are enforced.
* Invalid transitions are rejected or escalated.
* Financial truth is resolved using the defined source of truth.
* Operations receives an exception alert.

---

## 10. Internal System Failure

The platform fails during payment processing.

Examples:

* Database unavailable
* Ledger service fails
* Wallet service fails
* Queue unavailable
* Transaction commit fails
* Service crashes after provider success

Expected outcome:

* Financial operations roll back or compensate safely.
* Partial records are detectable.
* Transaction remains traceable.
* Retry does not duplicate financial effect.
* Operations can recover the transaction.

---

# Failure Before Debit vs Failure After Debit

This distinction is essential.

## Failure Before Debit

The payment fails before customer funds move.

Expected outcome:

* No wallet debit
* No reversal
* Failed status
* Clear error response
* No ledger movement

## Failure After Debit

The customer has already been charged before the provider or downstream process fails.

Expected outcome:

* Reversal or compensation is required.
* Wallet is restored.
* Reversal links to the original transaction.
* Ledger net effect returns to zero where appropriate.
* Customer receives accurate communication.

---

# Transaction Status Guidance

| Situation                             | Recommended Status               |
| ------------------------------------- | -------------------------------- |
| Request accepted, outcome unknown     | `PENDING`                        |
| Provider processing underway          | `PROCESSING`                     |
| Provider confirmed success            | `SUCCESSFUL`                     |
| Failed before debit                   | `FAILED`                         |
| Failed after debit, recovery required | `REVERSAL_PENDING` or equivalent |
| Funds restored                        | `REVERSED`                       |
| Customer refund completed             | `REFUNDED`                       |
| User cancelled before processing      | `CANCELLED`                      |

The exact statuses may differ by system, but transitions must be explicit and controlled.

---

# Payment Failure Test Scenarios

## Validation Failures

* Reject zero amount.
* Reject negative amount.
* Reject unsupported currency.
* Reject amount above configured limit.
* Reject insufficient wallet balance.
* Reject invalid beneficiary.
* Reject malformed provider reference.

## Authentication and Authorisation Failures

* Reject missing token.
* Reject expired token.
* Reject suspended customer.
* Reject access to another customer’s wallet.
* Reject unauthorised refund attempt.
* Reject unauthorised transaction-status update.

## Provider Failures

* Provider declines before debit.
* Provider declines after debit.
* Provider returns timeout.
* Provider returns server error.
* Provider response is malformed.
* Provider callback is delayed.
* Provider callback is duplicated.
* Provider sends conflicting statuses.

## Internal Failures

* Database fails before transaction creation.
* Ledger entry fails after transaction creation.
* Wallet update fails after provider confirmation.
* Audit service fails.
* Notification service fails.
* Queue delivery is repeated.
* Service crashes after debit but before response.

---

# Detailed Scenario 1 — Card Funding Decline

## Scenario

Customer attempts to fund a wallet with **£100**, but the card provider declines the transaction before funds are confirmed.

## Expected Result

* Transaction status becomes `FAILED`.
* Wallet balance remains unchanged.
* No credit ledger entry exists.
* Provider decline reason is stored safely.
* Customer receives a clear failure message.
* Retry can be attempted using a new valid payment request.

## Defects to Watch For

* Wallet credited despite decline.
* Transaction remains pending indefinitely.
* Failure reason exposes sensitive provider data.
* Duplicate retry uses the old transaction incorrectly.

---

# Detailed Scenario 2 — External Transfer Fails After Debit

## Scenario

Customer sends **£250** externally.

The wallet is debited, but the provider later confirms failure.

## Expected Result

* Original debit remains traceable.
* Reversal is created automatically.
* Wallet is restored by £250.
* Reversal links to the original transfer.
* Ledger net effect equals £0.
* Customer receives reversal notification.
* No duplicate reversal occurs.

## Defects to Watch For

* No reversal created.
* Partial reversal.
* Double reversal.
* Reversal not linked to original transaction.
* Status says failed while balance remains debited.
* Notification reports success.

---

# Detailed Scenario 3 — Provider Timeout With Unknown Outcome

## Scenario

Customer initiates a **£75** bill payment.

The provider does not respond within the timeout period.

## Expected Result

* Transaction remains `PENDING` or `PROCESSING`.
* Wallet handling follows the approved reservation or debit model.
* Customer is not told that the payment is definitely successful or failed.
* Provider status is queried or callback awaited.
* Retry uses the same idempotency context where appropriate.
* Final status is resolved within SLA.

## Defects to Watch For

* Immediate retry creates duplicate debit.
* Timeout is incorrectly marked successful.
* Timeout is marked failed even though provider later confirms success.
* Transaction remains pending beyond SLA with no alert.

---

# Detailed Scenario 4 — Duplicate Callback

## Scenario

The provider sends the same successful funding callback three times.

## Expected Result

* First valid callback completes the transaction.
* Additional callbacks are acknowledged safely.
* Wallet is credited once.
* One credit ledger entry exists.
* One provider reference is stored.
* Duplicate delivery is logged.

## Defects to Watch For

* Multiple wallet credits.
* Multiple transaction records.
* Conflicting statuses.
* Callback retry returns an error that causes the provider to keep retrying unnecessarily.

---

# Detailed Scenario 5 — Notification Failure After Payment Success

## Scenario

A **£60** wallet funding succeeds, but the SMS and email services are unavailable.

## Expected Result

* Transaction remains `SUCCESSFUL`.
* Wallet remains credited by £60.
* Ledger remains correct.
* Notification status is recorded as failed.
* Retry is queued.
* Notification retry does not repeat the payment.

## Defects to Watch For

* Transaction status changes to failed.
* Wallet credit is reversed.
* Duplicate credit occurs during notification retry.
* Customer receives conflicting notifications later.

---

# Detailed Scenario 6 — Database Failure After Provider Success

## Scenario

The provider confirms payment success, but the database fails before the platform completes the wallet update.

## Expected Result

The system must follow its approved recovery design.

Possible safe patterns include:

* Entire internal transaction rolls back and is later recovered through reconciliation.
* Provider success event is stored durably and retried.
* Transaction is flagged for manual or automated recovery.

Required outcomes:

* Provider success is not lost.
* Customer is not credited twice.
* Exception is visible to Operations.
* Reprocessing is idempotent.
* Final records reconcile.

---

# Retry Logic Testing

Retry logic must answer:

* Which failures are retryable?
* How many retries are allowed?
* What delay is used?
* Is exponential backoff applied?
* Does retry reuse the same idempotency key?
* Can retry create duplicate debit or credit?
* What happens after retry exhaustion?
* Is manual recovery possible?

## Retryable Examples

* Temporary provider timeout
* Network interruption
* HTTP 500 from provider
* Queue-delivery failure

## Usually Non-Retryable Examples

* Invalid account number
* Insufficient funds
* Unsupported currency
* Permanent provider rejection
* Failed validation

---

# Idempotency Testing

## Test Conditions

* Send identical request twice sequentially.
* Send identical requests concurrently.
* Retry after client timeout.
* Retry after server timeout.
* Replay provider callback.
* Re-deliver queue event.
* Reuse the same idempotency key with a different amount.

## Expected Behaviour

* Same request with same idempotency key returns the same logical outcome.
* No additional financial impact occurs.
* Reusing a key with materially different request data is rejected.
* Idempotency record remains traceable.

---

# Reversal Testing

Validate:

* Correct reversal amount
* Correct customer wallet
* Correct original transaction link
* Correct ledger entries
* One reversal only
* Reversal retry safety
* Accurate final status
* Customer notification
* Reconciliation

## Reversal Invariant

```text
Original Debit + Successful Reversal = Net Financial Effect of £0
```

---

# Refund Testing

Validate:

* Original transaction is refundable.
* Refund amount is positive.
* Refund does not exceed remaining refundable amount.
* Partial refunds are tracked cumulatively.
* Duplicate refund request is idempotent.
* Wallet credit and ledger entry are atomic.
* Refund links to original payment.
* Settlement adjustment is correct.
* Only authorised roles can refund.

---

# Double-Debit Prevention

Test:

* Rapid button clicks
* Browser refresh
* Client retry after timeout
* Two concurrent API requests
* Queue redelivery
* Provider repeated status update

Expected result:

* Customer is debited once.
* One transaction exists.
* One debit ledger entry exists.
* Duplicate attempts are safe.

---

# Double-Credit Prevention

Test:

* Duplicate provider callback
* Replayed webhook
* Duplicate bank-transfer notification
* Refund retry
* Reversal retry
* Recovery-job rerun

Expected result:

* Customer is credited once.
* One credit entry exists.
* Reprocessing is safe and traceable.

---

# Payment Failure SQL Checks

The exact schema may differ.

## Failed Debited Transactions Without Reversal

```sql
SELECT
    t.id,
    t.reference,
    t.amount,
    t.status
FROM transactions t
LEFT JOIN transactions r
    ON r.original_transaction_id = t.id
    AND r.transaction_type = 'REVERSAL'
    AND r.status = 'SUCCESSFUL'
WHERE t.status = 'FAILED'
  AND t.debit_applied = TRUE
  AND r.id IS NULL;
```

Expected result:

```text
0 rows
```

## Duplicate Provider References

```sql
SELECT
    provider_reference,
    COUNT(*) AS occurrence_count
FROM transactions
WHERE provider_reference IS NOT NULL
GROUP BY provider_reference
HAVING COUNT(*) > 1;
```

Expected result:

```text
0 rows
```

## Transactions Pending Beyond SLA

```sql
SELECT
    id,
    reference,
    status,
    created_at
FROM transactions
WHERE status IN ('PENDING', 'PROCESSING')
  AND created_at < NOW() - INTERVAL '30 minutes';
```

The interval should match the approved SLA.

## Over-Refund Detection

```sql
SELECT
    original.id,
    original.amount,
    SUM(refund.amount) AS total_refunded
FROM transactions original
JOIN transactions refund
    ON refund.original_transaction_id = original.id
    AND refund.transaction_type = 'REFUND'
    AND refund.status = 'SUCCESSFUL'
GROUP BY original.id, original.amount
HAVING SUM(refund.amount) > original.amount;
```

Expected result:

```text
0 rows
```

---

# Evidence to Capture

For every payment failure test, capture:

* Request payload
* Response body
* HTTP status
* Internal reference
* Provider reference
* Idempotency key
* Wallet balance before and after
* Transaction status
* Ledger entries
* Reversal or refund link
* Application logs
* Provider response or callback
* Audit record
* Notification status

---

# Severity Guidance

## Critical

* Double debit
* Double credit
* Missing reversal
* Over-refund
* Cross-customer financial action
* Wallet-ledger mismatch
* Provider success lost internally

## High

* Transaction stuck beyond SLA
* Incorrect final status
* Retry exhaustion without alert
* Notification shows incorrect payment outcome
* Reversal delayed beyond approved recovery window

## Medium

* Unclear failure message
* Duplicate notification with no financial impact
* Incomplete non-financial metadata

---

# Payment Failure Entry Criteria

Testing can begin when:

* Failure rules are documented.
* Transaction states are defined.
* Provider mock or sandbox is available.
* Retry policy is known.
* Reversal and refund rules are known.
* Test wallets and balances are prepared.
* Database access is available.
* Logging and references are enabled.

---

# Payment Failure Exit Criteria

Testing is complete when:

* Planned failure scenarios are executed.
* Duplicate processing is prevented.
* Reversal and refund paths pass.
* Wallet and ledger reconcile.
* Pending transactions resolve or alert within SLA.
* Provider retries are handled safely.
* No unresolved Critical financial defect remains.
* Evidence is stored.
* Regression coverage is updated.

---

# How a QA Engineer Performs Payment Failure Testing

A QA Engineer:

* Executes negative and failure scenarios.
* Simulates timeout, decline, and duplicate requests.
* Validates API responses.
* Checks wallet and database records.
* Confirms reversals and refunds.
* Reports defects with evidence.
* Retests fixes.

---

# How a Senior QA Performs Payment Failure Testing

A Senior QA Engineer:

* Identifies the highest-risk failure paths.
* Challenges incomplete recovery requirements.
* Reviews transaction-state transitions.
* Defines financial invariants.
* Coordinates testing across Product, Engineering, Finance, and Operations.
* Uses unresolved failure risks in release decisions.
* Ensures defects expand regression coverage.

---

# How an SDET Approaches Payment Failure Testing

An SDET:

* Automates provider timeout and retry simulation.
* Builds duplicate-request and concurrency tests.
* Adds API and database assertions.
* Automates reversal and refund validation.
* Runs idempotency checks in CI.
* Creates scheduled pending-transaction checks.
* Improves test diagnostics and logs.

---

# Common Production Issues

* Customer charged but service not delivered.
* Provider processed payment, platform timed out.
* Duplicate callback creates extra credit.
* Retry creates second debit.
* Failed transfer remains unreversed.
* Refund exceeds original payment.
* Transaction remains pending indefinitely.
* Provider and internal statuses conflict.
* Notification failure changes transaction state.
* Recovery job processes the same transaction twice.

---

# Common Interview Questions

## How do you test a payment timeout?

I verify that the transaction remains traceable, no duplicate financial impact occurs, retries are idempotent, the provider is queried or callback awaited, and the final outcome reconciles across the wallet, ledger, and provider records.

## What is the difference between a failed payment and a reversed payment?

A failed payment may stop before funds move. A reversed payment means funds moved or were reserved and then had to be restored because the transaction could not complete.

## How do you prevent duplicate payment processing?

I validate idempotency keys, unique provider references, atomic financial processing, duplicate callback handling, and concurrency behaviour.

## What should happen when notification fails after payment success?

The financial transaction should remain successful. Notification failure should be recorded and retried independently without reprocessing or reversing the payment.

## What is the highest-risk payment failure?

A failure after debit without recovery is among the highest risks because the customer loses access to funds while the intended payment does not complete.

---

# Recruiter Talking Points

This guide demonstrates the ability to:

* Test real payment failure patterns.
* Distinguish pre-debit and post-debit failures.
* Validate retries, timeouts, reversals, refunds, and idempotency.
* Protect against double debit and double credit.
* Combine API, database, ledger, provider, and operational validation.
* Translate payment failures into financial and release risk.

---

# QA Lead Conclusion

Payment failure testing is not limited to checking error messages.

The true objective is to prove that every unsuccessful, delayed, repeated, or partially completed transaction leaves the customer, wallet, ledger, provider records, and audit trail in a safe and recoverable state.

A fintech system is production-ready only when failures are handled as carefully as successful payments.
