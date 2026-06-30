# Defect Management

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This folder contains the defect management documentation for the Fintech Digital Banking QA Lab.

Defect management is the process of identifying, documenting, tracking, prioritizing, communicating, and verifying software defects throughout the software development lifecycle.

For a fintech application, effective defect management is essential because software defects can directly impact customer funds, financial integrity, regulatory compliance, and business reputation.

---

# Purpose

The purpose of defect management is to:

* Record software defects consistently.
* Communicate issues clearly to developers and stakeholders.
* Prioritize defects based on business impact and risk.
* Track defects from discovery through closure.
* Support release readiness decisions.
* Maintain a historical record for future regression testing.

---

# Defect Management Scope

This phase covers defects identified in:

1. Authentication
2. Wallet Management
3. Wallet Funding
4. Money Transfers
5. Transaction Processing
6. Bill Payments
7. Notifications
8. Security and Fraud Prevention

---

# Deliverables

| File                           | Purpose                                                          |
| ------------------------------ | ---------------------------------------------------------------- |
| bug-reports.md                 | Individual defect reports with complete reproduction details     |
| defect-log.md                  | Central register for tracking all reported defects               |
| defect-triage-documentation.md | Defect prioritization, severity assessment, and triage decisions |

---

# Defect Lifecycle

```text
New
 ↓
Assigned
 ↓
In Progress
 ↓
Fixed
 ↓
Ready for QA
 ↓
Retest
 ↓
Closed
```

Alternative outcomes:

```text
Rejected
Duplicate
Cannot Reproduce
Deferred
Won't Fix
```

---

# Defect Classification

### Severity

| Severity | Description                                                         |
| -------- | ------------------------------------------------------------------- |
| Critical | Financial loss, security breach, data corruption, production outage |
| High     | Major feature unavailable or incorrect business logic               |
| Medium   | Feature partially impacted with available workaround                |
| Low      | Cosmetic or minor usability issue                                   |

---

### Priority

| Priority | Description                                |
| -------- | ------------------------------------------ |
| P1       | Must be fixed immediately before release   |
| P2       | High priority; fix during current sprint   |
| P3       | Medium priority; schedule appropriately    |
| P4       | Low priority; can be deferred if necessary |

---

# Fintech Defects That Block Release

Examples include:

* Double debit
* Double credit
* Incorrect wallet balance
* Missing reversal
* Missing refund
* Unauthorized access
* Duplicate transaction processing
* Failed reconciliation
* Incorrect transaction status
* Security vulnerabilities affecting customer funds

---

# Best Practices

Every defect should include:

* Clear title
* Environment
* Preconditions
* Steps to reproduce
* Expected result
* Actual result
* Supporting evidence
* Severity
* Priority
* Business impact

---

# Recruiter Talking Points

This phase demonstrates the ability to:

* Communicate defects clearly.
* Prioritize issues based on business risk.
* Support developers during defect resolution.
* Make release recommendations based on defect analysis.
* Apply fintech-specific risk assessment when managing production issues.

---

# Success Criteria

Defect management is successful when:

* All defects are documented consistently.
* Business impact is clearly communicated.
* Severity and priority are justified.
* Defects are traceable through their lifecycle.
* Defect status supports release readiness decisions.
