# Test Plan

## Project: Fintech Digital Banking QA Lab

## Phase 4 Deliverable

---

# 1. Document Purpose

This Test Plan defines the practical execution plan for testing the Fintech Digital Banking QA Lab.

It explains what will be tested, what will not be tested, test levels, test types, test data, entry criteria, exit criteria, deliverables, risks, and reporting expectations.

---

# 2. Test Plan Scope

The test plan covers the following modules:

1. Authentication
2. Wallet Management
3. Wallet Funding
4. Money Transfers
5. Transaction Processing
6. Bill Payments
7. Notifications
8. Security and Fraud Prevention

---

# 3. Features To Be Tested

## 3.1 Authentication

Testing will cover:

* customer registration
* duplicate email validation
* duplicate phone validation
* OTP verification
* invalid OTP
* expired OTP
* login
* invalid login
* password reset
* session expiration
* logout
* unverified user restrictions

---

## 3.2 Wallet Management

Testing will cover:

* wallet creation after OTP verification
* prevention of duplicate wallet creation
* initial wallet balance
* wallet balance display
* wallet balance update after credits
* wallet balance update after debits
* wallet history
* wallet history filtering where applicable
* wallet ownership validation

---

## 3.3 Wallet Funding

Testing will cover:

* successful card funding
* failed card funding
* pending card funding
* successful bank transfer funding
* failed bank transfer funding
* pending bank transfer funding
* delayed provider confirmation
* duplicate provider callback
* wallet credit validation
* transaction reference validation
* funding notification

---

## 3.4 Money Transfers

Testing will cover:

* successful internal wallet transfer
* insufficient balance transfer
* invalid recipient transfer
* duplicate transfer request
* transfer above ₦50,000 per-transaction limit
* transfer above ₦200,000 daily limit
* successful external bank transfer
* pending external transfer
* failed external transfer before debit
* failed external transfer after debit
* transfer reversal
* beneficiary creation
* beneficiary duplicate validation
* beneficiary ownership validation

---

## 3.5 Transaction Processing

Testing will cover:

* transaction reference creation
* pending transaction status
* successful transaction status
* failed transaction status
* reversed transaction status
* refunded transaction status
* transaction status transition
* transaction history accuracy
* duplicate transaction detection
* audit trail validation

---

## 3.6 Bill Payments

Testing will cover:

* airtime purchase
* data purchase
* utility bill payment
* insufficient balance
* invalid biller details
* failed bill payment before debit
* failed bill payment after debit
* bill payment refund
* bill payment reversal
* duplicate bill payment request
* bill payment notification

---

## 3.7 Notifications

Testing will cover:

* successful funding notification
* successful transfer notification
* failed transaction notification
* reversal notification
* refund notification
* notification content accuracy
* notification failure handling
* email notification
* SMS notification
* push notification

---

## 3.8 Security and Fraud Prevention

Testing will cover:

* invalid authentication
* brute force-like login attempts
* unauthorized wallet access
* unauthorized transaction access
* expired token access
* invalid token access
* unverified user wallet access
* duplicate transfer attempts
* rapid transfer attempts
* cross-user beneficiary access

---

# 4. Features Not To Be Tested In Version 1

The following are out of scope for this version:

* BVN verification
* full KYC onboarding
* loan workflows
* investment trading
* real card processing
* real bank transfer settlement
* real production payment gateway integration
* crypto transactions
* advanced fraud machine learning
* merchant settlement dashboard
* performance testing at scale
* production compliance certification

---

# 5. Test Types

The following test types will be used:

| Test Type                 | Purpose                                                                            |
| ------------------------- | ---------------------------------------------------------------------------------- |
| Functional Testing        | Validate user-facing behavior against requirements                                 |
| Negative Testing          | Validate invalid, failed, and rejected flows                                       |
| API Testing               | Validate backend endpoints and business rules                                      |
| SQL Validation            | Validate database records and financial correctness                                |
| Integration Testing       | Validate interaction between wallet, transaction, provider, and notification flows |
| Regression Testing        | Ensure existing critical flows remain stable                                       |
| Exploratory Testing       | Discover risks not covered by scripted tests                                       |
| Security Testing          | Validate access control and abuse prevention                                       |
| UAT Support               | Validate business acceptance                                                       |
| Release Readiness Testing | Support go/no-go decision                                                          |

---

# 6. Test Levels

Testing will be performed across:

1. Requirement validation
2. Functional workflow testing
3. API-level testing
4. Database validation
5. Integration testing
6. Regression testing
7. UAT support
8. Release readiness review

---

# 7. Test Environment

Testing will use a controlled QA environment.

The QA environment should include:

* test frontend or API client
* backend API
* test database
* test payment provider simulation
* test bill payment provider simulation
* test notification records
* test user accounts
* database query access
* Postman or similar API tool

---

# 8. Test Data Requirements

The following test data will be required:

| Test Data                          | Purpose                             |
| ---------------------------------- | ----------------------------------- |
| Verified customer                  | Test wallet access and transactions |
| Unverified customer                | Test access restrictions            |
| Customer with ₦0 balance           | Test insufficient balance scenarios |
| Customer with sufficient balance   | Test transfers and bill payments    |
| Customer near ₦50,000 limit        | Test per-transaction limit          |
| Customer near ₦200,000 daily limit | Test daily limit                    |
| Recipient wallet user              | Test internal transfers             |
| External bank beneficiary          | Test external transfers             |
| Valid biller details               | Test bill payments                  |
| Invalid biller details             | Test bill payment validation        |
| Duplicate transaction reference    | Test duplicate prevention           |
| Pending transaction reference      | Test pending status handling        |
| Failed transaction reference       | Test failed transaction handling    |
| Reversal transaction record        | Test reversal validation            |
| Refund transaction record          | Test refund validation              |

---

# 9. Test Execution Priority

Testing will be prioritized as follows:

## Priority 1: Critical Financial Flows

* wallet balance accuracy
* card funding success and failure
* bank transfer funding success and failure
* duplicate funding callback
* internal transfer success
* duplicate transfer request
* external transfer failure and reversal
* failed bill payment refund
* unauthorized wallet access

## Priority 2: Important Business Flows

* registration
* OTP verification
* login
* password reset
* beneficiary management
* transaction history
* transfer limit validation
* notification accuracy

## Priority 3: Supporting Flows

* notification delivery failure
* transaction history filtering
* operations review scenarios
* edge case display validations

---

# 10. Entry Criteria

Test execution can begin when:

1. Business requirements are approved.
2. User stories and acceptance criteria are available.
3. Risk register is available.
4. Test environment is ready.
5. Test data is prepared.
6. API documentation or endpoint information is available.
7. Database validation access is available.
8. Build is deployed to the QA environment.
9. Known limitations are documented.

---

# 11. Exit Criteria

Test execution can close when:

1. All Priority 1 test cases are executed.
2. Critical and high-risk test scenarios are covered.
3. No unresolved critical defects remain.
4. High defects are fixed or accepted with business approval.
5. Regression test suite is executed.
6. API testing is completed for in-scope flows.
7. SQL validation is completed for key financial flows.
8. UAT execution is completed or signed off.
9. Test summary report is prepared.
10. Release readiness recommendation is documented.

---

# 12. Suspension Criteria

Testing may be paused if:

1. QA environment is unavailable.
2. API is not accessible.
3. Database access is unavailable for validation.
4. Critical blockers prevent execution.
5. Test data cannot be created.
6. Payment or bill provider simulation is unavailable.
7. Build is unstable and prevents meaningful testing.

---

# 13. Resumption Criteria

Testing may resume when:

1. QA environment is restored.
2. Blocker defects are fixed.
3. Required test data is available.
4. API access is restored.
5. Database access is restored.
6. Provider simulation is available.
7. A stable build is deployed.

---

# 14. Defect Severity Classification

| Severity | Description                                                   | Example                          |
| -------- | ------------------------------------------------------------- | -------------------------------- |
| Critical | Causes financial loss, unauthorized access, or blocks release | User debited twice               |
| High     | Major business flow fails or creates serious customer impact  | Failed transfer not reversed     |
| Medium   | Important function affected but workaround exists             | Transaction notification delayed |
| Low      | Minor UI/content issue with low impact                        | Typo in transaction label        |

---

# 15. Defect Priority Classification

| Priority | Description                  |
| -------- | ---------------------------- |
| P1       | Must be fixed immediately    |
| P2       | Must be fixed before release |
| P3       | Should be fixed soon         |
| P4       | Can be fixed later           |

---

# 16. Test Deliverables

This test plan supports the following deliverables:

1. Test Strategy
2. Test Plan
3. Test Scenarios
4. Test Cases
5. API Coverage Matrix
6. Postman Collection
7. SQL Validation Queries
8. Database Validation Checklist
9. Exploratory Testing Charters
10. Bug Reports
11. Defect Log
12. Defect Triage Documentation
13. Regression Test Suite
14. UAT Checklist
15. UAT Execution Report
16. Test Summary Report
17. Release Readiness Report
18. Release Sign-Off Report
19. Test Metrics Dashboard
20. Stakeholder Status Reports

---

# 17. Roles and Responsibilities

| Role                    | Responsibility                                                                              |
| ----------------------- | ------------------------------------------------------------------------------------------- |
| QA Engineer             | Execute functional, API, SQL, regression, and exploratory tests                             |
| Senior QA               | Review test coverage, prioritize risk, lead defect triage, support release decision         |
| SDET                    | Identify automation candidates, design API checks, support repeatable regression validation |
| Product Owner           | Clarify requirements and acceptance criteria                                                |
| Developer               | Fix defects and support technical investigation                                             |
| Operations/User Support | Support failed transaction and reconciliation review                                        |
| Stakeholder             | Review test reports and approve release readiness                                           |

---

# 18. Test Reporting

QA reporting will include:

* daily or sprint test progress
* executed vs planned tests
* passed tests
* failed tests
* blocked tests
* defects by severity
* defects by module
* critical risk status
* regression status
* release readiness status

---

# 19. Risks and Mitigation

| Risk                                   | Mitigation                                                  |
| -------------------------------------- | ----------------------------------------------------------- |
| Unclear transaction rules              | Clarify during requirement review                           |
| Unstable QA environment                | Track environment blockers and resume after fix             |
| Missing test data                      | Prepare test data before execution                          |
| Provider simulation unavailable        | Use mock responses where possible                           |
| Database access unavailable            | Document limitation and validate through API where possible |
| Duplicate transaction behavior unclear | Confirm idempotency and reference rules                     |
| Reversal/refund rules unclear          | Clarify expected accounting behavior before execution       |

---

# 20. Release Recommendation Rules

QA should recommend release only when:

1. No unresolved critical defects remain.
2. Wallet balance validation passes.
3. Duplicate debit prevention passes.
4. Duplicate credit prevention passes.
5. Failed transfer reversal passes.
6. Failed bill payment refund passes.
7. Authorization tests pass.
8. API and database validation pass for critical flows.
9. Regression suite passes.
10. UAT is completed or accepted.

---

# 21. Phase 4 Completion Criteria

This phase is complete when:

1. Test Strategy is created.
2. Test Plan is created.
3. Testing scope is clearly defined.
4. In-scope and out-of-scope items are documented.
5. Test types are defined.
6. Test data needs are documented.
7. Entry and exit criteria are defined.
8. Defect severity and priority rules are documented.
9. Release recommendation rules are documented.
10. The project is ready for Phase 5: Test Scenarios.

