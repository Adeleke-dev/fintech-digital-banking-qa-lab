# Regression Test Suite

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the risk-based regression test suite for the Fintech Digital Banking QA Lab.

The suite protects critical digital banking functionality after bug fixes, feature changes, configuration updates, database migrations, and new releases.

The complete Phase 5 scenario inventory provides broad test coverage. This regression suite contains the most important repeatable checks required to protect customer funds, transaction integrity, security controls, and core business workflows.

---

# Regression Suite Objectives

The regression suite verifies that:

* Previously working functionality remains stable.
* Previously fixed defects do not reappear.
* Customer wallet balances remain accurate.
* Duplicate debit and credit are prevented.
* Failed transactions are recovered correctly.
* Transaction statuses remain accurate.
* Authentication and authorization controls remain effective.
* API responses remain consistent with database records.
* Critical financial workflows remain safe for release.

---

# Priority Guide

| Priority | Meaning                                 | Execution Requirement       |
| -------- | --------------------------------------- | --------------------------- |
| P1       | Critical financial or security workflow | Execute for every release   |
| P2       | Important business workflow             | Execute for full regression |
| P3       | Supporting workflow                     | Execute when affected       |

---

# Automation Status Guide

| Status  | Meaning                                              |
| ------- | ---------------------------------------------------- |
| Yes     | Strong candidate for API, UI, or database automation |
| Partial | Some validations can be automated                    |
| No      | Better suited to manual or exploratory execution     |

---

# 1. Authentication Regression Suite

| Regression ID | Test Scenario                             | Priority | Test Level   | Automation | Expected Outcome                                |
| ------------- | ----------------------------------------- | -------- | ------------ | ---------- | ----------------------------------------------- |
| REG-AUTH-001  | Register customer using valid details     | P2       | UI/API       | Yes        | Account is created and OTP is generated         |
| REG-AUTH-002  | Reject registration using duplicate email | P2       | API          | Yes        | Duplicate account is not created                |
| REG-AUTH-003  | Verify account using valid OTP            | P1       | UI/API/DB    | Yes        | Account is verified and wallet is created       |
| REG-AUTH-004  | Reject invalid or expired OTP             | P1       | API          | Yes        | Account remains unverified                      |
| REG-AUTH-005  | Log in using valid credentials            | P1       | UI/API       | Yes        | Valid authenticated session is created          |
| REG-AUTH-006  | Reject invalid credentials                | P1       | API          | Yes        | Access is denied                                |
| REG-AUTH-007  | Reset password using valid OTP or link    | P2       | UI/API       | Yes        | New password becomes active                     |
| REG-AUTH-008  | Reject expired password-reset token       | P1       | API          | Yes        | Password remains unchanged                      |
| REG-AUTH-009  | Reject expired JWT on protected endpoints | P1       | API/Security | Yes        | API returns `401 Unauthorized`                  |
| REG-AUTH-010  | Verify logout invalidates session         | P2       | API/Security | Yes        | Logged-out session cannot access protected APIs |

---

# 2. Wallet Management Regression Suite

| Regression ID  | Test Scenario                                           | Priority | Test Level   | Automation | Expected Outcome                                       |
| -------------- | ------------------------------------------------------- | -------- | ------------ | ---------- | ------------------------------------------------------ |
| REG-WALLET-001 | Create wallet after successful OTP verification         | P1       | API/DB       | Yes        | One wallet is created for the customer                 |
| REG-WALLET-002 | Prevent duplicate wallet creation                       | P1       | API/DB       | Yes        | Only one wallet exists per customer                    |
| REG-WALLET-003 | Confirm initial wallet balance is ₦0.00                 | P1       | API/DB       | Yes        | New wallet starts with zero balance                    |
| REG-WALLET-004 | Validate balance after successful credit                | P1       | UI/API/DB    | Yes        | Balance increases by the correct amount                |
| REG-WALLET-005 | Validate balance after successful debit                 | P1       | UI/API/DB    | Yes        | Balance decreases by the correct amount                |
| REG-WALLET-006 | Confirm failed transaction does not change balance      | P1       | API/DB       | Yes        | Balance remains unchanged                              |
| REG-WALLET-007 | Verify wallet history contains correct transaction data | P2       | UI/API/DB    | Partial    | Amount, reference, type, date, and status are accurate |
| REG-WALLET-008 | Prevent customer from viewing another customer’s wallet | P1       | API/Security | Yes        | Access is denied                                       |

---

# 3. Wallet Funding Regression Suite

| Regression ID | Test Scenario                                 | Priority | Test Level        | Automation | Expected Outcome                                      |
| ------------- | --------------------------------------------- | -------- | ----------------- | ---------- | ----------------------------------------------------- |
| REG-FUND-001  | Complete successful card funding              | P1       | UI/API/DB         | Yes        | Wallet is credited once                               |
| REG-FUND-002  | Process failed card funding                   | P1       | API/DB            | Yes        | Wallet is not credited                                |
| REG-FUND-003  | Keep unconfirmed funding pending              | P1       | API/DB            | Yes        | Pending funding does not affect balance               |
| REG-FUND-004  | Process successful bank-transfer funding      | P1       | API/DB            | Yes        | Wallet is credited after confirmation                 |
| REG-FUND-005  | Handle delayed bank-transfer callback         | P1       | API/DB            | Yes        | Transaction remains pending                           |
| REG-FUND-006  | Prevent double credit from duplicate callback | P1       | API/DB            | Yes        | Duplicate callback has no additional financial impact |
| REG-FUND-007  | Generate unique funding transaction reference | P1       | API/DB            | Yes        | Reference is unique                                   |
| REG-FUND-008  | Confirm funding record matches wallet credit  | P1       | DB/Reconciliation | Yes        | Funding amount equals ledger credit                   |
| REG-FUND-009  | Send accurate successful-funding notification | P2       | Integration       | Partial    | Notification matches transaction data                 |

---

# 4. Money Transfer Regression Suite

| Regression ID    | Test Scenario                                         | Priority | Test Level        | Automation | Expected Outcome                             |
| ---------------- | ----------------------------------------------------- | -------- | ----------------- | ---------- | -------------------------------------------- |
| REG-TRANSFER-001 | Complete successful internal transfer                 | P1       | UI/API/DB         | Yes        | Sender is debited and receiver credited      |
| REG-TRANSFER-002 | Reject transfer with insufficient balance             | P1       | API/DB            | Yes        | No debit occurs                              |
| REG-TRANSFER-003 | Prevent duplicate transfer request                    | P1       | API/DB            | Yes        | Sender is debited once                       |
| REG-TRANSFER-004 | Validate internal transfer debit-credit balance       | P1       | DB/Reconciliation | Yes        | Total debit equals total credit              |
| REG-TRANSFER-005 | Complete successful external transfer                 | P1       | API/DB            | Yes        | Transaction becomes successful               |
| REG-TRANSFER-006 | Keep delayed external transfer pending                | P1       | API/DB            | Yes        | Transaction remains traceable as pending     |
| REG-TRANSFER-007 | Avoid debit when external transfer fails before debit | P1       | API/DB            | Yes        | Wallet remains unchanged                     |
| REG-TRANSFER-008 | Reverse failed external transfer after debit          | P1       | API/DB            | Yes        | Customer balance is fully restored           |
| REG-TRANSFER-009 | Enforce ₦50,000 per-transaction limit                 | P1       | API               | Yes        | Transfers above limit are rejected           |
| REG-TRANSFER-010 | Enforce ₦200,000 cumulative daily limit               | P1       | API/DB            | Yes        | Transfers exceeding daily total are rejected |
| REG-TRANSFER-011 | Save valid beneficiary                                | P2       | UI/API            | Yes        | Beneficiary is linked to customer            |
| REG-TRANSFER-012 | Prevent cross-customer beneficiary access             | P1       | API/Security      | Yes        | Access is denied                             |

---

# 5. Transaction Processing Regression Suite

| Regression ID | Test Scenario                                     | Priority | Test Level | Automation | Expected Outcome                       |
| ------------- | ------------------------------------------------- | -------- | ---------- | ---------- | -------------------------------------- |
| REG-TXN-001   | Generate unique reference for every transaction   | P1       | API/DB     | Yes        | Duplicate references do not exist      |
| REG-TXN-002   | Transition transaction from pending to successful | P1       | API/DB     | Yes        | Final status is accurate               |
| REG-TXN-003   | Transition transaction from pending to failed     | P1       | API/DB     | Yes        | Failed status is recorded correctly    |
| REG-TXN-004   | Prevent invalid transaction status transition     | P1       | API/DB     | Yes        | Invalid state change is rejected       |
| REG-TXN-005   | Restore balance after reversal                    | P1       | API/DB     | Yes        | Wallet returns to correct balance      |
| REG-TXN-006   | Credit correct amount during refund               | P1       | API/DB     | Yes        | Refund equals eligible original amount |
| REG-TXN-007   | Link reversal to original transaction             | P1       | DB/Audit   | Yes        | Complete reversal traceability exists  |
| REG-TXN-008   | Link refund to original transaction               | P1       | DB/Audit   | Yes        | Complete refund traceability exists    |
| REG-TXN-009   | Display accurate transaction history statuses     | P2       | UI/API/DB  | Partial    | Status matches backend record          |

---

# 6. Bill Payment Regression Suite

| Regression ID | Test Scenario                            | Priority | Test Level | Automation | Expected Outcome                         |
| ------------- | ---------------------------------------- | -------- | ---------- | ---------- | ---------------------------------------- |
| REG-BILL-001  | Complete successful airtime purchase     | P1       | UI/API/DB  | Yes        | Wallet is debited correctly              |
| REG-BILL-002  | Handle airtime failure before debit      | P1       | API/DB     | Yes        | Wallet remains unchanged                 |
| REG-BILL-003  | Reverse airtime failure after debit      | P1       | API/DB     | Yes        | Customer funds are restored              |
| REG-BILL-004  | Complete successful data purchase        | P2       | UI/API/DB  | Yes        | Data payment is recorded correctly       |
| REG-BILL-005  | Complete successful utility payment      | P1       | UI/API/DB  | Yes        | Utility transaction becomes successful   |
| REG-BILL-006  | Keep delayed utility response pending    | P1       | API/DB     | Yes        | Pending status remains accurate          |
| REG-BILL-007  | Refund or reverse failed utility payment | P1       | API/DB     | Yes        | Wallet is restored correctly             |
| REG-BILL-008  | Prevent duplicate bill-payment request   | P1       | API/DB     | Yes        | Wallet is debited once                   |
| REG-BILL-009  | Validate provider reference uniqueness   | P1       | DB         | Yes        | Duplicate provider records are prevented |

---

# 7. Notifications Regression Suite

| Regression ID | Test Scenario                                            | Priority | Test Level      | Automation | Expected Outcome                       |
| ------------- | -------------------------------------------------------- | -------- | --------------- | ---------- | -------------------------------------- |
| REG-NOTIF-001 | Send notification after successful transaction           | P2       | Integration     | Partial    | Customer receives confirmation         |
| REG-NOTIF-002 | Validate notification amount, reference, and status      | P1       | API/Integration | Yes        | Notification matches transaction data  |
| REG-NOTIF-003 | Send accurate failed-transaction notification            | P2       | Integration     | Partial    | Message reflects actual failure        |
| REG-NOTIF-004 | Send reversal or refund notification                     | P2       | Integration     | Partial    | Customer is informed of restored funds |
| REG-NOTIF-005 | Isolate notification failure from transaction processing | P1       | API/Integration | Yes        | Transaction remains successful         |
| REG-NOTIF-006 | Record failed notification for retry                     | P2       | API/DB          | Yes        | Failed delivery is traceable           |

---

# 8. Security and Fraud Regression Suite

| Regression ID | Test Scenario                                     | Priority | Test Level      | Automation | Expected Outcome                     |
| ------------- | ------------------------------------------------- | -------- | --------------- | ---------- | ------------------------------------ |
| REG-SEC-001   | Reject protected API request without token        | P1       | API/Security    | Yes        | API returns `401 Unauthorized`       |
| REG-SEC-002   | Reject invalid JWT token                          | P1       | API/Security    | Yes        | Protected resource is not returned   |
| REG-SEC-003   | Reject expired JWT token                          | P1       | API/Security    | Yes        | Session cannot be reused             |
| REG-SEC-004   | Prevent access to another customer’s wallet       | P1       | API/Security    | Yes        | Cross-customer access is denied      |
| REG-SEC-005   | Prevent access to another customer’s transactions | P1       | API/Security    | Yes        | Financial data remains private       |
| REG-SEC-006   | Process identical idempotent request only once    | P1       | API/DB/Security | Yes        | No duplicate financial impact occurs |
| REG-SEC-007   | Detect or limit rapid transfer attempts           | P1       | API/Security    | Yes        | Fraud control is triggered           |
| REG-SEC-008   | Record failed authentication attempt              | P2       | DB/Audit        | Yes        | Security event is traceable          |
| REG-SEC-009   | Record unauthorised resource-access attempt       | P2       | DB/Audit        | Yes        | Audit record is created              |

---

# 9. Defect-Fix Regression Coverage

The following tests must be executed after fixes for the Sprint 1 defects.

| Bug ID  | Fixed Defect                                    | Required Regression Tests                                    |
| ------- | ----------------------------------------------- | ------------------------------------------------------------ |
| BUG-001 | Duplicate wallet credit after callback retry    | REG-FUND-001, REG-FUND-006, REG-FUND-008                     |
| BUG-002 | Failed external transfer not reversed           | REG-TRANSFER-006, REG-TRANSFER-008, REG-TXN-005, REG-TXN-007 |
| BUG-003 | Expired JWT accepted                            | REG-AUTH-009, REG-SEC-003                                    |
| BUG-004 | Successful callback left transaction pending    | REG-FUND-001, REG-TXN-002                                    |
| BUG-005 | Daily transfer limit ignored cumulative total   | REG-TRANSFER-009, REG-TRANSFER-010                           |
| BUG-006 | Cross-customer beneficiary access               | REG-TRANSFER-012, REG-SEC-004                                |
| BUG-007 | Refund exceeded original transaction amount     | REG-TXN-006, REG-TXN-008                                     |
| BUG-008 | Notification failure changed transaction status | REG-NOTIF-005, REG-NOTIF-006                                 |

---

# 10. Regression Execution Order

Execute regression tests in this order:

1. Authentication and session security
2. Wallet creation and wallet balance
3. Wallet funding
4. Internal and external transfers
5. Transaction reversals and refunds
6. Bill payments
7. Authorisation and fraud controls
8. Notifications
9. Database reconciliation checks

Any failure in a P1 financial or security test should be raised immediately and may stop further release validation.

---

# 11. Regression Test Data

Prepare the following:

| Test Data                        | Purpose                       |
| -------------------------------- | ----------------------------- |
| Verified customer                | Core financial regression     |
| Unverified customer              | Access-control regression     |
| Customer with zero balance       | Insufficient-funds validation |
| Customer with sufficient balance | Transfers and bill payments   |
| Two active wallet customers      | Internal transfer validation  |
| Customer near transaction limit  | Boundary validation           |
| Customer near daily limit        | Cumulative limit validation   |
| Duplicate provider reference     | Callback idempotency          |
| Duplicate idempotency key        | Request replay prevention     |
| Failed external transaction      | Reversal validation           |
| Refund-eligible transaction      | Refund validation             |
| Expired JWT                      | Session-security validation   |

---

# 12. Regression Exit Criteria

Regression execution is complete when:

* All P1 tests have been executed.
* All P1 tests have passed.
* No unresolved Critical defect remains.
* No High defect presents unacceptable release risk.
* Wallet and ledger reconciliation checks pass.
* Previously fixed Sprint 1 defects remain resolved.
* API responses match database state.
* Test evidence and defect references are captured.
* QA issues a release recommendation.

---

# 13. Regression Suite Summary

| Module                        | Number of Regression Tests |
| ----------------------------- | -------------------------: |
| Authentication                |                         10 |
| Wallet Management             |                          8 |
| Wallet Funding                |                          9 |
| Money Transfers               |                         12 |
| Transaction Processing        |                          9 |
| Bill Payments                 |                          9 |
| Notifications                 |                          6 |
| Security and Fraud Prevention |                          9 |
| **Total**                     |                     **72** |

---

# Recruiter Talking Points

This suite demonstrates the ability to:

* Build a risk-based regression pack.
* Separate critical regression coverage from broad scenario coverage.
* Map bug fixes to targeted regression tests.
* Validate fintech workflows across UI, API, database, security, and reconciliation layers.
* Prioritise duplicate debit, duplicate credit, wallet balance, reversal, refund, and authorisation risks.
* Support release decisions using repeatable quality evidence.
