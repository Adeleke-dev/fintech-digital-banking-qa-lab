# Database Validation Checklist

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This checklist defines the database validations that must be performed after executing functional, API, integration, and security tests.

The objective is to verify that backend data remains accurate, consistent, traceable, and financially correct.

---

# Database Validation Checklist

## 1. User Validation

| Validation                                           | Status |
| ---------------------------------------------------- | ------ |
| User record created successfully                     | ☐      |
| Email stored correctly                               | ☐      |
| Phone number stored correctly                        | ☐      |
| Duplicate users not created                          | ☐      |
| User status updated correctly after OTP verification | ☐      |

---

## 2. Wallet Validation

| Validation                                      | Status |
| ----------------------------------------------- | ------ |
| Wallet created automatically after verification | ☐      |
| Only one wallet exists per customer             | ☐      |
| Wallet linked to correct user                   | ☐      |
| Initial wallet balance is ₦0.00                 | ☐      |
| Wallet status is Active                         | ☐      |

---

## 3. Wallet Balance Validation

| Validation                                      | Status |
| ----------------------------------------------- | ------ |
| Successful funding increases balance correctly  | ☐      |
| Successful transfer decreases balance correctly | ☐      |
| Failed transaction does not change balance      | ☐      |
| Reversal restores original balance              | ☐      |
| Refund credits correct amount                   | ☐      |
| Wallet balance matches API response             | ☐      |
| Wallet balance matches UI                       | ☐      |

---

## 4. Transaction Validation

| Validation                             | Status |
| -------------------------------------- | ------ |
| Transaction record created             | ☐      |
| Transaction reference is unique        | ☐      |
| Transaction amount stored correctly    | ☐      |
| Transaction type stored correctly      | ☐      |
| Transaction status stored correctly    | ☐      |
| Transaction timestamp recorded         | ☐      |
| Transaction linked to correct customer | ☐      |

---

## 5. Transaction Status Validation

Verify that only valid status transitions occur.

| Validation                               | Status |
| ---------------------------------------- | ------ |
| Pending → Successful                     | ☐      |
| Pending → Failed                         | ☐      |
| Successful → Reversed (where applicable) | ☐      |
| Successful → Refunded (where applicable) | ☐      |
| Invalid status transitions prevented     | ☐      |

---

## 6. Wallet Ledger Validation

| Validation                    | Status |
| ----------------------------- | ------ |
| Debit entry created           | ☐      |
| Credit entry created          | ☐      |
| Debit amount is correct       | ☐      |
| Credit amount is correct      | ☐      |
| Ledger references transaction | ☐      |
| No duplicate ledger entries   | ☐      |

---

## 7. Transfer Validation

| Validation                         | Status |
| ---------------------------------- | ------ |
| Sender debited correctly           | ☐      |
| Receiver credited correctly        | ☐      |
| Transfer limit enforced            | ☐      |
| Duplicate transfer prevented       | ☐      |
| Failed transfer reversed correctly | ☐      |

---

## 8. Bill Payment Validation

| Validation                          | Status |
| ----------------------------------- | ------ |
| Bill payment record created         | ☐      |
| Wallet debited correctly            | ☐      |
| Failed payment refunded or reversed | ☐      |
| Duplicate payment prevented         | ☐      |
| Provider reference stored           | ☐      |

---

## 9. Notification Validation

| Validation                       | Status |
| -------------------------------- | ------ |
| Notification record created      | ☐      |
| Correct notification type stored | ☐      |
| Delivery status recorded         | ☐      |
| Transaction reference linked     | ☐      |

---

## 10. Beneficiary Validation

| Validation                             | Status |
| -------------------------------------- | ------ |
| Beneficiary linked to correct customer | ☐      |
| Duplicate beneficiary prevented        | ☐      |
| Unauthorized access prevented          | ☐      |

---

## 11. Audit Trail Validation

| Validation                                        | Status |
| ------------------------------------------------- | ------ |
| Login event recorded                              | ☐      |
| Failed login recorded                             | ☐      |
| Wallet funding recorded                           | ☐      |
| Transfer recorded                                 | ☐      |
| Password reset recorded                           | ☐      |
| Authorization failure recorded                    | ☐      |
| Transaction reference captured (where applicable) | ☐      |

---

## 12. Duplicate Transaction Validation

| Validation                                | Status |
| ----------------------------------------- | ------ |
| Duplicate funding callback prevented      | ☐      |
| Duplicate transfer request prevented      | ☐      |
| Duplicate bill payment prevented          | ☐      |
| Duplicate transaction reference prevented | ☐      |
| Duplicate wallet prevented                | ☐      |

---

## 13. Reconciliation Validation

| Validation                              | Status |
| --------------------------------------- | ------ |
| Wallet balance equals ledger balance    | ☐      |
| Debit equals credit where applicable    | ☐      |
| Transaction totals reconcile            | ☐      |
| Reversal linked to original transaction | ☐      |
| Refund linked to original transaction   | ☐      |
| No orphan financial records             | ☐      |

---

## 14. Security Validation

| Validation                                     | Status |
| ---------------------------------------------- | ------ |
| Customer cannot access another customer's data | ☐      |
| Expired token does not expose records          | ☐      |
| Unauthorized queries return no financial data  | ☐      |
| Sensitive fields protected according to policy | ☐      |

---

# Database Validation Evidence

For each validation, capture evidence where applicable:

* SQL query executed
* Query result
* Screenshot of query output
* Related API response
* Related UI evidence
* Defect ID (if validation fails)

---

# Exit Criteria

Database validation is considered complete when:

* All critical validations pass.
* Wallet balances are financially accurate.
* Debit and credit records reconcile correctly.
* No duplicate financial records exist.
* Reversals and refunds are fully traceable.
* Audit records are complete.
* Security validations pass.
* Database state matches API responses and UI behavior.
