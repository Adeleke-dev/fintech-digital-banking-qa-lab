# API Testing

## Project

**Fintech Digital Banking QA Lab**

---

## Overview

This folder contains API testing documentation and artifacts for the Fintech Digital Banking QA Lab.

API testing is used to validate backend behavior for authentication, wallet management, wallet funding, money transfers, transaction processing, bill payments, notifications, and security controls.

In fintech systems, API testing is important because financial bugs may exist at the backend level even when the UI appears correct.

---

## Purpose

The purpose of API testing is to verify:

* API request validation
* Response status codes
* Response body structure
* Authentication and authorization behavior
* Wallet balance updates
* Transaction status changes
* Duplicate request prevention
* Failed payment handling
* Reversal and refund behavior
* API and database consistency
* Security and fraud prevention controls

---

## API Testing Scope

The API testing scope includes:

1. Authentication APIs
2. Wallet APIs
3. Wallet Funding APIs
4. Money Transfer APIs
5. Transaction APIs
6. Bill Payment APIs
7. Notification APIs
8. Security and Fraud Prevention APIs

---

## API Testing Artifacts

| File                                            | Purpose                                                               |
| ----------------------------------------------- | --------------------------------------------------------------------- |
| api-test-coverage-matrix.md                     | Maps API endpoints to test coverage, risk level, and validation focus |
| fintech-digital-banking.postman_collection.json | Postman collection for API execution                                  |
| environment.json                                | Postman environment variables                                         |
| api-test-notes.md                               | Notes on execution, assumptions, test data, and observations          |

---

## Key Fintech API Risks Covered

* Duplicate transfer requests
* Duplicate funding callbacks
* Wallet credited before payment confirmation
* Failed transfer not reversed
* Incorrect wallet balance
* Unauthorized wallet access
* Invalid or expired token access
* Transaction status mismatch
* API response success while database update fails
* Missing transaction reference

---

## API Testing Approach

API testing will include:

* Positive testing
* Negative testing
* Authentication testing
* Authorization testing
* Idempotency testing
* Data validation testing
* Transaction lifecycle testing
* Error response validation
* API-to-database validation

---

## Tools

Recommended tools:

* Postman
* Newman
* SQL client
* Swagger/OpenAPI documentation
* GitHub for documentation and evidence

---

## Success Criteria

API testing is successful when:

1. Critical financial APIs behave according to business rules.
2. Unauthorized access is blocked.
3. Invalid requests are rejected.
4. Duplicate financial requests do not cause duplicate debit or credit.
5. Wallet balances are updated correctly.
6. Transaction statuses are accurate.
7. API responses match database records.
8. Critical API defects are documented and triaged.
