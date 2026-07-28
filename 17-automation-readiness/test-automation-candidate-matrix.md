# Test Automation Candidate Matrix

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document identifies which test scenarios should be automated, which should remain manual, and the rationale behind each decision.

The objective is to maximise automation value while minimising maintenance effort.

Automation should focus on:

* High-risk workflows
* Frequently executed tests
* Stable functionality
* Regression-heavy scenarios
* Critical business processes

Tests requiring human judgement or frequent UI changes should remain manual.

---

# Automation Priority Levels

| Priority | Description                                   |
| -------- | --------------------------------------------- |
| P1       | Automate immediately (Critical Business Flow) |
| P2       | Automate after P1                             |
| P3       | Automate later if beneficial                  |
| Manual   | Keep manual                                   |
| N/A      | Do not automate                               |

---

# Automation Decision Criteria

A scenario is a strong automation candidate if it is:

* Business critical
* Executed frequently
* Stable
* Repeatable
* Deterministic
* High regression value

Keep tests manual when they involve:

* Exploratory testing
* Visual validation
* Usability evaluation
* Accessibility assessment
* Ad-hoc investigation

---

# Automation Candidate Matrix

| Module         | Test Scenario              | Risk     | Frequency | Automation Decision | Priority | Reason                 |
| -------------- | -------------------------- | -------- | --------- | ------------------- | -------- | ---------------------- |
| Authentication | User Registration          | High     | High      | Automate            | P1       | Core business flow     |
| Authentication | Login                      | Critical | Very High | Automate            | P1       | Executed every release |
| Authentication | Logout                     | Medium   | High      | Automate            | P2       | Stable workflow        |
| Authentication | Password Reset             | High     | Medium    | Automate            | P2       | Critical recovery flow |
| Authentication | Invalid Login              | High     | High      | Automate            | P1       | Security validation    |
| Wallet         | Retrieve Wallet            | High     | High      | Automate            | P1       | Frequently executed    |
| Wallet         | View Balance               | Critical | High      | Automate            | P1       | Financial integrity    |
| Wallet         | Wallet Ownership           | Critical | High      | Automate            | P1       | Security               |
| Wallet         | Suspended Wallet           | Medium   | Medium    | Automate            | P2       | Business rule          |
| Wallet Funding | Successful Funding         | Critical | Very High | Automate            | P1       | Revenue-critical       |
| Wallet Funding | Duplicate Callback         | Critical | High      | Automate            | P1       | Prevent double credit  |
| Wallet Funding | Provider Timeout           | Critical | Medium    | Automate            | P1       | High business risk     |
| Wallet Funding | Invalid Amount             | Medium   | High      | Automate            | P2       | Input validation       |
| Wallet Funding | Failed Funding             | High     | Medium    | Automate            | P2       | Error handling         |
| Transfers      | Internal Transfer          | Critical | High      | Automate            | P1       | Core banking feature   |
| Transfers      | External Transfer          | Critical | High      | Automate            | P1       | High-risk transaction  |
| Transfers      | Insufficient Balance       | High     | High      | Automate            | P1       | Financial validation   |
| Transfers      | Daily Limit Validation     | Critical | Medium    | Automate            | P1       | Fraud prevention       |
| Transfers      | Duplicate Transfer         | Critical | Medium    | Automate            | P1       | Idempotency            |
| Transfers      | Failed Transfer Reversal   | Critical | Medium    | Automate            | P1       | Financial recovery     |
| Transactions   | View History               | Medium   | High      | Automate            | P2       | Stable API             |
| Transactions   | Status Transition          | High     | High      | Automate            | P2       | Business workflow      |
| Transactions   | Transaction Search         | Low      | Medium    | Automate            | P3       | Lower risk             |
| Transactions   | Ledger Validation          | Critical | Medium    | Automate            | P1       | Financial integrity    |
| Bill Payments  | Successful Payment         | Critical | High      | Automate            | P1       | Core payment flow      |
| Bill Payments  | Failed Payment             | High     | Medium    | Automate            | P2       | Error handling         |
| Bill Payments  | Refund Validation          | Critical | Medium    | Automate            | P1       | Financial recovery     |
| Bill Payments  | Duplicate Payment          | Critical | Medium    | Automate            | P1       | Prevent double debit   |
| Notifications  | Email Notification         | Low      | Medium    | Automate            | P3       | Stable service         |
| Notifications  | SMS Notification           | Low      | Medium    | Automate            | P3       | Stable service         |
| Notifications  | Notification Retry         | Medium   | Medium    | Automate            | P3       | Retry logic            |
| Security       | JWT Validation             | Critical | High      | Automate            | P1       | Security regression    |
| Security       | RBAC Validation            | Critical | High      | Automate            | P1       | Access control         |
| Security       | Object-Level Authorisation | Critical | High      | Automate            | P1       | Prevent data exposure  |
| Security       | Expired Token              | High     | High      | Automate            | P1       | Authentication         |
| Security       | Invalid Token              | High     | High      | Automate            | P1       | Authentication         |
| Security       | SQL Injection Validation   | High     | Medium    | Automate            | P2       | Security regression    |
| Security       | XSS Validation             | Medium   | Medium    | Automate            | P3       | Security coverage      |
| Security       | Brute Force Protection     | High     | Medium    | Automate            | P2       | Abuse prevention       |

---

# Manual Testing Candidates

These scenarios should remain manual because they require human judgement.

| Scenario                   | Reason                 |
| -------------------------- | ---------------------- |
| Exploratory testing        | Creative investigation |
| UI consistency review      | Visual judgement       |
| Accessibility review       | Human interaction      |
| User experience validation | Behavioural evaluation |
| Ad-hoc bug investigation   | Flexible exploration   |
| UAT sessions               | Business validation    |
| Documentation review       | Human interpretation   |

---

# API Automation Priority

The following APIs should be automated first:

### Authentication

* Register
* Login
* Logout
* Password Reset

### Wallet

* Get Wallet
* Get Balance

### Wallet Funding

* Successful funding
* Duplicate funding
* Invalid funding

### Transfers

* Internal transfer
* External transfer
* Failed transfer
* Duplicate transfer

### Bill Payments

* Payment
* Refund

### Security

* Authentication
* RBAC
* JWT validation
* Object-level authorisation

---

# UI Automation Priority

UI automation should focus on complete customer journeys.

## Journey 1

Customer Registration → Login → Dashboard

Priority: P1

---

## Journey 2

Login → Wallet Funding → Success Confirmation

Priority: P1

---

## Journey 3

Login → Money Transfer → Transaction History

Priority: P1

---

## Journey 4

Login → Bill Payment → Receipt

Priority: P2

---

## Journey 5

Forgot Password

Priority: P2

---

# Database Validation Automation

The following SQL validations should execute automatically after API tests:

* Wallet balance validation
* Ledger reconciliation
* Duplicate transaction detection
* Duplicate provider reference detection
* Refund validation
* Reversal validation
* Transaction history validation
* Account ownership validation

---

# Regression Automation Suite

Every release should automatically execute:

## Smoke Suite

* Registration
* Login
* Wallet retrieval
* Wallet funding
* Money transfer
* Bill payment

Expected execution time:

Less than **10 minutes**

---

## Critical Regression

* Authentication
* Wallet
* Transfers
* Payments
* Refunds
* Reversals
* Security
* SQL validation

Expected execution time:

Less than **30 minutes**

---

## Full Regression

Includes:

* Functional
* API
* Database
* Security
* Notifications

Expected execution time:

Less than **60 minutes**

---

# CI/CD Execution Matrix

| Pipeline Stage          | Automated Tests                  |
| ----------------------- | -------------------------------- |
| Pull Request            | Smoke Tests                      |
| Merge to Main           | API Regression                   |
| Nightly Build           | Full Regression                  |
| Release Candidate       | Full Regression + SQL Validation |
| Production Verification | Smoke Suite                      |

---

# Automation ROI

Highest Return on Investment:

* Authentication
* Wallet funding
* Money transfer
* Bill payment
* Security regression

Lowest ROI:

* UI cosmetic checks
* Search filters
* Static informational pages
* Frequently changing UI layouts

---

# Risks of Automating Everything

Automating every test introduces:

* High maintenance costs
* Flaky tests
* Longer execution time
* Slower feedback
* Reduced productivity

The objective is **smart automation**, not **maximum automation**.

---

# Success Metrics

Automation success will be measured using:

* Regression execution time
* Automation coverage
* Pass rate
* Flaky test percentage
* Defects detected before release
* Manual effort reduced
* Pipeline execution success
* Time to feedback

---

# Automation Roadmap

### Phase 1

* Authentication APIs
* Wallet APIs
* Smoke Suite

### Phase 2

* Wallet Funding
* Transfers
* Bill Payments

### Phase 3

* Security Regression
* SQL Validation
* Notification APIs

### Phase 4

* UI End-to-End Flows
* Performance Testing
* CI/CD Optimisation

---

# Portfolio Value

This document demonstrates the ability to:

* Evaluate automation suitability.
* Prioritise automation based on business risk.
* Balance manual and automated testing.
* Build scalable automation strategies.
* Think beyond writing automation scripts.

---

# QA Lead Conclusion

Successful automation is driven by **business value**, not by the number of automated tests.

For a fintech platform, the first priority should always be protecting customer funds, validating financial integrity, enforcing security controls, and ensuring rapid regression feedback for the workflows that matter most.
