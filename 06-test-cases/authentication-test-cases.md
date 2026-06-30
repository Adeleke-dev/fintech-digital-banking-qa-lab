# Authentication Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Authentication** module.

Authentication is the entry point into the digital banking platform and is responsible for ensuring that only valid, verified, and authenticated users can access financial services.

The test cases in this document focus on the highest-risk authentication workflows that protect customer accounts and financial transactions.

---

# Scope

This document covers:

* Customer Registration
* OTP Verification
* Customer Login
* Password Reset
* Session Management

These test cases are fully traceable to the Business Requirements, User Stories, Acceptance Criteria, Risk Register, and Test Scenarios created in previous phases.

---

# Test Case Summary

| Test Case ID | Test Case                                       | Priority | Risk     | Test Type             |
| ------------ | ----------------------------------------------- | -------- | -------- | --------------------- |
| TC-AUTH-001  | Successful Customer Registration                | P2       | High     | Functional            |
| TC-AUTH-002  | Successful OTP Verification and Wallet Creation | P1       | High     | Functional / Database |
| TC-AUTH-003  | Successful Customer Login                       | P2       | High     | Functional / API      |
| TC-AUTH-004  | Password Reset Using Valid OTP                  | P2       | High     | Functional / Security |
| TC-AUTH-005  | Expired Session Cannot Access Protected APIs    | P1       | Critical | Security / API        |

---

# Detailed Test Cases

---

## TC-AUTH-001 — Successful Customer Registration

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-AUTH-001    |
| Module               | Authentication |
| Related Requirement  | BR-AUTH-001    |
| Related User Story   | US-AUTH-001    |
| Related Scenario     | TS-AUTH-001    |
| Priority             | P2             |
| Risk Level           | High           |
| Test Type            | Functional     |
| Automation Candidate | Yes            |

### Preconditions

* Customer does not already have an account.
* Registration service is available.

### Test Data

| Field      | Value                                         |
| ---------- | --------------------------------------------- |
| First Name | John                                          |
| Last Name  | Doe                                           |
| Email      | [john.doe@test.com](mailto:john.doe@test.com) |
| Phone      | 08010000001                                   |
| Password   | Password@123                                  |

### Test Steps

1. Open the registration page.
2. Enter all valid customer details.
3. Submit the registration form.

### Expected Result

* Registration is successful.
* Customer account is created.
* Verification OTP is generated and sent.
* Customer account remains unverified.
* Wallet is **not** created until OTP verification.

### Postconditions

* Customer record exists.
* OTP is pending.
* Customer cannot access wallet features.

---

## TC-AUTH-002 — Successful OTP Verification and Wallet Creation

| Field                | Details               |
| -------------------- | --------------------- |
| Test Case ID         | TC-AUTH-002           |
| Module               | Authentication        |
| Related Requirement  | BR-AUTH-002           |
| Related User Story   | US-AUTH-002           |
| Related Scenario     | TS-AUTH-004           |
| Priority             | P1                    |
| Risk Level           | High                  |
| Test Type            | Functional / Database |
| Automation Candidate | Yes                   |

### Preconditions

* Customer has completed registration.
* Valid OTP exists.

### Test Data

| Field | Value                                         |
| ----- | --------------------------------------------- |
| Email | [john.doe@test.com](mailto:john.doe@test.com) |
| OTP   | Valid OTP                                     |

### Test Steps

1. Navigate to OTP verification.
2. Enter the valid OTP.
3. Submit verification.
4. Query the database to confirm wallet creation.

### Expected Result

* OTP is accepted.
* Customer status changes to **Verified**.
* Wallet is created automatically.
* Initial wallet balance is ₦0.00.
* Customer can access wallet features.

### Postconditions

* Customer is verified.
* Wallet exists.
* Wallet balance is ₦0.00.

---

## TC-AUTH-003 — Successful Customer Login

| Field                | Details          |
| -------------------- | ---------------- |
| Test Case ID         | TC-AUTH-003      |
| Module               | Authentication   |
| Related Requirement  | BR-AUTH-003      |
| Related User Story   | US-AUTH-003      |
| Related Scenario     | TS-AUTH-007      |
| Priority             | P2               |
| Risk Level           | High             |
| Test Type            | Functional / API |
| Automation Candidate | Yes              |

### Preconditions

* Customer account is verified.
* Customer has valid credentials.

### Test Data

| Field    | Value                                         |
| -------- | --------------------------------------------- |
| Email    | [john.doe@test.com](mailto:john.doe@test.com) |
| Password | Password@123                                  |

### Test Steps

1. Open the login page.
2. Enter valid credentials.
3. Submit the login request.

### Expected Result

* Login succeeds.
* Access token is generated.
* Refresh token is generated (if applicable).
* Customer is redirected to the dashboard.
* Protected APIs are accessible with the access token.

### Postconditions

* Active authenticated session exists.

---

## TC-AUTH-004 — Password Reset Using Valid OTP

| Field                | Details               |
| -------------------- | --------------------- |
| Test Case ID         | TC-AUTH-004           |
| Module               | Authentication        |
| Related Requirement  | BR-AUTH-004           |
| Related User Story   | US-AUTH-004           |
| Related Scenario     | TS-AUTH-009           |
| Priority             | P2                    |
| Risk Level           | High                  |
| Test Type            | Functional / Security |
| Automation Candidate | Yes                   |

### Preconditions

* Customer account exists.
* Password reset OTP has been generated.

### Test Data

| Field        | Value                                         |
| ------------ | --------------------------------------------- |
| Email        | [john.doe@test.com](mailto:john.doe@test.com) |
| OTP          | Valid Reset OTP                               |
| New Password | NewPassword@123                               |

### Test Steps

1. Request password reset.
2. Enter the valid reset OTP.
3. Enter a new password.
4. Submit the request.
5. Log in using the new password.

### Expected Result

* Password is updated successfully.
* Old password no longer works.
* Login with the new password succeeds.
* Previous sessions are invalidated according to security policy.

### Postconditions

* New password is active.
* Previous credentials are unusable.

---

## TC-AUTH-005 — Expired Session Cannot Access Protected APIs

| Field                | Details        |
| -------------------- | -------------- |
| Test Case ID         | TC-AUTH-005    |
| Module               | Authentication |
| Related Requirement  | BR-AUTH-005    |
| Related User Story   | US-AUTH-005    |
| Related Scenario     | TS-AUTH-011    |
| Priority             | P1             |
| Risk Level           | Critical       |
| Test Type            | Security / API |
| Automation Candidate | Yes            |

### Preconditions

* Customer previously logged in.
* Session token has expired.

### Test Data

| Field        | Value       |
| ------------ | ----------- |
| Access Token | Expired JWT |

### Test Steps

1. Send a request to the Wallet Balance API using the expired token.
2. Send a request to the Money Transfer API using the expired token.
3. Observe the API responses.

### Expected Result

* API returns **401 Unauthorized**.
* No protected resource is returned.
* No wallet or transfer operation is performed.
* User is required to authenticate again.

### Postconditions

* Session remains invalid.
* No financial action occurs.

---

# Traceability Matrix

| Test Case   | Requirement | User Story  | Scenario    |
| ----------- | ----------- | ----------- | ----------- |
| TC-AUTH-001 | BR-AUTH-001 | US-AUTH-001 | TS-AUTH-001 |
| TC-AUTH-002 | BR-AUTH-002 | US-AUTH-002 | TS-AUTH-004 |
| TC-AUTH-003 | BR-AUTH-003 | US-AUTH-003 | TS-AUTH-007 |
| TC-AUTH-004 | BR-AUTH-004 | US-AUTH-004 | TS-AUTH-009 |
| TC-AUTH-005 | BR-AUTH-005 | US-AUTH-005 | TS-AUTH-011 |

---

# Execution Notes

During execution, record the following for each test case:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (screenshots, API responses, SQL query results)

