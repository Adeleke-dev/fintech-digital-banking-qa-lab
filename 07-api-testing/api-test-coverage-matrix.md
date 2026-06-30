# API Test Coverage Matrix

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document maps API endpoints to test coverage areas, risk level, validation type, and expected QA focus.

The goal is to show how backend API testing supports fintech quality validation across authentication, wallet operations, funding, transfers, bill payments, transactions, notifications, and security.

---

# API Coverage Matrix

| API Area       | Endpoint / API Action                       |  Method | Risk Level | Test Type              | Validation Focus                                                      | Related Module         |
| -------------- | ------------------------------------------- | ------: | ---------- | ---------------------- | --------------------------------------------------------------------- | ---------------------- |
| Authentication | `/auth/register`                            |    POST | High       | Functional / Negative  | Valid registration, duplicate email, duplicate phone, invalid payload | Authentication         |
| Authentication | `/auth/verify-otp`                          |    POST | High       | Functional / Negative  | Valid OTP, invalid OTP, expired OTP, account verification             | Authentication         |
| Authentication | `/auth/login`                               |    POST | High       | Functional / Security  | Valid login, invalid login, token generation                          | Authentication         |
| Authentication | `/auth/password-reset/request`              |    POST | High       | Functional / Security  | Password reset request, valid email, unregistered email               | Authentication         |
| Authentication | `/auth/password-reset/confirm`              |    POST | High       | Functional / Security  | Valid reset OTP, expired OTP, password update                         | Authentication         |
| Authentication | `/auth/logout`                              |    POST | Medium     | Security               | Session invalidation                                                  | Authentication         |
| Wallet         | `/wallet`                                   |     GET | Critical   | API / Security         | Retrieve authenticated user wallet only                               | Wallet Management      |
| Wallet         | `/wallet/balance`                           |     GET | Critical   | API / DB               | Wallet balance accuracy                                               | Wallet Management      |
| Wallet         | `/wallet/history`                           |     GET | High       | API / DB               | Transaction history accuracy and ownership                            | Wallet Management      |
| Wallet Funding | `/wallet/fund/card/initiate`                |    POST | Critical   | API / Functional       | Card funding initiation and transaction reference                     | Wallet Funding         |
| Wallet Funding | `/wallet/fund/card/callback`                |    POST | Critical   | API / DB               | Successful callback, failed callback, duplicate callback              | Wallet Funding         |
| Wallet Funding | `/wallet/fund/bank/initiate`                |    POST | Critical   | API / Functional       | Bank transfer funding initiation                                      | Wallet Funding         |
| Wallet Funding | `/wallet/fund/bank/callback`                |    POST | Critical   | API / DB               | Delayed confirmation, duplicate confirmation, failed funding          | Wallet Funding         |
| Transfers      | `/transfers/internal`                       |    POST | Critical   | API / DB               | Sender debit, receiver credit, transaction success                    | Money Transfers        |
| Transfers      | `/transfers/external`                       |    POST | Critical   | API / DB               | External transfer initiation, provider response handling              | Money Transfers        |
| Transfers      | `/transfers/beneficiaries`                  |    POST | High       | API / Security         | Add beneficiary, duplicate beneficiary, invalid beneficiary           | Money Transfers        |
| Transfers      | `/transfers/beneficiaries`                  |     GET | High       | API / Security         | View only authenticated user beneficiaries                            | Money Transfers        |
| Transfers      | `/transfers/limits/validate`                |    POST | High       | API / Business Rule    | ₦50,000 per-transaction limit and ₦200,000 daily limit                | Money Transfers        |
| Transactions   | `/transactions`                             |     GET | High       | API / DB               | Transaction listing and ownership                                     | Transaction Processing |
| Transactions   | `/transactions/{reference}`                 |     GET | High       | API / DB               | Transaction detail, status, reference validation                      | Transaction Processing |
| Transactions   | `/transactions/status/update`               |   PATCH | Critical   | API / DB               | Status transition: pending, successful, failed, reversed, refunded    | Transaction Processing |
| Transactions   | `/transactions/reverse`                     |    POST | Critical   | API / DB               | Reversal processing and wallet balance restoration                    | Transaction Processing |
| Transactions   | `/transactions/refund`                      |    POST | Critical   | API / DB               | Refund processing and original transaction linkage                    | Transaction Processing |
| Bill Payments  | `/bills/airtime`                            |    POST | High       | API / DB               | Airtime purchase, wallet debit, transaction status                    | Bill Payments          |
| Bill Payments  | `/bills/data`                               |    POST | High       | API / DB               | Data purchase, provider response, wallet debit                        | Bill Payments          |
| Bill Payments  | `/bills/utility`                            |    POST | High       | API / DB               | Utility payment, provider response, pending/failed states             | Bill Payments          |
| Bill Payments  | `/bills/callback`                           |    POST | Critical   | API / DB               | Provider success, provider failure, duplicate callback                | Bill Payments          |
| Notifications  | `/notifications`                            |     GET | Medium     | API                    | Retrieve user notifications                                           | Notifications          |
| Notifications  | `/notifications/send`                       |    POST | Medium     | Integration            | Send email, SMS, or push notification                                 | Notifications          |
| Notifications  | `/notifications/retry`                      |    POST | Medium     | Integration            | Retry failed notification without changing transaction status         | Notifications          |
| Security       | Protected endpoints without token           | Various | Critical   | Security / API         | `401 Unauthorized` response                                           | Security               |
| Security       | Access another user wallet                  |     GET | Critical   | Security / API         | `403 Forbidden` or defined authorization failure                      | Security               |
| Security       | Duplicate request with same idempotency key |    POST | Critical   | API / DB / Security    | Only one transaction is processed                                     | Security               |
| Security       | Rapid transfer attempts                     |    POST | High       | Security / Integration | Rate limit or fraud control is triggered                              | Security               |

---

# High-Priority API Test Areas

The highest-priority API areas are:

1. Wallet balance API
2. Wallet funding callback APIs
3. Internal transfer API
4. External transfer API
5. Transaction status update API
6. Reversal API
7. Refund API
8. Bill payment callback API
9. Protected API authorization checks
10. Duplicate request/idempotency checks

---

# API Validation Checklist

For each API, validate:

* Correct HTTP method
* Correct status code
* Required fields validation
* Invalid payload handling
* Authentication requirement
* Authorization requirement
* Response body structure
* Error message clarity
* Database update correctness
* Transaction reference uniqueness
* Wallet balance impact
* Duplicate request behavior
* Audit/logging behavior where applicable

---

# Fintech-Specific API Assertions

For financial APIs, confirm:

* Failed transactions do not update wallet balance incorrectly.
* Pending transactions do not appear as successful.
* Duplicate callbacks do not create duplicate credits.
* Duplicate transfer requests do not create duplicate debits.
* Reversals restore wallet balance correctly.
* Refunds are linked to original transactions.
* API success response matches database records.
* Unauthorized users cannot access another user’s wallet or transactions.

---

# API Coverage Summary

| Module                        | API Coverage Priority |
| ----------------------------- | --------------------- |
| Authentication                | High                  |
| Wallet Management             | Critical              |
| Wallet Funding                | Critical              |
| Money Transfers               | Critical              |
| Transaction Processing        | Critical              |
| Bill Payments                 | High                  |
| Notifications                 | Medium                |
| Security and Fraud Prevention | Critical              |

---

# Execution Notes

During API testing, capture:

* Request payload
* Response status code
* Response body
* Headers
* Authentication token behavior
* Database validation result
* Defect ID if failed
* Screenshot or exported Postman evidence

---

# Portfolio Value

This matrix demonstrates that API testing is not treated as a separate activity from business testing. Each endpoint is connected to fintech risks such as wallet balance accuracy, double debit prevention, duplicate credit prevention, failed payment recovery, authorization, transaction status accuracy, and database consistency.
