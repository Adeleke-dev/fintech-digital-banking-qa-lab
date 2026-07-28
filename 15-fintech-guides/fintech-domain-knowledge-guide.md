# Fintech Domain Knowledge Guide

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

This guide introduces the core concepts, workflows, and business rules that every QA Engineer should understand when testing fintech applications.

Unlike many software products, fintech systems handle customer funds, financial records, regulatory obligations, and business-critical transactions. A defect may lead to financial loss, compliance violations, or loss of customer trust.

Understanding the business domain enables QA Engineers to design realistic test scenarios, identify hidden risks, and communicate defects in terms that matter to Product Owners, developers, and business stakeholders.

---

# What is Fintech?

**Fintech (Financial Technology)** refers to software solutions that provide financial services using technology.

Examples include:

* Digital banks
* Mobile banking applications
* Digital wallets
* Payment gateways
* Money transfer platforms
* Investment platforms
* Lending applications
* Payroll systems
* Buy Now, Pay Later (BNPL)
* Card payment platforms
* Bill payment services

---

# Typical Fintech Architecture

```text
Customer
      │
      ▼
Mobile App / Web App
      │
      ▼
API Gateway
      │
      ▼
Backend Services
│
├── Authentication Service
├── Wallet Service
├── Payment Service
├── Transfer Service
├── Notification Service
├── Fraud Detection Service
├── Reporting Service
└── Audit Service
      │
      ▼
Database
      │
      ▼
External Providers
│
├── Payment Gateway
├── Bank APIs
├── Card Network
├── SMS Provider
└── Email Provider
```

---

# Core Fintech Entities

## Customer

A person or organisation using the financial platform.

Typical attributes:

* Customer ID
* Name
* Email
* Phone number
* KYC status
* Account status
* Wallet
* Beneficiaries
* Transaction history

---

## Wallet

A wallet stores a customer's electronic money balance.

Typical wallet attributes:

* Wallet ID
* Customer ID
* Available balance
* Reserved balance
* Currency
* Status
* Created date

A wallet should never change without a corresponding financial record.

---

## Transaction

A transaction records a financial event.

Examples include:

* Wallet funding
* Money transfer
* Bill payment
* Refund
* Reversal
* Withdrawal

A transaction answers:

* What happened?
* Who initiated it?
* When did it happen?
* How much money moved?
* What is its current status?

---

## Ledger

The ledger is the financial record of every debit and credit.

Unlike a wallet balance, the ledger provides a complete historical record.

Example:

| Entry          | Type   | Amount |
| -------------- | ------ | -----: |
| Wallet Funding | Credit |   £500 |
| Transfer       | Debit  |   £120 |
| Bill Payment   | Debit  |    £80 |
| Refund         | Credit |    £40 |

A correctly calculated wallet balance should always reconcile with its ledger entries.

---

## Beneficiary

A beneficiary is a saved recipient to whom a customer can send money.

A beneficiary must always belong only to the authenticated customer.

Cross-customer access is a serious security issue.

---

# Wallet Balance Concepts

## Available Balance

Money that can currently be spent.

Example:

```text
Wallet Balance

£500 Available
```

---

## Reserved Balance

Money temporarily held for a pending transaction.

Example:

```text
Available

£500

Reserved

£100

Spendable

£400
```

---

## Ledger Balance

The balance calculated from all historical debit and credit entries.

For a healthy system:

```text
Wallet Balance
=
Ledger Balance
```

If they differ, reconciliation has failed.

---

# Money Movement Lifecycle

A typical transfer follows this sequence:

```text
Customer Initiates Transfer
        │
        ▼
Validation
        │
        ▼
Authentication
        │
        ▼
Authorisation
        │
        ▼
Balance Check
        │
        ▼
Debit Wallet
        │
        ▼
Provider Processing
        │
        ▼
Provider Response
        │
 ┌──────┴────────┐
 │               │
 ▼               ▼
Success        Failure
 │               │
 ▼               ▼
Credit       Reversal
Receiver
 │
 ▼
Notify Customer
```

Every stage should be testable independently.

---

# Common Transaction Types

## Wallet Funding

Customer adds money to the wallet.

Expected result:

* Wallet credited
* Ledger credit created
* Transaction successful
* Customer notified

---

## Internal Transfer

Money moves between customers within the same platform.

Expected result:

* Sender debited
* Receiver credited
* Two ledger entries created
* Transaction linked

---

## External Transfer

Money is sent outside the platform through a bank or payment provider.

Expected result:

* Wallet debited
* Provider processes request
* Confirmation received
* Failure handled safely
* Reversal created if necessary

---

## Bill Payment

Customer pays a service provider.

Expected result:

* Wallet debited
* Provider receives payment
* Bill status updated
* Customer notified

---

## Refund

Money returned after a completed transaction.

Expected result:

* Refund never exceeds the eligible refundable amount.
* Refund links to the original transaction.
* Wallet credited.
* Ledger updated.
* Audit trail maintained.

---

## Reversal

Money returned because the original transaction failed.

Unlike a refund:

* Customer did not receive the intended service.
* Financial state must be restored automatically.

---

# Transaction Status Lifecycle

Common statuses include:

```text
Pending
    │
    ▼
Processing
    │
 ┌──┴─────────┐
 ▼            ▼
Successful   Failed
                  │
                  ▼
              Reversed
```

A transaction should never move between states in an invalid order.

Example:

```text
SUCCESSFUL

↓

PENDING

❌ Invalid
```

---

# Financial Invariants

A financial invariant is a rule that must always remain true.

Examples:

* One successful payment creates one wallet credit.
* One transfer debit creates one matching ledger entry.
* Refund amount never exceeds the remaining refundable amount.
* Failed debited transfer creates a reversal.
* Wallet balance equals ledger balance.
* Duplicate callback never creates duplicate money movement.
* Every financial event has an audit record.

These invariants should be protected by business rules, application logic, database constraints, and automated tests.

---

# Idempotency

Idempotency means that repeating the same request does not produce additional financial effects.

Example:

Customer clicks **"Pay"** twice because of a slow network.

Correct behaviour:

* One payment.
* One debit.
* One transaction.
* One provider reference.

Incorrect behaviour:

* Two payments.
* Double debit.
* Duplicate transaction.

Testing idempotency is essential for payment APIs.

---

# Reconciliation

Reconciliation is the process of confirming that all financial records agree.

Examples:

* Wallet balance matches ledger.
* Internal transaction matches provider record.
* Provider settlement matches platform records.
* Refund totals match original payments.

Reconciliation prevents hidden financial discrepancies.

---

# Settlement

Settlement is the final movement of funds between financial institutions after a transaction has been authorised and processed.

Example:

1. Customer pays a merchant.
2. Platform authorises payment.
3. Provider confirms payment.
4. Bank transfers funds.
5. Merchant receives settlement.

Settlement may occur immediately or after a scheduled period.

---

# Authentication vs Authorisation

## Authentication

Answers:

> Who is the user?

Example:

Customer logs in successfully.

---

## Authorisation

Answers:

> What is the user allowed to access?

Example:

Customer cannot access another customer's wallet or beneficiary.

Testing both is essential in fintech applications.

---

# Audit Trail

Every financial action should create an audit record.

Typical information includes:

* User ID
* Transaction ID
* Action performed
* Previous value
* New value
* Timestamp
* IP address (where applicable)
* Device information (where applicable)
* Result
* Actor (customer or system)

Audit trails support investigations, compliance, and dispute resolution.

---

# Common Fintech Risks

QA Engineers should actively test for:

* Double debit
* Double credit
* Duplicate callback
* Duplicate request
* Wallet mismatch
* Ledger mismatch
* Missing reversal
* Incorrect refund
* Stuck pending transaction
* Missing audit record
* Transfer-limit bypass
* Cross-customer access
* Expired-token access
* Provider timeout
* Notification failure affecting financial state

---

# Fintech Testing Mindset

Instead of asking:

> Did the API return 200 OK?

Ask:

* Did the correct amount move?
* Did money move only once?
* Was the wallet updated correctly?
* Was the ledger updated?
* Is reconciliation still correct?
* Is recovery possible if something fails?
* Can the request safely be repeated?
* Can another customer access these records?
* Is the transaction traceable?

---

# Real-World QA Example

## Scenario

A customer funds their wallet with **£500**.

### Expected Outcome

* Wallet balance increases by **£500**.
* One transaction record is created.
* One ledger credit is created.
* Provider reference is unique.
* Audit trail is recorded.
* Customer receives notification.
* Reconciliation passes.

### Potential Risks

* Duplicate callback credits wallet twice.
* Notification fails after funding.
* Provider delays confirmation.
* Transaction marked successful but ledger not updated.
* Wallet updated without audit trail.
* Duplicate request causes double funding.

A complete QA validation checks all these outcomes—not just the API response.

---

# Common Interview Questions

## What is the difference between a wallet and a ledger?

A wallet stores the customer's current balance, while the ledger stores the complete history of all financial debit and credit entries used to calculate that balance.

---

## What is idempotency?

Idempotency ensures that repeating the same request produces the same result without creating duplicate financial transactions.

---

## Why is reconciliation important?

Reconciliation confirms that internal financial records, wallet balances, ledger entries, and external provider records all agree, ensuring financial integrity.

---

## What is a reversal?

A reversal restores customer funds when the original transaction fails after money has already been debited.

---

## Why are audit trails important?

Audit trails provide evidence of every financial action, supporting compliance, investigations, fraud detection, and customer dispute resolution.

---

# Recruiter Talking Points

This guide demonstrates the ability to:

* Understand fintech business workflows.
* Explain financial concepts in simple language.
* Connect domain knowledge to QA activities.
* Identify financial risks beyond UI testing.
* Design realistic API, database, and security test scenarios.
* Communicate effectively with Product, Engineering, Finance, and Operations teams.

---

# QA Lead Conclusion

Successful fintech testing requires more than verifying software functionality.

A skilled QA Engineer must understand how money moves, how financial records are maintained, how failures are recovered, and how customer funds remain protected throughout every transaction.

Strong domain knowledge enables better test design, faster defect investigation, stronger release decisions, and higher confidence in production-quality financial systems.
