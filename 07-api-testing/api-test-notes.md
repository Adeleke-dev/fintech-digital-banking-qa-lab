# API Test Notes

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document captures the assumptions, execution notes, observations, risks, lessons learned, and best practices identified while performing API testing for the Fintech Digital Banking QA Lab.

Unlike the API Coverage Matrix, which defines *what* is tested, this document records *how* API testing is approached and the important considerations discovered during execution.

---

# API Testing Objectives

The objectives of API testing are to:

* Validate backend business logic independently of the UI.
* Verify financial transactions are processed correctly.
* Ensure APIs enforce authentication and authorization.
* Confirm wallet balances remain accurate.
* Validate transaction lifecycle management.
* Prevent duplicate financial processing.
* Verify database consistency.
* Detect backend defects before they reach production.

---

# Test Environment

| Item                  | Value                  |
| --------------------- | ---------------------- |
| Environment           | QA / Staging           |
| API Documentation     | Swagger / OpenAPI      |
| API Client            | Postman                |
| Database              | PostgreSQL             |
| Authentication        | JWT                    |
| Test Users            | Seeded QA Accounts     |
| Payment Gateway       | Mock Provider          |
| Notification Provider | Mock Email/SMS Service |

---

# Test Data Strategy

The following test data was prepared before execution:

### Customer Accounts

* Verified customer
* Unverified customer
* Suspended customer
* Customer with zero wallet balance
* Customer with sufficient wallet balance

### Wallet Data

* Empty wallet
* Wallet with transaction history
* Wallet near transfer limits

### Financial Data

* Pending transaction
* Successful transaction
* Failed transaction
* Reversed transaction
* Refunded transaction

### Security Data

* Expired JWT token
* Invalid JWT token
* Missing authentication token
* Duplicate idempotency key

---

# API Validation Checklist

Each API request should verify:

## Request Validation

* Required fields
* Optional fields
* Invalid data types
* Missing parameters
* Boundary values

---

## Response Validation

* HTTP status code
* Response message
* Response schema
* Response time
* Error handling
* Transaction reference

---

## Business Rule Validation

* Wallet balance accuracy
* Transaction status
* Transfer limits
* Duplicate request handling
* Reversal logic
* Refund logic
* Beneficiary ownership
* Notification trigger

---

## Database Validation

Confirm that:

* Wallet balance matches API response.
* Transaction record is created.
* Status is updated correctly.
* Debit and credit records balance.
* Audit records are generated.
* Duplicate transactions are not stored.

---

# API Execution Notes

## Authentication APIs

Focus areas:

* JWT generation
* Token expiry
* Unauthorized access
* Password reset
* OTP verification

Potential production risks:

* Token never expires.
* Invalid token accepted.
* OTP reused.
* Multiple active sessions.

---

## Wallet APIs

Focus areas:

* Wallet ownership
* Balance accuracy
* Transaction history

Potential production risks:

* Wrong customer wallet returned.
* Incorrect balance.
* Missing transaction history.

---

## Wallet Funding APIs

Focus areas:

* Successful funding
* Failed funding
* Pending funding
* Duplicate callback

Potential production risks:

* Double credit
* Missing transaction record
* Wallet credited before provider confirmation

---

## Transfer APIs

Focus areas:

* Internal transfers
* External transfers
* Beneficiaries
* Transfer limits

Potential production risks:

* Double debit
* Transfer without sufficient balance
* Missing reversal
* Beneficiary authorization failure

---

## Transaction APIs

Focus areas:

* Status transitions
* Transaction lookup
* Reversal
* Refund

Potential production risks:

* Incorrect status transition
* Duplicate transaction reference
* Refund without original transaction
* Reversal failure

---

## Bill Payment APIs

Focus areas:

* Airtime
* Data
* Utilities
* Provider callback

Potential production risks:

* Double debit
* Failed provider response
* Missing refund
* Duplicate callback

---

## Notification APIs

Focus areas:

* Email
* SMS
* Push notification

Potential production risks:

* Incorrect notification content
* Missing notification
* Notification affecting transaction processing

---

## Security APIs

Focus areas:

* Authentication
* Authorization
* Duplicate requests
* Rate limiting
* Fraud controls

Potential production risks:

* Unauthorized API access
* Customer data exposure
* Replay attacks
* Duplicate financial transactions

---

# Common API Defects in Fintech

Examples of defects likely to be identified during testing:

* Incorrect HTTP status codes
* Missing field validation
* Wallet balance mismatch
* Duplicate transaction processing
* Transaction reference duplication
* Failed reversal
* Incorrect refund amount
* Unauthorized resource access
* Missing audit logs
* Inconsistent API and database records

---

# Lessons Learned

During API testing, always remember:

1. Never rely only on the UI.
2. Validate every financial transaction in the database.
3. Test duplicate requests and idempotency.
4. Verify transaction status transitions.
5. Validate both success and failure paths.
6. Confirm wallet balances before and after every financial operation.
7. Check that notification failures do not affect financial processing.
8. Ensure every financial action is traceable through logs and audit records.

---

# Evidence to Capture

For every executed API test, retain evidence such as:

* Postman request
* Postman response
* Response headers
* Status code
* SQL query result
* Screenshot of successful execution
* Screenshot of failed execution
* Defect reference (if applicable)

This evidence supports defect reporting, regression testing, and release readiness.

---

# Recruiter Talking Points

This API testing approach demonstrates the ability to:

* Test backend services independently of the UI.
* Validate financial workflows through APIs.
* Perform API-to-database verification.
* Identify high-risk fintech defects.
* Apply risk-based testing.
* Validate idempotency and duplicate request handling.
* Support release decisions with technical evidence.

---

# Phase 7 Completion Criteria

API testing documentation is considered complete when:

* API Coverage Matrix is documented.
* API Test Notes are documented.
* Postman Collection is created.
* Environment variables are configured.
* Critical financial APIs are covered.
* API validation aligns with database validation.
* Evidence is available for execution and reporting.
