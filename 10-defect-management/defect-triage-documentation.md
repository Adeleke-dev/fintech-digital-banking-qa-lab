# Defect Triage Documentation

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document captures the outcomes of the defect triage sessions conducted during Sprint 1.

Defect triage is the collaborative process where QA Engineers, Developers, Product Managers, and Engineering Managers review reported defects to determine:

* Severity
* Priority
* Business impact
* Root cause ownership
* Release impact
* Resolution approach

The objective is to ensure development effort is focused on the defects that pose the greatest risk to customers and the business.

---

# Sprint Information

| Item         | Details                                                         |
| ------------ | --------------------------------------------------------------- |
| Sprint       | Sprint 1                                                        |
| Product      | Fintech Digital Banking QA Lab                                  |
| Triage Date  | Sprint Review Week                                              |
| Participants | QA Lead, Backend Engineer, Product Manager, Engineering Manager |

---

# Triage Decision Criteria

## Severity Guidelines

| Severity | Definition                                                                           |
| -------- | ------------------------------------------------------------------------------------ |
| Critical | Financial loss, security breach, regulatory risk, data corruption, production outage |
| High     | Major business functionality unavailable or incorrect                                |
| Medium   | Partial functionality affected with workaround                                       |
| Low      | Cosmetic or minor usability issue                                                    |

---

## Priority Guidelines

| Priority | Definition                              |
| -------- | --------------------------------------- |
| P1       | Must be fixed before production release |
| P2       | Fix within current sprint               |
| P3       | Fix in upcoming sprint                  |
| P4       | Can be deferred                         |

---

# Sprint 1 Defect Triage

| Bug ID  | Summary                                              | Severity | Priority | Business Impact             | Release Decision   |
| ------- | ---------------------------------------------------- | -------- | -------- | --------------------------- | ------------------ |
| BUG-001 | Duplicate wallet credit after payment callback retry | Critical | P1       | Financial loss              | Must Fix           |
| BUG-002 | Failed external transfer not reversed                | Critical | P1       | Customer funds at risk      | Must Fix           |
| BUG-003 | Expired JWT accepted by protected API                | Critical | P1       | Security vulnerability      | Must Fix           |
| BUG-004 | Transaction remains PENDING after provider success   | High     | P1       | Incorrect transaction state | Fix Before Release |
| BUG-005 | Daily transfer limit validation fails                | High     | P2       | Fraud and policy violation  | Fix Current Sprint |
| BUG-006 | Customer accessed another customer's beneficiary     | Critical | P1       | Data privacy breach         | Must Fix           |
| BUG-007 | Refund exceeds original payment amount               | Critical | P1       | Financial inconsistency     | Must Fix           |
| BUG-008 | Notification failure changes transaction status      | High     | P2       | Customer confusion          | Fix Current Sprint |

---

# Individual Triage Decisions

---

## BUG-001

### Summary

Wallet credited twice after duplicate payment gateway callback.

### Business Impact

A customer receives more money than intended, creating financial loss and reconciliation issues.

### QA Recommendation

Block production release until idempotency validation is corrected.

### Product Decision

Approve immediate fix.

### Final Decision

**Release Blocker**

---

## BUG-002

### Summary

Failed external transfer does not reverse wallet debit.

### Business Impact

Customer permanently loses funds after provider failure.

### QA Recommendation

Immediate correction required.

### Product Decision

Must not ship.

### Final Decision

**Release Blocker**

---

## BUG-003

### Summary

Expired JWT token still accesses protected APIs.

### Business Impact

Unauthorized users may access sensitive financial information.

### QA Recommendation

Security hotfix required.

### Product Decision

Block release.

### Final Decision

**Release Blocker**

---

## BUG-004

### Summary

Successful provider callback leaves transaction in **PENDING** status.

### Business Impact

Customers see incorrect transaction status, causing support tickets and reconciliation issues.

### QA Recommendation

Fix before deployment.

### Final Decision

**High Priority**

---

## BUG-005

### Summary

Daily transfer limit validation does not consider cumulative transfers.

### Business Impact

Customers can exceed configured daily transfer limits, increasing fraud and compliance risk.

### QA Recommendation

Fix within the current sprint before the next release.

### Final Decision

**High Priority**

---

## BUG-006

### Summary

Customer can retrieve another customer's saved beneficiary using the API.

### Business Impact

Sensitive customer information is exposed, creating a data privacy and security breach.

### QA Recommendation

Immediate security fix required.

### Final Decision

**Release Blocker**

---

## BUG-007

### Summary

Refund amount exceeds the original transaction amount.

### Business Impact

Incorrect refund calculations may result in direct financial loss and reconciliation failures.

### QA Recommendation

Block release until refund validation is corrected.

### Final Decision

**Release Blocker**

---

## BUG-008

### Summary

Notification failure incorrectly changes transaction status to **FAILED**.

### Business Impact

Customers receive inaccurate information despite successful financial processing.

### QA Recommendation

Correct service dependency before production release.

### Final Decision

**High Priority**

---

# Release Readiness Assessment

## Critical Defects

| Bug ID  | Production Risk         |
| ------- | ----------------------- |
| BUG-001 | Double credit           |
| BUG-002 | Customer financial loss |
| BUG-003 | Unauthorized access     |
| BUG-006 | Customer data exposure  |
| BUG-007 | Incorrect refund        |

**Recommendation:** Production deployment **must not proceed** until all Critical (P1) defects are resolved and successfully retested.

---

## High Priority Defects

| Bug ID  | Recommendation                       |
| ------- | ------------------------------------ |
| BUG-004 | Resolve before release if possible   |
| BUG-005 | Resolve during current sprint        |
| BUG-008 | Resolve before production deployment |

---

# Triage Metrics

| Metric                 | Value |
| ---------------------- | ----: |
| Total Defects Reviewed |     8 |
| Release Blockers       |     5 |
| High Priority          |     3 |
| Deferred               |     0 |
| Rejected               |     0 |
| Duplicate              |     0 |

---

# Action Items

| Owner             | Action                                                     |
| ----------------- | ---------------------------------------------------------- |
| Backend Team      | Resolve wallet funding idempotency issue                   |
| Backend Team      | Implement automatic reversal for failed external transfers |
| Security Team     | Correct JWT validation and authorisation controls          |
| Backend Team      | Fix refund calculation logic                               |
| Backend Team      | Correct transaction status transition logic                |
| Backend Team      | Enforce daily transfer limit validation                    |
| Notification Team | Decouple notification failures from transaction processing |
| QA Team           | Retest all fixes and execute regression suite              |

---

# QA Lead Recommendation

Based on the triage outcome:

* Production deployment should remain on hold until all release-blocking defects have been resolved.
* A focused regression test should be executed on wallet funding, money transfers, authentication, transaction processing, and security after fixes are deployed.
* Database validation and API regression should be completed before release approval.

---

# Recruiter Talking Points

This document demonstrates the ability to:

* Lead or participate in defect triage meetings.
* Differentiate **severity** from **priority**.
* Assess business and financial impact.
* Make evidence-based release recommendations.
* Collaborate effectively with developers, product managers, and engineering leadership.
* Apply risk-based decision-making in a fintech environment where customer funds, security, and compliance are critical.
