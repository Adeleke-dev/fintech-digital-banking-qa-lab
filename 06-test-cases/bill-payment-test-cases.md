# Bill Payment Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Bill Payment** module.

Bill payment is a critical fintech feature that enables customers to pay for services such as airtime, data subscriptions, and utility bills directly from their wallet. Since these transactions involve external service providers, QA must validate not only successful payments but also failures, pending responses, reversals, refunds, and reconciliation.

The test cases focus on the highest-risk bill payment scenarios.

---

# Scope

This document covers:

* Airtime Purchase
* Data Purchase
* Utility Bill Payment
* Failed Bill Payments
* Refund and Reversal Handling
* Duplicate Payment Prevention

These test cases are traceable to the Business Requirements, User Stories, Risk Register, and Test Scenarios created in previous phases.

---

# Test Case Summary

| Test Case ID | Test Case                                                         | Priority | Risk     | Test Type                   |
| ------------ | ----------------------------------------------------------------- | -------- | -------- | --------------------------- |
| TC-BILL-001  | Verify Successful Airtime Purchase                                | P1       | High     | Functional / API / Database |
| TC-BILL-002  | Verify Failed Airtime Purchase Does Not Result in Permanent Debit | P1       | Critical | Functional / API / Database |
| TC-BILL-003  | Verify Successful Utility Bill Payment                            | P1       | High     | Functional / API / Database |
| TC-BILL-004  | Verify Failed Utility Bill Payment Is Reversed or Refunded        | P1       | Critical | Functional / API / Database |
| TC-BILL-005  | Verify Duplicate Bill Payment Request Does Not Cause Double Debit | P1       | Critical | API / Database / Security   |

---

# Detailed Test Cases

---

## TC-BILL-001 — Verify Successful Airtime Purchase

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-BILL-001                 |
| Module               | Bill Payment                |
| Related Requirement  | BR-BILL-001                 |
| Related User Story   | US-BILL-001                 |
| Related Scenario     | TS-BILL-001                 |
| Priority             | P1                          |
| Risk Level           | High                        |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer is authenticated.
* Wallet has sufficient balance.
* Airtime provider is available.

### Test Data

| Field          | Value   |
| -------------- | ------- |
| Wallet Balance | ₦10,000 |
| Airtime Amount | ₦2,000  |
| Network        | MTN     |

### Test Steps

1. Select Airtime Purchase.
2. Enter valid phone number.
3. Enter ₦2,000.
4. Confirm payment.
5. Verify transaction.

### Expected Result

* Wallet is debited ₦2,000.
* Airtime purchase succeeds.
* Transaction status is **SUCCESSFUL**.
* Transaction history is updated.
* Customer receives a success notification.

### Postconditions

* Wallet balance is reduced correctly.
* Airtime transaction is available for reconciliation.

---

## TC-BILL-002 — Verify Failed Airtime Purchase Does Not Result in Permanent Debit

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-BILL-002                 |
| Module               | Bill Payment                |
| Related Requirement  | BR-BILL-002                 |
| Related User Story   | US-BILL-001                 |
| Related Scenario     | TS-BILL-003                 |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Wallet has sufficient balance.
* Provider failure can be simulated.

### Test Data

| Field          | Value   |
| -------------- | ------- |
| Wallet Balance | ₦15,000 |
| Airtime Amount | ₦5,000  |

### Test Steps

1. Initiate airtime purchase.
2. Simulate provider failure after wallet debit.
3. Verify transaction status.
4. Verify reversal or refund.

### Expected Result

* Failed purchase is recorded.
* Wallet balance is restored through reversal or refund.
* Customer does not lose money.
* Audit records are complete.

### Postconditions

* Wallet balance matches pre-transaction balance.

---

## TC-BILL-003 — Verify Successful Utility Bill Payment

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-BILL-003                 |
| Module               | Bill Payment                |
| Related Requirement  | BR-BILL-003                 |
| Related User Story   | US-BILL-003                 |
| Related Scenario     | TS-BILL-006                 |
| Priority             | P1                          |
| Risk Level           | High                        |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer has sufficient wallet balance.
* Utility provider is available.

### Test Data

| Field            | Value          |
| ---------------- | -------------- |
| Wallet Balance   | ₦30,000        |
| Bill Amount      | ₦8,500         |
| Utility Provider | Ikeja Electric |

### Test Steps

1. Select Utility Payment.
2. Enter valid account details.
3. Confirm payment.
4. Verify transaction records.

### Expected Result

* Wallet is debited correctly.
* Utility payment succeeds.
* Transaction status is **SUCCESSFUL**.
* Payment record is stored.
* Customer receives confirmation.

### Postconditions

* Utility payment is available for reconciliation.

---

## TC-BILL-004 — Verify Failed Utility Bill Payment Is Reversed or Refunded

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-BILL-004                 |
| Module               | Bill Payment                |
| Related Requirement  | BR-BILL-004                 |
| Related User Story   | US-BILL-003                 |
| Related Scenario     | TS-BILL-008                 |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Utility provider failure can be simulated.

### Test Data

| Field          | Value   |
| -------------- | ------- |
| Wallet Balance | ₦25,000 |
| Bill Amount    | ₦6,000  |

### Test Steps

1. Initiate utility payment.
2. Simulate provider failure after wallet debit.
3. Verify transaction outcome.
4. Confirm reversal or refund.

### Expected Result

* Transaction status reflects failure.
* Wallet balance returns to ₦25,000.
* Reversal or refund is linked to the original transaction.
* Customer is notified appropriately.

### Postconditions

* Customer funds are fully restored.

---

## TC-BILL-005 — Verify Duplicate Bill Payment Request Does Not Cause Double Debit

| Field                | Details                                 |
| -------------------- | --------------------------------------- |
| Test Case ID         | TC-BILL-005                             |
| Module               | Bill Payment                            |
| Related Requirement  | BR-BILL-005                             |
| Related User Story   | US-BILL-001 / US-BILL-002 / US-BILL-003 |
| Related Scenario     | TS-BILL-009                             |
| Priority             | P1                                      |
| Risk Level           | Critical                                |
| Test Type            | API / Database / Security               |
| Automation Candidate | Yes                                     |

### Preconditions

* Customer has sufficient balance.
* Duplicate request protection is enabled.

### Test Data

| Field       | Value                        |
| ----------- | ---------------------------- |
| Bill Amount | ₦4,000                       |
| Request ID  | Duplicate Request Identifier |

### Test Steps

1. Submit a bill payment request.
2. Immediately resend the same request.
3. Verify wallet balance.
4. Query payment records.

### Expected Result

* Only one payment is processed.
* Wallet is debited once.
* Duplicate request is rejected or ignored.
* Duplicate event is logged.
* No duplicate payment record exists.

### Postconditions

* Financial integrity is maintained.

---

# Traceability Matrix

| Test Case   | Requirement | User Story                              | Scenario    |
| ----------- | ----------- | --------------------------------------- | ----------- |
| TC-BILL-001 | BR-BILL-001 | US-BILL-001                             | TS-BILL-001 |
| TC-BILL-002 | BR-BILL-002 | US-BILL-001                             | TS-BILL-003 |
| TC-BILL-003 | BR-BILL-003 | US-BILL-003                             | TS-BILL-006 |
| TC-BILL-004 | BR-BILL-004 | US-BILL-003                             | TS-BILL-008 |
| TC-BILL-005 | BR-BILL-005 | US-BILL-001 / US-BILL-002 / US-BILL-003 | TS-BILL-009 |

---

# Execution Notes

During execution, record:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (screenshots, API responses, SQL query results, provider logs)

---

# Fintech QA Notes

### Why this module is critical

Bill payments integrate with external providers, making them susceptible to network issues, delayed responses, duplicate requests, and provider failures. QA must ensure that these situations never result in permanent customer financial loss.

### Production risks covered

* Double debit
* Failed payment without refund
* Incorrect wallet balance
* Provider response failures
* Duplicate payment processing
* Reconciliation mismatches

### Recruiter Talking Point

This module demonstrates the ability to validate third-party payment integrations, financial recovery mechanisms, duplicate request protection, and reconciliation readiness—skills commonly expected from QA Engineers working in digital banking and payment platforms.

