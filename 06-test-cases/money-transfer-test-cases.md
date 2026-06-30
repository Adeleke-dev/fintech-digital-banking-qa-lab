# Money Transfer Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Money Transfer** module.

Money transfers are among the highest-risk workflows in a digital banking platform because they involve the movement of customer funds. Errors in this module can lead to financial loss, reconciliation issues, duplicate debits, failed transfers, or incorrect wallet balances.

The test cases focus on validating transfer accuracy, financial integrity, transaction limits, duplicate request handling, and recovery from failures.

---

# Scope

This document covers:

* Internal Wallet Transfers
* External Bank Transfers
* Beneficiary Management
* Transfer Limits
* Reversal Handling
* Duplicate Request Prevention

---

# Test Case Summary

| Test Case ID    | Test Case                                               | Priority | Risk     | Test Type                   |
| --------------- | ------------------------------------------------------- | -------- | -------- | --------------------------- |
| TC-TRANSFER-001 | Verify Successful Internal Wallet Transfer              | P1       | Critical | Functional / API / Database |
| TC-TRANSFER-002 | Verify Insufficient Balance Prevents Transfer           | P1       | Critical | Negative / API / Database   |
| TC-TRANSFER-003 | Verify Duplicate Transfer Request Does Not Double Debit | P1       | Critical | API / Database / Security   |
| TC-TRANSFER-004 | Verify Failed External Transfer After Debit Is Reversed | P1       | Critical | Functional / API / Database |
| TC-TRANSFER-005 | Verify Per-Transaction Transfer Limit Is Enforced       | P1       | High     | Functional / API            |
| TC-TRANSFER-006 | Verify Daily Transfer Limit Is Enforced                 | P1       | High     | Functional / API / Database |
| TC-TRANSFER-007 | Verify Beneficiary Ownership Is Enforced                | P1       | High     | Security / API              |
| TC-TRANSFER-008 | Verify Debit and Credit Records Remain Balanced         | P1       | Critical | Database / Reconciliation   |

---

# Detailed Test Cases

---

## TC-TRANSFER-001 — Verify Successful Internal Wallet Transfer

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-TRANSFER-001             |
| Module               | Money Transfer              |
| Related Requirement  | BR-TRANSFER-001             |
| Related User Story   | US-TRANSFER-001             |
| Related Scenario     | TS-TRANSFER-001             |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Sender and receiver wallets are active.
* Sender has sufficient balance.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Sender Balance  | ₦50,000 |
| Transfer Amount | ₦10,000 |

### Test Steps

1. Initiate an internal transfer.
2. Confirm the transfer.
3. Verify balances through the UI, API, and database.

### Expected Result

* Sender is debited ₦10,000.
* Receiver is credited ₦10,000.
* Transaction status is **SUCCESSFUL**.
* Unique transaction reference is generated.
* Transaction history is updated for both users.

### Postconditions

* Ledger remains balanced.
* Wallet balances are accurate.

---

## TC-TRANSFER-002 — Verify Insufficient Balance Prevents Transfer

| Field                | Details                   |
| -------------------- | ------------------------- |
| Test Case ID         | TC-TRANSFER-002           |
| Module               | Money Transfer            |
| Related Requirement  | BR-TRANSFER-002           |
| Related User Story   | US-TRANSFER-001           |
| Related Scenario     | TS-TRANSFER-002           |
| Priority             | P1                        |
| Risk Level           | Critical                  |
| Test Type            | Negative / API / Database |
| Automation Candidate | Yes                       |

### Preconditions

* Sender wallet balance is lower than the transfer amount.

### Test Data

| Field           | Value  |
| --------------- | ------ |
| Sender Balance  | ₦2,000 |
| Transfer Amount | ₦5,000 |

### Test Steps

1. Initiate a transfer exceeding the available balance.
2. Submit the request.
3. Verify wallet balance and transaction status.

### Expected Result

* Transfer is rejected.
* Wallet balance remains unchanged.
* Transaction is not processed.
* Clear error message is returned.

### Postconditions

* No financial records are modified.

---

## TC-TRANSFER-003 — Verify Duplicate Transfer Request Does Not Double Debit

| Field                | Details                   |
| -------------------- | ------------------------- |
| Test Case ID         | TC-TRANSFER-003           |
| Module               | Money Transfer            |
| Related Requirement  | BR-TRANSFER-003           |
| Related User Story   | US-TRANSFER-001           |
| Related Scenario     | TS-TRANSFER-003           |
| Priority             | P1                        |
| Risk Level           | Critical                  |
| Test Type            | API / Database / Security |
| Automation Candidate | Yes                       |

### Preconditions

* Sender has sufficient balance.
* Idempotency or duplicate request protection is enabled.

### Test Data

| Field           | Value                |
| --------------- | -------------------- |
| Transfer Amount | ₦15,000              |
| Request ID      | Duplicate Request ID |

### Test Steps

1. Submit a transfer request.
2. Immediately resend the same request.
3. Verify wallet balance.
4. Query transaction records.

### Expected Result

* Only one transfer is processed.
* Sender is debited once.
* Receiver is credited once.
* Duplicate request is rejected or ignored.
* Duplicate event is logged.

### Postconditions

* Wallet balances remain correct.
* No duplicate financial impact occurs.

---

## TC-TRANSFER-004 — Verify Failed External Transfer After Debit Is Reversed

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-TRANSFER-004             |
| Module               | Money Transfer              |
| Related Requirement  | BR-TRANSFER-004             |
| Related User Story   | US-TRANSFER-002             |
| Related Scenario     | TS-TRANSFER-008             |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Sender has sufficient balance.
* External transfer provider is available.

### Test Data

| Field           | Value    |
| --------------- | -------- |
| Sender Balance  | ₦100,000 |
| Transfer Amount | ₦20,000  |

### Test Steps

1. Initiate an external transfer.
2. Debit the wallet.
3. Simulate provider failure.
4. Verify reversal processing.

### Expected Result

* Initial debit occurs.
* Transfer fails.
* Reversal restores ₦20,000.
* Transaction status becomes **REVERSED**.
* Reversal is linked to the original transaction.

### Postconditions

* Customer balance is restored.
* Audit trail is complete.

---

## TC-TRANSFER-005 — Verify Per-Transaction Transfer Limit Is Enforced

| Field                | Details          |
| -------------------- | ---------------- |
| Test Case ID         | TC-TRANSFER-005  |
| Module               | Money Transfer   |
| Related Requirement  | BR-TRANSFER-005  |
| Related User Story   | US-TRANSFER-004  |
| Related Scenario     | TS-TRANSFER-009  |
| Priority             | P1               |
| Risk Level           | High             |
| Test Type            | Functional / API |
| Automation Candidate | Yes              |

### Preconditions

* Customer has sufficient balance.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Transfer Amount | ₦60,000 |
| Maximum Limit   | ₦50,000 |

### Test Steps

1. Attempt a transfer above the allowed limit.
2. Submit the request.

### Expected Result

* Transfer is rejected.
* Wallet balance remains unchanged.
* Appropriate validation message is displayed.

### Postconditions

* No debit occurs.

---

## TC-TRANSFER-006 — Verify Daily Transfer Limit Is Enforced

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-TRANSFER-006             |
| Module               | Money Transfer              |
| Related Requirement  | BR-TRANSFER-006             |
| Related User Story   | US-TRANSFER-004             |
| Related Scenario     | TS-TRANSFER-010             |
| Priority             | P1                          |
| Risk Level           | High                        |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer has already transferred ₦195,000 today.

### Test Data

| Field        | Value    |
| ------------ | -------- |
| New Transfer | ₦10,000  |
| Daily Limit  | ₦200,000 |

### Test Steps

1. Attempt another transfer.
2. Submit the request.
3. Check daily totals.

### Expected Result

* Transfer is rejected.
* Daily limit rule is enforced.
* Wallet balance remains unchanged.

### Postconditions

* Daily transfer limit remains intact.

---

## TC-TRANSFER-007 — Verify Beneficiary Ownership Is Enforced

| Field                | Details         |
| -------------------- | --------------- |
| Test Case ID         | TC-TRANSFER-007 |
| Module               | Money Transfer  |
| Related Requirement  | BR-TRANSFER-007 |
| Related User Story   | US-TRANSFER-003 |
| Related Scenario     | TS-TRANSFER-013 |
| Priority             | P1              |
| Risk Level           | High            |
| Test Type            | Security / API  |
| Automation Candidate | Yes             |

### Preconditions

* Customer A and Customer B each have saved beneficiaries.

### Test Steps

1. Authenticate as Customer A.
2. Attempt to access Customer B's beneficiary.
3. Attempt to update Customer B's beneficiary.

### Expected Result

* Access is denied.
* Update is rejected.
* Unauthorized attempt is logged.

### Postconditions

* Beneficiary ownership remains protected.

---

## TC-TRANSFER-008 — Verify Debit and Credit Records Remain Balanced

| Field                | Details                   |
| -------------------- | ------------------------- |
| Test Case ID         | TC-TRANSFER-008           |
| Module               | Money Transfer            |
| Related Requirement  | BR-TRANSFER-001           |
| Related User Story   | US-TRANSFER-001           |
| Related Scenario     | TS-TRANSFER-004           |
| Priority             | P1                        |
| Risk Level           | Critical                  |
| Test Type            | Database / Reconciliation |
| Automation Candidate | Yes                       |

### Preconditions

* Successful internal transfer has completed.

### Test Steps

1. Query sender wallet.
2. Query receiver wallet.
3. Query transaction ledger.
4. Compare debit and credit amounts.

### Expected Result

* Sender debit equals receiver credit.
* Ledger is balanced.
* Transaction references match.
* No orphan debit or credit records exist.

### Postconditions

* Financial records are suitable for reconciliation.

---

# Traceability Matrix

| Test Case       | Requirement     | User Story      | Scenario        |
| --------------- | --------------- | --------------- | --------------- |
| TC-TRANSFER-001 | BR-TRANSFER-001 | US-TRANSFER-001 | TS-TRANSFER-001 |
| TC-TRANSFER-002 | BR-TRANSFER-002 | US-TRANSFER-001 | TS-TRANSFER-002 |
| TC-TRANSFER-003 | BR-TRANSFER-003 | US-TRANSFER-001 | TS-TRANSFER-003 |
| TC-TRANSFER-004 | BR-TRANSFER-004 | US-TRANSFER-002 | TS-TRANSFER-008 |
| TC-TRANSFER-005 | BR-TRANSFER-005 | US-TRANSFER-004 | TS-TRANSFER-009 |
| TC-TRANSFER-006 | BR-TRANSFER-006 | US-TRANSFER-004 | TS-TRANSFER-010 |
| TC-TRANSFER-007 | BR-TRANSFER-007 | US-TRANSFER-003 | TS-TRANSFER-013 |
| TC-TRANSFER-008 | BR-TRANSFER-001 | US-TRANSFER-001 | TS-TRANSFER-004 |

---

# Execution Notes

During execution, record:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (screenshots, API responses, SQL query results, reconciliation queries)

