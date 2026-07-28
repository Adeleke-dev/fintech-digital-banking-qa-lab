# System Design for QA

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

System design interviews are not only for software architects and backend engineers.

QA Engineers, Automation QA Engineers, and SDETs are increasingly expected to understand:

* How systems are structured
* How services communicate
* Where failures can occur
* How data moves through the platform
* How to test distributed systems
* How to identify quality risks early
* How architecture affects automation and release strategy

The goal of this guide is not to turn a QA Engineer into a system architect.

The goal is to help QA professionals understand system design well enough to:

* Ask better questions
* Design stronger tests
* Investigate failures
* Assess risk
* Validate integrations
* Support release decisions
* Communicate confidently during interviews

---

# What Is System Design?

System design is the process of defining how the different parts of a software system work together.

It includes:

* Applications
* APIs
* Services
* Databases
* Message queues
* Caches
* Authentication
* External providers
* Monitoring
* Infrastructure

A system design explains how a request enters the system, how it is processed, where data is stored, and how the response returns to the user.

---

# Why QA Engineers Need System Design Knowledge

Without architecture knowledge, testing may remain limited to visible UI behaviour.

With system design knowledge, QA can test:

* Individual services
* Service-to-service communication
* Database consistency
* Authentication boundaries
* Queue processing
* Failure recovery
* Cache behaviour
* Concurrency
* Provider integration
* Observability

This allows QA to identify risks that may not be visible through the UI.

---

# Example Digital Banking Architecture

```text
Customer Web or Mobile App
             │
             ▼
         API Gateway
             │
             ▼
      Authentication Service
             │
             ▼
       Banking Backend
             │
    ┌────────┼───────────┐
    ▼        ▼           ▼
 Wallet   Transfer    Payment
Service   Service     Service
    │        │           │
    └────────┼───────────┘
             ▼
        PostgreSQL
             │
             ▼
       Message Queue
             │
    ┌────────┼──────────┐
    ▼        ▼          ▼
Notification Fraud   Reconciliation
 Service      Engine      Service
             │
             ▼
     External Providers
```

---

# QA Questions for Any Architecture

When presented with a system design, ask:

* What are the critical user journeys?
* Which components process money?
* Where is the source of truth?
* Which operations are synchronous?
* Which operations are asynchronous?
* How are failures handled?
* How are retries controlled?
* How is duplicate processing prevented?
* How is authentication enforced?
* How is authorisation enforced?
* How are transactions reconciled?
* What logs and metrics are available?
* What happens if one service is unavailable?
* How is data restored after failure?

---

# Section 1 — Client-Server Architecture

## What Is Client-Server Architecture?

The client sends a request, and the server processes it and returns a response.

Example:

```text
Mobile App
    │
    │ GET /wallet
    ▼
Backend API
    │
    │ Query wallet database
    ▼
Database
    │
    ▼
Backend returns wallet balance
```

---

## QA Testing Considerations

Validate:

* Request structure
* Response structure
* Error handling
* Authentication
* Authorisation
* Network failure
* Timeout
* Data consistency
* Client behaviour when the server fails

---

## Interview Question

### How would you test a client-server application?

**Sample Answer**

I would test the frontend behaviour, API contracts, server-side business rules, database persistence, authentication, authorisation, and error handling.

I would also test how the client behaves when the server is slow, unavailable, or returns unexpected responses.

---

# Section 2 — Monolithic Architecture

## What Is a Monolith?

A monolithic application contains most business functions inside one deployable application.

Example:

```text
Single Banking Application
├── Authentication
├── Wallet
├── Transfers
├── Payments
├── Notifications
└── Reporting
```

---

## Advantages

* Simpler deployment
* Easier local development
* Fewer network calls
* Easier transaction management

---

## Risks

* One failure may affect the whole application.
* Deployments may become slower.
* Components may become tightly coupled.
* Scaling individual features is difficult.
* Regression scope may become large.

---

## QA Testing Considerations

Focus on:

* Broad regression testing
* Shared dependency impact
* Module interaction
* Database transaction integrity
* Release-wide smoke tests
* Change impact analysis

---

# Section 3 — Microservices Architecture

## What Are Microservices?

Microservices divide a system into smaller independently deployable services.

Example:

```text
Authentication Service
Wallet Service
Transfer Service
Payment Service
Notification Service
Fraud Service
```

Each service may have its own:

* API
* Database
* Deployment
* Logs
* Scaling rules
* Release cycle

---

## Benefits

* Independent deployment
* Independent scaling
* Clearer service ownership
* Smaller codebases
* Better fault isolation

---

## Risks

* Network failures
* Data inconsistency
* Complex debugging
* Version mismatch
* Queue failures
* Duplicate event processing
* Distributed transaction problems

---

## QA Testing Considerations

Test:

* Individual service APIs
* Service contracts
* End-to-end workflows
* Timeout behaviour
* Retry behaviour
* Circuit breakers
* Queue processing
* Data consistency across services
* Backward compatibility
* Partial failure

---

## Interview Question

### How does microservices architecture affect testing?

**Sample Answer**

Microservices increase the need for API testing, contract testing, service-level testing, integration testing, observability, and failure-path testing.

I would not rely only on end-to-end tests because they are slower and harder to diagnose. I would create layered coverage across unit, service, contract, integration, and end-to-end levels.

---

# Section 4 — API Gateway

## What Is an API Gateway?

An API gateway is the entry point for client requests.

It may handle:

* Routing
* Authentication
* Rate limiting
* Request transformation
* Logging
* Security policies
* Load balancing

---

## QA Testing Considerations

Test:

* Correct request routing
* Authentication enforcement
* Rate limiting
* Invalid paths
* Unsupported methods
* Header forwarding
* Error transformation
* Gateway timeout
* Service unavailability
* Sensitive-header protection

---

## Example Scenario

A customer sends:

```text
POST /api/v1/transfers
```

The API gateway:

1. Validates the token.
2. Applies rate limits.
3. Routes the request to the Transfer Service.
4. Returns the service response.

QA should confirm that the gateway does not allow direct unauthorised access to protected services.

---

# Section 5 — Databases

## What Is the Source of Truth?

The source of truth is the authoritative location for a specific type of data.

Examples:

* Wallet Service database owns wallet balances.
* Transfer Service database owns transfer records.
* Ledger database owns permanent financial entries.

A QA Engineer should understand which system owns each record.

---

## SQL vs NoSQL

| SQL Database               | NoSQL Database                              |
| -------------------------- | ------------------------------------------- |
| Relational tables          | Document, key-value, graph, or column-based |
| Strong schema              | Flexible schema                             |
| Joins supported            | Joins may be limited                        |
| Strong transaction support | Often optimised for scale or flexibility    |
| Example: PostgreSQL        | Example: MongoDB                            |

The right database depends on the business need.

---

## QA Testing Considerations

Validate:

* Data persistence
* Constraints
* Relationships
* Transactions
* Indexes
* Duplicate prevention
* Data types
* Decimal precision
* Auditability
* Data migration
* Backup and restore

---

# Section 6 — Database Transactions

## What Is a Database Transaction?

A database transaction groups multiple operations into one logical unit.

Either all operations succeed or all are rolled back.

Example transfer:

```text
Debit sender
Credit receiver
Create transaction
Create ledger entries
```

If the receiver credit fails, the sender debit should not remain committed without an approved compensation process.

---

## ACID Properties

| Property    | Meaning                                           |
| ----------- | ------------------------------------------------- |
| Atomicity   | All operations succeed or all fail                |
| Consistency | Data remains valid                                |
| Isolation   | Concurrent transactions do not corrupt each other |
| Durability  | Committed data remains saved                      |

---

## QA Testing Considerations

Test:

* Partial failure
* Rollback
* Concurrent transactions
* Duplicate requests
* Deadlocks
* Isolation behaviour
* Crash recovery

---

# Section 7 — Distributed Transactions

## What Is a Distributed Transaction?

A distributed transaction involves more than one service or database.

Example:

```text
Transfer Service
      │
      ├── Debit Wallet Service
      ├── Credit Recipient Service
      ├── Record Ledger Entry
      └── Send Notification
```

A single database transaction cannot always manage all these components.

---

## Common Patterns

* Saga pattern
* Compensation
* Event-driven processing
* Outbox pattern
* Idempotent consumers

---

## QA Testing Considerations

Test:

* Service fails after another service succeeds
* Compensation succeeds
* Compensation fails
* Events arrive out of order
* Duplicate events
* Lost events
* Delayed processing
* Retry exhaustion
* Dead-letter queues

---

## Interview Question

### How would you test a distributed transaction?

**Sample Answer**

I would test each service independently and then validate the complete workflow.

I would intentionally fail each step to confirm that compensation, retry, idempotency, and reconciliation mechanisms restore a valid financial state.

---

# Section 8 — Message Queues

## What Is a Message Queue?

A message queue allows services to communicate asynchronously.

Example:

```text
Transfer Completed
       │
       ▼
   Message Queue
       │
   ┌───┴─────────┐
   ▼             ▼
Notification   Reconciliation
Service        Service
```

The transfer API does not need to wait for every downstream process to complete before returning.

---

## Benefits

* Decoupling
* Better scalability
* Resilience
* Asynchronous processing
* Load smoothing

---

## Risks

* Duplicate messages
* Lost messages
* Delayed messages
* Out-of-order delivery
* Consumer failure
* Poison messages
* Dead-letter queue growth

---

## QA Testing Considerations

Test:

* Message produced correctly
* Message consumed correctly
* Duplicate delivery
* Retry
* Dead-letter queue
* Consumer downtime
* Out-of-order events
* Idempotent processing
* Message schema compatibility

---

# Section 9 — Caching

## What Is a Cache?

A cache stores frequently accessed data temporarily to improve response time.

Examples:

* Customer profile
* Exchange rate
* Wallet summary
* Session information

---

## Benefits

* Faster responses
* Reduced database load
* Better scalability

---

## Risks

* Stale data
* Cache inconsistency
* Incorrect invalidation
* Sensitive data exposure
* Cache poisoning
* Different users receiving the same cached data

---

## QA Testing Considerations

Test:

* Cache hit
* Cache miss
* Cache expiry
* Cache invalidation
* Updated data visibility
* User-specific isolation
* Fallback when cache is unavailable

---

## Fintech Warning

Wallet balances should be treated carefully when cached.

The system must not authorise spending based on a stale cached balance.

---

# Section 10 — Authentication

## What Is Authentication?

Authentication confirms who the user is.

Common methods include:

* Username and password
* JWT
* OAuth 2.0
* Session cookies
* Multi-factor authentication
* Biometrics

---

## QA Testing Considerations

Test:

* Valid login
* Invalid login
* Expired token
* Tampered token
* Missing token
* Revoked session
* Account suspension
* Password reset
* Multi-factor authentication
* Brute-force protection

---

# Section 11 — Authorisation

## What Is Authorisation?

Authorisation determines what an authenticated user is allowed to do.

Examples:

* Customer can access their own wallet.
* Support agent can view limited customer details.
* Administrator can manage accounts.
* Customer cannot access another customer's transaction.

---

## QA Testing Considerations

Test:

* Role-based access control
* Object-level authorisation
* Horizontal privilege escalation
* Vertical privilege escalation
* Ownership validation
* Restricted fields
* Suspended-account restrictions

---

# Section 12 — Load Balancers

## What Is a Load Balancer?

A load balancer distributes incoming traffic across multiple application instances.

```text
Customer Requests
       │
       ▼
   Load Balancer
   ┌────┼────┐
   ▼    ▼    ▼
 App1  App2  App3
```

---

## QA Testing Considerations

Test:

* Traffic distribution
* Instance failure
* Session handling
* Health checks
* Recovery
* Sticky sessions where applicable
* Consistency across instances

---

# Section 13 — External Providers

Fintech systems often integrate with:

* Card processors
* Banks
* Identity providers
* Fraud services
* Notification providers
* Credit bureaus

---

## QA Testing Considerations

Test:

* Successful response
* Failed response
* Timeout
* Invalid response
* Duplicate callback
* Delayed callback
* Provider downtime
* Rate limits
* Retry
* Signature validation
* Reconciliation

---

## Mocking

External providers should often be mocked in test environments so QA can simulate:

* Success
* Decline
* Timeout
* Malformed response
* Duplicate callback
* Delayed callback

Mocks should not replace all integration testing. Real sandbox validation is still required.

---

# Section 14 — Webhooks

## What Is a Webhook?

A webhook is a callback sent by an external system when an event occurs.

Example:

```text
Payment Provider
       │
       │ Payment Successful
       ▼
POST /webhooks/payment
```

---

## QA Testing Considerations

Test:

* Valid webhook
* Invalid signature
* Duplicate webhook
* Delayed webhook
* Out-of-order webhook
* Unknown reference
* Already processed event
* Webhook retry
* Response timeout

---

## Security Considerations

Validate:

* Signature
* Timestamp
* Replay protection
* Source verification
* Payload schema
* Sensitive logging

---

# Section 15 — Observability

## What Is Observability?

Observability allows teams to understand system behaviour through:

* Logs
* Metrics
* Traces
* Alerts

---

## Logs

Logs capture events and errors.

QA should verify:

* Relevant events are logged.
* Sensitive data is masked.
* Transaction references are included.
* Errors contain useful context.
* Logs can be correlated across services.

---

## Metrics

Useful metrics include:

* Request count
* Error rate
* Response time
* Queue depth
* Retry count
* Database connections
* Failed transactions
* Reconciliation mismatches

---

## Traces

Distributed tracing follows one request across multiple services.

Example:

```text
API Gateway
    │
    ▼
Transfer Service
    │
    ▼
Wallet Service
    │
    ▼
Provider
```

A trace ID helps identify where latency or failure occurred.

---

# Section 16 — Resilience Patterns

## Retry

Retries repeat failed operations.

QA should test:

* Maximum attempts
* Delay
* Backoff
* Retryable errors
* Non-retryable errors
* Duplicate processing

---

## Circuit Breaker

A circuit breaker stops repeated calls to an unhealthy dependency.

States may include:

* Closed
* Open
* Half-open

QA should test:

* Failure threshold
* Open state
* Recovery
* Fallback behaviour
* Monitoring

---

## Timeout

Timeouts prevent a service from waiting indefinitely.

QA should test:

* Client timeout
* Gateway timeout
* Provider timeout
* Database timeout
* Behaviour after timeout
* Safe retry

---

## Bulkhead

Bulkheads isolate resources so one failing component does not consume all system capacity.

QA should test whether heavy traffic in one service affects unrelated services.

---

# Section 17 — Idempotency

## What Is Idempotency?

Idempotency ensures that retrying the same request does not create duplicate side effects.

Example:

```text
POST /payments

Idempotency-Key: payment-123
```

Repeated requests with the same key should not create multiple payments.

---

## QA Testing Considerations

Test:

* Same key and same payload
* Same key and different payload
* Concurrent duplicate requests
* Retry after timeout
* Key expiry
* Duplicate callback
* Database uniqueness

---

# Section 18 — Concurrency

## What Is Concurrency?

Concurrency occurs when multiple operations happen at nearly the same time.

Example:

A wallet contains £100.

Two £80 transfers are submitted simultaneously.

Without proper control, both may pass the balance check.

---

## QA Testing Considerations

Test:

* Concurrent transfers
* Concurrent refunds
* Concurrent withdrawals
* Duplicate requests
* Race conditions
* Row locking
* Optimistic locking
* Pessimistic locking

---

# Section 19 — Eventual Consistency

## What Is Eventual Consistency?

Eventual consistency means different parts of the system may not update at exactly the same time, but should become consistent after processing completes.

Example:

A transfer completes immediately, but transaction history updates several seconds later.

---

## QA Testing Considerations

Verify:

* Expected delay is documented.
* Pending state is displayed.
* Final state is reached.
* Retry works.
* No data is permanently inconsistent.
* Monitoring detects stuck transactions.

---

# Section 20 — Data Integrity

For a financial system, data integrity is critical.

QA should validate:

* Debit equals credit where applicable.
* Ledger remains balanced.
* References are unique.
* Decimal precision is correct.
* Currency is preserved.
* Refunds do not exceed payments.
* Reversals are linked to original transactions.
* Audit trails are complete.

---

# Section 21 — Performance and Scalability

## Key Performance Questions

Ask:

* How many users are expected?
* How many transactions per second?
* What are the response-time targets?
* What is the expected peak?
* How does the system scale?
* Which components may become bottlenecks?

---

## QA Testing Types

* Load testing
* Stress testing
* Spike testing
* Endurance testing
* Scalability testing
* Volume testing

---

## Fintech Performance Risks

* Duplicate requests after timeout
* Queue backlog
* Slow reconciliation
* Database lock contention
* Provider rate limits
* Connection exhaustion
* Stale balance reads

---

# Section 22 — High Availability

## What Is High Availability?

High availability means the system remains accessible even when individual components fail.

Methods include:

* Multiple service instances
* Load balancing
* Database replication
* Automated failover
* Health checks
* Multi-zone deployment

---

## QA Testing Considerations

Test:

* Instance failure
* Database failover
* Queue failure
* Provider outage
* Service restart
* Recovery after failure
* No transaction duplication after failover

---

# Section 23 — Disaster Recovery

## What Is Disaster Recovery?

Disaster recovery defines how a system restores service and data after a serious failure.

Key terms:

* Recovery Time Objective (RTO)
* Recovery Point Objective (RPO)

---

## QA Testing Considerations

Validate:

* Backups
* Restore process
* Data completeness
* Configuration recovery
* Credentials
* Audit logs
* Reconciliation after recovery
* Recovery documentation

---

# Section 24 — Contract Testing

## What Is Contract Testing?

Contract testing verifies that services agree on request and response structures.

Example:

The Transfer Service expects the Wallet Service to return:

```json
{
  "walletId": "WALLET-123",
  "balance": 1000,
  "currency": "GBP"
}
```

If the Wallet Service changes the contract unexpectedly, the consumer may fail.

---

## QA Testing Considerations

Validate:

* Required fields
* Data types
* Optional fields
* Backward compatibility
* Error contracts
* Versioning
* Consumer expectations

Tools may include:

* Pact
* OpenAPI validation
* Schema testing

---

# Section 25 — Test Pyramid

A balanced test strategy may include:

```text
              UI Tests
           End-to-End Tests
        Integration and Contract Tests
          API and Service Tests
               Unit Tests
```

The lower layers should contain more tests because they are:

* Faster
* More stable
* Easier to diagnose
* Cheaper to maintain

QA should not rely entirely on end-to-end automation.

---

# Section 26 — System Design Interview Framework

When asked to test a system design, use this structure.

## Step 1 — Clarify the System

Ask:

* Who are the users?
* What are the critical workflows?
* What scale is expected?
* What data is sensitive?
* Which external systems are involved?

---

## Step 2 — Identify Components

List:

* Client
* Gateway
* Services
* Database
* Cache
* Queue
* External providers
* Monitoring

---

## Step 3 — Identify Risks

Consider:

* Financial risk
* Security risk
* Availability risk
* Data consistency
* Performance
* Concurrency
* Third-party dependency
* Recovery

---

## Step 4 — Define Test Layers

Include:

* Unit
* API
* Contract
* Integration
* Database
* End-to-end
* Security
* Performance
* Resilience

---

## Step 5 — Define Failure Scenarios

Ask what happens when:

* A service is unavailable.
* The database fails.
* The provider times out.
* A message is duplicated.
* A retry occurs.
* A transaction partially completes.
* The cache is stale.
* Multiple requests occur concurrently.

---

## Step 6 — Define Observability

Verify:

* Logs
* Metrics
* Traces
* Alerts
* Correlation IDs
* Dashboards

---

# Practical Interview Scenario 1

## Design a Test Strategy for a Money Transfer System

### Key Areas

#### Functional

* Successful transfer
* Insufficient balance
* Invalid recipient
* Transfer limit
* Currency validation

#### Security

* Authentication
* Authorisation
* Ownership
* Rate limiting
* Replay protection

#### Data

* Sender debit
* Receiver credit
* Ledger entries
* Unique reference
* Audit trail

#### Resilience

* Provider timeout
* Queue failure
* Service restart
* Duplicate event
* Reversal

#### Performance

* Concurrent transfers
* Peak load
* Response time
* Database locking

#### Observability

* Transaction trace
* Logs
* Metrics
* Alerts
* Reconciliation status

---

# Practical Interview Scenario 2

## Design Tests for a Notification Service

Test:

* Email sent after successful transfer
* No notification for failed transaction where not required
* Duplicate event
* Retry
* Provider timeout
* Invalid address
* Template correctness
* Sensitive-data masking
* Queue backlog
* Delivery status
* User notification preferences

---

# Practical Interview Scenario 3

## Design Tests for a Wallet Service

Test:

* Wallet creation
* Balance retrieval
* Credit
* Debit
* Insufficient balance
* Concurrent debit
* Currency
* Decimal precision
* Suspended wallet
* Ledger consistency
* Idempotency
* Audit logging
* Database failure
* Cache behaviour

---

# Common Interview Questions

## Question 1

### How would you test a microservices system?

**Sample Answer**

I would use layered testing.

I would validate each service independently through unit and API tests, verify service contracts, test database persistence, and then validate critical end-to-end workflows.

I would also test timeouts, retries, duplicate events, partial failure, observability, and data consistency across services.

---

## Question 2

### How would you test asynchronous processing?

**Sample Answer**

I would verify that the event is produced, delivered, consumed, and processed correctly.

I would test duplicate events, delayed events, out-of-order events, consumer failure, retries, dead-letter queues, and idempotency.

I would also validate the final database state rather than relying only on the initial API response.

---

## Question 3

### How would you test system resilience?

**Sample Answer**

I would intentionally introduce failures such as service downtime, provider timeout, database errors, message-queue delays, and network interruption.

I would confirm that the system fails gracefully, retries safely, avoids duplicate processing, preserves data integrity, and recovers correctly.

---

## Question 4

### How would you test a cache?

**Sample Answer**

I would test cache hits, misses, expiry, invalidation, stale data, unavailable cache, and user isolation.

For financial data, I would verify that the system never authorises transactions using stale balances.

---

## Question 5

### How would you test a rate limiter?

**Sample Answer**

I would verify behaviour below, at, and above the configured limit.

I would also test reset timing, multiple users, multiple IP addresses, distributed instances, error responses, and whether trusted internal services are treated differently where appropriate.

---

# Common System Design Interview Mistakes

Avoid:

* Focusing only on UI testing.
* Ignoring data ownership.
* Forgetting failure scenarios.
* Ignoring asynchronous processing.
* Assuming retries are always safe.
* Ignoring observability.
* Forgetting security boundaries.
* Treating all services as one system.
* Ignoring concurrency.
* Relying only on end-to-end tests.
* Forgetting reconciliation.

---

# Interview Tips

During system design interviews:

* Ask clarifying questions.
* Draw or describe the architecture.
* Think in layers.
* Identify the source of truth.
* Focus on critical workflows.
* Discuss failure paths.
* Explain data validation.
* Mention observability.
* Connect risks to business impact.
* Avoid pretending to know implementation details that were not provided.

---

# Portfolio Talking Points

This guide demonstrates understanding of:

* Monoliths
* Microservices
* APIs
* Databases
* Transactions
* Message queues
* Caching
* Authentication
* Authorisation
* Load balancing
* External providers
* Webhooks
* Observability
* Resilience
* Idempotency
* Concurrency
* Eventual consistency
* Contract testing
* High availability
* Disaster recovery

---

# QA Lead Conclusion

System design knowledge allows QA Engineers to test beyond the visible application.

A strong QA professional understands where data moves, where failures may occur, which component owns the truth, and how distributed workflows recover from partial failure.

In interviews, the goal is not to design every system component from scratch.

The goal is to demonstrate that you can understand architecture, identify quality risks, design layered tests, investigate failures, and protect critical business outcomes.
