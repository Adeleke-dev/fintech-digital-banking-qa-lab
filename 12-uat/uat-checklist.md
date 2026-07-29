# User Acceptance Testing (UAT) Checklist

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This checklist is used by the Product Owner and business stakeholders during User Acceptance Testing (UAT) to verify that the application satisfies business requirements and is ready for production deployment.

Unlike QA functional testing, this checklist focuses on **business outcomes**, customer experience, and operational readiness.

---

# UAT Execution Information

| Item             | Details            |
| ---------------- | ------------------ |
| Environment      | UAT / Staging      |
| Release Version  | v1.0.0-RC1         |
| Test Cycle       | UAT Cycle 1        |
| Product Owner    | __________________ |
| Business Analyst | __________________ |
| QA Lead          | __________________ |
| Execution Date   | __________________ |

---

# 1. Customer Registration

| Acceptance Check                                           |     Status    | Comments |
| ---------------------------------------------------------- | :-----------: | -------- |
| Customer can successfully register using valid information | ☐ Pass ☐ Fail |          |
| Duplicate email registration is prevented                  | ☐ Pass ☐ Fail |          |
| OTP verification works correctly                           | ☐ Pass ☐ Fail |          |
| Verified customer can proceed to login                     | ☐ Pass ☐ Fail |          |
| Business onboarding process is simple and understandable   | ☐ Pass ☐ Fail |          |

---

# 2. Customer Authentication

| Acceptance Check                         |     Status    | Comments |
| ---------------------------------------- | :-----------: | -------- |
| Customer logs in successfully            | ☐ Pass ☐ Fail |          |
| Invalid credentials are rejected         | ☐ Pass ☐ Fail |          |
| Password reset process works correctly   | ☐ Pass ☐ Fail |          |
| Customer session is maintained correctly | ☐ Pass ☐ Fail |          |
| Logout ends the customer session         | ☐ Pass ☐ Fail |          |

---

# 3. Wallet Management

| Acceptance Check                                          |     Status    | Comments |
| --------------------------------------------------------- | :-----------: | -------- |
| Wallet is created automatically for verified customer     | ☐ Pass ☐ Fail |          |
| Wallet balance is displayed correctly                     | ☐ Pass ☐ Fail |          |
| Transaction history is visible                            | ☐ Pass ☐ Fail |          |
| Wallet information belongs only to the logged-in customer | ☐ Pass ☐ Fail |          |

---

# 4. Wallet Funding

| Acceptance Check                                   |     Status    | Comments |
| -------------------------------------------------- | :-----------: | -------- |
| Customer can fund wallet successfully              | ☐ Pass ☐ Fail |          |
| Successful funding updates wallet balance          | ☐ Pass ☐ Fail |          |
| Failed funding does not credit wallet              | ☐ Pass ☐ Fail |          |
| Duplicate funding does not create duplicate credit | ☐ Pass ☐ Fail |          |
| Customer receives funding confirmation             | ☐ Pass ☐ Fail |          |

---

# 5. Money Transfers

| Acceptance Check                                 |     Status    | Comments |
| ------------------------------------------------ | :-----------: | -------- |
| Customer can transfer funds internally           | ☐ Pass ☐ Fail |          |
| Customer can transfer funds externally           | ☐ Pass ☐ Fail |          |
| Transfer limits are enforced correctly           | ☐ Pass ☐ Fail |          |
| Failed transfers are reversed correctly          | ☐ Pass ☐ Fail |          |
| Customer receives accurate transfer confirmation | ☐ Pass ☐ Fail |          |

---

# 6. Transaction Processing

| Acceptance Check                          |     Status    | Comments |
| ----------------------------------------- | :-----------: | -------- |
| Every transaction has a unique reference  | ☐ Pass ☐ Fail |          |
| Transaction statuses are accurate         | ☐ Pass ☐ Fail |          |
| Successful transactions appear in history | ☐ Pass ☐ Fail |          |
| Reversals restore customer funds          | ☐ Pass ☐ Fail |          |
| Refunds return the correct amount         | ☐ Pass ☐ Fail |          |

---

# 7. Bill Payments

| Acceptance Check                       |     Status    | Comments |
| -------------------------------------- | :-----------: | -------- |
| Customer can purchase airtime          | ☐ Pass ☐ Fail |          |
| Customer can purchase data             | ☐ Pass ☐ Fail |          |
| Customer can pay utility bills         | ☐ Pass ☐ Fail |          |
| Failed payments are handled correctly  | ☐ Pass ☐ Fail |          |
| Customer receives payment confirmation | ☐ Pass ☐ Fail |          |

---

# 8. Notifications

| Acceptance Check                                           |     Status    | Comments |
| ---------------------------------------------------------- | :-----------: | -------- |
| Transaction notifications are delivered                    | ☐ Pass ☐ Fail |          |
| Notification content is accurate                           | ☐ Pass ☐ Fail |          |
| Notification timing is acceptable                          | ☐ Pass ☐ Fail |          |
| Notification failures do not affect financial transactions | ☐ Pass ☐ Fail |          |

---

# 9. Security and Fraud Controls

| Acceptance Check                                    |     Status    | Comments |
| --------------------------------------------------- | :-----------: | -------- |
| Unauthorised users cannot access protected features | ☐ Pass ☐ Fail |          |
| Customer data remains private                       | ☐ Pass ☐ Fail |          |
| Duplicate financial requests are prevented          | ☐ Pass ☐ Fail |          |
| Fraud prevention controls operate correctly         | ☐ Pass ☐ Fail |          |

---

# 10. Customer Experience

| Acceptance Check                            |     Status    | Comments |
| ------------------------------------------- | :-----------: | -------- |
| Navigation is intuitive                     | ☐ Pass ☐ Fail |          |
| Error messages are clear and helpful        | ☐ Pass ☐ Fail |          |
| Financial information is easy to understand | ☐ Pass ☐ Fail |          |
| Response times meet business expectations   | ☐ Pass ☐ Fail |          |
| Overall customer journey is satisfactory    | ☐ Pass ☐ Fail |          |

---

# 11. Business Readiness

| Acceptance Check                        |     Status    | Comments |
| --------------------------------------- | :-----------: | -------- |
| Business requirements have been met     | ☐ Pass ☐ Fail |          |
| Acceptance criteria have been satisfied | ☐ Pass ☐ Fail |          |
| No critical business defects remain     | ☐ Pass ☐ Fail |          |
| Product is suitable for production use  | ☐ Pass ☐ Fail |          |

---

# UAT Summary

| Metric                 | Result     |
| ---------------------- | ---------- |
| Total Checks Executed  | __________ |
| Passed                 | __________ |
| Failed                 | __________ |
| Pass Rate              | __________ |
| Business Issues Raised | __________ |

---

# Business Risks Identified

| Risk | Impact | Action Required |
| ---- | ------ | --------------- |
|      |        |                 |
|      |        |                 |
|      |        |                 |

---

# Product Owner Feedback

### Positive Observations

---

---

---

### Concerns

---

---

---

### Recommended Improvements

---

---

---

---

# UAT Decision

| Decision                       | Select |
| ------------------------------ | :----: |
| Approved for Production        |    ☐   |
| Approved with Minor Conditions |    ☐   |
| Not Approved                   |    ☐   |

---

# Sign-Off

| Role                | Name | Signature | Date |
| ------------------- | ---- | --------- | ---- |
| Product Owner       |      |           |      |
| Business Analyst    |      |           |      |
| QA Lead             |      |           |      |
| Engineering Manager |      |           |      |

---

# Recruiter Talking Points

This checklist demonstrates the ability to:

* Support business stakeholders during UAT.
* Validate software from a business perspective rather than only a technical perspective.
* Translate requirements into measurable business acceptance criteria.
* Collaborate with Product Owners, Business Analysts, QA, and Engineering teams.
* Participate in the final production readiness decision using structured acceptance evidence.
