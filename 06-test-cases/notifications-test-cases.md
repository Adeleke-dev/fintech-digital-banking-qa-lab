# Notifications Test Cases

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This document contains the detailed test cases for the **Notifications** module.

The Notifications module ensures customers receive timely and accurate communication about financial activities on their accounts. While notifications do not execute financial transactions, they are critical for customer trust, fraud detection, dispute resolution, and overall user experience.

These test cases focus on validating notification accuracy, delivery, consistency, and resilience without affecting transaction processing.

---

# Scope

This document covers:

* Email Notifications
* SMS Notifications
* Push Notifications
* Notification Accuracy
* Notification Failure Handling

These test cases are traceable to the Business Requirements, User Stories, Risk Register, and Test Scenarios developed in previous phases.

---

# Test Case Summary

| Test Case ID | Test Case                                                          | Priority | Risk   | Test Type         |
| ------------ | ------------------------------------------------------------------ | -------- | ------ | ----------------- |
| TC-NOTIF-001 | Verify Successful Transaction Notification Is Sent                 | P2       | Medium | Functional        |
| TC-NOTIF-002 | Verify Notification Contains Accurate Transaction Details          | P1       | High   | Functional / API  |
| TC-NOTIF-003 | Verify Failed Transaction Notification Is Accurate                 | P2       | Medium | Functional        |
| TC-NOTIF-004 | Verify Notification Failure Does Not Affect Transaction Processing | P1       | High   | Integration / API |

---

# Detailed Test Cases

---

## TC-NOTIF-001 — Verify Successful Transaction Notification Is Sent

| Field                | Details       |
| -------------------- | ------------- |
| Test Case ID         | TC-NOTIF-001  |
| Module               | Notifications |
| Related Requirement  | BR-NOTIF-001  |
| Related User Story   | US-NOTIF-001  |
| Related Scenario     | TS-NOTIF-001  |
| Priority             | P2            |
| Risk Level           | Medium        |
| Test Type            | Functional    |
| Automation Candidate | Yes           |

### Preconditions

* Customer has enabled notifications.
* Customer completes a successful financial transaction.

### Test Data

| Field            | Value          |
| ---------------- | -------------- |
| Transaction Type | Wallet Funding |
| Amount           | ₦5,000         |

### Test Steps

1. Complete a successful wallet funding transaction.
2. Monitor configured notification channels.
3. Open the received notification.

### Expected Result

* Notification is delivered successfully.
* Delivery channel matches customer preferences.
* Notification is received within the expected time.
* Notification indicates that the transaction was successful.

### Postconditions

* Notification record is stored for audit purposes.

---

## TC-NOTIF-002 — Verify Notification Contains Accurate Transaction Details

| Field                | Details          |
| -------------------- | ---------------- |
| Test Case ID         | TC-NOTIF-002     |
| Module               | Notifications    |
| Related Requirement  | BR-NOTIF-002     |
| Related User Story   | US-NOTIF-001     |
| Related Scenario     | TS-NOTIF-002     |
| Priority             | P1               |
| Risk Level           | High             |
| Test Type            | Functional / API |
| Automation Candidate | Yes              |

### Preconditions

* Successful transaction has completed.
* Notification has been generated.

### Test Data

| Field                 | Value           |
| --------------------- | --------------- |
| Transaction Reference | Valid Reference |
| Amount                | ₦5,000          |

### Test Steps

1. Open the notification.
2. Compare notification details with transaction records.
3. Verify API response and transaction history.

### Expected Result

Notification correctly displays:

* Transaction amount
* Transaction reference
* Transaction type
* Transaction status
* Date and time
* Available balance (if applicable)

All values match the transaction record.

### Postconditions

* Customer receives accurate transaction information.

---

## TC-NOTIF-003 — Verify Failed Transaction Notification Is Accurate

| Field                | Details       |
| -------------------- | ------------- |
| Test Case ID         | TC-NOTIF-003  |
| Module               | Notifications |
| Related Requirement  | BR-NOTIF-003  |
| Related User Story   | US-NOTIF-002  |
| Related Scenario     | TS-NOTIF-003  |
| Priority             | P2            |
| Risk Level           | Medium        |
| Test Type            | Functional    |
| Automation Candidate | Yes           |

### Preconditions

* Transaction fails.

### Test Data

| Field            | Value             |
| ---------------- | ----------------- |
| Transaction Type | External Transfer |

### Test Steps

1. Initiate a transaction.
2. Simulate provider failure.
3. Review customer notification.

### Expected Result

* Notification clearly indicates the transaction failed.
* Failure reason is communicated where appropriate.
* Notification does not incorrectly state that money was successfully transferred.
* Customer receives guidance on next steps if applicable.

### Postconditions

* Notification accurately reflects the final transaction outcome.

---

## TC-NOTIF-004 — Verify Notification Failure Does Not Affect Transaction Processing

| Field                | Details           |
| -------------------- | ----------------- |
| Test Case ID         | TC-NOTIF-004      |
| Module               | Notifications     |
| Related Requirement  | BR-NOTIF-004      |
| Related User Story   | US-NOTIF-001      |
| Related Scenario     | TS-NOTIF-005      |
| Priority             | P1                |
| Risk Level           | High              |
| Test Type            | Integration / API |
| Automation Candidate | Yes               |

### Preconditions

* Notification service is temporarily unavailable.
* Transaction service is operational.

### Test Data

| Field       | Value                     |
| ----------- | ------------------------- |
| Transaction | Successful Wallet Funding |

### Test Steps

1. Disable or simulate failure of the notification service.
2. Complete a successful financial transaction.
3. Verify transaction status.
4. Review notification logs.

### Expected Result

* Financial transaction completes successfully.
* Wallet balance updates correctly.
* Transaction status remains **SUCCESSFUL**.
* Notification failure is logged.
* Notification failure does not trigger transaction rollback.

### Postconditions

* Financial records remain accurate.
* Notification can be retried according to system design.

---

# Traceability Matrix

| Test Case    | Requirement  | User Story   | Scenario     |
| ------------ | ------------ | ------------ | ------------ |
| TC-NOTIF-001 | BR-NOTIF-001 | US-NOTIF-001 | TS-NOTIF-001 |
| TC-NOTIF-002 | BR-NOTIF-002 | US-NOTIF-001 | TS-NOTIF-002 |
| TC-NOTIF-003 | BR-NOTIF-003 | US-NOTIF-002 | TS-NOTIF-003 |
| TC-NOTIF-004 | BR-NOTIF-004 | US-NOTIF-001 | TS-NOTIF-005 |

---

# Execution Notes

During execution, record:

* Actual Result
* Execution Status (Pass / Fail / Blocked / Not Run)
* Defect ID (if applicable)
* Tester Name
* Execution Date
* Environment
* Evidence (email content, SMS content, push notification screenshots, API responses, notification service logs)

---

# Fintech QA Notes

### Why this module is important

Customers rely on notifications to confirm financial activity, detect unauthorized transactions, and resolve disputes. Incorrect or missing notifications can reduce customer confidence even when the financial transaction itself is successful.

### Production risks covered

* Incorrect transaction amount in notifications
* Incorrect transaction status
* Delayed notifications
* Notification delivery failure
* Notification causing transaction failure
* Inconsistent information between notification and transaction record

### Recruiter Talking Point

This module demonstrates the ability to validate asynchronous services, notification accuracy, and system resilience by ensuring that communication failures do not compromise financial transaction processing.

