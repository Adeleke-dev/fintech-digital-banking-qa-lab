# API Testing Interview Questions

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This guide contains common API testing interview questions ranging from beginner to senior level.

The questions focus on practical API testing knowledge, REST principles, security, database validation, fintech scenarios, automation, and troubleshooting.

The model answers are designed to demonstrate understanding rather than memorisation.

---

# Section 1 – API Fundamentals

## Question 1

### What is an API?

**Sample Answer**

An API (Application Programming Interface) is a set of rules that allows different software systems to communicate with each other.

For example, when a mobile banking application requests a customer's wallet balance, it sends an API request to the backend, which processes the request and returns the appropriate response.

---

## Question 2

### What is REST?

**Sample Answer**

REST (Representational State Transfer) is an architectural style for designing web APIs.

REST APIs are typically:

* Stateless
* Client-server based
* Resource-oriented
* Cacheable where appropriate
* Accessible through standard HTTP methods

---

## Question 3

### What is a RESTful API?

A RESTful API follows REST principles by exposing resources through predictable URLs and using standard HTTP methods and status codes.

Example:

```text
GET    /users
POST   /users
GET    /users/{id}
PATCH  /users/{id}
DELETE /users/{id}
```

---

# Section 2 – HTTP Methods

## Question 4

### Explain the main HTTP methods.

| Method | Purpose                      |
| ------ | ---------------------------- |
| GET    | Retrieve data                |
| POST   | Create new data              |
| PUT    | Replace an existing resource |
| PATCH  | Partially update a resource  |
| DELETE | Remove a resource            |

---

## Question 5

### What is the difference between PUT and PATCH?

| PUT                                 | PATCH                             |
| ----------------------------------- | --------------------------------- |
| Replaces the entire resource        | Updates only specified fields     |
| Sends the full object               | Sends only changed values         |
| Often used for complete replacement | Commonly used for partial updates |

---

# Section 3 – HTTP Status Codes

## Question 6

### What are common HTTP status codes?

### Success

* 200 OK
* 201 Created
* 202 Accepted
* 204 No Content

### Client Errors

* 400 Bad Request
* 401 Unauthorized
* 403 Forbidden
* 404 Not Found
* 409 Conflict
* 422 Unprocessable Entity
* 429 Too Many Requests

### Server Errors

* 500 Internal Server Error
* 502 Bad Gateway
* 503 Service Unavailable
* 504 Gateway Timeout

---

## Question 7

### What is the difference between 401 and 403?

**401 Unauthorized**

The user has not authenticated successfully.

Example:

Missing or invalid access token.

**403 Forbidden**

The user is authenticated but does not have permission to perform the requested action.

Example:

A customer attempts to access an administrator endpoint.

---

# Section 4 – API Requests

## Question 8

### What makes up an HTTP request?

An HTTP request may contain:

* URL
* Method
* Headers
* Query parameters
* Path parameters
* Request body
* Authentication token

---

## Question 9

### What should you validate in an API response?

Always verify:

* Status code
* Response body
* Headers
* Response time (where relevant)
* Business rules
* Error messages
* Data types
* Required fields
* Database state (when applicable)

---

# Section 5 – Authentication & Security

## Question 10

### How do APIs authenticate users?

Common methods include:

* JWT Bearer Tokens
* OAuth 2.0
* API Keys
* Basic Authentication
* Session Cookies
* Mutual TLS (for some enterprise systems)

---

## Question 11

### What is a JWT?

A JSON Web Token (JWT) is a signed token that contains claims about an authenticated user.

A typical JWT includes:

* Header
* Payload (claims)
* Signature

The server validates the signature before trusting the token.

---

## Question 12

### What API security tests would you perform?

Examples include:

* Missing token
* Invalid token
* Expired token
* Token tampering
* RBAC validation
* Object-level authorisation
* Rate limiting
* Input validation
* Injection attempts
* Sensitive data exposure

---

# Section 6 – API Testing

## Question 13

### What do you verify during API testing?

I verify:

* Business rules
* Validation logic
* Authentication
* Authorisation
* Error handling
* Status codes
* Data persistence
* Database consistency
* Response schema
* Performance where appropriate

---

## Question 14

### What is positive testing?

Positive testing verifies that the API behaves correctly when valid input is provided.

Example:

Submitting a valid wallet funding request should return a successful response and update the wallet balance.

---

## Question 15

### What is negative testing?

Negative testing verifies that the API handles invalid input gracefully.

Examples:

* Missing required fields
* Invalid data types
* Negative amounts
* Invalid authentication
* Invalid resource identifiers

---

# Section 7 – Idempotency

## Question 16

### What is idempotency?

Idempotency means that repeating the same request produces the same end result without causing duplicate side effects.

Example:

Submitting the same payment request twice with the same idempotency key should create only one payment.

---

## Question 17

### Why is idempotency important in fintech?

Without idempotency:

* Customers may be charged twice.
* Wallets may be credited multiple times.
* Duplicate transfers may occur.
* Financial reconciliation becomes difficult.

---

# Section 8 – Database Validation

## Question 18

### Why should API testing include database validation?

A successful API response does not always mean the underlying data is correct.

Database validation confirms that:

* Records were created.
* Wallet balances are correct.
* Ledger entries exist.
* Transactions are consistent.
* No duplicate financial records exist.

---

## Question 19

### What would you validate after a successful wallet funding request?

I would verify:

* Wallet balance increased correctly.
* Transaction record exists.
* Ledger entry created.
* Provider reference stored.
* Audit record generated.
* No duplicate records created.

---

# Section 9 – Fintech Scenarios

## Question 20

### How would you test a money transfer API?

I would cover:

Positive scenarios:

* Successful transfer
* Internal transfer
* External transfer

Negative scenarios:

* Insufficient balance
* Invalid beneficiary
* Invalid amount
* Daily transfer limit exceeded
* Duplicate request
* Expired token

Database validation:

* Sender balance
* Receiver balance
* Ledger entries
* Transaction history
* Audit records

---

## Question 21

### What is reconciliation?

Reconciliation is the process of ensuring that all financial records match across systems.

For example:

* Wallet balance
* Ledger entries
* Transaction records
* Payment provider records

All should agree before a transaction is considered fully reconciled.

---

# Section 10 – Error Handling

## Question 22

### How do you test API error handling?

I verify:

* Correct status codes
* Clear error messages
* Validation errors
* Missing resources
* Duplicate requests
* Provider failures
* Timeout handling
* Retry behaviour

---

## Question 23

### What would you do if an API returns 200 OK but the database is incorrect?

I would raise a defect because the business outcome is incorrect.

API success alone is insufficient if:

* Wallet balances are wrong.
* Transactions are missing.
* Ledger entries are incorrect.
* Financial integrity is compromised.

---

# Section 11 – Automation

## Question 24

### Which tools can be used for API automation?

Common tools include:

* Playwright
* Postman (Collections/Newman)
* REST Assured
* Cypress
* Karate
* SuperTest
* k6 (performance-focused)

---

## Question 25

### Why is Playwright suitable for API automation?

Advantages include:

* TypeScript support
* Fast execution
* Parallel testing
* Built-in assertions
* Authentication handling
* Integration with UI testing
* CI/CD friendly

---

# Section 12 – Senior-Level Questions

## Question 26

### How do you prioritise API testing?

I prioritise according to business risk.

For a fintech platform, I would test in this order:

1. Authentication
2. Wallet funding
3. Money transfers
4. Bill payments
5. Financial reconciliation
6. Notifications

---

## Question 27

### What quality gates would you define before releasing an API?

Examples:

* Build successful
* Critical API tests passed
* Authentication tests passed
* SQL validation passed
* Security tests passed
* Performance smoke tests passed
* No unresolved Critical defects

---

## Question 28

### How would you investigate an intermittent API failure?

My approach would be:

1. Reproduce the issue.
2. Review logs.
3. Check request and response payloads.
4. Verify authentication.
5. Review database changes.
6. Check external dependencies.
7. Investigate timing or concurrency issues.
8. Identify business impact.
9. Raise a defect if necessary.

---

# Practical Scenario

## Question

A customer reports that they funded their wallet successfully, but the balance did not change.

How would you investigate?

### Suggested Answer

1. Confirm the request details.
2. Verify the API response.
3. Check payment provider confirmation.
4. Review wallet records.
5. Verify ledger entries.
6. Check transaction history.
7. Review application logs.
8. Determine whether reconciliation completed.
9. Identify the root cause.
10. Recommend regression coverage.

---

# Interview Tips

During API interviews:

* Explain the business impact.
* Mention database validation.
* Include security considerations.
* Discuss negative testing.
* Refer to idempotency for payment systems.
* Avoid focusing only on HTTP status codes.

---

# Common Mistakes

Avoid:

* Assuming 200 OK means success.
* Ignoring database validation.
* Forgetting security testing.
* Testing only positive scenarios.
* Ignoring duplicate requests.
* Overlooking retry behaviour and timeouts.

---

# Final Advice

Strong API testers validate more than requests and responses.

They verify:

* Business behaviour
* Security
* Financial integrity
* Database consistency
* Error handling
* Recovery scenarios
* Performance implications
* Release readiness

Always connect technical findings to business outcomes.

---

# QA Lead Conclusion

API testing is the backbone of modern backend quality assurance, especially in fintech systems where every request may represent a financial transaction.

An effective API tester understands not only HTTP methods and status codes but also authentication, business rules, database validation, security, idempotency, reconciliation and automation.

The strongest interview answers demonstrate how these technical concepts work together to protect customers, reduce business risk and support reliable software releases.
