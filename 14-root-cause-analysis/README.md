# Root Cause Analysis

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This folder contains the Root Cause Analysis documentation for critical and recurring defects identified during the Fintech Digital Banking QA Lab.

Root Cause Analysis goes beyond describing what failed. It investigates:

* Why the defect occurred
* Which contributing factors allowed it to occur
* Why existing controls did not prevent it
* Why testing did not detect it earlier
* What actions are required to prevent recurrence

For a fintech platform, Root Cause Analysis is especially important because recurring defects may cause customer financial loss, incorrect wallet balances, reconciliation failures, security incidents, operational costs, and loss of customer trust.

---

# Purpose

The purpose of this phase is to:

* Identify the underlying causes of critical defects.
* Separate symptoms from actual root causes.
* Analyse technical, process, data, environment, and communication failures.
* Define immediate corrective actions.
* Define long-term preventive actions.
* Improve engineering and QA practices.
* Reduce the risk of similar production incidents.

---

# RCA Scope

The RCA phase focuses primarily on the highest-impact Sprint 1 defects:

| Bug ID  | Defect                                                   | Business Impact                                  |
| ------- | -------------------------------------------------------- | ------------------------------------------------ |
| BUG-001 | Duplicate wallet credit after repeated provider callback | Financial loss and reconciliation mismatch       |
| BUG-002 | Failed external transfer did not trigger reversal        | Customer funds remained unavailable              |
| BUG-003 | Expired JWT token accessed protected API                 | Unauthorised financial-data exposure             |
| BUG-005 | Daily transfer limit ignored cumulative transfers        | Fraud and policy exposure                        |
| BUG-006 | Customer accessed another customer's beneficiary         | Privacy and broken-access-control risk           |
| BUG-007 | Refund exceeded original transaction amount              | Financial loss and inaccurate reconciliation     |
| BUG-008 | Notification failure changed transaction status          | Incorrect financial state and customer confusion |

Particular attention will be given to **BUG-002** and **BUG-007** because they prevented production approval.

---

# RCA Deliverables

| File                             | Purpose                                                                                           |
| -------------------------------- | ------------------------------------------------------------------------------------------------- |
| root-cause-analysis-report.md    | Consolidated investigation of critical defects and their underlying causes                        |
| five-whys-analysis.md            | Step-by-step analysis that repeatedly asks why until the root cause is reached                    |
| fishbone-analysis.md             | Categorises contributing factors across people, process, technology, data, tools, and environment |
| corrective-preventive-actions.md | Documents corrective actions and long-term preventive controls                                    |
| lessons-learned.md               | Records improvements for future sprints and releases                                              |

---

# Root Cause Analysis Process

The RCA process follows these steps:

```text
Defect or Incident Identified
            ↓
Immediate Impact Contained
            ↓
Evidence Collected
            ↓
Event Timeline Reconstructed
            ↓
Contributing Factors Identified
            ↓
Root Cause Confirmed
            ↓
Corrective Actions Defined
            ↓
Preventive Actions Defined
            ↓
Actions Assigned and Tracked
            ↓
Effectiveness Verified
```

---

# Evidence Sources

RCA conclusions should be based on evidence rather than assumptions.

Possible evidence includes:

* Bug reports
* API request and response logs
* Payment-provider callbacks
* Application logs
* Database records
* Wallet-ledger entries
* Audit logs
* Source-code review findings
* Test execution evidence
* Regression results
* UAT feedback
* Deployment and configuration history
* Stakeholder interviews

---

# RCA Classification Model

Potential causes will be reviewed across the following categories:

## 1. Requirements

* Business rules were unclear.
* Failure behaviour was not documented.
* Acceptance criteria omitted edge cases.
* Reversal or refund rules were ambiguous.

## 2. Design

* Transaction lifecycle design was incomplete.
* Idempotency controls were missing.
* Service dependencies were tightly coupled.
* Financial safeguards were not designed.

## 3. Development

* Validation logic was incomplete.
* Error handling did not cover provider failures.
* Database transactions were not atomic.
* Authorisation checks were implemented incorrectly.

## 4. Testing

* Negative scenarios were missing.
* Integration testing was incomplete.
* Database validation was not performed early.
* Regression coverage did not include the affected workflow.

## 5. Environment and Tools

* Provider mocks did not behave realistically.
* Logging was insufficient.
* Test data did not represent failure conditions.
* Environment instability prevented full validation.

## 6. Process and Communication

* Risk was not escalated early.
* Product and engineering assumptions differed.
* Review processes did not identify the gap.
* Ownership of failure recovery was unclear.

---

# Corrective vs Preventive Actions

## Corrective Action

A corrective action resolves the current defect.

Examples:

* Fix the reversal service.
* Add refund amount validation.
* Reject duplicate provider callbacks.
* Correct JWT expiry validation.

## Preventive Action

A preventive action reduces the chance of similar defects recurring.

Examples:

* Add automated idempotency regression tests.
* Introduce database constraints.
* Add mandatory financial-recovery acceptance criteria.
* Add code-review checklists for money movement.
* Improve provider-failure simulation.
* Add monitoring and alerts for stuck transactions.

---

# RCA Principles

All RCA activities should follow these principles:

* Focus on systems and processes, not blame.
* Use evidence rather than assumptions.
* Separate symptoms from causes.
* Identify multiple contributing factors where applicable.
* Assign clear action owners.
* Define measurable completion criteria.
* Verify that preventive actions are effective.
* Share lessons across QA, Engineering, Product, and Operations.

---

# Roles and Responsibilities

| Role                | Responsibility                                                            |
| ------------------- | ------------------------------------------------------------------------- |
| QA Lead             | Coordinates RCA, provides test evidence, and verifies preventive coverage |
| Backend Engineer    | Investigates code, service behaviour, and database changes                |
| Product Owner       | Clarifies business rules and customer impact                              |
| Engineering Manager | Approves remediation priorities and ownership                             |
| Operations Team     | Provides reconciliation, provider, and support evidence                   |
| Security Team       | Supports investigation of access-control and authentication defects       |
| Release Manager     | Ensures actions are considered before future releases                     |

---

# RCA Entry Criteria

Root Cause Analysis should begin when:

* A Critical defect is confirmed.
* A financial or security defect blocks release.
* A defect recurs after being fixed.
* Similar defects appear across multiple modules.
* A production incident affects customers.
* A defect reveals a broader process or control weakness.

---

# RCA Exit Criteria

An RCA is complete when:

* The root cause is supported by evidence.
* Contributing factors are documented.
* Customer and business impact are understood.
* Corrective actions are assigned.
* Preventive actions are assigned.
* Action owners and due dates are agreed.
* Regression coverage is updated.
* Action effectiveness is verified.
* Lessons are shared with stakeholders.

---

# Success Criteria

This phase is successful when:

* Critical defects are understood beyond their symptoms.
* Fixes address the actual cause rather than only the visible failure.
* Similar defects are less likely to recur.
* Testing and engineering controls improve.
* Financial integrity and security risks are reduced.
* Future release confidence increases.

---

# How Different QA Roles Approach RCA

## QA Engineer

A QA Engineer:

* Provides reliable reproduction steps.
* Supplies screenshots, API responses, SQL results, and logs.
* Identifies where expected and actual behaviour differ.
* Adds regression scenarios after the defect is fixed.

## Senior QA Engineer

A Senior QA Engineer:

* Reconstructs the end-to-end failure path.
* Connects technical defects to business risk.
* Challenges requirement, design, and test coverage gaps.
* Facilitates Five Whys and fishbone discussions.
* Ensures corrective and preventive actions are testable.

## SDET

An SDET:

* Identifies missing automated controls.
* Adds API, integration, database, and idempotency checks.
* Improves observability and test diagnostics.
* Builds repeatable failure simulations.
* Integrates preventive regression tests into CI/CD.

---

# Common Interview Questions

## What is Root Cause Analysis?

Root Cause Analysis is a structured investigation used to identify why a defect or incident occurred and what must change to prevent it from recurring.

## How is a root cause different from a symptom?

A symptom is the visible failure, such as a customer being debited without receiving a reversal. The root cause may be missing failure-handling logic, a broken status transition, or an incomplete provider-callback design.

## How do you contribute to RCA as a QA Engineer?

QA contributes by providing reproducible evidence, analysing where the workflow failed, identifying missing test coverage, validating fixes, and adding preventive regression tests.

## What techniques can be used for RCA?

Common techniques include:

* Five Whys
* Fishbone analysis
* Event timeline analysis
* Fault-tree analysis
* Log and database analysis
* Code and design review

---

# Common Production Issues Requiring RCA

Examples include:

* Duplicate debit
* Duplicate credit
* Missing reversal
* Incorrect refund
* Stuck pending transaction
* Reconciliation mismatch
* Expired-token access
* Broken object-level authorisation
* Missing audit records
* Notification failure affecting transaction processing

---

# Recruiter Evaluation

Recruiters and hiring managers evaluate RCA skill by checking whether a candidate can:

* Explain why a defect occurred.
* Use evidence to support conclusions.
* Connect technical failure to business impact.
* Work collaboratively with Engineering and Product.
* Recommend controls that prevent recurrence.
* Convert incident lessons into regression and automation coverage.

---

# Portfolio Value

This phase demonstrates:

* Senior QA problem-solving
* Defect investigation
* Financial-risk awareness
* Cross-functional collaboration
* Continuous improvement
* Preventive quality engineering
* RCA facilitation
* Regression and automation readiness
