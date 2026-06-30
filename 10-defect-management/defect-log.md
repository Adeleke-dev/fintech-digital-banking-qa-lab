# Defect Log

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document serves as the central repository for tracking all defects identified during testing.

It provides visibility into defect status, severity, priority, ownership, and release impact, enabling effective communication between QA, developers, product managers, and stakeholders.

---

# Defect Status Legend

| Status           | Description                                      |
| ---------------- | ------------------------------------------------ |
| New              | Defect has been reported and awaits triage       |
| Assigned         | Defect has been assigned to a developer          |
| In Progress      | Developer is actively fixing the defect          |
| Fixed            | Code change completed                            |
| Ready for QA     | Fix deployed for verification                    |
| Closed           | QA verified the fix successfully                 |
| Deferred         | Fix postponed to a future release                |
| Duplicate        | Duplicate of an existing defect                  |
| Rejected         | Reported behavior is not considered a defect     |
| Cannot Reproduce | QA and development could not reproduce the issue |

---

# Sprint 1 Defect Register

| Bug ID  | Module                 | Summary                                                                   | Severity | Priority | Status       | Assigned To  | Sprint   | Release Impact |
| ------- | ---------------------- | ------------------------------------------------------------------------- | -------- | -------- | ------------ | ------------ | -------- | -------------- |
| BUG-001 | Wallet Funding         | Wallet credited twice after duplicate payment gateway callback            | Critical | P1       | Fixed        | Backend Team | Sprint 1 | Blocker        |
| BUG-002 | Money Transfers        | Failed external transfer did not trigger wallet reversal                  | Critical | P1       | Ready for QA | Backend Team | Sprint 1 | Blocker        |
| BUG-003 | Authentication         | Expired JWT token still allowed access to Wallet Balance API              | Critical | P1       | Closed       | Backend Team | Sprint 1 | Blocker        |
| BUG-004 | Transaction Processing | Transaction remained **PENDING** after successful provider callback       | High     | P1       | Fixed        | Backend Team | Sprint 1 | High           |
| BUG-005 | Money Transfers        | Daily transfer limit validation failed after multiple small transfers     | High     | P2       | In Progress  | Backend Team | Sprint 1 | High           |
| BUG-006 | Money Transfers        | Customer could access another customer's saved beneficiary through API    | Critical | P1       | Closed       | Backend Team | Sprint 1 | Blocker        |
| BUG-007 | Transaction Processing | Refund amount exceeded original transaction amount                        | Critical | P1       | Assigned     | Backend Team | Sprint 1 | Blocker        |
| BUG-008 | Notifications          | Notification failure incorrectly changed transaction status to **FAILED** | High     | P2       | Fixed        | Backend Team | Sprint 1 | High           |

---

# Defect Metrics

## Total Defects

| Metric        | Count |
| ------------- | ----: |
| Total Defects |     8 |
| Critical      |     4 |
| High          |     4 |
| Medium        |     0 |
| Low           |     0 |

---

## Status Distribution

| Status           | Count |
| ---------------- | ----: |
| New              |     0 |
| Assigned         |     1 |
| In Progress      |     1 |
| Fixed            |     3 |
| Ready for QA     |     1 |
| Closed           |     2 |
| Deferred         |     0 |
| Duplicate        |     0 |
| Rejected         |     0 |
| Cannot Reproduce |     0 |

---

## Module Distribution

| Module                 | Defects |
| ---------------------- | ------: |
| Authentication         |       1 |
| Wallet Funding         |       1 |
| Money Transfers        |       3 |
| Transaction Processing |       2 |
| Notifications          |       1 |

---

## Severity Distribution

| Severity | Count | Percentage |
| -------- | ----: | ---------: |
| Critical |     4 |        50% |
| High     |     4 |        50% |
| Medium   |     0 |         0% |
| Low      |     0 |         0% |

---

# Release Readiness Assessment

## Release Blockers

The following defects must be resolved before production deployment:

| Bug ID  | Reason                                                   |
| ------- | -------------------------------------------------------- |
| BUG-001 | Financial loss through duplicate wallet credit           |
| BUG-002 | Customer funds not restored after failed transfer        |
| BUG-003 | Unauthorized access to protected financial resources     |
| BUG-006 | Cross-customer data exposure                             |
| BUG-007 | Incorrect refund amount creating financial inconsistency |

---

## High-Priority Defects

These should be resolved before release if possible:

* BUG-004
* BUG-005
* BUG-008

---

# QA Manager Summary

### Overall Assessment

Eight significant defects were identified during Sprint 1 testing.

The majority of defects affect critical financial workflows, including wallet funding, money transfers, authentication, and transaction processing.

The testing process successfully identified issues that could have resulted in:

* Financial loss
* Unauthorized access
* Data privacy violations
* Incorrect wallet balances
* Reconciliation failures
* Customer trust issues

Immediate remediation of all release-blocking defects is required before production deployment.

---

# Lessons Learned

Key observations from Sprint 1:

* Duplicate callback handling requires stronger idempotency controls.
* Transfer reversal logic requires additional automated regression coverage.
* Authorization testing should remain a mandatory regression activity.
* Refund calculations require stricter validation against original transaction amounts.
* Notification services should remain independent of financial transaction processing.

---

# Recruiter Talking Points

This defect log demonstrates the ability to:

* Track defects throughout their lifecycle.
* Prioritize issues based on business and financial impact.
* Differentiate severity from priority.
* Assess release readiness using defect data.
* Communicate quality risks to engineering and product stakeholders.
* Apply fintech-specific defect management practices focused on financial integrity and security.
