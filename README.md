# Fintech Digital Banking QA Lab

A portfolio-grade Quality Assurance project built around a realistic digital banking and wallet-based fintech application.

This repository demonstrates how I approach software quality from requirements analysis and risk assessment through API testing, SQL validation, defect investigation, regression, automation planning, performance testing, and release readiness.

> This is a realistic portfolio simulation. It is not presented as a live production banking platform.

## Portfolio Website

View my wider QA portfolio:

**[toyosi-qa-engineer.vercel.app](https://toyosi-qa-engineer.vercel.app)**

---

## What This Project Demonstrates

* Requirement analysis
* Risk-based testing
* Test strategy and planning
* Functional and exploratory testing
* API testing
* SQL and database validation
* Authentication and authorisation testing
* Security testing
* Defect management
* Regression testing
* UAT support
* Root Cause Analysis
* Automation readiness
* Performance testing
* CI/CD quality gates
* Fintech domain knowledge

---

## System Modules

1. Authentication
2. Wallet Management
3. Wallet Funding
4. Money Transfers
5. Transaction Processing
6. Bill Payments
7. Notifications
8. Security and Fraud Prevention

---

## Critical Fintech Risks Covered

* Double debit prevention
* Double credit prevention
* Duplicate transaction detection
* Duplicate callback handling
* Wallet balance accuracy
* Failed-transfer recovery
* Refund and reversal validation
* Transfer-limit enforcement
* Concurrency and race conditions
* Ledger validation
* Reconciliation testing
* Audit-trail validation
* Object-level authorisation
* Sensitive-data exposure

---

## Project Deliverables

| Area                  | Deliverables                                                |
| --------------------- | ----------------------------------------------------------- |
| Requirements          | Business requirements, user stories and acceptance criteria |
| Risk                  | Risk register and assessment matrix                         |
| Planning              | Test strategy and test plan                                 |
| Test Design           | Scenarios, test cases, negative cases and edge cases        |
| API                   | API coverage and Postman assets                             |
| Database              | SQL validation and reconciliation queries                   |
| Security              | Authentication, authorisation and ownership tests           |
| Defects               | Bug reports, defect log and triage guidance                 |
| Regression            | Smoke, critical and full regression suites                  |
| UAT                   | UAT scenarios and sign-off support                          |
| Reporting             | Test execution and release-readiness reports                |
| RCA                   | Five Whys, Fishbone Analysis and CAPA                       |
| Automation            | Automation strategy, roadmap and API/UI plans               |
| Performance           | k6 performance-testing plan                                 |
| CI/CD                 | Automated testing and quality-gate strategy                 |
| Interview Preparation | Questions, STAR stories and portfolio guide                 |

---

## Example Critical Scenario

### Wallet Debited but Recipient Not Credited

This scenario validates:

* Transfer API response
* Sender wallet balance
* Recipient wallet balance
* Transaction status
* Debit and credit ledger entries
* Retry behaviour
* Reversal or compensation processing
* Final reconciliation

It demonstrates API testing, SQL validation, financial-risk analysis, defect investigation, and regression planning.

---

## Recommended Tool Stack

* Postman
* Swagger
* SQL and PostgreSQL
* Playwright
* Cypress
* Selenium
* TypeScript
* JavaScript
* Java
* k6
* JMeter
* Git
* GitHub
* GitHub Actions
* Docker
* Jira
* Azure DevOps

---

## Testing Approach

```text
Requirements
    ↓
Risk Analysis
    ↓
Test Strategy
    ↓
Test Design
    ↓
API and Database Validation
    ↓
Security and Negative Testing
    ↓
Defect Management
    ↓
Regression and UAT
    ↓
Release Readiness
    ↓
Automation and CI/CD Planning
```

Testing is prioritised according to customer impact, financial risk, security risk, usage frequency, and technical complexity.

---

## Automation Approach

The proposed automation strategy is API-first.

API automation is prioritised because it is generally faster, more stable, and better suited to validating business rules and financial workflows.

UI automation is reserved for critical customer journeys such as:

* Registration
* Login
* Wallet funding
* Money transfer
* Transaction confirmation

Proposed automation stack:

* TypeScript
* Playwright
* PostgreSQL
* k6
* GitHub Actions

---

## Suggested Repository Review Path

For a quick review:

```text
Business Requirements
    ↓
Risk Register
    ↓
Test Strategy
    ↓
Money Transfer Test Cases
    ↓
API Coverage
    ↓
SQL Validation
    ↓
Critical Defect Report
    ↓
Regression Suite
    ↓
Automation Strategy
    ↓
CI/CD Testing Strategy
```

---

## Current Status

### Completed

* Manual QA documentation
* API test coverage
* SQL validation
* Security testing
* Defect management
* Regression planning
* UAT preparation
* Test reporting
* Root Cause Analysis
* Automation strategy
* Performance plan
* CI/CD testing strategy
* Interview-preparation materials

### Next Implementation Steps

* Build the Playwright API framework
* Add critical UI smoke tests
* Create reusable SQL helpers
* Implement k6 scripts
* Add contract testing
* Integrate automated suites with GitHub Actions

---

## Target Roles

This portfolio supports applications for:

* QA Engineer
* API Test Engineer
* Backend QA Engineer
* Automation QA Engineer
* Fintech QA Engineer
* Quality Engineer
* Junior or Mid-Level SDET

---

## About the Author

I am a QA Engineer focused on manual testing, API testing, SQL validation, fintech workflows, and automation.

My career direction is:

```text
QA Engineer
    ↓
Automation QA Engineer
    ↓
Software Development Engineer in Test
```

Explore more of my work at:

**[Toyosi QA Engineer Portfolio](https://toyosi-qa-engineer.vercel.app)**

---

## Disclaimer

All users, accounts, transactions, values, APIs, and business scenarios in this repository are fictional or simulated.

No real customer financial information is included.

---

## Core Quality Principle

> A successful API or UI response is not enough evidence of quality in a financial system. The transaction, wallet, ledger, security controls, and recovery behaviour must also be correct.
