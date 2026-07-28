# Portfolio Evidence Map

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document maps the skills demonstrated in this portfolio to the supporting evidence contained throughout the repository.

Its purpose is to help recruiters, hiring managers, technical interviewers, and engineering leaders quickly verify each claimed competency without reading every document.

Rather than simply listing skills, this evidence map shows **where each skill is demonstrated** and **how it was applied** during the project.

---

# How to Use This Document

For each competency:

1. Review the skill area.
2. See how it was applied in the project.
3. Navigate to the referenced repository folder for supporting evidence.

---

# Skills-to-Evidence Matrix

| Skill Area               | Demonstrated Through                               | Supporting Evidence        |
| ------------------------ | -------------------------------------------------- | -------------------------- |
| Test Strategy            | Risk-based QA strategy and quality objectives      | `01-test-strategy/`        |
| Test Planning            | Scope, schedule, entry/exit criteria, resources    | `02-test-plan/`            |
| Risk Analysis            | Business and technical risk assessment             | `03-risk-analysis/`        |
| Test Scenario Design     | End-to-end functional coverage                     | `05-test-scenarios/`       |
| Test Case Design         | Detailed high-risk test cases                      | `06-test-cases/`           |
| API Testing              | Endpoint validation and coverage                   | `07-api-testing/`          |
| Database Testing         | SQL validation and reconciliation                  | `08-database-validation/`  |
| Exploratory Testing      | Session-based exploratory testing                  | `09-exploratory-testing/`  |
| Defect Management        | Bug logging, triage and reporting                  | `10-defect-management/`    |
| Regression Testing       | Smoke and regression suites                        | `11-regression-testing/`   |
| User Acceptance Testing  | Business validation and sign-off                   | `12-uat/`                  |
| Test Reporting           | Metrics, release readiness and stakeholder reports | `13-test-reporting/`       |
| Root Cause Analysis      | Five Whys, Fishbone and CAPA                       | `14-root-cause-analysis/`  |
| Fintech Domain Knowledge | Banking concepts and QA guides                     | `15-fintech-guides/`       |
| QA Communication         | Case study and stakeholder-focused documentation   | `16-portfolio-case-study/` |

---

# Manual Testing

## Evidence

Demonstrated through:

* Functional testing
* Negative testing
* Boundary-value testing
* Exploratory testing
* Regression testing
* Smoke testing
* UAT

### Repository Evidence

* `05-test-scenarios/`
* `06-test-cases/`
* `09-exploratory-testing/`
* `11-regression-testing/`
* `12-uat/`

---

# API Testing

## Evidence

Validated REST APIs by testing:

* Request payloads
* Response bodies
* Status codes
* Authentication
* Authorisation
* Error handling
* Idempotency
* Duplicate requests
* Failure scenarios

### Repository Evidence

* `07-api-testing/api-test-coverage-matrix.md`
* `07-api-testing/api-test-notes.md`

---

# SQL & Database Testing

## Evidence

Verified:

* Wallet balances
* Ledger entries
* Transaction records
* Refunds
* Reversals
* Duplicate references
* Financial reconciliation
* Data integrity

### Repository Evidence

* `08-database-validation/database-validation-checklist.md`
* `08-database-validation/sql-validation-queries.sql`

---

# Risk-Based Testing

## Evidence

Prioritised testing according to business impact.

Highest-risk areas included:

* Wallet funding
* Money transfers
* Authentication
* Refunds
* Reversals
* Security
* Reconciliation

### Repository Evidence

* `01-test-strategy/`
* `02-test-plan/`
* `03-risk-analysis/`

---

# Security Testing

## Evidence

Validated:

* Authentication
* JWT validation
* Session management
* Role-Based Access Control (RBAC)
* Object-level authorisation
* Fraud prevention
* Sensitive-data protection

### Repository Evidence

* `15-fintech-guides/security-testing-checklist.md`
* `07-api-testing/`
* `06-test-cases/security-fraud-test-cases.md`

---

# Fintech Testing

## Evidence

Tested financial workflows including:

* Wallet funding
* Money transfers
* Bill payments
* Refunds
* Reversals
* Settlement awareness
* Reconciliation
* Audit trails

### Repository Evidence

* `15-fintech-guides/fintech-domain-knowledge-guide.md`
* `15-fintech-guides/reconciliation-testing-guide.md`
* `15-fintech-guides/payment-failure-testing-guide.md`
* `15-fintech-guides/audit-trail-validation-guide.md`

---

# Defect Management

## Evidence

Produced:

* Defect log
* Bug reports
* Defect triage documentation
* Severity assessment
* Priority recommendations

### Repository Evidence

* `10-defect-management/defect-log.md`
* `10-defect-management/bug-reports.md`
* `10-defect-management/defect-triage-documentation.md`

---

# Root Cause Analysis

## Evidence

Applied structured investigation techniques including:

* Five Whys
* Fishbone (Ishikawa)
* CAPA
* Lessons Learned

### Repository Evidence

* `14-root-cause-analysis/root-cause-analysis-report.md`
* `14-root-cause-analysis/five-whys-analysis.md`
* `14-root-cause-analysis/fishbone-analysis.md`
* `14-root-cause-analysis/corrective-preventive-actions.md`
* `14-root-cause-analysis/lessons-learned.md`

---

# Regression Testing

## Evidence

Designed reusable regression suites covering critical financial workflows and post-fix verification.

### Repository Evidence

* `11-regression-testing/regression-test-suite.md`
* `11-regression-testing/smoke-test-suite.md`
* `11-regression-testing/regression-execution-report.md`

---

# User Acceptance Testing

## Evidence

Supported business validation through:

* UAT planning
* Execution
* Business sign-off
* Acceptance criteria validation

### Repository Evidence

* `12-uat/uat-checklist.md`
* `12-uat/uat-execution-report.md`
* `12-uat/business-signoff.md`

---

# Test Reporting

## Evidence

Produced management-ready reports including:

* Sprint summary
* Stakeholder status
* Test metrics
* Release readiness

### Repository Evidence

* `13-test-reporting/sprint-test-summary-report.md`
* `13-test-reporting/stakeholder-status-report.md`
* `13-test-reporting/test-metrics-dashboard.md`
* `13-test-reporting/release-readiness-report.md`

---

# Communication & Documentation

## Evidence

Created structured, audience-specific documentation for:

* QA teams
* Product Owners
* Developers
* Engineering Managers
* Recruiters
* Hiring Managers

### Repository Evidence

* `16-portfolio-case-study/`
* `13-test-reporting/`
* `12-uat/`

---

# Tools Demonstrated

| Tool / Technique         | Evidence                                            |
| ------------------------ | --------------------------------------------------- |
| REST API Testing         | `07-api-testing/`                                   |
| SQL                      | `08-database-validation/sql-validation-queries.sql` |
| Manual Testing           | `05-test-scenarios/`, `06-test-cases/`              |
| Exploratory Testing      | `09-exploratory-testing/`                           |
| Risk-Based Testing       | `01-test-strategy/`, `03-risk-analysis/`            |
| Defect Management        | `10-defect-management/`                             |
| Regression Testing       | `11-regression-testing/`                            |
| UAT                      | `12-uat/`                                           |
| RCA                      | `14-root-cause-analysis/`                           |
| Fintech Domain Knowledge | `15-fintech-guides/`                                |

---

# Business Competencies Demonstrated

| Competency                     | Supporting Evidence                              |
| ------------------------------ | ------------------------------------------------ |
| Customer fund protection       | Reconciliation, payment failure, security guides |
| Financial integrity            | SQL validation and reconciliation testing        |
| Release governance             | Release readiness report and stakeholder reports |
| Business risk analysis         | Risk assessment and test strategy                |
| Cross-functional communication | UAT, stakeholder reporting and case study        |
| Continuous improvement         | RCA, CAPA and lessons learned                    |

---

# Portfolio Navigation Guide

For a quick review:

```text
Hiring Manager Summary
        ↓
Fintech Digital Banking Case Study
        ↓
Project Highlights
        ↓
Evidence Map (this document)
        ↓
Detailed QA Artefacts
```

For a technical review:

```text
Test Strategy
        ↓
Risk Analysis
        ↓
Test Cases
        ↓
API Testing
        ↓
Database Validation
        ↓
Defect Management
        ↓
Regression Testing
        ↓
Release Readiness
```

---

# What This Portfolio Demonstrates

By reviewing the linked evidence, a hiring manager can verify experience in:

* End-to-end QA planning
* Manual testing
* API testing
* SQL and database validation
* Security testing
* Fintech domain testing
* Defect management
* Root Cause Analysis
* Regression testing
* UAT support
* Release governance
* Professional technical documentation

---

# Recruiter Checklist

A reviewer should be able to answer **Yes** to the following questions after reviewing this repository:

* ✔ Can the candidate design a complete QA strategy?
* ✔ Can the candidate create structured test documentation?
* ✔ Can the candidate test REST APIs?
* ✔ Can the candidate validate databases using SQL?
* ✔ Can the candidate investigate defects systematically?
* ✔ Can the candidate understand fintech business processes?
* ✔ Can the candidate assess release readiness?
* ✔ Can the candidate communicate effectively with technical and business stakeholders?

---

# Conclusion

This evidence map connects every major competency claimed in this portfolio to tangible project artefacts.

Instead of relying on a list of skills, the repository provides verifiable evidence demonstrating practical application across the full software testing lifecycle, with a particular focus on fintech quality engineering, financial integrity, security, and risk-based testing.
