# SQL Interview Questions

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This guide contains SQL interview questions commonly asked for QA Engineer, API Test Engineer, Automation QA Engineer, and SDET roles.

The questions progress from beginner to advanced level and focus on how SQL is used in software testing, particularly for validating APIs, financial transactions, and database integrity.

---

# Why SQL Matters for QA

A QA Engineer should not rely solely on API or UI responses.

SQL allows testers to:

* Validate data stored in the database.
* Confirm API behaviour.
* Verify business rules.
* Investigate defects.
* Validate financial transactions.
* Support Root Cause Analysis.
* Perform reconciliation.

For fintech applications, SQL is an essential testing skill.

---

# Section 1 – SQL Fundamentals

## Question 1

### What is SQL?

**Sample Answer**

SQL (Structured Query Language) is the standard language used to interact with relational databases.

QA Engineers use SQL to:

* Retrieve data
* Validate application behaviour
* Verify test results
* Investigate production issues
* Confirm database integrity

---

## Question 2

### What is a database?

**Sample Answer**

A database is an organised collection of related data that applications use to store and retrieve information.

Examples include:

* Customer accounts
* Wallet balances
* Transactions
* Orders
* Products
* Audit logs

---

## Question 3

### What is the difference between a database and a table?

| Database                     | Table                       |
| ---------------------------- | --------------------------- |
| Collection of related tables | Stores related records      |
| Contains many objects        | Contains rows and columns   |
| Example: Banking Database    | Example: Transactions Table |

---

# Section 2 – Basic Queries

## Question 4

### How do you retrieve all records?

```sql
SELECT *
FROM users;
```

Avoid using `SELECT *` in production queries when only specific columns are required.

---

## Question 5

### How do you retrieve specific columns?

```sql
SELECT id,
       first_name,
       email
FROM users;
```

---

## Question 6

### How do you filter records?

```sql
SELECT *
FROM transactions
WHERE status = 'SUCCESS';
```

---

## Question 7

### How do you sort records?

```sql
SELECT *
FROM transactions
ORDER BY created_at DESC;
```

---

# Section 3 – WHERE Clause

## Question 8

### What operators can be used in a WHERE clause?

Common operators:

* =
* <>
* >
* <
* > =
* <=
* LIKE
* IN
* BETWEEN
* IS NULL

Example:

```sql
SELECT *
FROM wallets
WHERE balance > 1000;
```

---

## Question 9

### What is the difference between NULL and an empty string?

**NULL**

Represents the absence of a value.

**Empty String ('')**

Represents a value that contains no characters.

They are not the same.

---

# Section 4 – Aggregate Functions

## Question 10

### What are aggregate functions?

Common functions include:

* COUNT()
* SUM()
* AVG()
* MIN()
* MAX()

Example:

```sql
SELECT SUM(amount)
FROM transactions
WHERE status = 'SUCCESS';
```

---

## Question 11

### How do you count records?

```sql
SELECT COUNT(*)
FROM users;
```

---

# Section 5 – GROUP BY

## Question 12

### What is GROUP BY used for?

It groups rows so aggregate calculations can be performed.

Example:

```sql
SELECT status,
       COUNT(*)
FROM transactions
GROUP BY status;
```

---

# Section 6 – Joins

## Question 13

### What is a JOIN?

A JOIN combines data from multiple tables.

---

## Question 14

### Types of JOIN

| JOIN            | Purpose                                     |
| --------------- | ------------------------------------------- |
| INNER JOIN      | Matching rows only                          |
| LEFT JOIN       | All rows from left table                    |
| RIGHT JOIN      | All rows from right table                   |
| FULL OUTER JOIN | All rows from both tables (where supported) |

---

## Question 15

### Example INNER JOIN

```sql
SELECT
    u.id,
    u.first_name,
    w.balance
FROM users u
INNER JOIN wallets w
ON u.id = w.user_id;
```

---

# Section 7 – SQL for QA

## Question 16

### Why do QA Engineers need SQL?

Because SQL allows testers to verify that application behaviour matches the database.

Examples include:

* User created successfully
* Wallet credited correctly
* Transaction stored
* Refund recorded
* Audit trail created

---

## Question 17

### After testing a registration API, what SQL would you execute?

Example:

```sql
SELECT id,
       email,
       status
FROM users
WHERE email = 'customer@example.com';
```

Expected result:

* One record
* Correct email
* Active status

---

## Question 18

### How would you verify wallet funding?

```sql
SELECT
    wallet_id,
    balance
FROM wallets
WHERE wallet_id = 1001;
```

Then compare the stored balance with the expected balance after funding.

---

# Section 8 – Fintech SQL

## Question 19

### How do you validate a successful transfer?

Verify:

```sql
SELECT *
FROM transactions
WHERE reference = 'TXN123456';
```

Also validate:

* Sender wallet
* Receiver wallet
* Ledger entries
* Audit records

---

## Question 20

### What is reconciliation?

Reconciliation confirms that:

* Wallet balance
* Ledger
* Transactions
* Provider records

all contain consistent financial information.

---

## Question 21

### Why is reconciliation important?

Without reconciliation:

* Money may disappear.
* Duplicate payments may occur.
* Refunds may be incorrect.
* Audits become unreliable.
* Financial reporting becomes inaccurate.

---

# Section 9 – Transactions

## Question 22

### What is a database transaction?

A transaction is a sequence of operations treated as a single unit of work.

Either:

Everything succeeds

OR

Everything is rolled back.

---

## Question 23

### What is ACID?

| Letter | Meaning     |
| ------ | ----------- |
| A      | Atomicity   |
| C      | Consistency |
| I      | Isolation   |
| D      | Durability  |

These properties ensure reliable database transactions.

---

## Question 24

### Why is Atomicity important?

Example:

Wallet funding.

Operations:

* Debit payment provider
* Credit wallet
* Create ledger entry

If any step fails, the database should roll back so that no partial financial update is committed.

---

# Section 10 – Constraints

## Question 25

### What is a Primary Key?

A Primary Key uniquely identifies each record.

Example:

```text
user_id
```

No duplicates.

No NULL values.

---

## Question 26

### What is a Foreign Key?

A Foreign Key creates a relationship between tables.

Example:

```text
transactions.user_id

↓

users.id
```

---

# Section 11 – Debugging

## Question 27

### A user says their wallet balance is incorrect.

How would you investigate?

Suggested approach:

1. Retrieve wallet.
2. Retrieve transactions.
3. Verify ledger entries.
4. Check audit records.
5. Compare balances.
6. Review timestamps.
7. Identify inconsistencies.
8. Raise a defect if required.

---

## Question 28

### An API returns 200 OK but no record exists.

What do you do?

Answer:

Raise a defect.

A successful response without persistent data indicates that the business transaction did not complete successfully.

---

# Section 12 – Advanced SQL

## Question 29

### What is an Index?

An index improves query performance by allowing the database to locate records more efficiently.

Benefits:

* Faster searches
* Faster joins
* Faster filtering

Trade-off:

Indexes increase storage usage and can slow write operations because they must also be updated.

---

## Question 30

### What is a View?

A View is a stored SQL query that behaves like a virtual table.

It simplifies complex queries and can help restrict access to underlying tables.

---

## Question 31

### What is a Stored Procedure?

A Stored Procedure is a reusable block of SQL statements stored in the database.

It can encapsulate business logic and improve consistency.

---

## Question 32

### What is a Trigger?

A Trigger is database logic that runs automatically when an event occurs, such as:

* INSERT
* UPDATE
* DELETE

Triggers are often used for audit logging or enforcing business rules.

---

# Section 13 – Practical QA Scenarios

## Question 33

### After a successful refund API call, what SQL validations would you perform?

Verify:

* Refund record exists.
* Wallet balance updated correctly.
* Ledger entry created.
* Transaction status updated.
* Audit record created.
* Refund amount matches the original payment.
* No duplicate refund records exist.

---

## Question 34

### A duplicate payment is reported.

What SQL queries would you run?

Investigate:

* Duplicate transaction references
* Duplicate provider references
* Wallet balance
* Ledger entries
* Audit trail
* Request timestamps

The goal is to determine whether the duplication occurred in the application, the payment provider, or during retry processing.

---

## Question 35

### How would you validate data after a failed money transfer?

Verify that:

* Sender wallet has been restored if appropriate.
* Receiver wallet has not been credited incorrectly.
* Transaction status is correct.
* Reversal record exists (if applicable).
* Ledger remains balanced.
* Audit records capture the failure.

---

# Section 14 – Senior-Level Questions

## Question 36

### Why is database validation important for API testing?

Because APIs can return successful responses even when:

* Records are missing.
* Transactions fail internally.
* Wallet balances are incorrect.
* Business rules are violated.

Database validation confirms the true outcome of the operation.

---

## Question 37

### How would you investigate a production data issue?

Suggested approach:

1. Understand the business impact.
2. Reproduce the issue if possible.
3. Review API logs.
4. Query the database.
5. Compare related tables.
6. Check audit records.
7. Validate timestamps.
8. Review deployment history.
9. Identify the root cause.
10. Recommend regression coverage.

---

# Common SQL Interview Mistakes

Avoid:

* Using `SELECT *` unnecessarily.
* Ignoring NULL values.
* Forgetting JOIN conditions.
* Confusing INNER and LEFT JOIN.
* Assuming API success means database success.
* Forgetting transaction behaviour.
* Ignoring indexes and performance.

---

# Interview Tips

During SQL interviews:

* Explain why you would run a query, not just the syntax.
* Relate SQL to testing activities.
* Discuss business validation.
* Mention reconciliation for financial systems.
* Demonstrate how SQL supports Root Cause Analysis.

---

# Key SQL Topics to Master

Before interviews, be comfortable with:

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* JOINs
* Aggregate functions
* Transactions
* ACID properties
* Primary and Foreign Keys
* Indexes
* Views
* Stored Procedures
* Triggers
* Database validation for APIs

---

# QA Lead Conclusion

SQL is one of the most valuable technical skills for a QA Engineer because it provides visibility into the application's source of truth—the database.

Strong QA Engineers use SQL not only to retrieve data, but also to verify business rules, investigate defects, validate financial transactions and support Root Cause Analysis.

In interviews, demonstrate that you understand **why** database validation matters, especially for financial systems where a successful API response alone is never sufficient evidence that a transaction completed correctly.
