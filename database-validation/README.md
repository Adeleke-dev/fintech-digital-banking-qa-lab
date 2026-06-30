# Database Validation

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This folder contains database validation artifacts for the Fintech Digital Banking QA Lab.

Database validation is used to confirm that financial data is stored correctly after user actions, API calls, transaction processing, wallet funding, transfers, bill payments, refunds, and reversals.

In fintech QA, database validation is critical because UI and API responses alone may not prove that financial records are correct.

---

# Purpose

The purpose of database validation is to verify:

* Wallet balance accuracy
* Transaction record creation
* Debit and credit correctness
* Transaction reference uniqueness
* Transaction status updates
* Reversal and refund linkage
* Duplicate transaction prevention
* User-wallet ownership
* Beneficiary ownership
* Notification record accuracy
* Audit trail completeness
* Reconciliation readiness

---

# Database Validation Scope

This phase covers database checks for:

1. Authentication
2. Wallet Management
3. Wallet Funding
4. Money Transfers
5. Transaction Processing
6. Bill Payments
7. Notifications
8. Security and Fraud Prevention
9. Audit Trail
10. Reconciliation

---

# Database Validation Artifacts

| File                             | Purpose                                                                                                     |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| database-validation-checklist.md | Checklist of what must be verified in the database                                                          |
| sql-validation-queries.sql       | SQL queries used to validate wallet balances, transactions, statuses, reversals, refunds, and audit records |

---

# Key Tables Assumed

This project assumes the following logical tables:

| Table         | Purpose                                       |
| ------------- | --------------------------------------------- |
| users         | Stores customer account information           |
| wallets       | Stores customer wallet records and balances   |
| transactions  | Stores financial transaction records          |
| wallet_ledger | Stores debit and credit movement records      |
| beneficiaries | Stores saved transfer beneficiaries           |
| bill_payments | Stores bill payment records                   |
| notifications | Stores notification delivery records          |
| audit_logs    | Stores security and transaction activity logs |

---

# Key Fintech Database Risks Covered

* Wallet balance mismatch
* Duplicate wallet creation
* Duplicate transaction reference
* Duplicate debit
* Duplicate credit
* Failed transaction changing wallet balance
* Missing reversal record
* Missing refund record
* Reversal not linked to original transaction
* Refund not linked to original transaction
* Unauthorized data ownership issue
* Missing audit trail
* API success without database update
* Reconciliation mismatch

---

# Database Validation Approach

Database validation will be performed by comparing:

1. Expected business outcome
2. API response
3. UI display
4. Database record
5. Ledger movement
6. Audit trail

Example:

If a customer funds wallet with ₦5,000 successfully:

* API should return success.
* Wallet balance should increase by ₦5,000.
* Transaction status should be `SUCCESSFUL`.
* Ledger should contain one credit record.
* No duplicate credit should exist.
* Notification record should be created.
* Audit record should exist.

---

# Success Criteria

Database validation is successful when:

1. Wallet balances match expected financial outcomes.
2. Transaction records are complete and accurate.
3. Debit and credit records are balanced.
4. Failed transactions do not incorrectly affect balances.
5. Duplicate requests do not create duplicate records.
6. Reversals and refunds are traceable.
7. Audit logs support investigation.
8. API responses match database state.
9. Records are ready for reconciliation.
