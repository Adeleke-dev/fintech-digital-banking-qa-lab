# Audit Trail Validation Guide

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

Audit trail validation confirms that important financial, security, administrative, and customer actions are recorded completely, accurately, and securely.

An audit trail should provide enough evidence to answer:

* Who performed the action?
* What action was performed?
* Which record was affected?
* When did it happen?
* What was the previous state?
* What is the new state?
* Was the action successful or unsuccessful?
* Which device, IP address, request, or service triggered it?
* Can the event be linked to the related financial transaction?

In fintech systems, audit trails support:

* Fraud investigation
* Customer dispute resolution
* Security monitoring
* Financial reconciliation
* Compliance reviews
* Operational recovery
* Root Cause Analysis
* Incident response

---

# Purpose

This guide helps QA Engineers validate that audit records are:

* Complete
* Accurate
* Consistent
* Traceable
* Tamper-resistant
* Secure
* Searchable
* Retained according to policy
* Linked to the correct customer and transaction

---

# What Is an Audit Trail?

An audit trail is a chronological record of system and user activities.

It should capture enough information to reconstruct what happened without relying on memory or manual explanation.

Example:

```text
Customer 1024 initiated external transfer TXN-90812
Amount: £250
Status changed: PENDING → PROCESSING
Provider response: FAILED
Reversal created: REV-33481
Wallet restored: £250
Final status: REVERSED
```

A complete audit trail should make this entire sequence traceable.

---

# Audit Trail vs Application Log

These are related but not identical.

## Application Log

Used mainly for technical diagnostics.

Examples:

* Service started
* Database connection failed
* API returned an error
* Provider request timed out
* Exception stack trace

## Audit Trail

Used to record significant business and security actions.

Examples:

* Customer logged in
* Transfer initiated
* Wallet balance changed
* Refund approved
* Beneficiary deleted
* Admin changed account status

Application logs help explain technical behaviour.

Audit trails help prove business and user actions.

---

# Core Audit Record Fields

A strong audit record may include:

| Field                 | Description                                           |
| --------------------- | ----------------------------------------------------- |
| Audit ID              | Unique audit-event identifier                         |
| Event Type            | Login, transfer, refund, role update, or other action |
| Actor ID              | User or system that performed the action              |
| Actor Type            | Customer, admin, service, scheduled job               |
| Resource Type         | Wallet, transaction, beneficiary, account             |
| Resource ID           | Identifier of the affected record                     |
| Action                | Created, updated, deleted, approved, rejected         |
| Previous Value        | State before the action                               |
| New Value             | State after the action                                |
| Result                | Success, failure, denied                              |
| Timestamp             | When the event occurred                               |
| IP Address            | Request source where applicable                       |
| Device ID             | Device information where applicable                   |
| Request ID            | Correlation identifier                                |
| Transaction Reference | Related financial transaction                         |
| Provider Reference    | External provider identifier                          |
| Reason                | Reason for action or failure                          |
| Metadata              | Additional safe contextual information                |

---

# Audit Trail Principles

A valid audit trail should follow these principles:

## Completeness

Every required event should be recorded.

## Accuracy

The event details must match the actual system behaviour.

## Chronology

Events should appear in the correct order.

## Traceability

Related events should be linked through references or correlation IDs.

## Immutability

Historical audit records should not be edited silently.

## Security

Only authorised roles should access audit data.

## Privacy

Sensitive data should not be exposed unnecessarily.

## Availability

Audit data should be searchable during investigations.

---

# Events That Should Be Audited

## Authentication Events

* Registration attempt
* OTP verification
* Login success
* Login failure
* Password reset request
* Password reset completion
* Logout
* Session expiry
* Token refresh
* Account lockout
* Brute-force detection

## Wallet Events

* Wallet creation
* Wallet activation
* Wallet suspension
* Wallet credit
* Wallet debit
* Balance adjustment
* Reserved-balance change

## Transaction Events

* Transaction initiation
* Status transition
* Provider submission
* Provider callback
* Retry
* Reversal
* Refund
* Settlement
* Manual adjustment

## Beneficiary Events

* Beneficiary created
* Beneficiary viewed
* Beneficiary updated
* Beneficiary deleted
* Cross-customer access denied

## Security Events

* Unauthorised access attempt
* Expired-token request
* Invalid-token request
* Role change
* Permission change
* Suspicious rapid transfer attempt
* Transfer-limit breach
* Duplicate request detected

## Administrative Events

* Account suspended
* Account reactivated
* Refund approved
* Manual wallet adjustment
* Transaction status overridden
* User role changed
* Limit configuration changed

---

# Audit Trail Validation Questions

For every important workflow, ask:

1. Was an audit event created?
2. Is the actor correct?
3. Is the affected resource correct?
4. Is the action correct?
5. Are the previous and new values accurate?
6. Is the timestamp correct?
7. Is the event linked to the request and transaction?
8. Is sensitive data masked?
9. Can unauthorised users access the record?
10. Can the record be changed or deleted improperly?
11. Does a failed or denied action create an event?
12. Can the complete event sequence be reconstructed?

---

# Audit Trail Test Scenarios

## Authentication

* Successful login creates audit record.
* Failed login creates audit record.
* Expired-token access creates security event.
* Password reset creates traceable events.
* Logout invalidates session and creates event.
* Brute-force threshold creates alert or audit event.

## Wallet

* Wallet creation is audited.
* Funding credit is audited.
* Transfer debit is audited.
* Manual adjustment is audited with reason and actor.
* Failed financial update does not create a false success event.

## Transactions

* Initiation is recorded.
* Every status transition is recorded.
* Provider callback is linked.
* Reversal links to original transaction.
* Refund links to original transaction.
* Duplicate request is recorded without duplicate financial impact.

## Authorisation

* Cross-customer access attempt is denied and recorded.
* Admin-only actions are audited.
* Role changes include previous and new role.
* Permission changes include actor and approval reason.

---

# Detailed Scenario 1 — External Transfer Audit Trail

## Scenario

A customer initiates an external transfer of **£250**.

The provider later reports failure, and the system creates a reversal.

## Expected Audit Sequence

| Sequence | Event                              |
| -------: | ---------------------------------- |
|        1 | Customer authenticated             |
|        2 | Transfer request received          |
|        3 | Transfer validated                 |
|        4 | Wallet debit applied               |
|        5 | Provider request submitted         |
|        6 | Provider failure received          |
|        7 | Reversal initiated                 |
|        8 | Wallet restored                    |
|        9 | Final status changed to `REVERSED` |
|       10 | Customer notification attempted    |

## Key Validations

* All events share the correct transaction reference.
* Reversal event references the original transfer.
* Debit and recovery amounts both equal £250.
* Actor is correct for each event.
* Events appear in the correct order.
* Notification failure does not change the financial events.

---

# Detailed Scenario 2 — Refund Approval Audit Trail

## Scenario

An authorised admin approves a **£40** partial refund for an original **£100** bill payment.

## Expected Audit Data

* Original transaction ID
* Refund transaction ID
* Admin user ID
* Approval action
* Refund amount
* Remaining refundable amount
* Previous transaction state
* New refund state
* Approval reason
* Timestamp
* Request or correlation ID

## Defects to Watch For

* No record of who approved the refund.
* Refund amount differs from wallet credit.
* Original transaction link is missing.
* Approval reason is absent.
* Previous and new values are incorrect.
* Unauthorised customer appears as the actor.

---

# Detailed Scenario 3 — Cross-Customer Access Attempt

## Scenario

Customer A attempts to access Customer B’s beneficiary.

## Expected Result

* Request is denied.
* No beneficiary data is returned.
* Security audit event is created.
* Actor is Customer A.
* Resource ID belongs to Customer B.
* Result is recorded as denied.
* IP, request ID, and timestamp are stored according to policy.

## Defects to Watch For

* Access is denied but not audited.
* Sensitive beneficiary data appears inside the audit metadata.
* Wrong actor ID is recorded.
* Security event cannot be correlated to the API request.

---

# Detailed Scenario 4 — Manual Wallet Adjustment

## Scenario

An authorised operations user adds **£25** to a customer wallet to correct a confirmed reconciliation exception.

## Expected Audit Record

* Operations user ID
* Customer wallet ID
* Adjustment amount
* Adjustment type
* Previous wallet balance
* New wallet balance
* Reason
* Supporting incident or ticket ID
* Approval reference
* Timestamp
* Related ledger entry

## High-Risk Defects

* Manual adjustment has no reason.
* Actor is recorded as system instead of operations user.
* Wallet changes without ledger entry.
* Audit event can be deleted.
* No approval reference exists.

---

# Audit Trail Status Transitions

Transaction status history should be reconstructable.

Example:

```text
PENDING
   ↓
PROCESSING
   ↓
FAILED
   ↓
REVERSAL_PENDING
   ↓
REVERSED
```

Each transition should capture:

* Old status
* New status
* Actor or service
* Timestamp
* Reason
* Related request
* Related provider response

Invalid transitions should be rejected and audited.

---

# Audit Trail Data Integrity Checks

## Unique Audit IDs

Every audit event should have a unique identifier.

## Non-Null Required Fields

Critical fields should not be null.

Examples:

* Actor
* Action
* Resource
* Timestamp
* Result

## Valid Resource Linkage

The referenced resource should exist or remain historically traceable.

## Accurate Previous and New Values

Changes should match the actual database state.

## Correlation IDs

Events for one workflow should share a common correlation or request ID where appropriate.

## Timestamp Ordering

Events should follow the actual sequence of actions.

---

# Audit Trail SQL Examples

The exact schema may differ.

## 1. Detect Missing Audit Events for Successful Transactions

```sql
SELECT
    t.id,
    t.reference,
    t.status
FROM transactions t
LEFT JOIN audit_logs a
    ON a.resource_type = 'TRANSACTION'
    AND a.resource_id = t.id
    AND a.action = 'TRANSACTION_COMPLETED'
WHERE t.status = 'SUCCESSFUL'
  AND a.id IS NULL;
```

Expected result:

```text
0 rows
```

---

## 2. Detect Audit Records With Missing Actors

```sql
SELECT
    id,
    event_type,
    resource_type,
    resource_id,
    created_at
FROM audit_logs
WHERE actor_id IS NULL
  AND actor_type <> 'SYSTEM';
```

Expected result:

```text
0 rows
```

---

## 3. Detect Status Changes Without Old or New Values

```sql
SELECT
    id,
    resource_id,
    action,
    previous_value,
    new_value
FROM audit_logs
WHERE action = 'STATUS_CHANGED'
  AND (
      previous_value IS NULL
      OR new_value IS NULL
  );
```

Expected result:

```text
0 rows
```

---

## 4. Detect Manual Adjustments Without Reasons

```sql
SELECT
    id,
    actor_id,
    resource_id,
    created_at
FROM audit_logs
WHERE action = 'MANUAL_WALLET_ADJUSTMENT'
  AND (
      reason IS NULL
      OR TRIM(reason) = ''
  );
```

Expected result:

```text
0 rows
```

---

## 5. Detect Financial Transactions Without Correlation IDs

```sql
SELECT
    id,
    reference,
    transaction_type,
    status
FROM transactions
WHERE correlation_id IS NULL;
```

The expected result depends on system design, but critical financial transactions should usually have a traceable identifier.

---

# Audit Trail Security Testing

Validate that:

* Customers cannot access system-wide audit logs.
* Operations users access only permitted audit data.
* Admin access is role-controlled.
* Audit exports are restricted.
* Sensitive values are masked.
* Passwords, OTPs, CVVs, tokens, and secret keys are never stored.
* Audit records cannot be altered through public APIs.
* Deletion requires approved retention procedures.
* Failed unauthorised access is itself audited.

---

# Sensitive Data That Should Not Appear

Audit records should not expose:

* Plain-text passwords
* OTP values
* Full card numbers
* CVV
* Access tokens
* Refresh tokens
* API secret keys
* Provider credentials
* Full personal data where unnecessary

Where financial identifiers must be recorded, approved masking should be used.

Example:

```text
Card: **** **** **** 4821
```

---

# Immutability Testing

Audit records should generally be append-only.

Test:

* Update existing audit record.
* Delete existing audit record.
* Change actor ID.
* Change amount.
* Change timestamp.
* Insert event through unauthorised API.

Expected result:

* Unauthorised changes are rejected.
* Attempts are logged.
* Historical records remain unchanged.

---

# Failed Action Auditing

A system should not record only successful actions.

Important failures may include:

* Failed login
* Denied access
* Rejected transfer
* Failed refund attempt
* Transfer-limit breach
* Invalid status update
* Duplicate request
* Provider failure
* Reversal failure

Recording failures supports fraud detection and investigations.

---

# Audit Trail and Reconciliation

Audit trails should support financial reconciliation by showing:

* When a transaction was created
* When a wallet changed
* When a ledger entry was written
* When a provider response arrived
* When a reversal or refund occurred
* Who performed any manual adjustment

Audit data should complement financial records, not replace them.

---

# Audit Trail and Root Cause Analysis

During RCA, audit records help reconstruct:

* The sequence of events
* The service or user that performed each action
* The state before failure
* The point where behaviour diverged
* Whether retries occurred
* Whether manual intervention happened
* Whether the same defect occurred before

Poor auditability increases investigation time and operational risk.

---

# Audit Trail Retention

Retention requirements depend on business, legal, regulatory, and operational policies.

QA should validate:

* Records remain available for the required period.
* Archived records remain searchable.
* Expired records are disposed of through approved processes.
* Retention jobs do not delete active investigation evidence.
* Exported records remain complete and secure.

---

# Audit Trail Performance Considerations

Audit logging should not:

* Block critical financial transactions unnecessarily.
* Cause duplicate financial processing.
* Lose important events under high load.
* Create unacceptable response delays.

Performance testing may verify:

* Audit records are created under concurrent requests.
* Queue-based audit processing does not lose events.
* Audit storage remains available under load.
* Financial success is not falsely reported when mandatory audit persistence fails.

---

# Audit Trail Entry Criteria

Testing can begin when:

* Audited events are defined.
* Required fields are documented.
* Roles and access permissions are known.
* Database or audit-service access is available.
* Test users and financial records exist.
* Retention and masking rules are known.
* Correlation IDs are enabled.

---

# Audit Trail Exit Criteria

Testing is complete when:

* All critical events create audit records.
* Event details match actual behaviour.
* Financial workflows are fully traceable.
* Previous and new values are accurate.
* Failed and denied actions are recorded.
* Sensitive data is protected.
* Access controls pass.
* Immutability controls pass.
* Missing or malformed audit events are resolved.
* Evidence is stored.

---

# How a QA Engineer Performs Audit Trail Validation

A QA Engineer:

* Executes business and security actions.
* Queries audit records.
* Compares events with actual system behaviour.
* Validates actors, timestamps, values, and references.
* Tests access control and masking.
* Reports missing or inaccurate events.

---

# How a Senior QA Performs Audit Trail Validation

A Senior QA Engineer:

* Defines which events are business-critical.
* Reviews audit requirements during planning.
* Connects auditability to fraud, disputes, and compliance risk.
* Validates end-to-end event sequences.
* Uses audit gaps in release-readiness decisions.
* Coordinates with Security, Operations, Product, and Engineering.

---

# How an SDET Approaches Audit Trail Validation

An SDET:

* Automates audit assertions after API actions.
* Validates event sequences and correlation IDs.
* Builds reusable database queries.
* Adds audit checks to CI.
* Tests immutability and access control.
* Creates high-volume and concurrency validation.
* Produces automated exception reports.

---

# Common Production Issues

* Successful transaction has no audit record.
* Manual wallet adjustment has no reason.
* Wrong actor is recorded.
* Status transition history is incomplete.
* Audit event contains sensitive data.
* Cross-customer access attempt is not recorded.
* Duplicate callbacks cannot be traced.
* Reversal has no original transaction link.
* Audit timestamp uses incorrect time zone.
* Audit data can be modified by unauthorised users.

---

# Common Interview Questions

## What is the purpose of an audit trail?

An audit trail provides a chronological record of important user, system, security, and financial actions so incidents, disputes, fraud, and transaction history can be investigated.

## What fields should a financial audit event contain?

It should contain the actor, action, affected resource, timestamp, result, request or correlation ID, related transaction reference, and previous and new values where applicable.

## How do you validate an audit trail?

I perform the action, query the audit record, and compare the event details with the actual API, database, wallet, ledger, and user behaviour. I also test access control, masking, immutability, and event sequencing.

## Should failed actions be audited?

Yes. Failed logins, denied access, duplicate requests, rejected financial actions, and security events are important for fraud detection and investigations.

## What should never be stored in audit logs?

Plain-text passwords, OTPs, CVVs, full tokens, secret keys, and unnecessary sensitive personal or card data should never be stored.

---

# Recruiter Talking Points

This guide demonstrates the ability to:

* Validate financial and security traceability.
* Test user, system, and administrative actions.
* Connect audit events to transactions, wallets, providers, and ledger records.
* Assess access control, immutability, masking, and retention.
* Support fraud investigation, dispute handling, reconciliation, and RCA.
* Design audit validations across API and database layers.

---

# QA Lead Conclusion

An action that changes money, customer access, account status, permissions, or transaction state should be traceable.

A strong audit trail allows the organisation to explain what happened, who performed the action, which records changed, and how the final financial state was reached.

In fintech systems, auditability is not an optional reporting feature. It is a core quality, security, operational, and trust requirement.
