# Exploratory Testing

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This folder contains the exploratory testing documentation for the Fintech Digital Banking QA Lab.

Exploratory testing complements structured test cases by allowing QA Engineers to investigate the application without predefined scripts. It combines learning, test design, and execution simultaneously to uncover defects that may not be identified through traditional test cases.

In fintech applications, exploratory testing is especially valuable because real customer behavior, unexpected workflows, and third-party integrations often expose issues that scripted testing cannot anticipate.

---

# Purpose

The purpose of exploratory testing is to:

* Discover high-risk defects not covered by scripted testing.
* Validate user experience across financial workflows.
* Identify usability and workflow inconsistencies.
* Investigate unexpected system behavior.
* Assess application resilience under unusual conditions.
* Verify business rule implementation from an end-user perspective.

---

# Scope

Exploratory testing will be performed on the following modules:

1. Authentication
2. Wallet Management
3. Wallet Funding
4. Money Transfers
5. Transaction Processing
6. Bill Payments
7. Notifications
8. Security and Fraud Prevention

---

# Exploratory Testing Approach

Each exploratory testing session will be guided by a **testing charter** that defines:

* Mission
* Scope
* Time Box
* Risks
* Areas to Explore
* Expected Observations

This structured approach ensures exploratory testing remains focused while allowing flexibility to investigate unexpected behaviors.

---

# Areas of Investigation

Examples of areas explored during testing include:

### Authentication

* Invalid login sequences
* OTP edge cases
* Session timeout behavior
* Password reset workflow

### Wallet Management

* Wallet balance consistency
* Transaction history accuracy
* Wallet creation timing

### Wallet Funding

* Duplicate callbacks
* Delayed provider responses
* Interrupted funding flows

### Money Transfers

* Rapid transfer attempts
* Concurrent transfer requests
* Transfer cancellation scenarios

### Transaction Processing

* Status transition anomalies
* Duplicate references
* Reversal and refund behavior

### Bill Payments

* Provider failures
* Timeout scenarios
* Duplicate payment attempts

### Notifications

* Delayed delivery
* Missing notifications
* Incorrect notification content

### Security

* Unauthorized access attempts
* Session hijacking scenarios
* Duplicate API requests
* Authorization boundary testing

---

# Deliverables

This phase produces:

| File                            | Purpose                                                 |
| ------------------------------- | ------------------------------------------------------- |
| exploratory-testing-charters.md | Structured exploratory testing sessions for each module |

---

# Expected Outcomes

Exploratory testing should help identify:

* Unexpected application behavior
* Workflow gaps
* Business rule inconsistencies
* UI and API inconsistencies
* Integration issues
* Data integrity problems
* Security weaknesses
* Customer experience issues

---

# Best Practices

During exploratory testing:

* Follow realistic customer journeys.
* Think like an attacker, an impatient customer, and a first-time user.
* Explore both expected and unexpected workflows.
* Capture detailed notes and screenshots.
* Record every defect with clear reproduction steps.
* Validate findings against API responses and database records where applicable.

---

# Recruiter Talking Points

This phase demonstrates the ability to:

* Think beyond scripted testing.
* Investigate complex user workflows.
* Apply critical thinking and risk-based exploration.
* Identify production issues before release.
* Perform end-to-end quality assessment across UI, API, and database layers.

---

# Success Criteria

Exploratory testing is considered successful when:

* High-risk workflows have been explored.
* Significant observations are documented.
* Defects are logged where applicable.
* Findings contribute to improving product quality and release confidence.
