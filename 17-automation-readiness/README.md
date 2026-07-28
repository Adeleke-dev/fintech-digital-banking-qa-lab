# Automation Readiness

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This folder demonstrates how the manual testing activities completed throughout this project can be transformed into a scalable, maintainable, and production-ready automation strategy.

Rather than attempting to automate every test, this phase focuses on selecting the right tests for automation based on:

* Business risk
* Frequency of execution
* Stability
* Repeatability
* Return on investment (ROI)
* Regression impact

The goal is to show how a QA Engineer can evolve into an Automation QA Engineer or Software Development Engineer in Test (SDET).

---

# Purpose

The objectives of this phase are to:

* Define an automation strategy.
* Identify automation candidates.
* Prioritise high-value automated tests.
* Reduce repetitive manual testing.
* Improve regression efficiency.
* Support Continuous Integration and Continuous Delivery (CI/CD).
* Build a roadmap for long-term automation maturity.

---

# Why Automation Matters

As products grow, manual testing alone becomes insufficient.

Automation helps teams:

* Execute regression suites quickly.
* Detect defects earlier.
* Improve release confidence.
* Reduce repetitive effort.
* Increase test consistency.
* Support faster deployments.
* Enable continuous testing.

However, automation should complement manual testing—not replace it.

---

# Automation Philosophy

The project follows these principles:

* Automate repetitive tests.
* Keep exploratory testing manual.
* Prioritise business-critical workflows.
* Validate APIs before UI where practical.
* Design reusable and maintainable test suites.
* Integrate automation into CI/CD pipelines.
* Measure automation value through coverage and reliability.

---

# Folder Structure

```text
17-automation-readiness/
├── README.md
├── automation-strategy.md
├── test-automation-candidate-matrix.md
├── automation-roadmap.md
├── api-automation-plan.md
├── ui-automation-plan.md
├── performance-testing-plan.md
└── ci-cd-testing-strategy.md
```

---

# Document Guide

## automation-strategy.md

Defines the overall automation vision, objectives, scope, tooling, and guiding principles for the project.

---

## test-automation-candidate-matrix.md

Identifies which scenarios should:

* Be automated immediately
* Remain manual
* Be deferred
* Never be automated

The prioritisation is based on business value and maintenance effort.

---

## automation-roadmap.md

Describes the phased implementation plan for introducing automation into the project.

---

## api-automation-plan.md

Explains how REST APIs will be automated, including:

* Authentication
* Wallet operations
* Transfers
* Payments
* Negative testing
* Database validation
* Regression execution

---

## ui-automation-plan.md

Describes UI automation coverage, framework structure, and candidate user journeys.

---

## performance-testing-plan.md

Defines the performance testing approach, including:

* Load testing
* Stress testing
* Spike testing
* Endurance testing
* Scalability assessment

---

## ci-cd-testing-strategy.md

Explains how automated tests integrate into CI/CD pipelines to support continuous quality and rapid feedback.

---

# Recommended Automation Stack

| Area                 | Recommended Tool                 |
| -------------------- | -------------------------------- |
| Programming Language | TypeScript                       |
| API Automation       | Playwright API Testing           |
| UI Automation        | Playwright                       |
| Performance Testing  | k6                               |
| Version Control      | Git & GitHub                     |
| CI/CD                | GitHub Actions                   |
| Reporting            | HTML Reports / Allure (optional) |
| Database Validation  | SQL                              |
| Package Manager      | npm                              |

---

# Automation Priorities

The first automation targets should be:

## Critical

* Authentication
* Wallet funding
* Money transfers
* Bill payments
* Financial reconciliation
* Security validation
* Duplicate payment prevention

## High

* Notifications
* Customer profile updates
* Transaction history
* Administrative workflows

## Medium

* Search
* Reporting
* Preferences
* Low-risk UI interactions

---

# Manual vs Automated Testing

| Testing Activity           | Recommended Approach            |
| -------------------------- | ------------------------------- |
| Smoke Testing              | Automated                       |
| Regression Testing         | Automated                       |
| API Regression             | Automated                       |
| Authentication             | Automated                       |
| Financial Workflows        | Automated                       |
| Exploratory Testing        | Manual                          |
| User Experience Evaluation | Manual                          |
| Accessibility Review       | Mostly Manual with Tool Support |
| UAT                        | Primarily Manual                |
| Ad-hoc Investigation       | Manual                          |

---

# Automation Goals

This project aims to achieve:

* Faster regression execution.
* Consistent API validation.
* Automated financial workflow verification.
* Early defect detection.
* Repeatable test execution.
* Reliable release confidence.
* Reduced manual regression effort.

---

# Guiding Principles

The automation approach follows these principles:

* Prioritise high-risk scenarios.
* Build maintainable test suites.
* Avoid unnecessary UI automation.
* Validate APIs before user interfaces.
* Keep tests independent and repeatable.
* Use realistic test data.
* Minimise flaky tests.
* Produce actionable reports.
* Integrate with CI/CD.

---

# Relationship to Previous Phases

This phase builds on:

* Test Strategy
* Risk Analysis
* Test Cases
* API Testing
* Database Validation
* Security Testing
* Regression Testing
* Release Readiness

Every automated test should trace back to an approved manual test case or high-risk scenario.

---

# Expected Outcomes

By completing this phase, the project demonstrates the ability to:

* Design an automation strategy.
* Select the right automation candidates.
* Plan API and UI automation.
* Integrate testing into CI/CD.
* Prepare performance testing.
* Think like an Automation QA Engineer or SDET.

---

# Success Criteria

This phase is complete when:

* An automation strategy is documented.
* High-value automation candidates are identified.
* API and UI automation plans are defined.
* Performance testing is planned.
* CI/CD integration strategy is documented.
* Automation priorities align with business risk.
* The roadmap supports future implementation.

---

# Portfolio Value

This phase strengthens the portfolio by showing that testing expertise extends beyond manual execution.

It demonstrates:

* Automation planning
* Test architecture thinking
* Tool selection
* Continuous testing knowledge
* Scalable QA practices
* SDET-oriented decision making

---

# QA Lead Conclusion

Automation is not about replacing testers—it is about increasing the speed, reliability, and consistency of quality assurance.

By combining risk-based testing, API automation, UI automation, performance testing, and CI/CD integration, this project demonstrates a practical roadmap for evolving from Manual QA to Automation QA and ultimately to an SDET role.
