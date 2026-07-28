# Security Testing Checklist

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This checklist provides a structured approach for validating the security of the Fintech Digital Banking platform.

Security testing in fintech must protect:

* Customer identities
* Wallet balances
* Transactions
* Beneficiaries
* Payment information
* Authentication credentials
* Personal data
* Administrative functions
* Audit records
* Financial operations

The checklist focuses on practical QA validation across authentication, authorisation, APIs, sessions, financial abuse, fraud controls, auditability, and sensitive data protection.

---

# Purpose

The purpose of this checklist is to:

* Validate that only authorised users can access protected features.
* Prevent customers from accessing another customer’s data.
* Confirm authentication and session controls work correctly.
* Protect against duplicate and fraudulent financial requests.
* Validate transfer limits and abuse controls.
* Protect sensitive data in APIs, logs, and audit records.
* Confirm security failures do not create financial impact.
* Support regression, UAT, and release-readiness reviews.

---

# Security Testing Scope

The checklist covers:

1. Registration security
2. OTP security
3. Login security
4. Password reset security
5. Session management
6. Token validation
7. Authorisation
8. Object-level access control
9. API security
10. Financial transaction security
11. Fraud and abuse prevention
12. Sensitive data protection
13. Audit logging
14. Administrative security
15. Third-party integration security
16. Database security
17. Error handling
18. Security monitoring
19. Release readiness

---

# Checklist Status Guide

| Status         | Meaning                            |
| -------------- | ---------------------------------- |
| Pass           | Security control works as expected |
| Fail           | Security control is ineffective    |
| Blocked        | Test could not be completed        |
| Not Applicable | Control does not apply             |
| Not Tested     | Test has not yet been executed     |

---

# 1. Registration Security

| Security Check                                                              | Status | Evidence |
| --------------------------------------------------------------------------- | :----: | -------- |
| Registration requires valid mandatory fields                                |    ☐   |          |
| Invalid email format is rejected                                            |    ☐   |          |
| Weak passwords are rejected                                                 |    ☐   |          |
| Duplicate email registration is prevented                                   |    ☐   |          |
| Duplicate phone registration is prevented where required                    |    ☐   |          |
| Registration does not expose whether unrelated accounts exist unnecessarily |    ☐   |          |
| Restricted roles cannot be selected during public registration              |    ☐   |          |
| Registration data is validated on the server                                |    ☐   |          |
| Malicious input is rejected or sanitised                                    |    ☐   |          |
| Registration attempts are rate-limited where required                       |    ☐   |          |
| Sensitive registration data is not exposed in logs                          |    ☐   |          |

---

# 2. OTP Security

| Security Check                                     | Status | Evidence |
| -------------------------------------------------- | :----: | -------- |
| Valid OTP verifies the correct customer only       |    ☐   |          |
| Invalid OTP is rejected                            |    ☐   |          |
| Expired OTP is rejected                            |    ☐   |          |
| Previously used OTP cannot be reused               |    ☐   |          |
| OTP attempt limit is enforced                      |    ☐   |          |
| Excessive OTP requests are rate-limited            |    ☐   |          |
| New OTP invalidates older OTP where required       |    ☐   |          |
| OTP is never returned in a production API response |    ☐   |          |
| OTP is never stored in plain text in logs          |    ☐   |          |
| OTP cannot verify another customer’s account       |    ☐   |          |
| Brute-force attempts trigger protection            |    ☐   |          |

---

# 3. Login Security

| Security Check                                                         | Status | Evidence |
| ---------------------------------------------------------------------- | :----: | -------- |
| Valid credentials create an authenticated session                      |    ☐   |          |
| Invalid password is rejected                                           |    ☐   |          |
| Unknown account is handled securely                                    |    ☐   |          |
| Suspended account cannot log in                                        |    ☐   |          |
| Locked account cannot log in                                           |    ☐   |          |
| Unverified account follows the approved rule                           |    ☐   |          |
| Repeated failed logins trigger rate limiting or lockout                |    ☐   |          |
| Login error messages do not reveal sensitive account details           |    ☐   |          |
| Password is not exposed in request logs                                |    ☐   |          |
| Authentication events are audited                                      |    ☐   |          |
| Login over an insecure channel is prevented in applicable environments |    ☐   |          |

---

# 4. Password Reset Security

| Security Check                                                         | Status | Evidence |
| ---------------------------------------------------------------------- | :----: | -------- |
| Password reset request accepts only valid input                        |    ☐   |          |
| Reset response does not reveal whether an account exists unnecessarily |    ☐   |          |
| Reset token or OTP expires                                             |    ☐   |          |
| Reset token cannot be reused                                           |    ☐   |          |
| Reset token belongs only to the intended account                       |    ☐   |          |
| New password follows password policy                                   |    ☐   |          |
| Old password no longer works after successful reset                    |    ☐   |          |
| Existing sessions are invalidated according to policy                  |    ☐   |          |
| Reset action creates an audit event                                    |    ☐   |          |
| Reset token is not stored in plain text in logs                        |    ☐   |          |
| Excessive reset requests are rate-limited                              |    ☐   |          |

---

# 5. Session Management

| Security Check                                          | Status | Evidence |
| ------------------------------------------------------- | :----: | -------- |
| Session is created only after successful authentication |    ☐   |          |
| Logout invalidates the session                          |    ☐   |          |
| Logged-out token cannot access protected APIs           |    ☐   |          |
| Expired session is rejected                             |    ☐   |          |
| Idle timeout follows the approved policy                |    ☐   |          |
| Absolute session timeout follows policy                 |    ☐   |          |
| Session token is not exposed in URLs                    |    ☐   |          |
| Session token is not exposed in logs                    |    ☐   |          |
| Concurrent session behaviour follows policy             |    ☐   |          |
| Password reset invalidates sessions where required      |    ☐   |          |
| Suspended account sessions are revoked where required   |    ☐   |          |

---

# 6. Token and JWT Validation

| Security Check                                                                  | Status | Evidence |
| ------------------------------------------------------------------------------- | :----: | -------- |
| Missing token returns `401 Unauthorized`                                        |    ☐   |          |
| Invalid token is rejected                                                       |    ☐   |          |
| Expired token is rejected                                                       |    ☐   |          |
| Tampered token is rejected                                                      |    ☐   |          |
| Token with invalid signature is rejected                                        |    ☐   |          |
| Token with unsupported algorithm is rejected                                    |    ☐   |          |
| Token intended for another audience is rejected where applicable                |    ☐   |          |
| Token issuer is validated where applicable                                      |    ☐   |          |
| Token role claims are not trusted without server-side validation where required |    ☐   |          |
| Refresh token cannot be used as an access token                                 |    ☐   |          |
| Revoked token or session is rejected where supported                            |    ☐   |          |

---

# 7. Role-Based Authorisation

| Security Check                                                | Status | Evidence |
| ------------------------------------------------------------- | :----: | -------- |
| Customer can access customer-approved resources only          |    ☐   |          |
| Operations user can access only approved operational features |    ☐   |          |
| Admin-only endpoints reject normal customers                  |    ☐   |          |
| Restricted actions require the correct role                   |    ☐   |          |
| Role changes require authorised action                        |    ☐   |          |
| Role changes are audited                                      |    ☐   |          |
| User cannot modify role in request payload                    |    ☐   |          |
| User cannot change protected account status                   |    ☐   |          |
| Hidden UI controls are still protected at API level           |    ☐   |          |
| Direct endpoint access does not bypass role restrictions      |    ☐   |          |

---

# 8. Object-Level Authorisation

Object-level authorisation confirms that authenticated users can access only records they own or are explicitly permitted to use.

| Security Check                                                         | Status | Evidence |
| ---------------------------------------------------------------------- | :----: | -------- |
| Customer cannot view another customer’s wallet                         |    ☐   |          |
| Customer cannot view another customer’s balance                        |    ☐   |          |
| Customer cannot view another customer’s transactions                   |    ☐   |          |
| Customer cannot access another customer’s beneficiary                  |    ☐   |          |
| Customer cannot update another customer’s beneficiary                  |    ☐   |          |
| Customer cannot delete another customer’s beneficiary                  |    ☐   |          |
| Customer cannot access another customer’s funding record               |    ☐   |          |
| Customer cannot access another customer’s bill payment                 |    ☐   |          |
| Customer cannot access another customer’s notifications                |    ☐   |          |
| Resource ownership is enforced server-side                             |    ☐   |          |
| Changing a resource ID in the request does not bypass ownership checks |    ☐   |          |

---

# 9. API Security

| Security Check                                                   | Status | Evidence |
| ---------------------------------------------------------------- | :----: | -------- |
| Protected endpoints require authentication                       |    ☐   |          |
| Request payloads are validated server-side                       |    ☐   |          |
| Unexpected fields are rejected or safely ignored                 |    ☐   |          |
| Invalid data types are rejected                                  |    ☐   |          |
| Oversized payloads are restricted                                |    ☐   |          |
| Malformed JSON is handled safely                                 |    ☐   |          |
| Unsupported HTTP methods are rejected                            |    ☐   |          |
| Sensitive endpoints use appropriate rate limits                  |    ☐   |          |
| API does not expose internal stack traces                        |    ☐   |          |
| Error responses do not reveal database or infrastructure details |    ☐   |          |
| API versioning cannot bypass security controls                   |    ☐   |          |
| Deprecated endpoints remain secured or disabled                  |    ☐   |          |
| CORS policy follows approved rules                               |    ☐   |          |
| Security headers are present where applicable                    |    ☐   |          |

---

# 10. Financial Transaction Security

| Security Check                                                  | Status | Evidence |
| --------------------------------------------------------------- | :----: | -------- |
| Transaction requires authenticated customer                     |    ☐   |          |
| Customer can use only owned wallet                              |    ☐   |          |
| Sufficient-balance validation is enforced server-side           |    ☐   |          |
| Negative amount is rejected                                     |    ☐   |          |
| Zero amount is rejected                                         |    ☐   |          |
| Excessive amount is rejected                                    |    ☐   |          |
| Per-transaction limit is enforced                               |    ☐   |          |
| Cumulative daily limit is enforced                              |    ☐   |          |
| Duplicate request does not create duplicate debit               |    ☐   |          |
| Duplicate callback does not create duplicate credit             |    ☐   |          |
| Idempotency key is validated                                    |    ☐   |          |
| Reusing idempotency key with different request data is rejected |    ☐   |          |
| Transaction reference is unique                                 |    ☐   |          |
| Failed pre-debit transaction does not change balance            |    ☐   |          |
| Failed post-debit transaction creates reversal                  |    ☐   |          |
| Refund cannot exceed remaining refundable amount                |    ☐   |          |
| Unauthorised user cannot initiate refund                        |    ☐   |          |
| Manual financial adjustment requires approved role and reason   |    ☐   |          |

---

# 11. Double-Debit and Double-Credit Prevention

## Double-Debit Checks

| Security Check                                         | Status | Evidence |
| ------------------------------------------------------ | :----: | -------- |
| Rapid repeated button clicks cause one debit           |    ☐   |          |
| Browser refresh causes no additional debit             |    ☐   |          |
| Client timeout retry causes no additional debit        |    ☐   |          |
| Concurrent identical API requests cause one debit      |    ☐   |          |
| Queue redelivery causes one debit                      |    ☐   |          |
| Duplicate external request reference is handled safely |    ☐   |          |

## Double-Credit Checks

| Security Check                                         | Status | Evidence |
| ------------------------------------------------------ | :----: | -------- |
| Duplicate provider callback causes one credit          |    ☐   |          |
| Replayed webhook causes one credit                     |    ☐   |          |
| Reversal retry causes one reversal credit              |    ☐   |          |
| Refund retry causes one refund credit                  |    ☐   |          |
| Recovery job rerun causes no extra credit              |    ☐   |          |
| Duplicate bank-transfer notification causes one credit |    ☐   |          |

---

# 12. Fraud and Abuse Prevention

| Security Check                                                      | Status | Evidence |
| ------------------------------------------------------------------- | :----: | -------- |
| Repeated failed logins trigger control                              |    ☐   |          |
| Rapid transfer attempts trigger rate or fraud control               |    ☐   |          |
| Multiple transfers just below a limit are detected where required   |    ☐   |          |
| Excessive beneficiary creation is controlled where required         |    ☐   |          |
| Suspicious device or location change is handled according to policy |    ☐   |          |
| Unusual transaction velocity is detected                            |    ☐   |          |
| Transfer-limit bypass through concurrent requests is prevented      |    ☐   |          |
| Duplicate account creation is controlled                            |    ☐   |          |
| Repeated refund attempts are controlled                             |    ☐   |          |
| Fraud-related events are audited                                    |    ☐   |          |
| Fraud control failure does not expose sensitive rule details        |    ☐   |          |

---

# 13. Sensitive Data Protection

| Security Check                                           | Status | Evidence |
| -------------------------------------------------------- | :----: | -------- |
| Passwords are never returned in API responses            |    ☐   |          |
| OTP values are not exposed                               |    ☐   |          |
| Access tokens are not written to logs                    |    ☐   |          |
| Refresh tokens are not written to logs                   |    ☐   |          |
| Secret keys are not exposed                              |    ☐   |          |
| Full card numbers are not exposed                        |    ☐   |          |
| CVV is never stored                                      |    ☐   |          |
| Sensitive fields are masked                              |    ☐   |          |
| Personal data is returned only when required             |    ☐   |          |
| Cross-customer personal data is not exposed              |    ☐   |          |
| Error messages do not expose secrets                     |    ☐   |          |
| Audit records do not contain prohibited sensitive values |    ☐   |          |
| Exports follow approved access controls                  |    ☐   |          |

---

# 14. Audit Logging Security

| Security Check                                         | Status | Evidence |
| ------------------------------------------------------ | :----: | -------- |
| Successful login is audited                            |    ☐   |          |
| Failed login is audited                                |    ☐   |          |
| Password reset is audited                              |    ☐   |          |
| Financial transaction initiation is audited            |    ☐   |          |
| Financial status transition is audited                 |    ☐   |          |
| Reversal is audited                                    |    ☐   |          |
| Refund is audited                                      |    ☐   |          |
| Manual wallet adjustment is audited                    |    ☐   |          |
| Role change is audited                                 |    ☐   |          |
| Unauthorised access attempt is audited                 |    ☐   |          |
| Duplicate request detection is audited                 |    ☐   |          |
| Audit records contain correct actor and resource       |    ☐   |          |
| Audit records cannot be modified by unauthorised users |    ☐   |          |
| Sensitive data is masked in audit records              |    ☐   |          |

---

# 15. Administrative Security

| Security Check                                                 | Status | Evidence |
| -------------------------------------------------------------- | :----: | -------- |
| Admin endpoints reject non-admin users                         |    ☐   |          |
| Admin actions require authenticated sessions                   |    ☐   |          |
| Account suspension is role-restricted                          |    ☐   |          |
| Account reactivation is role-restricted                        |    ☐   |          |
| Refund approval is role-restricted                             |    ☐   |          |
| Manual wallet adjustment is role-restricted                    |    ☐   |          |
| Transfer-limit configuration is role-restricted                |    ☐   |          |
| Role changes require authorised access                         |    ☐   |          |
| High-risk actions require reason or approval reference         |    ☐   |          |
| Administrative actions are audited                             |    ☐   |          |
| Admin cannot silently modify audit records                     |    ☐   |          |
| Privilege escalation through payload manipulation is prevented |    ☐   |          |

---

# 16. Third-Party Integration Security

| Security Check                                                       | Status | Evidence |
| -------------------------------------------------------------------- | :----: | -------- |
| Provider callbacks are authenticated or verified                     |    ☐   |          |
| Callback signature is validated where supported                      |    ☐   |          |
| Invalid callback signature is rejected                               |    ☐   |          |
| Callback timestamp or replay protection is validated where supported |    ☐   |          |
| Provider reference is unique                                         |    ☐   |          |
| Duplicate callback is idempotent                                     |    ☐   |          |
| Provider secret is not exposed                                       |    ☐   |          |
| Sensitive provider response data is not logged unnecessarily         |    ☐   |          |
| Callback endpoint accepts only approved methods                      |    ☐   |          |
| Malformed callback payload is rejected safely                        |    ☐   |          |
| Conflicting callbacks follow approved state rules                    |    ☐   |          |
| Provider timeout does not create insecure retry behaviour            |    ☐   |          |

---

# 17. Database Security and Integrity

| Security Check                                              | Status | Evidence |
| ----------------------------------------------------------- | :----: | -------- |
| Customer cannot access database directly                    |    ☐   |          |
| Application uses least-privilege database access            |    ☐   |          |
| Sensitive fields are protected                              |    ☐   |          |
| Financial references use unique constraints where required  |    ☐   |          |
| Foreign-key relationships are enforced                      |    ☐   |          |
| Financial operations use atomic transactions where required |    ☐   |          |
| Ownership filters are enforced in queries                   |    ☐   |          |
| SQL injection attempts are rejected                         |    ☐   |          |
| Audit records are protected from unauthorised updates       |    ☐   |          |
| Manual financial changes require controlled access          |    ☐   |          |
| Backup and restore preserve financial integrity             |    ☐   |          |
| Test data does not expose real customer data                |    ☐   |          |

---

# 18. Error Handling Security

| Security Check                                           | Status | Evidence |
| -------------------------------------------------------- | :----: | -------- |
| Error response does not expose stack trace               |    ☐   |          |
| Error response does not expose SQL query                 |    ☐   |          |
| Error response does not expose server path               |    ☐   |          |
| Error response does not expose secret configuration      |    ☐   |          |
| Authentication errors use appropriate status codes       |    ☐   |          |
| Authorisation errors use appropriate status codes        |    ☐   |          |
| Validation errors are clear but not overly revealing     |    ☐   |          |
| Provider errors are safely mapped                        |    ☐   |          |
| Internal exception does not create financial duplication |    ☐   |          |
| Failed request remains traceable through request ID      |    ☐   |          |

---

# 19. Security Monitoring

| Security Check                                             | Status | Evidence |
| ---------------------------------------------------------- | :----: | -------- |
| Failed-login spikes can be detected                        |    ☐   |          |
| Brute-force attempts trigger alert                         |    ☐   |          |
| Repeated unauthorised access triggers alert where required |    ☐   |          |
| Rapid transfer attempts can be detected                    |    ☐   |          |
| Daily-limit breaches can be detected                       |    ☐   |          |
| Duplicate callback patterns can be detected                |    ☐   |          |
| Failed debited transfers without reversal trigger alert    |    ☐   |          |
| Suspicious refund activity is detectable                   |    ☐   |          |
| Audit-log failures are detectable                          |    ☐   |          |
| Security events contain correlation IDs                    |    ☐   |          |
| Alerts reach the correct operational owner                 |    ☐   |          |

---

# 20. Security Regression Pack

The following checks should run for every significant release:

* Missing token rejection
* Invalid token rejection
* Expired token rejection
* Logged-out session rejection
* Cross-user wallet access
* Cross-user transaction access
* Cross-user beneficiary access
* Admin endpoint access by customer
* Duplicate payment request
* Duplicate callback
* Daily transfer-limit enforcement
* Rapid transfer attempts
* Refund authorisation
* Over-refund rejection
* Sensitive data exposure
* Audit-event creation
* Provider callback signature validation
* Error-response information leakage

---

# Detailed Scenario 1 — Cross-Customer Wallet Access

## Scenario

Customer A requests Customer B’s wallet details by changing the wallet identifier.

## Expected Result

* Request is rejected.
* No wallet balance or personal data is returned.
* No database modification occurs.
* Security event is audited.
* Response does not confirm unnecessary details about Customer B.

## Severity

**Critical**

---

# Detailed Scenario 2 — Duplicate Transfer Request

## Scenario

A customer submits the same £100 transfer request twice using the same idempotency key.

## Expected Result

* One transfer is created.
* Customer is debited once.
* Receiver is credited once where applicable.
* Repeated request returns the same logical result.
* Duplicate attempt is traceable.

## Severity

**Critical**

---

# Detailed Scenario 3 — Expired JWT

## Scenario

A customer uses an expired access token to retrieve wallet balance.

## Expected Result

* API returns `401 Unauthorized`.
* No wallet data is returned.
* Request is recorded according to security policy.
* Customer must authenticate again or use the approved refresh flow.

## Severity

**Critical**

---

# Detailed Scenario 4 — Transfer-Limit Concurrency

## Scenario

A customer sends two concurrent transfers that individually appear valid but together exceed the daily limit.

## Expected Result

* Limit validation remains correct under concurrency.
* At most the eligible transfer is approved.
* The daily limit cannot be bypassed.
* Rejected request creates no debit.

## Severity

**Critical**

---

# Detailed Scenario 5 — Unauthorised Refund

## Scenario

A normal customer attempts to call an admin refund endpoint directly.

## Expected Result

* Request is denied.
* No refund transaction is created.
* Wallet is unchanged.
* Security event is audited.
* Admin-only details are not exposed.

## Severity

**Critical**

---

# Security Test Evidence

Capture:

* Request payload
* Response body
* HTTP status
* Authenticated user
* Role
* Resource owner
* Access token state
* Idempotency key
* Transaction reference
* Wallet balance before and after
* Database records
* Audit event
* Application logs
* Provider callback evidence
* Screenshots where useful

Sensitive evidence should be masked before adding it to the portfolio.

---

# Severity Guidance

## Critical

* Cross-customer financial access
* Authentication bypass
* Privilege escalation
* Double debit
* Double credit
* Unauthorised refund
* Expired token grants access
* Provider callback forgery creates financial impact
* Sensitive secret exposure

## High

* Transfer-limit bypass
* Brute-force protection missing
* Important security event not audited
* Session remains active after required revocation
* Sensitive personal data exposed without financial action

## Medium

* Incomplete masking of low-risk metadata
* Weak but non-exploitable error detail
* Missing non-critical audit metadata

## Low

* Cosmetic security-message issue
* Minor documentation inconsistency

---

# Security Entry Criteria

Security testing can begin when:

* Authentication is implemented.
* Roles and permissions are documented.
* Test users for different roles exist.
* Multiple customer accounts are available.
* Protected APIs are deployed.
* Database validation access is available.
* Fraud and rate-limit rules are known.
* Provider callback security rules are documented.
* Audit logs can be queried.

---

# Security Exit Criteria

Security validation is complete when:

* Critical authentication tests pass.
* Critical authorisation tests pass.
* Cross-user access is prevented.
* Duplicate financial processing is prevented.
* Sensitive data exposure tests pass.
* Provider callbacks are protected.
* High-risk administrative functions are restricted.
* Security audit events are created.
* No unresolved Critical security defect remains.
* Regression coverage is updated.
* Security risks are included in the release recommendation.

---

# How a QA Engineer Performs Security Testing

A QA Engineer:

* Tests valid and invalid authentication.
* Changes resource identifiers to test ownership.
* Validates roles and permissions.
* Checks error responses.
* Tests repeated financial requests.
* Confirms sensitive data is not exposed.
* Captures evidence and raises defects.

---

# How a Senior QA Performs Security Testing

A Senior QA Engineer:

* Identifies high-risk attack and abuse paths.
* Reviews security requirements early.
* Connects vulnerabilities to financial and privacy impact.
* Prioritises security regression.
* Coordinates with Security, Product, Engineering, and Operations.
* Uses unresolved security risk in release decisions.
* Ensures related endpoints are reviewed for the same vulnerability pattern.

---

# How an SDET Approaches Security Testing

An SDET:

* Automates token, role, and ownership checks.
* Builds cross-user API test suites.
* Adds duplicate-request and concurrency tests.
* Automates sensitive-data assertions.
* Integrates security regression into CI.
* Builds provider-callback verification tests.
* Adds audit and database checks after security events.

---

# Common Production Issues

* Expired token still accesses protected API.
* Customer retrieves another customer’s data.
* Admin endpoint accessible by normal customer.
* Duplicate request creates double debit.
* Callback replay creates double credit.
* Daily transfer limit bypassed through concurrency.
* Password-reset token reused.
* Sensitive token written to logs.
* Manual adjustment performed without audit record.
* Provider callback accepted without signature verification.
* Error response reveals internal infrastructure details.

---

# Common Interview Questions

## What is the difference between authentication and authorisation?

Authentication verifies who the user is. Authorisation verifies what that user is allowed to access or perform.

## How do you test object-level authorisation?

I authenticate as one customer and attempt to access another customer’s wallet, transaction, beneficiary, or other owned resource by changing the identifier. The API must deny access and return no sensitive information.

## How do you test duplicate financial requests?

I send the same request sequentially and concurrently using the same idempotency key, then confirm only one transaction, debit, credit, and ledger impact exists.

## How do you test an expired token?

I use an expired access token against every protected endpoint and verify that each request returns `401 Unauthorized` without exposing data or changing financial state.

## What is the most important fintech security risk?

Unauthorised access and duplicate financial processing are among the highest risks because they may expose customer data or directly affect customer funds.

---

# Recruiter Talking Points

This checklist demonstrates the ability to:

* Test authentication, authorisation, and session security.
* Validate object-level ownership.
* Protect financial APIs against duplicate and fraudulent requests.
* Test role-based access control.
* Validate sensitive-data handling.
* Assess third-party callback security.
* Connect security findings to financial, privacy, and release risk.
* Build reusable security regression coverage.

---

# QA Lead Conclusion

Security testing in fintech is not limited to checking login.

A secure digital banking platform must prove that:

* Users are correctly authenticated.
* Customers can access only their own records.
* Privileged actions are restricted.
* Duplicate requests cannot move money twice.
* Provider callbacks cannot be forged or replayed.
* Sensitive data remains protected.
* Security events are traceable.
* Fraud and abuse controls work under realistic conditions.

A fintech release should not proceed while a known vulnerability can expose customer data, bypass financial controls, or create unauthorised money movement.
