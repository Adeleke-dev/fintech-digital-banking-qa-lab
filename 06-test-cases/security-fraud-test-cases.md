# Security and Fraud Prevention Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Security and Fraud Prevention** module.

Security is one of the most critical aspects of any digital banking platform. The objective is to ensure that only authorized users can access financial resources, while preventing fraud, duplicate financial requests, account compromise, and unauthorized transactions.

The test cases focus on validating authentication, authorization, session security, duplicate request prevention, fraud detection, and protection of customer financial data.

---

# Scope

This document covers:

* Authentication Security
* Authorization
* Session Security
* Duplicate Request Prevention
* Fraud Detection
* Financial Data Protection

These test cases are traceable to the Business Requirements, User Stories, Risk Register, and Test Scenarios developed in previous phases.

---

# Test Case Summary

| Test Case ID | Test Case                                                 | Priority | Risk     | Test Type                 |
| ------------ | --------------------------------------------------------- | -------- | -------- | ------------------------- |
| TC-SEC-001   | Verify Unauthorized User Cannot Access Protected APIs     | P1       | Critical | Security / API            |
| TC-SEC-002   | Verify Customer Cannot Access Another Customer's Wallet   | P1       | Critical | Security / API            |
| TC-SEC-003   | Verify Expired JWT Token Is Rejected                      | P1       | Critical | Security / API            |
| TC-SEC-004   | Verify Duplicate Financial Request Is Processed Only Once | P1       | Critical | API / Database / Security |
| TC-SEC-005   | Verify Rapid Transfer Attempts Trigger Fraud Controls     | P1       | High     | Security / Integration    |
| TC-SEC-006   | Verify Audit Trail Captures Security-Sensitive Activities | P1       | High     | Database / Audit          |

---

# Detailed Test Cases

---

## TC-SEC-001 — Verify Unauthorized User Cannot Access Protected APIs

| Field                | Details                       |
| -------------------- | ----------------------------- |
| Test Case ID         | TC-SEC-001                    |
| Module               | Security and Fraud Prevention |
| Related Requirement  | BR-SEC-001                    |
| Related User Story   | US-SEC-001                    |
| Related Scenario     | TS-SEC-003                    |
| Priority             | P1                            |
| Risk Level           | Critical                      |
| Test Type            | Security / API                |
| Automation Candidate | Yes                           |

### Preconditions

* Protected APIs are available.

### Test Data

| Field        | Value |
| ------------ | ----- |
| Access Token | None  |

### Test Steps

1. Send a request to a protected API without authentication.
2. Observe the API response.
3. Verify that no sensitive data is returned.

### Expected Result

* API returns **401 Unauthorized**.
* No protected information is exposed.
* No business operation is executed.
* Unauthorized request is logged according to security policy.

### Postconditions

* System remains secure.
* No financial data is disclosed.

---

## TC-SEC-002 — Verify Customer Cannot Access Another Customer's Wallet

| Field                | Details                       |
| -------------------- | ----------------------------- |
| Test Case ID         | TC-SEC-002                    |
| Module               | Security and Fraud Prevention |
| Related Requirement  | BR-SEC-002                    |
| Related User Story   | US-SEC-002                    |
| Related Scenario     | TS-SEC-004                    |
| Priority             | P1                            |
| Risk Level           | Critical                      |
| Test Type            | Security / API                |
| Automation Candidate | Yes                           |

### Preconditions

* Customer A and Customer B both have active wallets.

### Test Data

| Field              | Value      |
| ------------------ | ---------- |
| Authenticated User | Customer A |
| Target Wallet      | Customer B |

### Test Steps

1. Authenticate as Customer A.
2. Attempt to retrieve Customer B's wallet information.
3. Attempt to retrieve Customer B's wallet history.

### Expected Result

* Access is denied.
* API returns **403 Forbidden** (or the application's defined authorization response).
* Customer B's financial data is never exposed.
* Authorization failure is logged.

### Postconditions

* Customer data remains protected.

---

## TC-SEC-003 — Verify Expired JWT Token Is Rejected

| Field                | Details                       |
| -------------------- | ----------------------------- |
| Test Case ID         | TC-SEC-003                    |
| Module               | Security and Fraud Prevention |
| Related Requirement  | BR-SEC-003                    |
| Related User Story   | US-SEC-001                    |
| Related Scenario     | TS-SEC-001                    |
| Priority             | P1                            |
| Risk Level           | Critical                      |
| Test Type            | Security / API                |
| Automation Candidate | Yes                           |

### Preconditions

* User previously authenticated.
* JWT token has expired.

### Test Data

| Field        | Value       |
| ------------ | ----------- |
| Access Token | Expired JWT |

### Test Steps

1. Send a request to a protected endpoint using the expired token.
2. Observe the response.

### Expected Result

* Request is rejected.
* API returns **401 Unauthorized**.
* User is required to authenticate again.
* No protected action is performed.

### Postconditions

* Expired session cannot access protected resources.

---

## TC-SEC-004 — Verify Duplicate Financial Request Is Processed Only Once

| Field                | Details                       |
| -------------------- | ----------------------------- |
| Test Case ID         | TC-SEC-004                    |
| Module               | Security and Fraud Prevention |
| Related Requirement  | BR-SEC-004                    |
| Related User Story   | US-SEC-003                    |
| Related Scenario     | TS-SEC-007                    |
| Priority             | P1                            |
| Risk Level           | Critical                      |
| Test Type            | API / Database / Security     |
| Automation Candidate | Yes                           |

### Preconditions

* Customer has sufficient balance.
* Duplicate request protection (idempotency) is enabled.

### Test Data

| Field              | Value         |
| ------------------ | ------------- |
| Transaction Amount | ₦10,000       |
| Idempotency Key    | Duplicate Key |

### Test Steps

1. Submit a financial transaction.
2. Immediately resend the same request with the same idempotency key.
3. Verify wallet balance.
4. Query transaction records.

### Expected Result

* Only one transaction is processed.
* Wallet is debited only once.
* Duplicate request is rejected or safely ignored.
* Duplicate request is logged for investigation.

### Postconditions

* No duplicate financial impact occurs.

---

## TC-SEC-005 — Verify Rapid Transfer Attempts Trigger Fraud Controls

| Field                | Details                       |
| -------------------- | ----------------------------- |
| Test Case ID         | TC-SEC-005                    |
| Module               | Security and Fraud Prevention |
| Related Requirement  | BR-SEC-005                    |
| Related User Story   | US-SEC-003                    |
| Related Scenario     | TS-SEC-006                    |
| Priority             | P1                            |
| Risk Level           | High                          |
| Test Type            | Security / Integration        |
| Automation Candidate | Yes                           |

### Preconditions

* Fraud monitoring or rate-limiting rules are enabled.

### Test Data

| Field             | Value                   |
| ----------------- | ----------------------- |
| Transfer Attempts | Multiple rapid requests |

### Test Steps

1. Submit multiple transfer requests in rapid succession.
2. Observe system behavior.
3. Review fraud or security logs.

### Expected Result

* Fraud controls or rate limits are triggered according to business rules.
* Excess requests are rejected, delayed, or flagged.
* Legitimate completed transactions remain accurate.
* Fraud event is recorded for investigation.

### Postconditions

* Fraud controls operate without compromising valid financial records.

---

## TC-SEC-006 — Verify Audit Trail Captures Security-Sensitive Activities

| Field                | Details                       |
| -------------------- | ----------------------------- |
| Test Case ID         | TC-SEC-006                    |
| Module               | Security and Fraud Prevention |
| Related Requirement  | BR-SEC-006                    |
| Related User Story   | US-SEC-004                    |
| Related Scenario     | TS-TXN-006                    |
| Priority             | P1                            |
| Risk Level           | High                          |
| Test Type            | Database / Audit              |
| Automation Candidate | Yes                           |

### Preconditions

* Audit logging is enabled.

### Test Data

| Activities            |
| --------------------- |
| Login                 |
| Failed Login          |
| Password Reset        |
| Transfer              |
| Wallet Funding        |
| Authorization Failure |

### Test Steps

1. Perform the listed activities.
2. Query audit logs.
3. Compare audit records with executed actions.

### Expected Result

Audit records contain:

* Timestamp
* User ID
* Activity performed
* Transaction reference (where applicable)
* Result (Success/Failure)
* Source information (if captured)

No expected audit record is missing.

### Postconditions

* Security investigation and compliance requirements are supported.

---

# Traceability Matrix

| Test Case  | Requirement | User Story | Scenario   |
| ---------- | ----------- | ---------- | ---------- |
| TC-SEC-001 | BR-SEC-001  | US-SEC-001 | TS-SEC-003 |
| TC-SEC-002 | BR-SEC-002  | US-SEC-002 | TS-SEC-004 |
| TC-SEC-003 | BR-SEC-003  | US-SEC-001 | TS-SEC-001 |
| TC-SEC-004 | BR-SEC-004  | US-SEC-003 | TS-SEC-007 |
| TC-SEC-005 | BR-SEC-005  | US-SEC-003 | TS-SEC-006 |
| TC-SEC-006 | BR-SEC-006  | US-SEC-004 | TS-TXN-006 |

---

# Execution Notes

During execution, record:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (API responses, audit logs, SQL query results, security logs)

---

# Fintech QA Notes

### Why this module is critical

Financial platforms are attractive targets for fraud and unauthorized access. Security testing ensures customer funds, personal information, and transaction integrity are protected while supporting regulatory compliance and operational investigations.

### Production risks covered

* Unauthorized API access
* Cross-customer data exposure
* Expired session misuse
* Duplicate transaction processing
* Fraudulent rapid transaction attempts
* Missing audit records

### Recruiter Talking Point

This module demonstrates practical experience in validating authentication, authorization, API security, idempotency, fraud prevention controls, and audit trail completeness. These are essential quality assurance responsibilities in digital banking, payment processing, and financial technology platforms.

