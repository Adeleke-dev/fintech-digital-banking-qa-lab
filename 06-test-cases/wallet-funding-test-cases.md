# Wallet Funding Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Wallet Funding** module.

Wallet funding is one of the highest-risk areas in a fintech application because it directly affects customer balances and financial records. Incorrect handling of funding requests can result in duplicate credits, reconciliation issues, financial loss, and customer complaints.

The test cases in this document focus on the highest-risk funding scenarios.

---

# Scope

This document covers:

* Card Funding
* Bank Transfer Funding
* Pending Funding
* Failed Funding
* Duplicate Callback Prevention
* Funding Notifications

---

# Test Case Summary

| Test Case ID | Test Case                                                        | Priority | Risk     | Test Type                   |
| ------------ | ---------------------------------------------------------------- | -------- | -------- | --------------------------- |
| TC-FUND-001  | Verify Successful Card Funding                                   | P1       | Critical | Functional / API / Database |
| TC-FUND-002  | Verify Failed Card Funding Does Not Credit Wallet                | P1       | Critical | Negative / API / Database   |
| TC-FUND-003  | Verify Pending Funding Does Not Credit Wallet Until Confirmation | P1       | Critical | API / Database              |
| TC-FUND-004  | Verify Duplicate Provider Callback Does Not Double Credit Wallet | P1       | Critical | API / Database              |
| TC-FUND-005  | Verify Successful Bank Transfer Funding                          | P1       | Critical | Functional / API / Database |
| TC-FUND-006  | Verify Delayed Provider Confirmation Keeps Transaction Pending   | P1       | High     | API / Database              |
| TC-FUND-007  | Verify Transaction Record Matches Wallet Credit                  | P1       | Critical | Database                    |
| TC-FUND-008  | Verify Funding Notification Contains Accurate Details            | P2       | Medium   | Functional                  |

---

# Detailed Test Cases

---

## TC-FUND-001 — Verify Successful Card Funding

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-FUND-001                 |
| Module               | Wallet Funding              |
| Related Requirement  | BR-FUND-001                 |
| Related User Story   | US-FUND-001                 |
| Related Scenario     | TS-FUND-001                 |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer is authenticated.
* Wallet is active.
* Initial wallet balance is known.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Initial Balance | ₦10,000 |
| Funding Amount  | ₦5,000  |

### Test Steps

1. Initiate card funding.
2. Complete payment successfully.
3. Retrieve wallet balance from the UI.
4. Verify the funding API response.
5. Query the wallet and transaction tables.

### Expected Result

* Funding transaction is successful.
* Wallet balance increases to ₦15,000.
* Transaction status is **SUCCESSFUL**.
* A unique transaction reference is generated.
* UI, API, and database values are consistent.

### Postconditions

* Wallet reflects the new balance.
* Funding record is available for reconciliation.

---

## TC-FUND-002 — Verify Failed Card Funding Does Not Credit Wallet

| Field                | Details                   |
| -------------------- | ------------------------- |
| Test Case ID         | TC-FUND-002               |
| Module               | Wallet Funding            |
| Related Requirement  | BR-FUND-002               |
| Related User Story   | US-FUND-003               |
| Related Scenario     | TS-FUND-002               |
| Priority             | P1                        |
| Risk Level           | Critical                  |
| Test Type            | Negative / API / Database |
| Automation Candidate | Yes                       |

### Preconditions

* Customer has an active wallet.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Initial Balance | ₦10,000 |
| Funding Amount  | ₦5,000  |

### Test Steps

1. Initiate card funding.
2. Simulate provider failure.
3. Verify transaction status.
4. Check wallet balance.
5. Query database records.

### Expected Result

* Transaction status becomes **FAILED**.
* Wallet balance remains ₦10,000.
* No credit entry is recorded.
* Failure is logged correctly.

### Postconditions

* Wallet balance remains unchanged.

---

## TC-FUND-003 — Verify Pending Funding Does Not Credit Wallet Until Confirmation

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-FUND-003    |
| Module               | Wallet Funding |
| Related Requirement  | BR-FUND-003    |
| Related User Story   | US-FUND-002    |
| Related Scenario     | TS-FUND-003    |
| Priority             | P1             |
| Risk Level           | Critical       |
| Test Type            | API / Database |
| Automation Candidate | Yes            |

### Preconditions

* Payment request has been initiated.
* Provider confirmation has not been received.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Initial Balance | ₦20,000 |
| Funding Amount  | ₦7,500  |

### Test Steps

1. Initiate wallet funding.
2. Leave provider response in **PENDING** state.
3. Check wallet balance.
4. Query transaction status.

### Expected Result

* Transaction status remains **PENDING**.
* Wallet balance remains unchanged.
* No credit is applied until successful confirmation.

### Postconditions

* Pending transaction awaits provider callback.

---

## TC-FUND-004 — Verify Duplicate Provider Callback Does Not Double Credit Wallet

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-FUND-004    |
| Module               | Wallet Funding |
| Related Requirement  | BR-FUND-004    |
| Related User Story   | US-FUND-004    |
| Related Scenario     | TS-FUND-004    |
| Priority             | P1             |
| Risk Level           | Critical       |
| Test Type            | API / Database |
| Automation Candidate | Yes            |

### Preconditions

* Funding transaction has already completed successfully.

### Test Data

| Field              | Value              |
| ------------------ | ------------------ |
| Provider Reference | Existing Reference |

### Test Steps

1. Resend the same provider callback.
2. Verify API response.
3. Query wallet balance.
4. Query transaction records.

### Expected Result

* Duplicate callback is detected.
* Wallet is credited only once.
* Duplicate event is logged.
* No duplicate transaction record is created.

### Postconditions

* Wallet balance remains accurate.

---

## TC-FUND-005 — Verify Successful Bank Transfer Funding

| Field                | Details                     |
| -------------------- | --------------------------- |
| Test Case ID         | TC-FUND-005                 |
| Module               | Wallet Funding              |
| Related Requirement  | BR-FUND-005                 |
| Related User Story   | US-FUND-002                 |
| Related Scenario     | TS-FUND-005                 |
| Priority             | P1                          |
| Risk Level           | Critical                    |
| Test Type            | Functional / API / Database |
| Automation Candidate | Yes                         |

### Preconditions

* Customer has an active wallet.

### Test Data

| Field           | Value   |
| --------------- | ------- |
| Initial Balance | ₦50,000 |
| Funding Amount  | ₦20,000 |

### Test Steps

1. Initiate bank transfer funding.
2. Simulate successful provider confirmation.
3. Verify wallet balance.
4. Validate database records.

### Expected Result

* Wallet balance becomes ₦70,000.
* Transaction status is **SUCCESSFUL**.
* Funding reference is unique.
* Transaction history displays the funding.

### Postconditions

* Wallet reflects credited amount.

---

## TC-FUND-006 — Verify Delayed Provider Confirmation Keeps Transaction Pending

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-FUND-006    |
| Module               | Wallet Funding |
| Related Requirement  | BR-FUND-006    |
| Related User Story   | US-FUND-002    |
| Related Scenario     | TS-FUND-006    |
| Priority             | P1             |
| Risk Level           | High           |
| Test Type            | API / Database |
| Automation Candidate | Yes            |

### Preconditions

* Funding request has been initiated.

### Test Steps

1. Delay provider confirmation.
2. Retrieve transaction status.
3. Verify wallet balance.

### Expected Result

* Transaction remains **PENDING**.
* Wallet balance does not change.
* Operations team can identify the pending transaction.

### Postconditions

* Transaction remains available for later reconciliation.

---

## TC-FUND-007 — Verify Transaction Record Matches Wallet Credit

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-FUND-007    |
| Module               | Wallet Funding |
| Related Requirement  | BR-FUND-001    |
| Related User Story   | US-FUND-001    |
| Related Scenario     | TS-FUND-009    |
| Priority             | P1             |
| Risk Level           | Critical       |
| Test Type            | Database       |
| Automation Candidate | Yes            |

### Preconditions

* Successful wallet funding has completed.

### Test Steps

1. Query wallet balance.
2. Query transaction table.
3. Compare funding amount with wallet credit.

### Expected Result

* Wallet balance increase equals the transaction amount.
* Transaction reference matches funding record.
* No duplicate credit exists.

### Postconditions

* Financial records remain internally consistent.

---

## TC-FUND-008 — Verify Funding Notification Contains Accurate Details

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-FUND-008    |
| Module               | Wallet Funding |
| Related Requirement  | BR-NOTIF-001   |
| Related User Story   | US-NOTIF-001   |
| Related Scenario     | TS-FUND-010    |
| Priority             | P2             |
| Risk Level           | Medium         |
| Test Type            | Functional     |
| Automation Candidate | Yes            |

### Preconditions

* Successful funding transaction has completed.

### Test Steps

1. Complete wallet funding.
2. Open the received notification.
3. Compare notification details with the transaction.

### Expected Result

* Notification is delivered.
* Amount is correct.
* Transaction reference is correct.
* Date and time are accurate.
* Notification reflects **SUCCESSFUL** status.

### Postconditions

* Customer has accurate confirmation of the funding transaction.

---

# Traceability Matrix

| Test Case   | Requirement  | User Story   | Scenario    |
| ----------- | ------------ | ------------ | ----------- |
| TC-FUND-001 | BR-FUND-001  | US-FUND-001  | TS-FUND-001 |
| TC-FUND-002 | BR-FUND-002  | US-FUND-003  | TS-FUND-002 |
| TC-FUND-003 | BR-FUND-003  | US-FUND-002  | TS-FUND-003 |
| TC-FUND-004 | BR-FUND-004  | US-FUND-004  | TS-FUND-004 |
| TC-FUND-005 | BR-FUND-005  | US-FUND-002  | TS-FUND-005 |
| TC-FUND-006 | BR-FUND-006  | US-FUND-002  | TS-FUND-006 |
| TC-FUND-007 | BR-FUND-001  | US-FUND-001  | TS-FUND-009 |
| TC-FUND-008 | BR-NOTIF-001 | US-NOTIF-001 | TS-FUND-010 |

---

# Execution Notes

During execution, record:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (screenshots, API responses, SQL query results)

