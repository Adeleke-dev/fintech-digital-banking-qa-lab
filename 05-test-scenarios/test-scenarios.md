# Test Scenarios

## Project: Fintech Digital Banking QA Lab

## Phase 5 Deliverable

---

# 1. Document Purpose

This document defines high-level test scenarios for the Fintech Digital Banking QA Lab.

The scenarios are organized by:

* Module
* Risk Level
* Test Type
* Priority
* Related User Story
* Expected Business Outcome

---

# 2. Scenario Priority Guide

| Priority | Meaning                                                  |
| -------- | -------------------------------------------------------- |
| P1       | Critical fintech flow; must be tested before release     |
| P2       | Important business flow; should be tested before release |
| P3       | Supporting flow; can be tested after critical areas      |

---

# 3. Risk Level Guide

| Risk Level | Meaning                                                                       |
| ---------- | ----------------------------------------------------------------------------- |
| Critical   | Can cause money loss, wrong balance, unauthorized access, or release blockage |
| High       | Can affect major fintech workflow or customer trust                           |
| Medium     | Can affect usability, support, or transaction clarity                         |
| Low        | Minor impact                                                                  |

---

# 4. Authentication Test Scenarios

| Scenario ID | Scenario Title                                             | Risk Level | Test Type    | Priority | Related User Story | Expected Business Outcome                   |
| ----------- | ---------------------------------------------------------- | ---------- | ------------ | -------- | ------------------ | ------------------------------------------- |
| TS-AUTH-001 | Verify successful customer registration with valid details | High       | Functional   | P2       | US-AUTH-001        | Customer account is created successfully    |
| TS-AUTH-002 | Verify duplicate email registration is rejected            | High       | Negative     | P2       | US-AUTH-001        | Duplicate account creation is prevented     |
| TS-AUTH-003 | Verify duplicate phone registration is rejected            | High       | Negative     | P2       | US-AUTH-001        | Duplicate customer identity is prevented    |
| TS-AUTH-004 | Verify successful OTP verification activates account       | High       | Functional   | P1       | US-AUTH-002        | Customer account becomes verified           |
| TS-AUTH-005 | Verify invalid OTP is rejected                             | High       | Negative     | P1       | US-AUTH-002        | Unauthorized verification is prevented      |
| TS-AUTH-006 | Verify unverified user cannot access wallet features       | High       | Security     | P1       | US-AUTH-002        | Wallet access is blocked until verification |
| TS-AUTH-007 | Verify successful login with valid credentials             | High       | Functional   | P2       | US-AUTH-003        | Customer can access account securely        |
| TS-AUTH-008 | Verify invalid login credentials are rejected              | High       | Security     | P2       | US-AUTH-003        | Unauthorized account access is prevented    |
| TS-AUTH-009 | Verify password reset with valid reset OTP/link            | High       | Functional   | P2       | US-AUTH-004        | Customer can recover account access         |
| TS-AUTH-010 | Verify expired reset token is rejected                     | High       | Security     | P2       | US-AUTH-004        | Account takeover risk is reduced            |
| TS-AUTH-011 | Verify expired session cannot access protected endpoints   | High       | Security/API | P1       | US-AUTH-005        | Unauthorized session access is prevented    |

---

# 5. Wallet Management Test Scenarios

| Scenario ID   | Scenario Title                                                             | Risk Level | Test Type         | Priority | Related User Story | Expected Business Outcome               |
| ------------- | -------------------------------------------------------------------------- | ---------- | ----------------- | -------- | ------------------ | --------------------------------------- |
| TS-WALLET-001 | Verify wallet is created after successful OTP verification                 | High       | Functional/DB     | P1       | US-WALLET-001      | Verified customer receives wallet       |
| TS-WALLET-002 | Verify wallet is not created before OTP verification                       | High       | Negative/DB       | P1       | US-WALLET-001      | Unverified users cannot access wallet   |
| TS-WALLET-003 | Verify duplicate wallet is not created for same customer                   | Critical   | DB/API            | P1       | US-WALLET-001      | Wallet duplication is prevented         |
| TS-WALLET-004 | Verify initial wallet balance is ₦0.00                                     | High       | Functional/DB     | P1       | US-WALLET-002      | Wallet starts with correct balance      |
| TS-WALLET-005 | Verify wallet balance after successful credit                              | Critical   | Functional/API/DB | P1       | US-WALLET-002      | Balance increases correctly             |
| TS-WALLET-006 | Verify wallet balance after successful debit                               | Critical   | Functional/API/DB | P1       | US-WALLET-002      | Balance decreases correctly             |
| TS-WALLET-007 | Verify failed transaction does not change wallet balance                   | Critical   | Functional/API/DB | P1       | US-WALLET-002      | Failed transactions do not affect funds |
| TS-WALLET-008 | Verify wallet history displays credit, debit, reversal, and refund records | High       | Functional/DB     | P2       | US-WALLET-003      | Customer can trace wallet activity      |
| TS-WALLET-009 | Verify customer cannot view another customer’s wallet history              | Critical   | Security/API      | P1       | US-WALLET-003      | Financial privacy is protected          |

---

# 6. Wallet Funding Test Scenarios

| Scenario ID | Scenario Title                                                         | Risk Level | Test Type         | Priority | Related User Story | Expected Business Outcome                        |
| ----------- | ---------------------------------------------------------------------- | ---------- | ----------------- | -------- | ------------------ | ------------------------------------------------ |
| TS-FUND-001 | Verify successful card funding credits wallet once                     | Critical   | Functional/API/DB | P1       | US-FUND-001        | Customer wallet is credited accurately           |
| TS-FUND-002 | Verify failed card funding does not credit wallet                      | Critical   | Negative/API/DB   | P1       | US-FUND-001        | Failed payment does not create false credit      |
| TS-FUND-003 | Verify pending card funding does not credit wallet before confirmation | Critical   | API/DB            | P1       | US-FUND-001        | Pending payment does not affect balance          |
| TS-FUND-004 | Verify duplicate card provider callback does not double credit wallet  | Critical   | API/DB            | P1       | US-FUND-004        | Double credit is prevented                       |
| TS-FUND-005 | Verify successful bank transfer funding credits wallet once            | Critical   | Functional/API/DB | P1       | US-FUND-002        | Bank transfer funding updates balance correctly  |
| TS-FUND-006 | Verify delayed bank transfer confirmation remains pending              | High       | API/DB            | P1       | US-FUND-002        | Pending state is handled correctly               |
| TS-FUND-007 | Verify failed bank transfer funding does not credit wallet             | Critical   | Negative/API/DB   | P1       | US-FUND-002        | Failed transfer funding does not affect balance  |
| TS-FUND-008 | Verify duplicate bank transfer callback is logged but not reprocessed  | Critical   | API/DB            | P1       | US-FUND-004        | Duplicate provider event has no financial impact |
| TS-FUND-009 | Verify successful funding appears in transaction history               | High       | Functional/DB     | P2       | US-FUND-001        | Customer can see accurate funding record         |
| TS-FUND-010 | Verify successful funding notification is sent with correct details    | Medium     | Functional        | P2       | US-NOTIF-001       | Customer receives accurate funding notification  |

---

# 7. Money Transfer Test Scenarios

| Scenario ID     | Scenario Title                                                       | Risk Level | Test Type         | Priority | Related User Story | Expected Business Outcome                      |
| --------------- | -------------------------------------------------------------------- | ---------- | ----------------- | -------- | ------------------ | ---------------------------------------------- |
| TS-TRANSFER-001 | Verify successful internal wallet transfer                           | Critical   | Functional/API/DB | P1       | US-TRANSFER-001    | Sender debited and receiver credited correctly |
| TS-TRANSFER-002 | Verify internal transfer with insufficient balance is rejected       | Critical   | Negative/API/DB   | P1       | US-TRANSFER-001    | Customer cannot transfer unavailable funds     |
| TS-TRANSFER-003 | Verify duplicate internal transfer request does not double debit     | Critical   | API/DB/Security   | P1       | US-TRANSFER-001    | Double debit is prevented                      |
| TS-TRANSFER-004 | Verify sender debit and receiver credit records are created          | Critical   | DB                | P1       | US-TRANSFER-001    | Ledger records remain balanced                 |
| TS-TRANSFER-005 | Verify external bank transfer success                                | High       | Functional/API/DB | P1       | US-TRANSFER-002    | External transfer completes correctly          |
| TS-TRANSFER-006 | Verify external transfer pending status                              | High       | API/DB            | P1       | US-TRANSFER-002    | Pending transfer is traceable                  |
| TS-TRANSFER-007 | Verify failed external transfer before debit does not reduce balance | Critical   | API/DB            | P1       | US-TRANSFER-002    | Customer funds remain safe                     |
| TS-TRANSFER-008 | Verify failed external transfer after debit is reversed              | Critical   | Functional/API/DB | P1       | US-TRANSFER-002    | Customer money is restored                     |
| TS-TRANSFER-009 | Verify transfer above ₦50,000 is rejected                            | High       | Functional/API    | P1       | US-TRANSFER-004    | Per-transaction limit is enforced              |
| TS-TRANSFER-010 | Verify transfer above ₦200,000 daily limit is rejected               | High       | Functional/API/DB | P1       | US-TRANSFER-004    | Daily limit is enforced                        |
| TS-TRANSFER-011 | Verify beneficiary can be added with valid details                   | Medium     | Functional/API    | P2       | US-TRANSFER-003    | Customer can save valid beneficiary            |
| TS-TRANSFER-012 | Verify duplicate beneficiary handling                                | Medium     | Negative/API      | P2       | US-TRANSFER-003    | Duplicate beneficiary records are controlled   |
| TS-TRANSFER-013 | Verify customer cannot access another user’s beneficiary             | High       | Security/API      | P1       | US-TRANSFER-003    | Beneficiary ownership is protected             |

---

# 8. Transaction Processing Test Scenarios

| Scenario ID | Scenario Title                                               | Risk Level | Test Type         | Priority | Related User Story | Expected Business Outcome                   |
| ----------- | ------------------------------------------------------------ | ---------- | ----------------- | -------- | ------------------ | ------------------------------------------- |
| TS-TXN-001  | Verify every transaction has a unique reference              | Critical   | API/DB            | P1       | US-TXN-001         | Duplicate processing risk is reduced        |
| TS-TXN-002  | Verify transaction status changes from PENDING to SUCCESSFUL | High       | API/DB            | P1       | US-TXN-001         | Transaction lifecycle is accurate           |
| TS-TXN-003  | Verify transaction status changes from PENDING to FAILED     | High       | API/DB            | P1       | US-TXN-001         | Failed transaction is recorded correctly    |
| TS-TXN-004  | Verify reversed transaction restores wallet balance          | Critical   | Functional/API/DB | P1       | US-TXN-002         | Customer funds are restored                 |
| TS-TXN-005  | Verify refund transaction credits correct amount             | Critical   | Functional/API/DB | P1       | US-TXN-003         | Customer receives correct refund            |
| TS-TXN-006  | Verify reversal is linked to original transaction            | High       | DB/Audit          | P1       | US-TXN-002         | Investigation and audit trail are supported |
| TS-TXN-007  | Verify refund is linked to original transaction              | High       | DB/Audit          | P1       | US-TXN-003         | Refund traceability is supported            |
| TS-TXN-008  | Verify duplicate transaction reference is rejected           | Critical   | API/DB            | P1       | US-TXN-004         | Duplicate financial processing is prevented |
| TS-TXN-009  | Verify transaction history displays all statuses correctly   | Medium     | Functional/DB     | P2       | US-TXN-001         | Customer sees accurate transaction outcome  |

---

# 9. Bill Payment Test Scenarios

| Scenario ID | Scenario Title                                                      | Risk Level | Test Type         | Priority | Related User Story  | Expected Business Outcome                            |
| ----------- | ------------------------------------------------------------------- | ---------- | ----------------- | -------- | ------------------- | ---------------------------------------------------- |
| TS-BILL-001 | Verify successful airtime purchase debits wallet                    | High       | Functional/API/DB | P1       | US-BILL-001         | Airtime purchase is processed correctly              |
| TS-BILL-002 | Verify failed airtime purchase before debit does not change balance | Critical   | Negative/API/DB   | P1       | US-BILL-001         | Failed payment does not affect wallet                |
| TS-BILL-003 | Verify failed airtime purchase after debit is reversed or refunded  | Critical   | Functional/API/DB | P1       | US-BILL-001         | Customer money is restored                           |
| TS-BILL-004 | Verify successful data purchase                                     | High       | Functional/API/DB | P2       | US-BILL-002         | Data purchase is processed correctly                 |
| TS-BILL-005 | Verify failed data purchase after debit is reversed/refunded        | Critical   | Functional/API/DB | P1       | US-BILL-002         | Failed service delivery does not cause money loss    |
| TS-BILL-006 | Verify successful utility bill payment                              | High       | Functional/API/DB | P2       | US-BILL-003         | Utility payment is processed correctly               |
| TS-BILL-007 | Verify delayed utility provider response keeps transaction pending  | High       | API/DB            | P1       | US-BILL-003         | Pending provider response is handled correctly       |
| TS-BILL-008 | Verify failed utility bill payment after debit is reversed/refunded | Critical   | Functional/API/DB | P1       | US-BILL-003         | Customer is not permanently debited                  |
| TS-BILL-009 | Verify duplicate bill payment request does not double debit         | Critical   | API/DB            | P1       | US-BILL-001/002/003 | Duplicate bill payment financial impact is prevented |

---

# 10. Notification Test Scenarios

| Scenario ID  | Scenario Title                                                    | Risk Level | Test Type      | Priority | Related User Story | Expected Business Outcome                  |
| ------------ | ----------------------------------------------------------------- | ---------- | -------------- | -------- | ------------------ | ------------------------------------------ |
| TS-NOTIF-001 | Verify successful transaction notification is sent                | Medium     | Functional     | P2       | US-NOTIF-001       | Customer receives transaction confirmation |
| TS-NOTIF-002 | Verify notification content matches transaction amount and status | High       | Functional/API | P1       | US-NOTIF-001       | Customer receives accurate information     |
| TS-NOTIF-003 | Verify failed transaction notification is accurate                | Medium     | Functional     | P2       | US-NOTIF-002       | Customer understands failed outcome        |
| TS-NOTIF-004 | Verify reversal/refund notification is accurate                   | Medium     | Functional     | P2       | US-NOTIF-002       | Customer understands money restoration     |
| TS-NOTIF-005 | Verify notification failure does not change transaction status    | High       | API/DB         | P1       | US-NOTIF-001       | Transaction truth is preserved             |

---

# 11. Security and Fraud Prevention Test Scenarios

| Scenario ID | Scenario Title                                                        | Risk Level | Test Type       | Priority | Related User Story | Expected Business Outcome                      |
| ----------- | --------------------------------------------------------------------- | ---------- | --------------- | -------- | ------------------ | ---------------------------------------------- |
| TS-SEC-001  | Verify invalid authentication is rejected                             | High       | Security/API    | P1       | US-SEC-001         | Unauthorized access is prevented               |
| TS-SEC-002  | Verify brute force-like login attempts are detected or limited        | High       | Security        | P1       | US-SEC-001         | Account attack risk is reduced                 |
| TS-SEC-003  | Verify unauthenticated user cannot access wallet APIs                 | Critical   | Security/API    | P1       | US-SEC-001         | Wallet APIs are protected                      |
| TS-SEC-004  | Verify user cannot access another customer’s wallet                   | Critical   | Security/API    | P1       | US-SEC-002         | Financial privacy is protected                 |
| TS-SEC-005  | Verify user cannot access another customer’s transactions             | Critical   | Security/API    | P1       | US-SEC-002         | Transaction data is protected                  |
| TS-SEC-006  | Verify rapid transfer attempts are detected                           | High       | Security/API    | P1       | US-SEC-003         | Fraud-like or duplicate behavior is controlled |
| TS-SEC-007  | Verify duplicate request detection prevents repeated financial impact | Critical   | Security/API/DB | P1       | US-SEC-003         | Duplicate debit/credit is prevented            |

---

# 12. Scenario Summary

| Module                        | Scenario Count |
| ----------------------------- | -------------: |
| Authentication                |             11 |
| Wallet Management             |              9 |
| Wallet Funding                |             10 |
| Money Transfers               |             13 |
| Transaction Processing        |              9 |
| Bill Payments                 |              9 |
| Notifications                 |              5 |
| Security and Fraud Prevention |              7 |
| Total                         |             73 |

---

# 13. High-Priority Scenario Focus

The most important P1 scenario areas are:

1. OTP verification and wallet access control
2. Wallet creation after verification
3. Wallet balance accuracy
4. Successful and failed wallet funding
5. Duplicate provider callback prevention
6. Internal transfer debit and credit validation
7. Duplicate transfer request prevention
8. External transfer failure and reversal
9. Bill payment failure and refund/reversal
10. Unauthorized wallet and transaction access
11. Transaction reference uniqueness
12. API and database consistency

---

# 14. Phase 5 Completion Criteria

Phase 5 is complete when:

1. Test scenarios are created for all modules.
2. Each scenario has a scenario ID.
3. Each scenario is linked to a user story.
4. Risk level is assigned.
5. Test type is identified.
6. Priority is assigned.
7. Expected business outcome is documented.
8. Scenarios are ready to be converted into detailed test cases.

