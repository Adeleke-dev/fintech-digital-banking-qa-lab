# UI Automation Plan

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document defines the User Interface (UI) automation strategy for the **Fintech Digital Banking QA Lab**.

While API automation validates the majority of business logic, UI automation ensures that customers can successfully complete critical end-to-end journeys through the application's interface.

The objective is to automate the **most valuable user journeys**, not every screen or UI element.

---

# Objectives

The UI automation programme aims to:

* Validate critical customer journeys.
* Detect UI regressions early.
* Verify integration between frontend and backend.
* Reduce repetitive manual regression testing.
* Increase confidence before production releases.
* Support Continuous Integration (CI).

---

# Automation Philosophy

The project follows these principles:

* Automate complete user journeys.
* Keep UI tests independent.
* Avoid brittle selectors.
* Minimise test maintenance.
* Verify business outcomes rather than visual appearance.
* Use API setup where possible to reduce execution time.
* Keep UI automation focused on high-value scenarios.

---

# Technology Stack

| Area               | Tool                   |
| ------------------ | ---------------------- |
| Language           | TypeScript             |
| Framework          | Playwright             |
| Test Runner        | Playwright Test        |
| Browser Automation | Playwright             |
| Assertions         | Playwright Expect      |
| Reporting          | Playwright HTML Report |
| CI/CD              | GitHub Actions         |
| Version Control    | Git                    |

---

# UI Automation Architecture

```text
                 Playwright Test Runner
                         │
                         ▼
                 Browser Automation
                         │
                         ▼
                 Frontend Application
                         │
             ┌───────────┴───────────┐
             ▼                       ▼
         REST APIs             Backend Services
             │                       │
             └───────────┬───────────┘
                         ▼
                    PostgreSQL
```

---

# Scope

## In Scope

Critical customer workflows:

* User registration
* Login
* Logout
* Password reset
* Wallet dashboard
* Wallet funding
* Internal transfer
* External transfer
* Bill payment
* Transaction history
* Notification display
* User profile

---

## Out of Scope

These activities remain primarily manual:

* Exploratory testing
* Visual design review
* Accessibility assessment
* Responsive design verification across every device
* Ad-hoc investigations
* Usability studies
* Marketing pages

---

# Customer Journeys

## Journey 1 – Registration

### Flow

```text
Landing Page
      │
      ▼
Register
      │
      ▼
Complete Registration
      │
      ▼
Verification
      │
      ▼
Dashboard
```

### Validation

* Registration form
* Mandatory fields
* Validation messages
* Successful account creation
* Dashboard redirect

Priority:

**Critical**

---

## Journey 2 – Login

### Flow

```text
Login
   │
   ▼
Authentication
   │
   ▼
Dashboard
```

### Validation

* Valid login
* Invalid login
* Locked account
* Expired password flow (if applicable)
* Session creation

Priority:

**Critical**

---

## Journey 3 – Wallet Funding

### Flow

```text
Dashboard
     │
     ▼
Fund Wallet
     │
     ▼
Payment
     │
     ▼
Confirmation
```

### Validation

* Funding form
* Amount validation
* Successful funding
* Updated balance
* Success notification
* Transaction record displayed

Priority:

**Critical**

---

## Journey 4 – Internal Transfer

### Flow

```text
Dashboard
      │
      ▼
Transfer
      │
      ▼
Recipient
      │
      ▼
Confirmation
```

### Validation

* Recipient selection
* Amount validation
* Successful transfer
* Updated balances
* Transaction history updated

Priority:

**Critical**

---

## Journey 5 – External Transfer

### Validation

* Beneficiary selection
* Account validation
* Amount validation
* Confirmation screen
* Success notification
* Failure handling

Priority:

**Critical**

---

## Journey 6 – Bill Payment

### Flow

```text
Dashboard
      │
      ▼
Bills
      │
      ▼
Choose Provider
      │
      ▼
Payment
      │
      ▼
Receipt
```

### Validation

* Provider selection
* Amount validation
* Payment success
* Payment failure
* Receipt generation

Priority:

**High**

---

## Journey 7 – Transaction History

### Validation

* Transaction list
* Transaction details
* Sorting
* Filtering
* Pagination
* Empty state

Priority:

**High**

---

## Journey 8 – User Profile

### Validation

* View profile
* Edit profile
* Save changes
* Validation messages
* Cancel changes

Priority:

**Medium**

---

## Journey 9 – Password Reset

### Validation

* Forgot password
* Email submission
* Reset link flow
* New password
* Login with new password

Priority:

**High**

---

# Cross-Browser Testing

Supported browsers:

* Chromium
* Firefox
* WebKit

Execution:

* Smoke suite on Chromium for every Pull Request.
* Full browser matrix on nightly builds and release candidates.

---

# Responsive Testing

Minimum viewport coverage:

| Device  | Resolution  |
| ------- | ----------- |
| Mobile  | 390 × 844   |
| Tablet  | 768 × 1024  |
| Laptop  | 1366 × 768  |
| Desktop | 1920 × 1080 |

Critical workflows should execute successfully across supported viewports.

---

# Locator Strategy

Preferred selector order:

1. `getByRole()`
2. `getByLabel()`
3. `getByPlaceholder()`
4. `getByText()`
5. Stable `data-testid` attributes
6. CSS selectors (only if necessary)

Avoid:

* XPath where possible
* Dynamic CSS classes
* Index-based selectors
* Absolute DOM paths

---

# Test Data Strategy

Use:

* Dedicated QA users
* Independent test accounts
* Unique transaction references
* Resettable datasets
* Environment variables

Avoid:

* Shared mutable data
* Production accounts
* Hard-coded credentials

---

# Assertions

Every UI test should validate:

## UI

* Page loaded
* Correct navigation
* Button availability
* Form validation
* Success messages
* Error messages

---

## Business

* Wallet updated
* Transaction completed
* Balance changed
* Notification displayed
* Status updated

---

## Database (where applicable)

Validate:

* Wallet balance
* Transaction record
* Ledger entry
* Audit record

---

# Error Handling

Automated tests should verify:

* Invalid input
* Empty fields
* Server errors
* Provider failures
* Timeout handling
* Duplicate submissions
* Session expiry

---

# Synchronisation Strategy

Playwright auto-waiting should be used wherever possible.

Avoid:

* Fixed delays (`waitForTimeout`)
* Arbitrary sleeps

Prefer:

* Element visibility
* Network completion
* URL changes
* Expected conditions

---

# Screenshot Strategy

Capture screenshots:

* On failure
* After successful completion of critical journeys (optional)
* Before submitting defect reports

Store artefacts with each pipeline run for investigation.

---

# Video Recording

Enable video for:

* Failed tests
* Nightly regression
* Release candidate executions

Video evidence supports faster Root Cause Analysis.

---

# Reporting

Every execution should produce:

* HTML report
* Test duration
* Pass/fail status
* Screenshots
* Videos (when enabled)
* Trace files
* Failure logs

---

# CI/CD Integration

## Pull Request

Run:

* Login
* Registration
* Smoke suite

---

## Merge to Main

Run:

* Critical UI journeys
* Authentication
* Wallet funding
* Transfer flow

---

## Nightly

Run:

* Full UI regression
* Multi-browser execution
* Responsive checks

---

## Release Candidate

Run:

* Complete UI regression
* Cross-browser suite
* End-to-end customer journeys

---

# Flaky Test Prevention

To minimise instability:

* Use stable locators.
* Keep tests isolated.
* Avoid dependency between tests.
* Reset test data.
* Use Playwright auto-waiting.
* Retry only where justified.
* Review flaky failures regularly.

Target:

**Less than 2% flaky tests**

---

# Success Metrics

| Metric                               | Target                  |
| ------------------------------------ | ----------------------- |
| Smoke suite                          | < 10 minutes            |
| Critical UI regression               | < 20 minutes            |
| Full UI regression                   | < 45 minutes            |
| Pass rate                            | > 95%                   |
| Flaky tests                          | < 2%                    |
| Browser coverage                     | 100% supported browsers |
| Critical customer journeys automated | 100%                    |

---

# Risks

Potential challenges:

* Frequent UI redesigns
* Unstable selectors
* Shared environments
* Slow third-party services
* Dynamic content
* Browser differences

Mitigation:

* Prefer API setup.
* Use stable locators.
* Maintain reusable page objects.
* Review failing tests promptly.
* Mock third-party services where appropriate.

---

# Best Practices

* Follow the Page Object Model (POM).
* Keep test cases independent.
* Separate test data from test logic.
* Reuse helper functions.
* Write clear assertions.
* Keep tests readable and maintainable.
* Validate business outcomes instead of implementation details.

---

# Portfolio Value

This document demonstrates the ability to:

* Design a scalable UI automation strategy.
* Select high-value customer journeys.
* Apply Playwright best practices.
* Balance UI and API automation.
* Integrate UI testing into CI/CD.
* Build maintainable automation for fintech applications.

---

# QA Lead Conclusion

UI automation provides confidence that customers can complete the most important business journeys through the application.

For a fintech platform, UI tests should focus on validating complete customer experiences while relying on API automation to verify detailed business logic. Combining both approaches creates a balanced, efficient, and maintainable automation strategy that supports rapid, high-quality software delivery.
