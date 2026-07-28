# Smoke Test Suite

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the smoke test suite for the Fintech Digital Banking QA Lab.

Smoke testing is a fast, high-level validation performed after a new build or deployment. Its purpose is to confirm that the application is stable enough for deeper functional, integration, API, database, exploratory, and regression testing.

The smoke suite focuses only on critical customer journeys and system components.

---

# Smoke Testing Objectives

The smoke test suite verifies that:

* The application is accessible.
* Authentication services are operational.
* Verified customers can access their wallets.
* Wallet balances can be retrieved.
* Core funding, transfer, and bill-payment workflows are available.
* Critical APIs respond correctly.
* The database is reachable and financial records can be created.
* Security controls protect restricted endpoints.
* No major deployment blocker prevents further testing.

---

# Smoke Test Execution Rules

Smoke tests should be:

* Small and fast.
* Executed after every QA or staging deployment.
* Focused on build stability rather than deep validation.
* Completed before full regression begins.
* Stopped immediately if a critical platform dependency is unavailable.

A failed P1 smoke test should block deeper testing until the build or environment is corrected.

---

# 1. Environment and Application Health

| Smoke ID      | Test                                             | Priority | Level       | Expected Result                        |
| ------------- | ------------------------------------------------ | -------- | ----------- | -------------------------------------- |
| SMOKE-ENV-001 | Open the application                             | P1       | UI          | Application loads without server error |
| SMOKE-ENV-002 | Call API health endpoint                         | P1       | API         | API returns healthy response           |
| SMOKE-ENV-003 | Verify database connectivity                     | P1       | DB          | Database connection is available       |
| SMOKE-ENV-004 | Verify payment-provider mock is reachable        | P1       | Integration | Provider simulation responds           |
| SMOKE-ENV-005 | Verify notification service or mock is reachable | P2       | Integration | Notification dependency responds       |

---

# 2. Authentication Smoke Tests

| Smoke ID       | Test                                        | Priority | Level        | Expected Result                    |
| -------------- | ------------------------------------------- | -------- | ------------ | ---------------------------------- |
| SMOKE-AUTH-001 | Register a new customer using valid details | P1       | UI/API       | Registration succeeds              |
| SMOKE-AUTH-002 | Verify customer using valid OTP             | P1       | UI/API/DB    | Account becomes verified           |
| SMOKE-AUTH-003 | Log in using valid credentials              | P1       | UI/API       | Access token or session is created |
| SMOKE-AUTH-004 | Access protected API using valid token      | P1       | API          | Protected resource is returned     |
| SMOKE-AUTH-005 | Reject protected API request without token  | P1       | Security/API | API returns `401 Unauthorized`     |

---

# 3. Wallet Management Smoke Tests

| Smoke ID         | Test                                         | Priority | Level        | Expected Result                        |
| ---------------- | -------------------------------------------- | -------- | ------------ | -------------------------------------- |
| SMOKE-WALLET-001 | Verify wallet exists for verified customer   | P1       | API/DB       | One active wallet exists               |
| SMOKE-WALLET-002 | Retrieve wallet balance                      | P1       | UI/API       | Correct balance is returned            |
| SMOKE-WALLET-003 | Retrieve wallet transaction history          | P2       | UI/API       | History endpoint responds successfully |
| SMOKE-WALLET-004 | Verify customer cannot access another wallet | P1       | Security/API | Access is denied                       |

---

# 4. Wallet Funding Smoke Tests

| Smoke ID       | Test                                            | Priority | Level  | Expected Result                    |
| -------------- | ----------------------------------------------- | -------- | ------ | ---------------------------------- |
| SMOKE-FUND-001 | Initiate wallet funding                         | P1       | API    | Funding request is accepted        |
| SMOKE-FUND-002 | Process successful funding confirmation         | P1       | API/DB | Wallet is credited once            |
| SMOKE-FUND-003 | Retrieve successful funding transaction         | P1       | API/DB | Transaction status is `SUCCESSFUL` |
| SMOKE-FUND-004 | Verify funding credit appears in wallet history | P2       | UI/API | Funding record is visible          |

---

# 5. Money Transfer Smoke Tests

| Smoke ID           | Test                                        | Priority | Level  | Expected Result                      |
| ------------------ | ------------------------------------------- | -------- | ------ | ------------------------------------ |
| SMOKE-TRANSFER-001 | Complete internal wallet transfer           | P1       | API/DB | Sender debited and receiver credited |
| SMOKE-TRANSFER-002 | Retrieve internal transfer record           | P1       | API/DB | Transaction is traceable             |
| SMOKE-TRANSFER-003 | Initiate external bank transfer             | P1       | API    | Transfer request is accepted         |
| SMOKE-TRANSFER-004 | Reject transfer with insufficient balance   | P1       | API/DB | No debit occurs                      |
| SMOKE-TRANSFER-005 | Reject transfer above per-transaction limit | P1       | API    | Limit rule is enforced               |

---

# 6. Transaction Processing Smoke Tests

| Smoke ID      | Test                                      | Priority | Level  | Expected Result                 |
| ------------- | ----------------------------------------- | -------- | ------ | ------------------------------- |
| SMOKE-TXN-001 | Verify transaction reference is generated | P1       | API/DB | Unique reference exists         |
| SMOKE-TXN-002 | Retrieve transaction by reference         | P1       | API    | Correct transaction is returned |
| SMOKE-TXN-003 | Verify pending-to-successful update       | P1       | API/DB | Status changes correctly        |
| SMOKE-TXN-004 | Verify transaction appears in history     | P2       | UI/API | Transaction record is visible   |

---

# 7. Bill Payment Smoke Tests

| Smoke ID       | Test                                          | Priority | Level  | Expected Result                   |
| -------------- | --------------------------------------------- | -------- | ------ | --------------------------------- |
| SMOKE-BILL-001 | Complete airtime purchase                     | P1       | API/DB | Wallet is debited correctly       |
| SMOKE-BILL-002 | Complete utility bill payment                 | P1       | API/DB | Payment record becomes successful |
| SMOKE-BILL-003 | Retrieve bill-payment transaction             | P2       | API/DB | Payment is traceable              |
| SMOKE-BILL-004 | Reject bill payment with insufficient balance | P1       | API/DB | Wallet remains unchanged          |

---

# 8. Notification Smoke Tests

| Smoke ID        | Test                                                     | Priority | Level           | Expected Result                          |
| --------------- | -------------------------------------------------------- | -------- | --------------- | ---------------------------------------- |
| SMOKE-NOTIF-001 | Trigger notification after successful transaction        | P2       | Integration     | Notification record is created           |
| SMOKE-NOTIF-002 | Verify notification matches transaction status           | P2       | API/Integration | Notification data is accurate            |
| SMOKE-NOTIF-003 | Verify notification failure does not reverse transaction | P1       | API/Integration | Financial transaction remains successful |

---

# 9. Security Smoke Tests

| Smoke ID      | Test                                                         | Priority | Level           | Expected Result                     |
| ------------- | ------------------------------------------------------------ | -------- | --------------- | ----------------------------------- |
| SMOKE-SEC-001 | Reject invalid JWT                                           | P1       | API/Security    | API returns authentication error    |
| SMOKE-SEC-002 | Reject expired JWT                                           | P1       | API/Security    | Protected resource is not returned  |
| SMOKE-SEC-003 | Prevent cross-customer transaction access                    | P1       | API/Security    | Access is denied                    |
| SMOKE-SEC-004 | Process repeated request with same idempotency key only once | P1       | API/DB/Security | No duplicate debit or credit occurs |

---

# Smoke Test Summary

| Area                   | Number of Tests |
| ---------------------- | --------------: |
| Environment and Health |               5 |
| Authentication         |               5 |
| Wallet Management      |               4 |
| Wallet Funding         |               4 |
| Money Transfers        |               5 |
| Transaction Processing |               4 |
| Bill Payments          |               4 |
| Notifications          |               3 |
| Security               |               4 |
| **Total**              |          **38** |

---

# Recommended Fast Smoke Pack

When a very fast deployment check is required, execute these 12 tests first:

1. SMOKE-ENV-001 — Application loads.
2. SMOKE-ENV-002 — API health check passes.
3. SMOKE-ENV-003 — Database is reachable.
4. SMOKE-AUTH-003 — Customer can log in.
5. SMOKE-AUTH-004 — Valid token accesses protected API.
6. SMOKE-WALLET-002 — Wallet balance can be retrieved.
7. SMOKE-FUND-002 — Successful funding credits wallet once.
8. SMOKE-TRANSFER-001 — Internal transfer completes correctly.
9. SMOKE-TXN-002 — Transaction can be retrieved by reference.
10. SMOKE-BILL-001 — Airtime purchase completes.
11. SMOKE-SEC-001 — Invalid JWT is rejected.
12. SMOKE-SEC-004 — Duplicate financial request is processed once.

---

# Smoke Test Entry Criteria

Smoke testing can begin when:

* Build is deployed to QA or staging.
* Application URL is available.
* API is running.
* Database is reachable.
* Test user accounts exist.
* Required mock providers are available.
* No known environment outage blocks execution.

---

# Smoke Test Exit Criteria

The build passes smoke testing when:

* All P1 smoke tests pass.
* Core application and API services are available.
* Authentication works.
* Wallet balance can be retrieved.
* At least one funding, transfer, and bill-payment flow succeeds.
* Protected APIs reject unauthorised access.
* No Critical deployment defect is found.

---

# Failure Handling

If a P1 smoke test fails:

1. Stop full regression execution.
2. Confirm whether the issue is caused by the build, environment, test data, or dependency.
3. Log a blocker defect or environment issue.
4. Notify engineering and release stakeholders.
5. Resume testing only after the issue is resolved and the smoke test passes.

---

# Recruiter Talking Points

This smoke suite demonstrates the ability to:

* Distinguish smoke testing from full regression testing.
* Validate build stability quickly after deployment.
* Prioritise critical fintech journeys.
* Identify release-blocking environment or deployment failures early.
* Combine UI, API, database, integration, and security checks.
* Protect customer funds before deeper testing begins.
