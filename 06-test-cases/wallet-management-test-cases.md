# Wallet Management Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Wallet Management** module.

The Wallet Management module is responsible for creating customer wallets, maintaining accurate wallet balances, and providing a complete transaction history. Since wallet balances represent customer funds, this module is one of the most critical areas of the application.

The test cases focus on the highest-risk scenarios that could lead to incorrect balances, duplicate wallets, or inaccurate transaction history.

---

# Scope

This document covers:

* Wallet Creation
* Wallet Balance
* Wallet History

These test cases are traceable to the Business Requirements, User Stories, Risk Register, and Test Scenarios created in previous phases.

---

# Test Case Summary

| Test Case ID  | Test Case                                                   | Priority | Risk     | Test Type                   |
| ------------- | ----------------------------------------------------------- | -------- | -------- | --------------------------- |
| TC-WALLET-001 | Verify Wallet Is Created After OTP Verification             | P1       | High     | Functional / Database       |
| TC-WALLET-002 | Verify Duplicate Wallet Is Not Created                      | P1       | Critical | Database / API              |
| TC-WALLET-003 | Verify Wallet Balance Updates After Successful Credit       | P1       | Critical | Functional / API / Database |
| TC-WALLET-004 | Verify Failed Transaction Does Not Change Wallet Balance    | P1       | Critical | Functional / API / Database |
| TC-WALLET-005 | Verify Wallet History Displays Accurate Transaction Records | P2       | High     | Functional / Database       |

---

# Detailed Test Cases

---

## TC-WALLET-001 — Verify Wallet Is Created After OTP Verification

| Field                | Details               |
| -------------------- | --------------------- |
| Test Case ID         | TC-WALLET-001         |
| Module               | Wallet Management     |
| Related Requirement  | BR-WALLET-001         |
| Related User Story   | US-WALLET-001         |
| Related Scenario     | TS-WALLET-001         |
| Priority             | P1                    |
| Risk Level           | High                  |
| Test Type            | Functional / Database |
| Automation Candidate | Yes                   |

### Preconditions

* Customer has completed registration.
* Customer has successfully verified their OTP.

### Test Data

| Field    | Value             |
| -------- | ----------------- |
| Customer | Verified Customer |

### Test Steps

1. Complete OTP verification.
2. Open the wallet dashboard.
3. Query the wallet table in the database.

### Expected Result

* A wallet is created automatically.
* Wallet is linked to the correct customer.
* Initial wallet balance is **₦0.00**.
* Only one wallet exists for the customer.

### Postconditions

* Wallet is active and available for transactions.

---

## TC-WALLET-002 — Verify Duplicate Wallet Is Not Created

| Field                | Details           |
| -------------------- | ----------------- |
| Test Case ID         | TC-WALLET-002     |
| Module               | Wallet Management |
| Related Requirement  | BR-WALLET-001     |
| Related User Story   | US-WALLET-001     |
| Related Scenario     | TS-WALLET-003     |
| Priority             | P1                |
| Risk Level           | Critical          |
| Test Type            | Database / API    |
| Automation Candidate | Yes               |

### Preconditions

* Customer already has an active wallet.

### Test Data

| Field       | Value             |
| ----------- | ----------------- |
| Customer ID | Existing Customer |

### Test Steps

1. Attempt to trigger wallet creation again using the same customer.
2. Query the wallet table.
3. Count wallet records linked to the customer.

### Expected Result

* No duplicate wallet is created.
* Only one wallet exists for the customer.
* Existing wallet remains unchanged.

### Postconditions

* Wallet uniqueness is maintained.

---

## TC-WALLET-003 — Verify Wallet Balance Updates After Successful Credit

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-WALLET-003               |
| Module               | Wallet Management           |
| Related Requirement  | BR-WALLET-002               |
| Related User Story   | US-WALLET-002               |
| Related Scenario     | TS-WALLET-005               |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer has an active wallet.
* Wallet balance is known before funding.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Initial Balance | ₦10,000 |
| Credit Amount   | ₦5,000  |

### Test Steps

1. Complete a successful wallet funding transaction.
2. Retrieve wallet balance from the UI.
3. Retrieve wallet balance through the API.
4. Query the wallet balance in the database.

### Expected Result

* Wallet balance increases by ₦5,000.
* UI, API, and database all display **₦15,000**.
* Transaction history records the successful credit.

### Postconditions

* Updated wallet balance is persisted.

---

## TC-WALLET-004 — Verify Failed Transaction Does Not Change Wallet Balance

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-WALLET-004               |
| Module               | Wallet Management           |
| Related Requirement  | BR-WALLET-002               |
| Related User Story   | US-WALLET-002               |
| Related Scenario     | TS-WALLET-007               |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer has an active wallet.
* Current wallet balance is known.

### Test Data

| Field                     | Value   |
| ------------------------- | ------- |
| Current Balance           | ₦15,000 |
| Failed Transaction Amount | ₦3,000  |

### Test Steps

1. Initiate a transaction that is forced to fail.
2. Verify transaction status becomes **FAILED**.
3. Check wallet balance in the UI.
4. Verify balance through the API.
5. Query the database.

### Expected Result

* Wallet balance remains **₦15,000**.
* Transaction status is **FAILED**.
* No debit or credit is applied.
* Financial records remain consistent.

### Postconditions

* Wallet balance remains unchanged.

---

## TC-WALLET-005 — Verify Wallet History Displays Accurate Transaction Records

| Field                | Details               |
| -------------------- | --------------------- |
| Test Case ID         | TC-WALLET-005         |
| Module               | Wallet Management     |
| Related Requirement  | BR-WALLET-003         |
| Related User Story   | US-WALLET-003         |
| Related Scenario     | TS-WALLET-008         |
| Priority             | P2                    |
| Risk Level           | High                  |
| Test Type            | Functional / Database |
| Automation Candidate | Yes                   |

### Preconditions

* Customer has completed multiple transactions.

### Test Data

| Transaction Types |
| ----------------- |
| Credit            |
| Debit             |
| Failed            |
| Reversed          |
| Refunded          |

### Test Steps

1. Open wallet history.
2. Review all transaction records.
3. Compare displayed records with database records.

### Expected Result

* Wallet history displays all completed transactions.
* Each record contains:

  * Transaction Reference
  * Transaction Type
  * Amount
  * Date and Time
  * Status
* Database records match the UI.
* No transactions belonging to another customer are displayed.

### Postconditions

* Wallet history remains accurate and traceable.

---

# Traceability Matrix

| Test Case     | Requirement   | User Story    | Scenario      |
| ------------- | ------------- | ------------- | ------------- |
| TC-WALLET-001 | BR-WALLET-001 | US-WALLET-001 | TS-WALLET-001 |
| TC-WALLET-002 | BR-WALLET-001 | US-WALLET-001 | TS-WALLET-003 |
| TC-WALLET-003 | BR-WALLET-002 | US-WALLET-002 | TS-WALLET-005 |
| TC-WALLET-004 | BR-WALLET-002 | US-WALLET-002 | TS-WALLET-007 |
| TC-WALLET-005 | BR-WALLET-003 | US-WALLET-003 | TS-WALLET-008 |

---

# Execution Notes

During execution, capture:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (screenshots, API responses, SQL query results)

