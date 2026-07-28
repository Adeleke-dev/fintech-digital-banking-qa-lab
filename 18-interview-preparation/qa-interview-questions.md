# QA Interview Questions

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This guide contains common Manual QA interview questions and model answers, progressing from **Junior QA Engineer** to **Senior QA Engineer** level.

The answers emphasise practical understanding rather than memorised definitions and encourage candidates to explain concepts using examples from real projects.

---

# Section 1 – QA Fundamentals

## Question 1

### What is Software Testing?

**Sample Answer**

Software testing is the process of evaluating a software application to verify that it meets business requirements, works as expected, and does not contain defects that could negatively affect users or the business.

The objective is not only to find bugs but also to provide confidence that the software is suitable for release.

---

## Question 2

### Why is software testing important?

**Sample Answer**

Testing helps:

* Prevent production defects
* Protect customer data
* Improve software quality
* Reduce business risk
* Verify business requirements
* Improve customer confidence
* Reduce the cost of fixing defects later

For fintech applications, testing also helps protect customer funds and maintain financial integrity.

---

## Question 3

### What is the difference between Quality Assurance and Quality Control?

| Quality Assurance (QA)          | Quality Control (QC)            |
| ------------------------------- | ------------------------------- |
| Process-oriented                | Product-oriented                |
| Prevents defects                | Detects defects                 |
| Improves development process    | Verifies completed software     |
| Includes planning and standards | Includes testing and inspection |

A QA Engineer often contributes to both by improving processes and validating software quality.

---

## Question 4

### What is a defect?

**Sample Answer**

A defect is any deviation between the expected behaviour of the software and its actual behaviour.

A defect may be caused by:

* Incorrect implementation
* Missing requirements
* Poor design
* Configuration errors
* Integration issues

---

## Question 5

### What is the difference between an Error, Defect and Failure?

| Term         | Meaning                                          |
| ------------ | ------------------------------------------------ |
| Error        | Human mistake during development or requirements |
| Defect (Bug) | Fault introduced into the software               |
| Failure      | Incorrect behaviour observed during execution    |

Example:

Developer writes incorrect calculation logic → Error

↓

Incorrect code exists in the application → Defect

↓

Customer receives an incorrect wallet balance → Failure

---

# Section 2 – STLC

## Question 6

### What are the phases of the Software Testing Life Cycle (STLC)?

**Answer**

1. Requirement Analysis
2. Test Planning
3. Test Case Development
4. Test Environment Setup
5. Test Execution
6. Defect Reporting
7. Test Closure

Explain what activities occur during each phase and provide examples from your projects.

---

## Question 7

### What activities happen during Requirement Analysis?

**Answer**

During Requirement Analysis, QA engineers:

* Review requirements
* Identify ambiguities
* Identify risks
* Estimate testing effort
* Prepare questions for stakeholders
* Identify automation opportunities

---

## Question 8

### What is a Test Plan?

**Answer**

A Test Plan describes:

* Scope
* Objectives
* Testing approach
* Resources
* Schedule
* Risks
* Entry criteria
* Exit criteria
* Deliverables

It explains how testing will be organised and managed throughout the project.

---

## Question 9

### What is the difference between a Test Plan and a Test Strategy?

| Test Strategy                        | Test Plan                       |
| ------------------------------------ | ------------------------------- |
| High-level approach                  | Project-specific implementation |
| Long-term direction                  | Execution details               |
| Organisation-wide or programme-level | Individual project              |

---

# Section 3 – Test Design

## Question 10

### What is a Test Scenario?

**Answer**

A Test Scenario is a high-level testing objective describing **what** needs to be validated.

Example:

Verify successful wallet funding.

---

## Question 11

### What is a Test Case?

**Answer**

A Test Case contains detailed execution steps including:

* Preconditions
* Test steps
* Test data
* Expected result
* Actual result
* Status

Example:

Verify successful wallet funding using a valid payment method and confirm that the wallet balance updates correctly.

---

## Question 12

### What makes a good Test Case?

A good Test Case is:

* Clear
* Repeatable
* Independent
* Easy to execute
* Easy to maintain
* Traceable to requirements

---

# Section 4 – Test Types

## Question 13

### What is Regression Testing?

**Answer**

Regression Testing verifies that existing functionality continues to work after changes have been made to the application.

---

## Question 14

### What is Smoke Testing?

**Answer**

Smoke Testing validates the application's critical functionality before deeper testing begins.

Typical smoke tests include:

* Login
* Registration
* Dashboard access
* Health checks

---

## Question 15

### What is Sanity Testing?

**Answer**

Sanity Testing is a focused validation performed after a defect fix or small change to verify that the specific functionality works as expected.

---

## Question 16

### What is Exploratory Testing?

**Answer**

Exploratory Testing combines learning, test design and execution simultaneously.

The tester investigates the application without relying solely on predefined test cases to uncover unexpected issues.

---

## Question 17

### What is Negative Testing?

**Answer**

Negative Testing verifies how the application behaves when users provide invalid input or perform unexpected actions.

Example:

Attempting to transfer more money than the available wallet balance.

---

## Question 18

### What is Boundary Value Analysis?

**Answer**

Boundary Value Analysis focuses on values at the edges of valid input ranges because defects commonly occur around boundaries.

Example:

If the transfer limit is £10,000:

* £9,999
* £10,000
* £10,001

---

## Question 19

### What is Equivalence Partitioning?

**Answer**

Equivalence Partitioning divides input values into groups that should behave similarly.

Instead of testing every possible value, one representative value from each partition is tested.

---

# Section 5 – Defect Management

## Question 20

### What information should a Bug Report contain?

A Bug Report should include:

* Title
* Description
* Environment
* Steps to reproduce
* Expected result
* Actual result
* Severity
* Priority
* Evidence
* Attachments
* Status

---

## Question 21

### What is Severity?

Severity measures how seriously a defect affects the system.

Examples:

* Critical
* High
* Medium
* Low

---

## Question 22

### What is Priority?

Priority determines how quickly the defect should be fixed.

Priority is driven by business impact rather than technical complexity.

---

## Question 23

### Can Severity and Priority differ?

Yes.

Example:

A spelling mistake on the homepage.

Severity:

Low

Priority:

High (because it affects branding).

---

# Section 6 – Risk-Based Testing

## Question 24

### How do you prioritise testing?

**Sample Answer**

I prioritise testing based on:

* Business impact
* Customer impact
* Financial risk
* Security risk
* Usage frequency
* Technical complexity
* Regulatory requirements

High-risk workflows such as authentication, payments and money transfers are tested before lower-risk features.

---

## Question 25

### What is Risk-Based Testing?

**Answer**

Risk-Based Testing allocates testing effort according to the likelihood and impact of potential failures.

The higher the business risk, the greater the testing effort.

---

# Section 7 – Agile QA

## Question 26

### What is the QA Engineer's role in Agile?

Responsibilities include:

* Reviewing user stories
* Defining acceptance criteria
* Participating in sprint planning
* Executing tests
* Reporting defects
* Supporting releases
* Collaborating with developers and product owners

---

## Question 27

### What are Acceptance Criteria?

Acceptance Criteria define the conditions that must be satisfied before a user story is considered complete.

They provide a shared understanding between developers, testers and product owners.

---

# Section 8 – Communication

## Question 28

### How do you report a Critical defect?

**Sample Answer**

I document the defect clearly, explain the business impact, notify the relevant stakeholders immediately, provide supporting evidence and recommend whether the issue should block the release based on its severity and risk.

---

## Question 29

### What would you do if a developer disagreed with your defect?

**Sample Answer**

I would review the requirements, reproduce the issue together, present evidence objectively and discuss the expected behaviour. The focus should be on understanding the product behaviour rather than proving who is correct.

---

# Section 9 – Senior-Level Questions

## Question 30

### How do you decide whether software is ready for release?

**Sample Answer**

I review multiple sources of evidence, including:

* Test execution results
* Critical defect status
* Regression outcomes
* Security validation
* Performance results
* Database validation
* Business acceptance
* Release risks

The decision should balance technical quality with business risk.

---

## Question 31

### How do you measure QA success?

Possible metrics include:

* Test coverage
* Defect leakage
* Defect detection rate
* Regression pass rate
* Escaped defects
* Test execution progress
* Automation coverage
* Customer-reported issues

No single metric should be used in isolation.

---

## Question 32

### What is Root Cause Analysis?

**Answer**

Root Cause Analysis investigates why a defect occurred and identifies actions to prevent similar defects in the future.

Common techniques include:

* Five Whys
* Fishbone (Ishikawa) Diagram
* Timeline Analysis
* CAPA (Corrective and Preventive Actions)

---

## Question 33

### What qualities make a good QA Engineer?

A good QA Engineer should demonstrate:

* Analytical thinking
* Attention to detail
* Curiosity
* Clear communication
* Business understanding
* Risk awareness
* Collaboration
* Continuous learning
* Technical knowledge
* Integrity

---

# Practical Interview Scenario

**Question**

A customer reports that their wallet balance is incorrect after a money transfer. How would you investigate?

**Suggested Approach**

1. Reproduce the issue if possible.
2. Review the transaction history.
3. Validate API requests and responses.
4. Check database records.
5. Verify wallet balance calculations.
6. Review ledger entries.
7. Check logs for failures or retries.
8. Determine business impact.
9. Raise a defect if required.
10. Recommend regression coverage.

---

# Interview Tips

* Explain concepts with practical examples.
* Connect answers to business impact.
* Think aloud during scenario questions.
* Ask clarifying questions if requirements are unclear.
* Be honest about areas you are still learning.
* Use examples from your portfolio whenever possible.

---

# Common Mistakes

Avoid:

* Giving textbook definitions without context.
* Focusing only on UI testing.
* Ignoring business risks.
* Confusing severity with priority.
* Claiming to know tools you have not used.
* Speaking negatively about colleagues or previous employers.

---

# Final Advice

Strong QA interview answers demonstrate more than technical knowledge.

They show that you can:

* Understand requirements.
* Identify risks.
* Design effective tests.
* Investigate defects.
* Communicate clearly.
* Support informed release decisions.

Use examples from your portfolio to illustrate these skills and show how your testing contributed to product quality and business outcomes.

---

# QA Lead Conclusion

Successful QA Engineers do more than execute test cases. They think critically, understand the business, anticipate risks and collaborate across teams to deliver reliable software.

During interviews, focus on explaining **how you think**, **why you made specific testing decisions**, and **what value your work delivered**, rather than simply listing testing activities or tools.
