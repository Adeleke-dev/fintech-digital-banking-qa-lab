# 30-60-90 Day Plan

## Target Role

**QA Engineer / API Test Engineer / Automation QA Engineer**

---

# Overview

This plan outlines how I would approach my first 90 days in a new QA role.

The purpose is to demonstrate how I would:

* Learn the product
* Understand the team
* Assess quality risks
* Contribute to testing
* Improve documentation
* Strengthen regression coverage
* Identify automation opportunities
* Support reliable releases

The plan is intentionally flexible because every organisation has different products, priorities, processes, tools, and levels of QA maturity.

---

# Guiding Principles

During the first 90 days, I would focus on:

* Learning before changing
* Understanding business risk
* Building trust with the team
* Delivering useful results early
* Making evidence-based recommendations
* Improving quality incrementally
* Avoiding unnecessary process disruption
* Aligning testing with customer and business outcomes

---

# Success Definition

By the end of 90 days, I should be able to:

* Explain the product’s critical workflows.
* Understand the architecture and integrations.
* Identify the highest quality risks.
* Execute testing independently.
* Investigate defects effectively.
* Maintain or improve regression coverage.
* Contribute to release decisions.
* Recommend practical automation improvements.
* Collaborate confidently with developers, product managers, and stakeholders.

---

# First 30 Days — Learn and Understand

## Primary Goal

Build product, technical, and team understanding before proposing major changes.

---

# Week 1 — Onboarding and Access

## Objectives

* Complete company onboarding.
* Gain access to required systems.
* Understand team structure.
* Learn the release process.
* Review available documentation.

---

## Activities

### Team and Process

Meet with:

* QA team members
* Developers
* Product managers
* Engineering managers
* DevOps or platform engineers
* Customer support where relevant

Understand:

* Team responsibilities
* Communication channels
* Sprint structure
* Definition of Ready
* Definition of Done
* Defect workflow
* Release cadence
* Escalation process

---

### Tools and Access

Confirm access to:

* Test environments
* Issue-tracking system
* Test-management tools
* API documentation
* Source control
* CI/CD pipelines
* Logging and monitoring systems
* Database tools
* Product analytics
* Communication platforms

---

### Documentation Review

Review:

* Product requirements
* Architecture diagrams
* API contracts
* Existing test plans
* Regression suites
* Defect history
* Release reports
* Incident reports
* Runbooks
* Automation documentation

---

## Week 1 Deliverables

* Onboarding checklist completed
* Access gaps documented
* Initial product glossary
* List of key stakeholders
* Questions and assumptions recorded

---

# Week 2 — Product and Domain Understanding

## Objectives

* Understand the customer journey.
* Identify business-critical workflows.
* Learn the domain language.
* Understand major product risks.

---

## Activities

Walk through the product as different users.

For a fintech product, this may include:

* Registration
* Login
* Identity verification
* Wallet creation
* Wallet funding
* Money transfer
* Bill payment
* Refund
* Transaction history
* Notifications
* Account suspension

Document:

* Main user journeys
* Critical business rules
* Role permissions
* External integrations
* Failure and recovery paths
* High-risk financial operations

---

## Questions to Ask

* Which workflows directly affect customer funds?
* Which defects have occurred most frequently?
* Which issues generate the most customer complaints?
* Which modules change most often?
* Which areas have the weakest test coverage?
* Which third-party systems are most unstable?
* What does the business consider release-blocking?
* Which features are currently the highest priority?

---

## Week 2 Deliverables

* Critical workflow map
* Initial risk list
* Product and domain notes
* User-role matrix
* High-level integration map

---

# Week 3 — Testing Process Assessment

## Objectives

Understand the current QA process and identify immediate gaps.

---

## Areas to Review

### Requirements

* Are requirements clear and testable?
* Are acceptance criteria complete?
* Is QA involved early?
* Are edge cases discussed before development?

### Test Design

* Are test scenarios documented?
* Are positive and negative tests included?
* Is risk-based prioritisation used?
* Are tests traceable to requirements?

### Defect Management

* Are defects reproducible?
* Is severity applied consistently?
* Is business impact documented?
* Are escaped defects reviewed?

### Regression

* Is there a maintained regression suite?
* Are critical tests clearly marked?
* How long does execution take?
* Are there flaky or outdated tests?

### Automation

* What is currently automated?
* Where do tests run?
* How reliable are they?
* Who owns maintenance?

### Release Readiness

* What evidence supports release approval?
* Are quality gates defined?
* How are known risks communicated?

---

## Week 3 Deliverables

* QA process observations
* Coverage-gap list
* Regression health notes
* Automation maturity notes
* Initial improvement opportunities

---

# Week 4 — First Practical Contribution

## Objectives

Begin contributing directly while continuing to learn.

---

## Activities

* Execute smoke tests.
* Test a small feature or bug fix.
* Review acceptance criteria.
* Validate APIs.
* Query the database where appropriate.
* Raise clear defects.
* Attend defect triage.
* Support a release or deployment.
* Improve one small piece of documentation.

---

## First Contribution Examples

* Add missing negative test cases.
* Improve a defect template.
* Create a smoke checklist.
* Add SQL validation for one API.
* Identify outdated regression cases.
* Improve test evidence.
* Document a critical workflow.

---

## First 30-Day Deliverables

By Day 30, I should have:

* Product and domain understanding
* Access to required systems
* Initial risk assessment
* Critical workflow map
* QA process observations
* First executed test cycle
* First defects or quality findings
* One small process or documentation improvement
* Agreed priorities for the next 30 days

---

# 30-Day Interview Summary

> During my first 30 days, I would focus on understanding the product, architecture, business risks, team processes, and existing test coverage. I would begin contributing through smoke testing, API validation, defect reporting, and small documentation improvements while avoiding major changes before I fully understand the current environment.

---

# Days 31–60 — Contribute and Strengthen

## Primary Goal

Take ownership of testing activities and improve the reliability of critical coverage.

---

# Week 5 — Own a Feature or Workstream

## Objectives

Take responsibility for testing a defined feature, module, or sprint workstream.

---

## Activities

* Review requirements.
* Identify risks.
* Create test scenarios.
* Prepare test data.
* Execute functional tests.
* Validate APIs.
* Perform database checks.
* Report defects.
* Retest fixes.
* Update regression coverage.
* Provide test summary.

---

## Expected Outcome

Demonstrate the ability to manage a feature from requirement review through test completion.

---

# Week 6 — Improve Regression Coverage

## Objectives

Strengthen confidence in repeatable testing.

---

## Activities

Review the regression suite for:

* Missing critical workflows
* Duplicate cases
* Obsolete tests
* Unclear expected results
* Weak negative coverage
* Poor traceability
* Long execution time
* High-maintenance cases

Categorise tests into:

* Smoke
* Critical regression
* Full regression
* Release-specific validation

---

## Deliverables

* Updated regression suite
* Critical-test list
* Removed or flagged obsolete cases
* Improved negative and edge-case coverage
* Execution-priority model

---

# Week 7 — Improve API and Database Validation

## Objectives

Increase backend test depth.

---

## Activities

For selected APIs, validate:

* Status codes
* Response schemas
* Authentication
* Authorisation
* Business rules
* Error handling
* Data persistence
* Side effects
* Idempotency
* Audit records

Create or improve SQL checks for:

* User records
* Transaction records
* Wallet balances
* Ledger entries
* Refunds
* Reversals
* Duplicate references
* Reconciliation

---

## Deliverables

* API validation checklist
* SQL query pack
* Backend defect findings
* Improved API regression coverage

---

# Week 8 — Improve Defect and Release Communication

## Objectives

Make quality findings easier for the team to understand and act on.

---

## Activities

Improve defect reports by including:

* Clear titles
* Reproduction steps
* Expected and actual results
* Environment
* Evidence
* Severity
* Business impact
* Transaction or correlation references

Improve release reporting by including:

* Scope tested
* Pass and fail status
* Critical defects
* Deferred coverage
* Known risks
* Release recommendation

---

## Day 60 Deliverables

By Day 60, I should have:

* Owned at least one feature or workstream
* Improved regression coverage
* Expanded API and database validation
* Contributed to defect triage
* Supported at least one release cycle
* Improved test reporting
* Identified practical automation candidates
* Built stronger working relationships across the team

---

# 60-Day Interview Summary

> Between Days 31 and 60, I would move from learning to ownership. I would take responsibility for testing a feature or workstream, improve regression coverage, strengthen API and database validation, and contribute clearer defect and release evidence. By this stage, I should be operating independently in the team’s normal delivery process.

---

# Days 61–90 — Improve and Scale

## Primary Goal

Use the knowledge gained during the first 60 days to introduce targeted, sustainable quality improvements.

---

# Week 9 — Define Automation Priorities

## Objectives

Identify where automation can provide the highest value.

---

## Candidate Selection Criteria

Evaluate tests based on:

* Business risk
* Execution frequency
* Stability
* Repeatability
* Manual effort
* Defect history
* Technical feasibility
* Maintenance cost

---

## Priority Automation Areas

For a fintech product:

1. Authentication
2. Wallet balance
3. Wallet funding
4. Money transfers
5. Refunds and reversals
6. Idempotency
7. Security regression
8. Reconciliation
9. Critical UI journeys

---

## Deliverables

* Automation candidate matrix
* Priority list
* Estimated implementation effort
* Dependencies and risks
* Recommended first automation milestone

---

# Week 10 — Deliver or Improve a Small Automation Suite

## Objectives

Produce a small, reliable automation improvement rather than attempting a large framework rewrite.

---

## Possible Contributions

* Add critical API smoke tests.
* Stabilise flaky tests.
* Add missing assertions.
* Improve test fixtures.
* Add database helpers.
* Add CI reporting.
* Improve test-data generation.
* Move slow UI setup to APIs.
* Add one high-risk end-to-end flow.

---

## Principles

The suite should be:

* Stable
* Fast
* Readable
* Independent
* Maintainable
* CI/CD friendly
* Connected to a real regression need

---

# Week 11 — Strengthen CI/CD Quality Gates

## Objectives

Improve how test evidence is used during delivery.

---

## Activities

Review:

* Which tests run on pull requests
* Which tests run after merge
* Which tests run nightly
* Which tests run before release
* Pipeline duration
* Failure reporting
* Flaky-test visibility
* Test artefact retention

---

## Recommended Quality-Gate Model

### Pull Request

* Build
* Lint
* Unit tests
* Smoke tests
* Critical API tests

### Main Branch

* API regression
* Database validation
* Security checks

### Nightly

* Full regression
* Extended integration testing
* Broader browser coverage

### Release Candidate

* Full regression
* UI smoke
* Performance smoke
* Release-readiness report

---

## Deliverables

* CI/CD test-execution proposal
* Quality-gate recommendations
* Pipeline failure-handling guide
* Reporting improvement suggestions

---

# Week 12 — Present Findings and Roadmap

## Objectives

Share evidence-based recommendations with the team.

---

## Topics to Present

* Product risks learned
* Coverage improvements completed
* Defects and patterns observed
* Regression health
* Automation opportunities
* Environment challenges
* Process improvements
* Next-quarter quality roadmap

---

## Recommendation Categories

### Immediate

Low effort, high value.

Examples:

* Fix outdated smoke tests.
* Add missing API negative tests.
* Improve defect evidence.
* Add required CI checks.

### Medium-Term

Examples:

* Expand API automation.
* Improve test-data management.
* Add contract testing.
* Stabilise environments.
* Improve release dashboards.

### Long-Term

Examples:

* Broader automation framework
* Performance regression
* Production synthetic monitoring
* Service virtualisation
* Quality metrics and trend analysis

---

# Day 90 Deliverables

By Day 90, I should have:

* Strong product and architecture understanding
* Ownership of testing workstreams
* Improved regression coverage
* Better API and database validation
* Clear defect and release reporting
* Practical automation priorities
* At least one measurable automation or process improvement
* CI/CD quality-gate recommendations
* A prioritised quality roadmap
* Established trust across engineering and product teams

---

# 90-Day Interview Summary

> Between Days 61 and 90, I would focus on sustainable improvement. I would use the knowledge gained from real delivery work to prioritise automation, strengthen CI/CD quality gates, improve test reliability, and present a practical roadmap for the next quarter. The goal would be measurable improvement without disrupting the team with unnecessary process changes.

---

# 30-60-90 Day Summary Table

| Period     | Focus                     | Main Outcome                                        |
| ---------- | ------------------------- | --------------------------------------------------- |
| Days 1–30  | Learn and understand      | Product, process, risk, and team knowledge          |
| Days 31–60 | Contribute and strengthen | Independent testing ownership and stronger coverage |
| Days 61–90 | Improve and scale         | Automation, CI/CD, and quality roadmap              |

---

# Role-Specific Adaptation

## Manual QA Engineer

### First 30 Days

Focus on:

* Product knowledge
* Requirements
* Test cases
* Defect process
* Regression execution

### Days 31–60

Focus on:

* Feature ownership
* Exploratory testing
* Regression improvements
* UAT
* Release reporting

### Days 61–90

Focus on:

* Process improvements
* Risk-based testing
* Traceability
* Automation candidate identification

---

## API Test Engineer

### First 30 Days

Focus on:

* API architecture
* Swagger or OpenAPI
* Authentication
* Test environments
* Database access

### Days 31–60

Focus on:

* Endpoint coverage
* Negative tests
* SQL validation
* Security
* Idempotency

### Days 61–90

Focus on:

* API automation
* Contract tests
* CI integration
* Service-level quality gates

---

## Automation QA Engineer

### First 30 Days

Focus on:

* Existing framework
* Test reliability
* Pipeline structure
* Coding standards
* Test data

### Days 31–60

Focus on:

* Stabilising tests
* Adding high-value coverage
* Improving reporting
* Reducing execution time

### Days 61–90

Focus on:

* Expanding critical automation
* CI/CD quality gates
* Framework improvements
* Reliability metrics

---

## SDET

### First 30 Days

Focus on:

* Architecture
* Service dependencies
* Testability
* Framework design
* Deployment process

### Days 31–60

Focus on:

* Service-level testing
* Contract testing
* Database validation
* Observability
* Test infrastructure

### Days 61–90

Focus on:

* Scalable automation architecture
* Performance
* Resilience testing
* CI/CD optimisation
* Engineering quality standards

---

## Fintech QA Engineer

### First 30 Days

Focus on:

* Transaction lifecycle
* Wallets
* Payment providers
* Ledger
* Reconciliation
* Fraud controls

### Days 31–60

Focus on:

* High-risk financial workflows
* Refunds and reversals
* SQL validation
* Security
* Incident patterns

### Days 61–90

Focus on:

* Financial regression automation
* Idempotency
* Concurrency
* Reconciliation automation
* Release quality gates

---

# Metrics to Review

Metrics should be used to understand trends, not to judge individuals.

Possible measures include:

* Critical workflow coverage
* Regression execution time
* Test pass rate
* Escaped defects
* Defect reopen rate
* Automation reliability
* Flaky-test rate
* Mean time to feedback
* Number of unresolved critical defects
* Release success rate
* Production incident patterns

---

# Example 90-Day Success Measures

Subject to the organisation’s current baseline, possible outcomes include:

* Critical workflow map completed
* Smoke suite reviewed and updated
* At least one feature owned end to end
* API and SQL coverage improved
* Obsolete regression tests removed
* Defect-reporting quality improved
* Automation candidates prioritised
* One reliable automated flow added or stabilised
* CI/CD quality recommendations accepted
* Next-quarter roadmap agreed

Avoid promising arbitrary percentages before understanding the current baseline.

---

# Risks and Mitigations

## Risk 1 — Incomplete Access

### Mitigation

Identify missing access during the first week and escalate through the correct channels.

---

## Risk 2 — Poor Documentation

### Mitigation

Learn through product walkthroughs, API exploration, code discussions, defect history, and stakeholder interviews.

---

## Risk 3 — Unstable Test Environment

### Mitigation

Document environment issues separately from product defects and work with engineering to improve stability.

---

## Risk 4 — Large Regression Suite

### Mitigation

Prioritise critical tests, remove obsolete cases, and identify high-value automation opportunities.

---

## Risk 5 — Pressure to Change Too Much

### Mitigation

Recommend incremental improvements supported by evidence rather than replacing existing processes immediately.

---

## Risk 6 — Flaky Automation

### Mitigation

Measure failure patterns, stabilise critical tests first, and avoid expanding unreliable coverage.

---

# Questions to Ask the Hiring Manager

To tailor this plan, I would ask:

* What are the biggest quality challenges today?
* Which product areas are most critical?
* What is the current release frequency?
* How mature is the automation suite?
* What does success look like after 90 days?
* Which production incidents occur most often?
* How is QA involved in requirements?
* What are the main test-environment constraints?
* Which quality metrics does the team use?
* Are there upcoming releases or migrations that need priority support?

---

# Interview Talking Points

When presenting this plan:

* Make it clear that you will first understand the environment.
* Avoid criticising existing processes before joining.
* Focus on partnership rather than control.
* Connect improvements to business priorities.
* Show that automation is not the first answer to every problem.
* Explain that goals will be adjusted after understanding the baseline.
* Emphasise delivery as well as process improvement.

---

# Common Mistakes to Avoid

Avoid saying:

* I will automate everything in 90 days.
* I will replace the existing framework immediately.
* I will eliminate all production defects.
* I will achieve 100% test coverage.
* I will completely redesign the QA process.
* I will introduce many new tools before understanding current needs.

These promises are unrealistic and may suggest poor judgement.

---

# Strong Interview Answer

> My first 30 days would focus on learning the product, architecture, team process, and highest business risks while beginning to contribute through smoke, API, and feature testing. During Days 31 to 60, I would take ownership of a workstream, improve regression and backend validation, and support releases independently. During Days 61 to 90, I would use the evidence gathered to deliver targeted improvements in automation, CI/CD, reporting, or test reliability. I would keep the plan flexible because the final priorities should reflect the organisation’s actual quality gaps rather than assumptions made before joining.

---

# Portfolio Connection

This plan reflects the same quality-engineering principles demonstrated throughout the Fintech Digital Banking QA Lab:

* Risk-based testing
* Requirements analysis
* API testing
* SQL validation
* Security testing
* Defect investigation
* Regression management
* Automation readiness
* CI/CD quality gates
* Release-readiness reporting
* Continuous improvement

---

# QA Lead Conclusion

A strong first 90 days should balance learning, delivery, relationship-building, and improvement.

The objective is not to introduce the largest number of changes.

The objective is to understand the product, contribute to current priorities, build trust, and make practical improvements that strengthen quality without slowing the team down.
