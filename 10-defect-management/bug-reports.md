# Bug Reports

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains detailed bug reports identified during Sprint 1 testing.

Each report follows a standard defect reporting format commonly used in Jira, Azure DevOps, and other defect management tools.

---

# BUG-001

## Title

**Duplicate wallet credit after payment gateway callback retry**

### Module

Wallet Funding

### Environment

QA

### Severity

Critical

### Priority

P1

### Status

Fixed

### Reported By

QA Engineer

### Preconditions

* Customer has an active wallet.
* Wallet balance is ₦10,000.
* Payment provider supports callback retries.

### Steps to Reproduce

1. Initiate wallet funding of ₦5,000.
2. Complete payment successfully.
3. Simulate the payment gateway sending the same callback twice.
4. Refresh the wallet balance.

### Expected Result

* Wallet should be credited only once.
* Duplicate callback should be ignored.
* Only one successful transaction should exist.

### Actual Result

* Wallet was credited twice.
* Two successful ledger credit entries were created.
* Wallet balance became ₦20,000 instead of ₦15,000.

### Business Impact

Customers can receive excess funds, resulting in financial loss and reconciliation issues.

### Evidence

* API response
* SQL query result
* Wallet balance screenshot

---

# BUG-002

## Title

**Failed external transfer did not reverse wallet debit**

### Module

Money Transfers

### Environment

QA

### Severity

Critical

### Priority

P1

### Status

Ready for QA

### Preconditions

* Customer wallet balance is ₦100,000.
* External banking provider is available.

### Steps to Reproduce

1. Initiate an external transfer of ₦20,000.
2. Simulate provider failure after wallet debit.
3. Review wallet balance and transaction history.

### Expected Result

* Wallet should be automatically reversed.
* Transaction should be marked **REVERSED** or **FAILED** according to business rules.

### Actual Result

* Wallet remained debited.
* No reversal transaction was created.

### Business Impact

Customer funds remain unavailable despite transfer failure.

### Evidence

* API response
* Transaction log
* SQL validation

---

# BUG-003

## Title

**Expired JWT token still grants access to Wallet Balance API**

### Module

Authentication / Security

### Environment

QA

### Severity

Critical

### Priority

P1

### Status

Closed

### Preconditions

* JWT token has expired.

### Steps to Reproduce

1. Authenticate successfully.
2. Wait for the token to expire.
3. Call the Wallet Balance API.

### Expected Result

* API should return **401 Unauthorized**.
* No wallet information should be returned.

### Actual Result

* API returned **200 OK**.
* Wallet balance was exposed.

### Business Impact

Unauthorized users may access sensitive financial information.

### Evidence

* Postman response
* Authentication logs

---

# BUG-004

## Title

**Transaction remains PENDING after successful provider callback**

### Module

Transaction Processing

### Environment

QA

### Severity

High

### Priority

P1

### Status

Fixed

### Preconditions

* Provider callback endpoint available.

### Steps to Reproduce

1. Complete wallet funding.
2. Provider returns successful callback.
3. Query transaction status.

### Expected Result

Transaction status changes to **SUCCESSFUL**.

### Actual Result

Transaction status remains **PENDING**.

### Business Impact

Customers receive incorrect transaction status, causing reconciliation issues and increased support requests.

### Evidence

* API response
* Database query
* Transaction history

---

# BUG-005

## Title

**Daily transfer limit validation ignores cumulative transfers**

### Module

Money Transfers

### Environment

QA

### Severity

High

### Priority

P2

### Status

In Progress

### Preconditions

* Daily transfer limit is ₦200,000.

### Steps to Reproduce

1. Transfer ₦80,000.
2. Transfer another ₦80,000.
3. Transfer an additional ₦60,000.

### Expected Result

The third transfer should be rejected because the daily limit would be exceeded.

### Actual Result

All transfers were processed successfully.

### Business Impact

Customers can exceed configured transfer limits, increasing fraud and compliance risk.

### Evidence

* API responses
* SQL query results

---

# BUG-006

## Title

**Customer can access another customer's saved beneficiary**

### Module

Money Transfers

### Environment

QA

### Severity

Critical

### Priority

P1

### Status

Closed

### Preconditions

* Customer A and Customer B have saved beneficiaries.

### Steps to Reproduce

1. Authenticate as Customer A.
2. Call the Beneficiary API using Customer B's beneficiary identifier.

### Expected Result

API should deny access with **403 Forbidden**.

### Actual Result

Beneficiary details belonging to Customer B were returned.

### Business Impact

Sensitive customer information is exposed, resulting in a serious privacy and security issue.

### Evidence

* API response
* Security test logs

---

# BUG-007

## Title

**Refund amount exceeds original transaction amount**

### Module

Transaction Processing

### Environment

QA

### Severity

Critical

### Priority

P1

### Status

Assigned

### Preconditions

* Original bill payment of ₦8,000 exists.

### Steps to Reproduce

1. Process a refund.
2. Query refund transaction.

### Expected Result

Refund amount should equal the original payment amount.

### Actual Result

Refund amount was ₦8,500.

### Business Impact

Incorrect refunds create direct financial loss and reconciliation discrepancies.

### Evidence

* SQL query
* Refund API response

---

# BUG-008

## Title

**Notification failure incorrectly changes transaction status to FAILED**

### Module

Notifications

### Environment

QA

### Severity

High

### Priority

P2

### Status

Fixed

### Preconditions

* Notification service is unavailable.

### Steps to Reproduce

1. Complete a successful wallet funding transaction.
2. Simulate notification service failure.
3. Review transaction status.

### Expected Result

Transaction remains **SUCCESSFUL** even if notification delivery fails.

### Actual Result

Transaction status changed to **FAILED** because notification processing failed.

### Business Impact

Customers receive incorrect transaction information, increasing support requests and reducing trust.

### Evidence

* Notification logs
* API response
* Database validation

---

# Summary

| Metric            | Value |
| ----------------- | ----: |
| Total Bug Reports |     8 |
| Critical          |     5 |
| High              |     3 |
| Medium            |     0 |
| Low               |     0 |

---

# QA Lead Observations

The majority of defects discovered during Sprint 1 affect financial integrity and application security.

The highest-risk issues involve:

* Duplicate wallet credits
* Missing transaction reversals
* Authorization failures
* Incorrect refund calculations
* Transfer limit enforcement

These defects would require immediate attention before approving a production release due to their potential financial and security impact.
