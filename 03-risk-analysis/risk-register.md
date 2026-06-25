# Risk Register

## Project: Fintech Digital Banking QA Lab

## Phase 3 Deliverable

---

# 1. Document Purpose

This document identifies key product, financial, security, operational, and quality risks for the Fintech Digital Banking QA Lab.

The goal is to support risk-based testing, test prioritization, defect severity decisions, regression planning, and release readiness evaluation.

---

# 2. Risk Rating Scale

## Impact

| Rating | Meaning                                                                                                        |
| ------ | -------------------------------------------------------------------------------------------------------------- |
| High   | Can cause financial loss, incorrect wallet balance, fraud exposure, major customer impact, or release blockage |
| Medium | Can affect user experience, transaction clarity, support workload, or partial business functionality           |
| Low    | Minor issue with limited financial or customer impact                                                          |

## Likelihood

| Rating | Meaning                                                                        |
| ------ | ------------------------------------------------------------------------------ |
| High   | Likely to occur during normal usage or under common failure conditions         |
| Medium | Could occur under specific user behaviour, provider response, or edge condition |
| Low    | Unlikely, but still possible                                                   |

## Priority

| Rating   | Meaning                                                      |
| -------- | ------------------------------------------------------------ |
| Critical | Must be tested deeply and should block release if unresolved |
| High     | Must be covered before release                               |
| Medium   | Should be tested, but may not block release unless severe    |
| Low      | Can be tested after higher-risk areas                        |

---

# 3. Risk Register Table

| Risk ID  | Module                 | Risk Description                                               | Impact | Likelihood | Priority | Possible Production Impact                                                 | QA Mitigation                                                           |
| -------- | ---------------------- | -------------------------------------------------------------- | ------ | ---------- | -------- | -------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| RISK-001 | Wallet Funding         | Wallet credited before payment provider confirms success       | High   | Medium     | Critical | Customer receives money without confirmed payment; reconciliation mismatch | Test pending funding, failed funding, and successful confirmation rules |
| RISK-002 | Wallet Funding         | Duplicate provider callback credits wallet twice               | High   | High       | Critical | Double credit, financial loss, reconciliation issue                        | Test duplicate callback using same provider reference                   |
| RISK-003 | Money Transfer         | Duplicate transfer request debits user twice                   | High   | High       | Critical | Double debit, customer complaint, financial loss                           | Test rapid repeated transfer requests and idempotency behavior          |
| RISK-004 | Money Transfer         | Sender debited but receiver not credited in internal transfer  | High   | Medium     | Critical | Unbalanced ledger, customer dispute, failed money movement                 | Validate sender debit and receiver credit records                       |
| RISK-005 | External Transfer      | User debited but external bank transfer fails without reversal | High   | Medium     | Critical | Customer loses money; operations escalation                                | Test failed external transfer after debit and reversal flow             |
| RISK-006 | Wallet Balance         | UI wallet balance does not match database balance              | High   | Medium     | Critical | Customer confusion, support complaints, trust issue                        | Compare UI/API balance against database wallet balance                  |
| RISK-007 | Transaction Processing | Transaction marked successful even though provider failed      | High   | Medium     | Critical | False success, failed service delivery, reconciliation mismatch            | Test provider failure response and status transition                    |
| RISK-008 | Transaction Processing | Pending transaction remains unresolved indefinitely            | Medium | High       | High     | Customer complaint, support backlog, unclear financial state               | Test pending timeout and operations review rule                         |
| RISK-009 | Bill Payments          | User debited but airtime/data/utility value not delivered      | High   | Medium     | Critical | Customer financial loss and service complaint                              | Test bill payment failure after debit and refund/reversal               |
| RISK-010 | Bill Payments          | Failed bill payment not refunded                               | High   | Medium     | Critical | Direct customer financial loss                                             | Test refund and reversal linkage to original bill transaction           |
| RISK-011 | Authentication         | Unverified user accesses wallet features                       | High   | Medium     | High     | Unauthorized financial access before verification                          | Test wallet access restrictions before OTP verification                 |
| RISK-012 | Authentication         | Weak password reset allows account takeover                    | High   | Medium     | High     | Unauthorized access and fraudulent transfers                               | Test reset token/OTP expiry, invalid token, and session invalidation    |
| RISK-013 | Session Management     | Expired or invalid token allows protected wallet action        | High   | Medium     | High     | Unauthorized wallet access                                                 | Test protected API endpoints with invalid/expired tokens                |
| RISK-014 | Authorization          | User accesses another customer’s wallet or transactions        | High   | Medium     | Critical | Sensitive financial data exposure; IDOR vulnerability                      | Test cross-user wallet and transaction access                           |
| RISK-015 | Transfer Limits        | User transfers above per-transaction limit                     | High   | Medium     | High     | Fraud exposure and business rule violation                                 | Test ₦50,000 per-transaction limit                                      |
| RISK-016 | Transfer Limits        | User exceeds daily transaction limit                           | High   | Medium     | High     | Fraud exposure and policy violation                                        | Test ₦200,000 daily cumulative limit                                    |
| RISK-017 | Beneficiary Management | User views or modifies another user’s beneficiary              | Medium | Medium     | High     | Privacy breach and possible wrong transfer target                          | Test beneficiary ownership and authorization                            |
| RISK-018 | Notifications          | Notification says success while transaction failed             | Medium | Medium     | High     | Customer confusion and trust issue                                         | Validate notification content against transaction status                |
| RISK-019 | Notifications          | Notification failure changes transaction status                | Medium | Low        | Medium   | Successful transaction incorrectly treated as failed                       | Test notification failure isolation                                     |
| RISK-020 | Reversal               | Reversal is not linked to original transaction                 | High   | Medium     | High     | Poor audit trail, difficult complaint resolution                           | Validate reversal relationship to original transaction reference        |
| RISK-021 | Refund                 | Refund amount differs from original failed transaction amount  | High   | Low        | High     | Customer under-refunded or over-refunded                                   | Test refund amount against original debit                               |
| RISK-022 | Audit Trail            | Transaction status changes are not traceable                   | High   | Medium     | High     | Poor investigation support and weak compliance evidence                    | Validate audit fields and status history                                |
| RISK-023 | API Testing            | API returns success response but database update fails         | High   | Medium     | Critical | False success shown to user; backend inconsistency                         | Compare API response with database state                                |
| RISK-024 | Database               | Transaction record created without unique reference            | High   | Medium     | Critical | Duplicate processing and reconciliation failure                            | Test uniqueness constraints and duplicate references                    |
| RISK-025 | Security/Fraud         | Rapid transfer attempts are not detected                       | High   | Medium     | High     | Fraud exposure or accidental duplicate debit                               | Test rapid transfer attempts and duplicate detection                    |
| RISK-026 | Reconciliation         | Internal transaction records do not match provider records     | High   | Medium     | Critical | Settlement mismatch and financial reporting issue                          | Validate provider reference, internal reference, status, and amount     |
| RISK-027 | Wallet Accounting      | Failed transaction changes wallet balance                      | High   | Medium     | Critical | Incorrect customer funds                                                   | Test balance before and after failed transactions                       |
| RISK-028 | Wallet Accounting      | Reversed transaction does not restore correct balance          | High   | Medium     | Critical | Customer still loses money after reversal                                  | Test balance restoration after reversal                                 |
| RISK-029 | Transaction History    | Customer cannot see failed/reversed/refunded transactions      | Medium | Medium     | Medium   | Poor transparency and support complaints                                   | Test transaction history display for all statuses                       |
| RISK-030 | Admin/Ops              | Operations cannot investigate pending or failed transactions   | Medium | Medium     | High     | Delayed issue resolution and customer dissatisfaction                      | Test availability of transaction details for review                     |

---

# 4. Highest Priority Risks

The highest priority risks for this project are:

1. Double debit during transfer
2. Double credit during wallet funding
3. Incorrect wallet balance
4. Failed transfer not reversed
5. Failed bill payment not refunded
6. Duplicate provider callback
7. Unauthorized access to wallet or transactions
8. API response not matching database state
9. Missing unique transaction reference
10. Reconciliation mismatch

---

# 5. Risk-Based Testing Decision

The following areas must receive the deepest test coverage:

* wallet funding
* internal transfers
* external transfers
* bill payments
* transaction status handling
* duplicate transaction prevention
* wallet balance validation
* reversal and refund handling
* authorization testing
* API and database validation
* reconciliation testing

---

# 6. Release Blocker Risks

The following unresolved issues should block release:

1. Customer is debited twice.
2. Customer is credited twice.
3. Wallet balance is incorrect.
4. Failed debit is not reversed.
5. Refund amount is incorrect.
6. Unauthorized user can access wallet data.
7. Transaction status is incorrect.
8. API returns success but database does not update correctly.
9. Duplicate transaction reference is accepted.
10. Provider callback causes repeated financial impact.

---

# 7. Phase 3 Completion Criteria

This risk register is complete when:

1. Major fintech risks are identified.
2. Risks are mapped to modules.
3. Impact and likelihood are assigned.
4. Release blocker risks are identified.
5. QA mitigation actions are defined.
6. Risks are ready to drive test strategy, test planning, and test prioritization.
