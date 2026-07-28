# Bug Investigation Scenarios

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This guide contains realistic bug investigation scenarios commonly discussed during QA, API testing, automation, SDET, and fintech interviews.

The goal is not only to identify a defect, but to demonstrate a structured investigation process.

A strong QA Engineer should be able to:

* Reproduce the issue
* Gather evidence
* Identify the affected system layer
* Assess business impact
* Validate the database
* Review logs and integrations
* Communicate findings clearly
* Recommend regression coverage
* Support Root Cause Analysis

---

# Recommended Investigation Framework

Use the following structure when answering scenario-based interview questions.

## 1. Understand the Issue

Clarify:

* What happened?
* Who was affected?
* When did it happen?
* Is the issue reproducible?
* What was the expected behaviour?
* What was the actual behaviour?

---

## 2. Assess Business Impact

Determine:

* Are customer funds affected?
* Is customer data exposed?
* Is the issue affecting one user or many users?
* Is the issue blocking a critical workflow?
* Is there a regulatory or security risk?
* Should the release or service be stopped?

---

## 3. Reproduce the Issue

Attempt to reproduce using:

* The same account
* The same environment
* The same transaction data
* The same device or browser
* The same API request
* Similar timing and network conditions

---

## 4. Collect Evidence

Gather:

* Screenshots
* Videos
* API requests and responses
* Database records
* Application logs
* Network logs
* Transaction references
* Timestamps
* User identifiers
* Provider references

---

## 5. Isolate the Failure

Determine whether the issue is related to:

* Frontend
* API
* Business logic
* Database
* Authentication
* Authorisation
* External provider
* Queue or background process
* Environment
* Test data
* Configuration

---

## 6. Report and Recommend

Document:

* Reproduction steps
* Expected and actual results
* Severity
* Priority
* Business impact
* Supporting evidence
* Likely affected components
* Suggested regression coverage

---

# Scenario 1 — Wallet Debited but Recipient Not Credited

## Problem

A customer reports that £250 was deducted from their wallet, but the recipient did not receive the money.

---

## Investigation Approach

### Step 1 — Gather Details

Collect:

* Sender account ID
* Recipient account ID
* Transaction reference
* Amount
* Date and time
* Channel used
* Environment
* Screenshot or receipt

---

### Step 2 — Check API Behaviour

Review:

* Transfer request payload
* API response
* Status code
* Transaction status
* Error message
* Retry attempts

Confirm whether the API returned:

* Success
* Pending
* Failed
* Timeout

---

### Step 3 — Check Database Records

Validate:

* Sender wallet debit
* Recipient wallet credit
* Transaction record
* Ledger entries
* Reversal record
* Audit logs

Example queries:

```sql
SELECT
    id,
    reference,
    sender_wallet_id,
    receiver_wallet_id,
    amount,
    status,
    created_at
FROM transactions
WHERE reference = 'TXN-REFERENCE';
```

```sql
SELECT
    wallet_id,
    entry_type,
    amount,
    reference,
    created_at
FROM ledger_entries
WHERE reference = 'TXN-REFERENCE';
```

---

### Step 4 — Check Asynchronous Processing

If the transfer uses queues or background processing, verify:

* Was the transfer event published?
* Was it consumed?
* Did it fail?
* Was it retried?
* Was it sent to a dead-letter queue?
* Was a compensation process triggered?

---

## Possible Root Causes

* Recipient credit failed after sender debit.
* Database transaction was not atomic.
* Queue message was lost.
* Consumer failed during processing.
* Provider returned a delayed response.
* Retry logic created an inconsistent state.
* Reversal process did not execute.

---

## Business Impact

This is a **Critical** defect because customer funds are affected.

Possible consequences include:

* Financial loss
* Customer complaints
* Reconciliation mismatch
* Regulatory exposure
* Loss of customer trust

---

## Recommended Regression Coverage

Add automated tests for:

* Debit succeeds but credit fails
* Queue consumer failure
* Provider timeout
* Retry after partial processing
* Automatic reversal
* Duplicate reversal prevention
* Ledger balance validation

---

# Scenario 2 — Customer Charged Twice

## Problem

A customer submits one payment but is charged twice.

---

## Investigation Approach

Check:

* Number of API requests
* Idempotency key
* Payment references
* Provider callbacks
* Retry behaviour
* Ledger entries
* Wallet balance
* Transaction timestamps

Example query:

```sql
SELECT
    provider_reference,
    COUNT(*) AS occurrence_count
FROM transactions
GROUP BY provider_reference
HAVING COUNT(*) > 1;
```

---

## Possible Root Causes

* Missing idempotency control
* Duplicate callback processing
* User clicked the payment button multiple times
* Frontend submitted duplicate requests
* Network retry created another transaction
* Provider callback was replayed
* Unique database constraint was missing

---

## Business Impact

Potential impact includes:

* Financial loss
* Refund requests
* Reconciliation mismatch
* Customer complaints
* Increased support workload

---

## Recommended Regression Coverage

Automate:

* Same request submitted twice
* Concurrent duplicate requests
* Same callback replayed
* Same idempotency key with identical payload
* Same idempotency key with different payload
* Rapid repeated button clicks

---

# Scenario 3 — API Returns Success but No Database Record Exists

## Problem

An API returns `201 Created`, but the expected database record does not exist.

---

## Investigation Approach

Review:

* API response
* Application logs
* Database transaction logs
* ORM or repository layer
* Environment configuration
* Database connection
* Rollback behaviour
* Error handling

---

## Possible Root Causes

* Database insert failed after response was generated.
* Asynchronous processing failed.
* Wrong database environment was queried.
* Transaction rolled back.
* Application swallowed an exception.
* Response was returned before persistence completed.
* Read replica delay caused temporary inconsistency.

---

## Business Impact

The API contract is misleading because the operation did not actually complete.

For a financial transaction, this may be a **High** or **Critical** defect.

---

## Recommended Regression Coverage

Add tests that verify:

* API success
* Database persistence
* Correct record values
* Audit entry creation
* Rollback on failure
* No false-success response

---

# Scenario 4 — Login Works for Suspended User

## Problem

A user with a suspended account can still log in and access protected features.

---

## Investigation Approach

Validate:

* Authentication provider status
* Application user status
* Access token claims
* Authentication guard
* Authorisation guard
* Session invalidation
* Cached user data

---

## Possible Root Causes

* Login validates identity but not account status.
* Suspended status is not checked by the guard.
* Existing sessions were not revoked.
* Cache contains outdated account status.
* Token validation does not query application user state.

---

## Business Impact

Potential consequences include:

* Unauthorised financial activity
* Security risk
* Policy violation
* Fraud exposure

---

## Recommended Regression Coverage

Automate:

* Suspended user login
* Suspended user with existing token
* Inactive user
* Pending user
* Status changed during active session
* Session revocation after suspension

---

# Scenario 5 — User Can Access Another Customer’s Wallet

## Problem

Customer A changes a wallet ID in the URL and retrieves Customer B’s wallet details.

---

## Investigation Approach

Review:

* Authentication
* Object ownership validation
* Endpoint authorisation
* Route parameters
* Database query filters
* Role checks
* API response data

Example vulnerable pattern:

```text
GET /wallets/2002
```

The system validates that the wallet exists but not whether it belongs to the authenticated user.

---

## Possible Root Causes

* Missing object-level authorisation
* Query filters only by wallet ID
* User identity not included in database query
* Role check exists without ownership check

---

## Business Impact

This is a **Critical security defect** because it exposes another customer’s financial information.

---

## Recommended Regression Coverage

Automate:

* Access own wallet
* Access another customer’s wallet
* Access another customer’s transaction
* Modify another customer’s beneficiary
* Delete another customer’s payment method
* Admin and customer permission differences

---

# Scenario 6 — Transfer Limit Can Be Bypassed

## Problem

The daily transfer limit is £5,000, but a customer completes six separate £1,000 transfers.

---

## Investigation Approach

Verify:

* Whether the limit applies per transaction or per day
* Time-zone handling
* Successful versus failed transactions counted
* Pending transactions
* Currency handling
* Limit reset logic
* Database aggregation query

Example query:

```sql
SELECT
    sender_wallet_id,
    SUM(amount) AS total_transferred
FROM transactions
WHERE sender_wallet_id = 1001
  AND status IN ('PENDING', 'SUCCESS')
  AND created_at >= CURRENT_DATE
GROUP BY sender_wallet_id;
```

---

## Possible Root Causes

* Limit checked only against individual transaction amount
* Previous transfers not aggregated
* Pending transfers excluded
* Time-zone mismatch
* Race condition during concurrent requests
* Limit data cached incorrectly

---

## Business Impact

Potential consequences include:

* Fraud exposure
* Regulatory breach
* Business rule violation
* Financial risk

---

## Recommended Regression Coverage

Automate:

* Amount just below limit
* Amount exactly at limit
* Amount above limit
* Multiple transfers reaching daily limit
* Concurrent transfers
* Midnight boundary
* Failed and reversed transactions
* Multi-currency limit handling

---

# Scenario 7 — Refund Exceeds Original Payment

## Problem

A customer pays £100 but receives a refund of £150.

---

## Investigation Approach

Check:

* Original payment amount
* Previous refunds
* Refund status
* Partial refund calculations
* Concurrent refund requests
* Provider response
* Ledger entries

Example query:

```sql
SELECT
    original_transaction_id,
    SUM(amount) AS total_refunded
FROM refunds
WHERE status IN ('PENDING', 'SUCCESS')
GROUP BY original_transaction_id;
```

---

## Possible Root Causes

* Refund amount not validated
* Previous refunds not included
* Concurrent requests passed validation
* Pending refunds excluded
* Currency conversion error
* Decimal precision issue

---

## Business Impact

This is a **Critical financial defect** because the business may lose money.

---

## Recommended Regression Coverage

Automate:

* Full refund
* Partial refund
* Multiple partial refunds
* Refund equal to remaining amount
* Refund greater than remaining amount
* Concurrent refund requests
* Duplicate refund submission

---

# Scenario 8 — Transaction History Shows Incorrect Status

## Problem

A completed payment appears as `PENDING` in transaction history.

---

## Investigation Approach

Compare:

* Provider status
* Internal transaction status
* Ledger state
* Database records
* UI mapping
* Cache
* Background status-update job
* Event processing

---

## Possible Root Causes

* Provider callback was not processed.
* Status-update event failed.
* UI uses an outdated field.
* Cache was not refreshed.
* Database update failed.
* Incorrect status mapping exists.

---

## Business Impact

Although funds may be correct, the issue can cause:

* Customer confusion
* Duplicate payment attempts
* Increased support requests
* Reduced trust

---

## Recommended Regression Coverage

Test:

* Pending to success
* Pending to failed
* Delayed callback
* Duplicate callback
* Cache refresh
* Transaction-history mapping
* Status-update retries

---

# Scenario 9 — Intermittent API Timeout

## Problem

A money transfer API sometimes takes more than 30 seconds and returns a timeout.

---

## Investigation Approach

Review:

* API response times
* Database query performance
* External provider latency
* Queue processing
* Connection pool usage
* CPU and memory
* Retry logic
* Logs and distributed traces

---

## Possible Root Causes

* Slow database query
* Missing index
* Provider latency
* Connection pool exhaustion
* Deadlock
* Excessive synchronous processing
* Environment overload

---

## Business Impact

Timeouts may cause customers to retry requests and create duplicate financial transactions.

---

## Recommended Regression Coverage

Add:

* Performance smoke test
* Timeout simulation
* Retry test
* Idempotency test after timeout
* Database performance validation
* Concurrent transfer test

---

# Scenario 10 — Automated Test Passes Locally but Fails in CI

## Problem

A Playwright test passes consistently on a local machine but fails in GitHub Actions.

---

## Investigation Approach

Compare:

* Environment variables
* Browser versions
* Operating system
* Test data
* Network access
* Worker count
* Headless execution
* Timing assumptions
* Secret configuration
* Application availability

---

## Possible Root Causes

* Missing CI secret
* Shared test data
* Parallel execution conflict
* Fixed wait
* Different browser version
* Environment is slower
* API dependency is unavailable
* Incorrect base URL

---

## Recommended Fixes

* Use web-first assertions.
* Remove fixed waits.
* Isolate test data.
* Review trace and screenshots.
* Configure secrets.
* Match dependency versions.
* Reduce workers if the environment cannot support parallel execution.
* Reproduce in a CI-like container.

---

# Scenario 11 — Duplicate Notifications

## Problem

A customer receives three notifications for one successful transfer.

---

## Investigation Approach

Check:

* Number of emitted events
* Notification consumer retries
* Event identifiers
* Delivery-provider response
* Notification database records
* Retry policy
* Idempotency handling

---

## Possible Root Causes

* Same event published more than once
* Consumer retried after successful delivery
* Provider response was not recorded
* Notification event lacks a unique identifier
* Duplicate callback triggered notification again

---

## Business Impact

This may not affect funds, but it creates:

* Customer confusion
* Reduced trust
* Increased messaging cost
* Poor user experience

---

## Recommended Regression Coverage

Test:

* One notification per transaction event
* Event replay
* Provider timeout
* Consumer retry
* Duplicate callback
* Notification idempotency

---

# Scenario 12 — Balance Becomes Negative

## Problem

A wallet with £100 allows two concurrent transfers of £80, leaving a negative balance.

---

## Investigation Approach

Review:

* Balance validation
* Transaction isolation level
* Row locking
* Concurrent requests
* Database transaction boundaries
* Cached balance
* Ledger entries

---

## Possible Root Causes

* Both requests read the same starting balance.
* Balance check and debit are separate operations.
* Row-level locking is missing.
* Isolation level is insufficient.
* Cached balance is used for validation.

---

## Business Impact

This is a **Critical financial defect** because the platform allows customers to spend funds they do not have.

---

## Recommended Regression Coverage

Automate:

* Concurrent transfers
* Concurrent bill payments
* Transfer and withdrawal at the same time
* Balance exactly equal to transaction amount
* Insufficient-balance race condition
* Database locking behaviour

---

# Scenario 13 — Reversal Process Credits Customer Twice

## Problem

A failed transaction is reversed successfully, but a retry of the reversal event credits the customer again.

---

## Investigation Approach

Check:

* Original transaction
* Reversal reference
* Event ID
* Number of reversal records
* Ledger credits
* Idempotency control
* Retry logs

---

## Possible Root Causes

* Reversal processing is not idempotent.
* No unique constraint exists on original transaction ID.
* Event replay creates another reversal.
* Consumer does not check previous completion.

---

## Business Impact

This is a **Critical financial defect** because the customer receives excess funds.

---

## Recommended Regression Coverage

Test:

* Initial reversal
* Reversal event replay
* Concurrent reversal processing
* Provider retry
* Duplicate message delivery
* Unique reversal constraint

---

# Scenario 14 — Password Reset Token Can Be Reused

## Problem

A password reset token remains valid after it has already been used.

---

## Investigation Approach

Verify:

* Token expiry
* Token-use status
* Session invalidation
* Password update timestamp
* Token storage
* Replay behaviour

---

## Possible Root Causes

* Token not invalidated after use
* Stateless token lacks one-time-use validation
* Token record not updated
* Multiple requests processed concurrently

---

## Business Impact

This is a **High security defect** because an attacker may reuse the reset link to take over the account.

---

## Recommended Regression Coverage

Automate:

* Valid reset token
* Expired token
* Invalid token
* Used token
* Concurrent reset attempts
* Old password after reset
* Existing session behaviour after reset

---

# Scenario 15 — Search Results Expose Sensitive Data

## Problem

An administrator search endpoint returns full card numbers or sensitive identity data.

---

## Investigation Approach

Review:

* API response
* DTO or serializer
* Database query
* Logging
* Role permissions
* Data-masking rules
* Swagger examples

---

## Possible Root Causes

* Entity returned directly
* Sensitive fields not excluded
* Incorrect response DTO
* Admin role assumed to allow unrestricted data exposure
* Data-masking rules missing

---

## Business Impact

Potential consequences include:

* Data breach
* Compliance violation
* Security incident
* Customer harm
* Reputational damage

---

## Recommended Regression Coverage

Test:

* Sensitive data masking
* Role-based response fields
* API logs
* Error messages
* Export endpoints
* Administrator and support-user permissions

---

# Interview Scenario Answer Template

Use this structure when answering bug investigation questions.

## Example Response

> First, I would confirm the exact customer impact and collect identifiers such as the user ID, transaction reference, amount, timestamp, and environment. I would then reproduce the issue where possible and compare the API response with the actual database and ledger state. Next, I would review logs, retries, asynchronous events, and external-provider responses to identify where the workflow failed. If customer funds or security were affected, I would classify the issue as high priority, communicate it immediately, and recommend blocking the release or disabling the affected feature where necessary. After the fix, I would add regression coverage for the original failure, related negative scenarios, concurrency, idempotency, and recovery behaviour.

---

# Questions to Ask During Investigation

Useful questions include:

* Is the issue reproducible?
* How many customers are affected?
* Are funds or sensitive data involved?
* Did the API return success, failure, or timeout?
* What is the database state?
* Are ledger entries balanced?
* Did an external provider respond?
* Were retries attempted?
* Was the same event processed more than once?
* Was there a recent deployment?
* Is rollback or compensation required?

---

# Evidence Checklist

Before raising a defect, gather where possible:

* [ ] User or account ID
* [ ] Transaction reference
* [ ] Request payload
* [ ] Response payload
* [ ] Status code
* [ ] Timestamp
* [ ] Environment
* [ ] Database evidence
* [ ] Ledger evidence
* [ ] Logs
* [ ] Screenshots or video
* [ ] Provider reference
* [ ] Reproduction frequency
* [ ] Business impact

---

# Defect Classification Guide

| Impact                                          | Suggested Severity |
| ----------------------------------------------- | ------------------ |
| Customer funds lost or duplicated               | Critical           |
| Unauthorised financial access                   | Critical           |
| Sensitive data exposed                          | Critical           |
| Critical workflow unavailable                   | High or Critical   |
| Incorrect transaction status with correct funds | Medium or High     |
| Duplicate notification                          | Medium             |
| Cosmetic issue                                  | Low                |

Severity should reflect technical and customer impact, while priority should reflect how urgently the business needs the issue resolved.

---

# Common Investigation Mistakes

Avoid:

* Assuming the frontend is the cause.
* Relying only on screenshots.
* Treating a `200 OK` response as proof of success.
* Ignoring database and ledger validation.
* Failing to check retries and duplicate processing.
* Testing only the original scenario after the fix.
* Reporting defects without business impact.
* Blaming individuals rather than investigating systems and processes.
* Changing production data without approval.
* Exposing sensitive customer information in defect reports.

---

# Senior QA Perspective

A Senior QA Engineer should go beyond reproducing the issue.

They should also consider:

* Blast radius
* Financial exposure
* Security implications
* Temporary mitigation
* Release impact
* Monitoring gaps
* Missing requirements
* Regression weaknesses
* Process improvements
* Root Cause Analysis
* Corrective and preventive actions

---

# Portfolio Talking Points

This guide demonstrates the ability to:

* Investigate complex production-style defects
* Validate APIs and databases
* Understand fintech transaction flows
* Assess business and financial risk
* Analyse concurrency and idempotency
* Review asynchronous processing
* Recommend regression coverage
* Communicate evidence clearly
* Support release and incident decisions

---

# QA Lead Conclusion

Bug investigation is not simply about proving that an issue exists.

A strong investigation explains:

* What failed
* Where it failed
* Who was affected
* What evidence supports the finding
* What business risk exists
* How the issue should be fixed
* How similar issues can be prevented

For fintech applications, investigations must always consider financial accuracy, security, reconciliation, retries, concurrency, auditability, and customer trust.
