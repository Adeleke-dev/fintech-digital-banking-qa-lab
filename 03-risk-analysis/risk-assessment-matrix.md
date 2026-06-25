# Risk Assessment Matrix

## Project: Fintech Digital Banking QA Lab

## Phase 3 Deliverable

---

# 1. Document Purpose

This document ranks product risks based on impact and likelihood.

The goal is to help QA prioritise testing effort, identify release blockers, guide regression testing, and support stakeholder communication.

---

# 2. Risk Scoring Model

Each risk is scored using:

Impact x Likelihood = Risk Score

## Impact Score

| Score | Rating | Meaning                                                                                          |
| ----: | ------ | ------------------------------------------------------------------------------------------------ |
|     3 | High   | Financial loss, fraud exposure, incorrect wallet balance, release blocker, major customer impact |
|     2 | Medium | User confusion, support workload, partial business impact                                        |
|     1 | Low    | Minor issue with limited business impact                                                         |

## Likelihood Score

| Score | Rating | Meaning                                                          |
| ----: | ------ | ---------------------------------------------------------------- |
|     3 | High   | Likely to happen under normal usage or common failure conditions |
|     2 | Medium | Could happen under specific conditions                           |
|     1 | Low    | Unlikely but possible                                            |

## Risk Score

| Score | Risk Level | Testing Action                                              |
| ----: | ---------- | ----------------------------------------------------------- |
|   7–9 | Critical   | Deep testing required; unresolved defects may block release |
|   4–6 | High       | Must be covered before release                              |
|   2–3 | Medium     | Should be tested in planned cycles                          |
|     1 | Low        | Lower priority                                              |

---

# 3. Risk Assessment Matrix Table

| Risk ID  | Risk Area                                        | Impact Score | Likelihood Score | Total Score | Risk Level | Testing Priority |
| -------- | ------------------------------------------------ | -----------: | ---------------: | ----------: | ---------- | ---------------- |
| RISK-001 | Wallet credited before provider success          |            3 |                2 |           6 | High       | High             |
| RISK-002 | Duplicate callback credits wallet twice          |            3 |                3 |           9 | Critical   | Critical         |
| RISK-003 | Duplicate transfer debits user twice             |            3 |                3 |           9 | Critical   | Critical         |
| RISK-004 | Sender debited but receiver not credited         |            3 |                2 |           6 | High       | Critical         |
| RISK-005 | External transfer failure not reversed           |            3 |                2 |           6 | High       | Critical         |
| RISK-006 | UI balance differs from database balance         |            3 |                2 |           6 | High       | Critical         |
| RISK-007 | Failed provider response marked successful       |            3 |                2 |           6 | High       | Critical         |
| RISK-008 | Pending transaction unresolved                   |            2 |                3 |           6 | High       | High             |
| RISK-009 | Bill payment debited but value not delivered     |            3 |                2 |           6 | High       | Critical         |
| RISK-010 | Failed bill payment not refunded                 |            3 |                2 |           6 | High       | Critical         |
| RISK-011 | Unverified user accesses wallet                  |            3 |                2 |           6 | High       | High             |
| RISK-012 | Password reset account takeover risk             |            3 |                2 |           6 | High       | High             |
| RISK-013 | Invalid session allows wallet action             |            3 |                2 |           6 | High       | High             |
| RISK-014 | User accesses another user’s wallet              |            3 |                2 |           6 | High       | Critical         |
| RISK-015 | Per-transaction limit bypassed                   |            3 |                2 |           6 | High       | High             |
| RISK-016 | Daily limit bypassed                             |            3 |                2 |           6 | High       | High             |
| RISK-017 | Beneficiary ownership issue                      |            2 |                2 |           4 | High       | High             |
| RISK-018 | Wrong notification status                        |            2 |                2 |           4 | High       | Medium           |
| RISK-019 | Notification failure changes transaction         |            2 |                1 |           2 | Medium     | Medium           |
| RISK-020 | Reversal not linked to original transaction      |            3 |                2 |           6 | High       | High             |
| RISK-021 | Incorrect refund amount                          |            3 |                1 |           3 | Medium     | High             |
| RISK-022 | Missing audit trail for status changes           |            3 |                2 |           6 | High       | High             |
| RISK-023 | API success but DB update fails                  |            3 |                2 |           6 | High       | Critical         |
| RISK-024 | Missing unique transaction reference             |            3 |                2 |           6 | High       | Critical         |
| RISK-025 | Rapid transfer attempts not detected             |            3 |                2 |           6 | High       | High             |
| RISK-026 | Internal records mismatch provider records       |            3 |                2 |           6 | High       | Critical         |
| RISK-027 | Failed transaction changes wallet balance        |            3 |                2 |           6 | High       | Critical         |
| RISK-028 | Reversal does not restore balance                |            3 |                2 |           6 | High       | Critical         |
| RISK-029 | Missing transaction history visibility           |            2 |                2 |           4 | High       | Medium           |
| RISK-030 | Operations cannot investigate failed transaction |            2 |                2 |           4 | High       | High             |

---

# 4. Critical Risk Zone

The following risks are in the critical zone:

| Risk ID  | Risk Area                  | Reason                                            |
| -------- | -------------------------- | ------------------------------------------------- |
| RISK-002 | Duplicate funding callback | Can cause double credit and direct financial loss |
| RISK-003 | Duplicate transfer request | Can cause double debit and customer complaints    |

These must receive priority test coverage in functional, API, database, regression, and release readiness testing.

---

# 5. High Business Impact Risk Areas

Even when the score is not 9, the following areas should be treated as high priority because of financial impact:

* wallet balance accuracy
* reversal handling
* refund handling
* provider failure handling
* transaction status accuracy
* database consistency
* authorization protection
* reconciliation validation

---

# 6. Test Prioritization Decision

Testing priority should follow this order:

1. Wallet balance accuracy
2. Duplicate debit prevention
3. Duplicate credit prevention
4. Failed transfer reversal
5. Failed bill payment refund
6. Authorization and access control
7. Transaction status validation
8. API and database consistency
9. Reconciliation validation
10. Notifications and history display

---

# 7. Automation Priority

The following risk areas should be considered first for automation:

| Automation Candidate                    | Reason                                          |
| --------------------------------------- | ----------------------------------------------- |
| Duplicate transfer request              | High financial risk and repeatable API scenario |
| Duplicate funding callback              | High financial risk and repeatable API scenario |
| Wallet balance validation               | Critical regression check                       |
| Transfer limit validation               | Rule-based and easy to automate                 |
| Invalid token access                    | Security regression check                       |
| Cross-user wallet access                | Authorization regression check                  |
| Failed funding status                   | Important transaction lifecycle check           |
| External transfer reversal              | Critical financial recovery flow                |
| API response vs database state          | Strong backend validation                       |
| Unique transaction reference validation | Prevents duplicate processing                   |

---

# 8. Release Risk Decision

A release should not be approved if any of the following remain unresolved:

1. Critical duplicate debit bug.
2. Critical duplicate credit bug.
3. Wallet balance mismatch.
4. Failed transaction causes permanent customer money loss.
5. An unauthorised customer can view another customer’s wallet.
6. API returns success while the database transaction fails.
7. Transaction references are not unique.
8. Reversal or refund cannot be traced.
9. Transaction status is unreliable.
10. Reconciliation records are incomplete.

---

# 9. Phase 3 Completion Criteria

This matrix is complete when:

1. Risks are scored by impact and likelihood.
2. Critical and high-risk areas are clearly identified.
3. Risk level guides test priority.
4. Release blocker risks are documented.
5. Automation priority areas are identified.
6. The matrix is ready to support the Test Strategy and Test Plan.
