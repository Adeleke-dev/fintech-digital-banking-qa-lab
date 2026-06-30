# Exploratory Testing Charters

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains structured exploratory testing charters for the Fintech Digital Banking QA Lab.

Each charter is a focused, time-boxed testing session designed to investigate high-risk areas that may not be fully covered by scripted test cases.

---

# Session Structure

Each exploratory testing session contains:

* Charter ID
* Module
* Mission
* Business Risk
* Time Box
* Test Data
* Areas to Explore
* Expected Observations
* Evidence to Capture
* Possible Defects

---

# Charter 1 — Authentication

### Charter ID

**ET-AUTH-001**

### Mission

Explore customer registration, OTP verification, login, password reset, and session management for unexpected authentication behavior.

### Business Risk

Unauthorized access to customer accounts.

### Time Box

60 Minutes

### Test Data

* Valid customer
* Invalid customer
* Expired OTP
* Invalid OTP
* Locked account

### Areas to Explore

* Multiple OTP submissions
* Browser refresh during OTP verification
* Login after password reset
* Concurrent login sessions
* Session expiration
* Login from different devices
* Password complexity validation

### Expected Observations

* Authentication behaves consistently.
* Invalid credentials are rejected.
* Sessions expire correctly.
* Security controls prevent unauthorized access.

### Evidence to Capture

* API responses
* Screenshots
* Authentication logs
* SQL validation

### Possible Defects

* OTP reused
* Multiple active sessions
* Session never expires
* Invalid login accepted

---

# Charter 2 — Wallet Management

### Charter ID

**ET-WALLET-001**

### Mission

Explore wallet creation, wallet balance consistency, and transaction history under normal and unusual user behavior.

### Business Risk

Incorrect customer balance.

### Time Box

60 Minutes

### Areas to Explore

* Wallet creation timing
* Multiple browser refreshes
* Balance updates after transactions
* Transaction history ordering
* Missing transactions
* Wallet ownership validation

### Expected Observations

* Wallet created once.
* Balance remains accurate.
* History reflects completed transactions only.

### Possible Defects

* Duplicate wallet
* Incorrect balance
* Missing history
* Cross-customer wallet access

---

# Charter 3 — Wallet Funding

### Charter ID

**ET-FUND-001**

### Mission

Investigate wallet funding behavior under provider delays, failures, duplicate callbacks, and interrupted payment flows.

### Business Risk

Customer receives incorrect wallet credit.

### Time Box

90 Minutes

### Areas to Explore

* Payment timeout
* Duplicate callback
* Browser closed during payment
* Delayed callback
* Failed callback after debit
* Retry payment
* Simultaneous funding requests

### Expected Observations

* Wallet credited only after successful confirmation.
* Duplicate callbacks do not create duplicate credits.
* Failed funding does not affect balance.

### Possible Defects

* Double credit
* Missing transaction
* Wallet credited before confirmation
* Incorrect transaction status

---

# Charter 4 — Money Transfers

### Charter ID

**ET-TRANSFER-001**

### Mission

Explore internal and external transfer workflows, focusing on financial integrity and fraud prevention.

### Business Risk

Loss of customer funds.

### Time Box

90 Minutes

### Areas to Explore

* Concurrent transfers
* Rapid repeated clicks
* Network interruption
* Transfer retry
* Duplicate requests
* Beneficiary validation
* Transfer limit boundaries

### Expected Observations

* Duplicate transfers prevented.
* Wallet balances remain correct.
* Failed transfers reverse correctly.

### Possible Defects

* Double debit
* Missing reversal
* Incorrect beneficiary
* Transfer exceeds limit

---

# Charter 5 — Transaction Processing

### Charter ID

**ET-TXN-001**

### Mission

Investigate transaction lifecycle management from initiation through completion, reversal, refund, and reconciliation.

### Business Risk

Financial records become inconsistent.

### Time Box

90 Minutes

### Areas to Explore

* Status transitions
* Duplicate transaction references
* Refund timing
* Reversal timing
* Transaction lookup
* Audit records
* Transaction history

### Expected Observations

* Valid status transitions only.
* Every transaction has a unique reference.
* Reversals and refunds remain traceable.

### Possible Defects

* Duplicate references
* Missing refund
* Invalid status transition
* Orphan transaction

---

# Charter 6 — Bill Payments

### Charter ID

**ET-BILL-001**

### Mission

Explore airtime, data, and utility bill payment workflows with provider interruptions and recovery scenarios.

### Business Risk

Customer pays but service is not delivered.

### Time Box

75 Minutes

### Areas to Explore

* Provider timeout
* Failed callback
* Duplicate payment
* Retry payment
* Delayed confirmation
* Incorrect provider response

### Expected Observations

* Failed payments are reversed or refunded.
* Duplicate requests do not create duplicate debits.
* Payment records remain accurate.

### Possible Defects

* Double debit
* Missing refund
* Incorrect provider status
* Duplicate payment

---

# Charter 7 — Notifications

### Charter ID

**ET-NOTIF-001**

### Mission

Explore notification delivery, timing, and content across email, SMS, and push channels.

### Business Risk

Customer receives incorrect or missing financial notifications.

### Time Box

45 Minutes

### Areas to Explore

* Delayed notifications
* Notification retry
* Incorrect transaction details
* Duplicate notifications
* Missing notifications

### Expected Observations

* Notifications match transaction data.
* Failed notification does not affect transaction processing.

### Possible Defects

* Wrong amount
* Wrong status
* Duplicate notification
* Missing notification

---

# Charter 8 — Security and Fraud Prevention

### Charter ID

**ET-SEC-001**

### Mission

Explore authentication, authorization, fraud detection, and abuse scenarios to identify security weaknesses.

### Business Risk

Unauthorized financial access or fraud.

### Time Box

90 Minutes

### Areas to Explore

* Expired tokens
* Invalid tokens
* Missing authentication
* Access to another customer's data
* Duplicate API requests
* Rapid transfer attempts
* Authorization boundaries

### Expected Observations

* Unauthorized requests are rejected.
* Fraud controls activate as expected.
* Sensitive customer data remains protected.

### Possible Defects

* Unauthorized access
* Duplicate processing
* Missing audit logs
* Broken access control

---

# Session Report Template

Complete the following after each exploratory session.

| Field            | Description                                |
| ---------------- | ------------------------------------------ |
| Charter ID       | Reference to the exploratory session       |
| Tester           | QA Engineer                                |
| Date             | Execution date                             |
| Time Spent       | Actual duration                            |
| Environment      | QA / Staging                               |
| Areas Covered    | Summary of exploration                     |
| Observations     | Key findings                               |
| Defects Found    | Number and IDs                             |
| Risks Identified | New risks discovered                       |
| Recommendations  | Improvements for product or future testing |

---

# Recruiter Talking Points

This document demonstrates the ability to:

* Conduct structured exploratory testing.
* Investigate high-risk fintech workflows.
* Think beyond predefined test cases.
* Discover production defects through experience-driven exploration.
* Apply risk-based testing to financial systems.

---

# Exit Criteria

Exploratory testing is complete when:

* All planned charters have been executed.
* High-risk areas have been explored.
* Findings have been documented.
* Relevant defects have been logged.
* Evidence has been captured.
* Recommendations have been communicated to stakeholders.
