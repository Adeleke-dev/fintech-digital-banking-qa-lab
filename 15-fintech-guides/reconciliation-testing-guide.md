# Reconciliation Testing Guide

## Project

**Fintech Digital Banking QA Lab**

---

# Overview

Reconciliation testing verifies that financial records from different systems, services, databases, and providers agree with one another.

In a digital banking platform, one transaction may appear in several places:

* Customer wallet
* Transaction table
* Ledger
* Payment-provider records
* Bank records
* Settlement report
* Refund or reversal records
* Audit logs

Reconciliation testing confirms that these records describe the same financial event accurately and completely.

---

# Why Reconciliation Matters

A transaction may return `200 OK` and still be financially incorrect.

Examples:

* The API reports success, but the wallet was not credited.
* The customer was debited, but no ledger entry exists.
* The provider reports success, while the platform shows `PENDING`.
* A refund exists internally, but the provider did not process it.
* The wallet balance differs from the ledger-calculated balance.
* One provider transaction created two internal credits.

These differences are called **reconciliation exceptions** or **breaks**.

---

# Purpose

The purpose of reconciliation testing is to:

* Confirm financial records agree across systems.
* Detect missing, duplicate, or incorrect transactions.
* Validate wallet and ledger accuracy.
* Confirm provider responses match internal records.
* Verify reversals and refunds.
* Validate settlement totals.
* Support financial reporting and operational investigation.
* Protect customer funds and business revenue.

---

# Reconciliation Principles

A healthy financial system should maintain the following principles:

1. Every financial transaction has a unique reference.
2. Every wallet movement has a corresponding ledger entry.
3. Every successful provider event has the expected internal record.
4. Every failed post-debit transaction has a reversal.
5. Refund totals do not exceed the refundable amount.
6. Duplicate callbacks do not create duplicate financial impact.
7. Internal totals match external provider totals.
8. Every exception is traceable and investigated.

---

# Types of Reconciliation

## 1. Wallet-to-Ledger Reconciliation

This confirms that the wallet’s stored balance matches the balance calculated from its ledger entries.

Example:

| Entry             | Type   | Amount |
| ----------------- | ------ | -----: |
| Opening balance   | Credit |     £0 |
| Wallet funding    | Credit |   £500 |
| Internal transfer | Debit  |   £120 |
| Bill payment      | Debit  |    £80 |
| Refund            | Credit |    £40 |

Expected calculated balance:

```text
£500 - £120 - £80 + £40 = £340
```

The wallet balance should therefore equal **£340**.

---

## 2. Transaction-to-Ledger Reconciliation

This confirms that each financial transaction produced the correct ledger impact.

Example:

| Transaction                  | Expected Ledger Effect              |
| ---------------------------- | ----------------------------------- |
| Successful wallet funding    | One credit                          |
| Successful outgoing transfer | One debit                           |
| Successful internal transfer | Sender debit and receiver credit    |
| Reversal                     | Credit restoring the original debit |
| Refund                       | Credit linked to original payment   |
| Failed pre-debit transfer    | No financial entry                  |

---

## 3. Internal-to-Provider Reconciliation

This compares platform transaction records against the external provider’s records.

Fields commonly compared include:

* Provider reference
* Internal reference
* Amount
* Currency
* Status
* Transaction date
* Customer or account identifier
* Settlement status
* Fee
* Failure reason

---

## 4. Settlement Reconciliation

This verifies that the amount expected from or payable to a provider matches the actual settlement amount.

Example:

| Item                         |  Amount |
| ---------------------------- | ------: |
| Successful customer payments | £10,000 |
| Refunds                      |    £500 |
| Provider fees                |    £200 |
| Expected settlement          |  £9,300 |

The settlement report should show the same expected amount, subject to the agreed settlement rules.

---

## 5. Refund Reconciliation

This confirms that refunds:

* Link to the correct original transaction.
* Do not exceed the refundable amount.
* Produce the correct wallet or account credit.
* Appear in provider and internal records.
* Are included correctly in settlement calculations.

---

## 6. Reversal Reconciliation

This confirms that a failed transaction that previously debited the customer is fully restored.

The expected relationship is:

```text
Original Debit + Matching Reversal = Net Financial Effect of £0
```

---

# Reconciliation Data Sources

Testing may compare data from:

| Source                   | Example Information                          |
| ------------------------ | -------------------------------------------- |
| Wallet table             | Current balance and wallet status            |
| Transaction table        | Amount, status, reference, transaction type  |
| Ledger table             | Debit and credit entries                     |
| Provider API             | Provider status and reference                |
| Provider settlement file | Settled transaction totals                   |
| Bank statement           | Actual external fund movement                |
| Refund table             | Refund amount and original transaction link  |
| Reversal table           | Reversal amount and source transaction       |
| Audit table              | Actor, action, timestamp, and previous state |
| Notification table       | Customer communication status                |

---

# Key Fields to Reconcile

The following fields should be compared wherever applicable:

* Internal transaction reference
* Provider reference
* Customer ID
* Wallet ID
* Transaction type
* Debit amount
* Credit amount
* Currency
* Fee
* Status
* Created timestamp
* Processed timestamp
* Settled timestamp
* Original transaction ID
* Reversal or refund ID
* Idempotency key

---

# Reconciliation Status Categories

| Category           | Meaning                                                  |
| ------------------ | -------------------------------------------------------- |
| Matched            | Internal and external records agree                      |
| Unmatched Internal | Internal record exists but no provider record exists     |
| Unmatched External | Provider record exists but no internal record exists     |
| Amount Mismatch    | Records exist but amounts differ                         |
| Status Mismatch    | Records exist but statuses differ                        |
| Duplicate          | More than one record exists for the same financial event |
| Missing Reversal   | Failed debited transaction has no recovery record        |
| Over-Refund        | Refund total exceeds eligible amount                     |
| Timing Difference  | Records may match after an expected processing delay     |

---

# Reconciliation Test Workflow

```text
Select Reconciliation Period
          ↓
Collect Internal Records
          ↓
Collect Provider or Bank Records
          ↓
Normalise Formats
          ↓
Match Using References
          ↓
Compare Amounts and Statuses
          ↓
Identify Exceptions
          ↓
Investigate Root Cause
          ↓
Correct or Escalate
          ↓
Re-run Reconciliation
```

---

# Reconciliation Test Scenarios

## Wallet and Ledger

* Wallet balance equals the sum of ledger entries.
* Credit transaction increases wallet and ledger correctly.
* Debit transaction decreases wallet and ledger correctly.
* Failed pre-debit transaction does not change balance.
* Reversal restores original balance.
* Refund credits the correct amount.
* Duplicate ledger entry is detected.

## Provider Comparison

* Successful internal transaction matches provider success.
* Failed provider transaction is not marked successful internally.
* Provider callback amount matches the initiated amount.
* Provider reference is unique.
* Delayed provider confirmation remains traceable.
* Provider success without internal record is detected.
* Internal success without provider confirmation is detected.

## Settlement

* Total successful transactions match settlement records.
* Refunds reduce settlement according to business rules.
* Provider fees are calculated correctly.
* Failed transactions are excluded from settlement.
* Reversed transactions are handled correctly.
* Settlement currency is correct.
* Settlement date follows the agreed schedule.

---

# Detailed Scenario 1 — Wallet Funding Reconciliation

## Scenario

A customer funds a wallet with **£500**.

## Expected Internal Records

| Record              | Expected Result             |
| ------------------- | --------------------------- |
| Funding transaction | `SUCCESSFUL`, £500          |
| Wallet              | Balance increases by £500   |
| Ledger              | One £500 credit             |
| Provider reference  | Stored and unique           |
| Audit record        | Funding completion recorded |

## Expected Provider Record

| Field     | Expected                            |
| --------- | ----------------------------------- |
| Amount    | £500                                |
| Status    | Successful                          |
| Reference | Matches internal provider reference |
| Currency  | GBP                                 |

## Reconciliation Failure Examples

* Provider reports £500, but wallet receives £1,000.
* Wallet increases by £500, but no ledger entry exists.
* Internal transaction is successful, but provider reports failed.
* Same provider reference appears twice.
* Internal amount is £500, but provider amount is £450.

---

# Detailed Scenario 2 — Internal Transfer Reconciliation

## Scenario

Customer A transfers **£200** to Customer B.

## Expected Records

| Record                |           Customer A |           Customer B |
| --------------------- | -------------------: | -------------------: |
| Wallet effect         |                -£200 |                +£200 |
| Ledger                |           £200 debit |          £200 credit |
| Transaction reference | Same linked transfer | Same linked transfer |

Expected financial invariant:

```text
Total Debit = Total Credit
```

The platform’s total stored value should not increase or decrease because of the internal transfer.

## Reconciliation Failure Examples

* Sender debited but receiver not credited.
* Receiver credited twice.
* Debit and credit amounts differ.
* Sender and receiver entries use unrelated references.
* Transaction reports success while one ledger entry is missing.

---

# Detailed Scenario 3 — External Transfer Reversal

## Scenario

A customer sends **£300** externally.

The wallet is debited, but the provider later reports failure.

## Expected Records

1. Original £300 debit.
2. Failed external-transfer status.
3. Linked £300 reversal credit.
4. Final net financial effect of £0.
5. Customer wallet restored to its original balance.

## Reconciliation Failure Examples

* Transfer fails but no reversal exists.
* Reversal exists but credits only £290.
* Two reversals are created.
* Reversal is not linked to the original transfer.
* Wallet is restored but ledger remains incorrect.

---

# Detailed Scenario 4 — Refund Reconciliation

## Scenario

A customer completes an **£80** bill payment and later receives a partial refund of **£30**.

## Expected Records

* Original payment remains linked and traceable.
* Refund transaction is £30.
* Wallet receives one £30 credit.
* Remaining refundable amount is £50.
* Provider refund record matches £30.
* Settlement adjustment reflects the refund where applicable.

## Reconciliation Failure Examples

* Refund is £35 internally and £30 externally.
* Wallet receives £30 twice.
* Refund has no original transaction link.
* Cumulative refunds exceed £80.
* Refund is excluded from settlement adjustment.

---

# Reconciliation SQL Examples

The exact schema may differ. These examples show the validation intent.

## 1. Compare Stored Wallet Balance With Ledger Total

```sql
SELECT
    w.id AS wallet_id,
    w.balance AS stored_balance,
    COALESCE(
        SUM(
            CASE
                WHEN l.entry_type = 'CREDIT' THEN l.amount
                WHEN l.entry_type = 'DEBIT' THEN -l.amount
                ELSE 0
            END
        ),
        0
    ) AS calculated_ledger_balance
FROM wallets w
LEFT JOIN ledger_entries l
    ON l.wallet_id = w.id
GROUP BY w.id, w.balance
HAVING w.balance <> COALESCE(
    SUM(
        CASE
            WHEN l.entry_type = 'CREDIT' THEN l.amount
            WHEN l.entry_type = 'DEBIT' THEN -l.amount
            ELSE 0
        END
    ),
    0
);
```

Expected result:

```text
0 rows
```

Any returned row represents a wallet-to-ledger mismatch.

---

## 2. Detect Duplicate Provider References

```sql
SELECT
    provider_reference,
    COUNT(*) AS reference_count
FROM transactions
WHERE provider_reference IS NOT NULL
GROUP BY provider_reference
HAVING COUNT(*) > 1;
```

Expected result:

```text
0 rows
```

---

## 3. Detect Failed Debited Transfers Without Reversal

```sql
SELECT
    t.id,
    t.reference,
    t.amount,
    t.status
FROM transactions t
LEFT JOIN transactions r
    ON r.original_transaction_id = t.id
    AND r.transaction_type = 'REVERSAL'
    AND r.status = 'SUCCESSFUL'
WHERE t.transaction_type = 'EXTERNAL_TRANSFER'
  AND t.status = 'FAILED'
  AND t.debit_applied = TRUE
  AND r.id IS NULL;
```

Expected result:

```text
0 rows
```

---

## 4. Detect Refunds Exceeding the Original Amount

```sql
SELECT
    original.id AS original_transaction_id,
    original.amount AS original_amount,
    SUM(refund.amount) AS total_refunded
FROM transactions original
JOIN transactions refund
    ON refund.original_transaction_id = original.id
    AND refund.transaction_type = 'REFUND'
    AND refund.status = 'SUCCESSFUL'
GROUP BY original.id, original.amount
HAVING SUM(refund.amount) > original.amount;
```

Expected result:

```text
0 rows
```

---

## 5. Detect Unbalanced Internal Transfers

```sql
SELECT
    transaction_reference,
    SUM(
        CASE
            WHEN entry_type = 'CREDIT' THEN amount
            WHEN entry_type = 'DEBIT' THEN -amount
            ELSE 0
        END
    ) AS net_amount
FROM ledger_entries
WHERE transaction_type = 'INTERNAL_TRANSFER'
GROUP BY transaction_reference
HAVING SUM(
    CASE
        WHEN entry_type = 'CREDIT' THEN amount
        WHEN entry_type = 'DEBIT' THEN -amount
        ELSE 0
    END
) <> 0;
```

Expected result:

```text
0 rows
```

---

# Provider File Reconciliation

Providers may supply settlement or transaction files in:

* CSV
* Excel
* JSON
* API responses
* Secure file transfer

Before comparison, QA should confirm:

* Date format
* Time zone
* Currency format
* Decimal precision
* Reference format
* Status mapping
* Header names
* Duplicate rows
* Missing fields
* File completeness

---

# Status Mapping

Internal and provider systems may use different status names.

Example:

| Internal Status | Provider Status   |
| --------------- | ----------------- |
| `PENDING`       | `INITIATED`       |
| `PROCESSING`    | `IN_PROGRESS`     |
| `SUCCESSFUL`    | `COMPLETED`       |
| `FAILED`        | `DECLINED`        |
| `REVERSED`      | `VOIDED`          |
| `REFUNDED`      | `REFUND_COMPLETE` |

The reconciliation process must use an approved mapping rather than comparing text values blindly.

---

# Time-Based Reconciliation

Some records may not match immediately because of expected delays.

Examples:

* Delayed callback
* End-of-day settlement
* Bank processing window
* Weekend or public holiday
* Retry queue
* Batch settlement

A temporary difference should be categorised as a **timing difference** only when:

* The expected SLA is documented.
* The transaction remains traceable.
* Monitoring exists.
* The record is matched within the allowed period.

A transaction that remains unmatched beyond SLA becomes an exception.

---

# Reconciliation Exception Report

Each exception should include:

| Field              | Description                                          |
| ------------------ | ---------------------------------------------------- |
| Exception ID       | Unique investigation reference                       |
| Internal Reference | Platform transaction reference                       |
| Provider Reference | External provider reference                          |
| Exception Type     | Amount, status, duplicate, missing record, or timing |
| Internal Amount    | Amount stored internally                             |
| External Amount    | Amount reported externally                           |
| Internal Status    | Platform status                                      |
| External Status    | Provider status                                      |
| Age                | Time since mismatch was detected                     |
| Owner              | Team responsible for investigation                   |
| Root Cause         | Confirmed cause                                      |
| Resolution         | Correction made                                      |
| Status             | Open, investigating, resolved, accepted              |

---

# Reconciliation Defect Examples

## Critical

* Customer debit has no corresponding receiver credit or reversal.
* Wallet balance differs from ledger.
* Duplicate provider callback creates duplicate credit.
* Refund exceeds original amount.
* Settlement total differs materially from expected funds.

## High

* Successful provider transaction remains internally pending.
* Reversal record exists but is not linked correctly.
* Missing provider reference prevents matching.
* Settlement fee calculation is incorrect.

## Medium

* Transaction matched after SLA.
* Incorrect report date or non-financial metadata.
* Duplicate notification but correct financial records.

---

# Test Data Requirements

Prepare data for:

* Successful wallet funding
* Failed wallet funding
* Duplicate callback
* Internal transfer
* External transfer success
* External transfer failure after debit
* Full reversal
* Full refund
* Partial refund
* Multiple partial refunds
* Duplicate refund request
* Delayed provider callback
* Provider success without internal match
* Internal success without provider match
* Settlement fee calculation

---

# Reconciliation Entry Criteria

Reconciliation testing can begin when:

* Transaction records are available.
* Ledger entries are available.
* Wallet balances can be queried.
* Provider records or mocks are accessible.
* Status mappings are documented.
* Currency and precision rules are known.
* Test transactions have unique references.

---

# Reconciliation Exit Criteria

Reconciliation testing is complete when:

* All planned records have been compared.
* Wallet and ledger balances match.
* Internal and provider transactions match.
* Reversals and refunds reconcile.
* Settlement calculations are correct.
* All Critical exceptions are resolved.
* Remaining differences are documented and accepted.
* Evidence is stored.

---

# How a QA Engineer Performs Reconciliation Testing

A QA Engineer:

* Executes transactions.
* Records internal and provider references.
* Queries wallet, transaction, and ledger data.
* Compares amounts and statuses.
* Documents mismatches.
* Raises defects with evidence.
* Retests corrected records.

---

# How a Senior QA Performs Reconciliation Testing

A Senior QA Engineer:

* Defines the reconciliation strategy.
* Identifies financial invariants.
* Reviews status mappings and timing rules.
* Prioritises high-risk exceptions.
* Coordinates with Product, Engineering, Finance, and Operations.
* Uses reconciliation results in release decisions.
* Ensures exception patterns become regression tests.

---

# How an SDET Approaches Reconciliation Testing

An SDET:

* Automates API-to-database comparison.
* Builds reusable ledger assertions.
* Parses provider settlement files.
* Automates duplicate and missing-record detection.
* Runs reconciliation checks in CI or scheduled jobs.
* Produces machine-readable exception reports.
* Adds alerts for reconciliation failures.

---

# Common Production Issues

* Provider reports success, platform remains pending.
* Platform reports success, provider has no record.
* Duplicate callback creates two credits.
* Ledger entry missing after wallet update.
* Reversal applied twice.
* Partial refund total exceeds original amount.
* Settlement file contains missing transactions.
* Currency or decimal precision creates amount mismatch.
* Time-zone difference places transactions in the wrong settlement day.
* Provider fee calculation differs from internal calculation.

---

# Common Interview Questions

## What is reconciliation testing?

Reconciliation testing confirms that financial records across internal systems, ledgers, providers, banks, and settlement reports agree.

## How do you validate a wallet balance?

I calculate the net total of all eligible ledger credits and debits and compare it with the stored wallet balance.

## What would you do if the provider reports success but the application shows pending?

I would compare the provider reference, callback logs, internal transaction record, ledger entries, and wallet balance. I would determine whether the callback was missed, delayed, rejected, or processed incorrectly.

## What is a reconciliation break?

A reconciliation break is a mismatch between two financial data sources, such as a status difference, amount mismatch, duplicate transaction, or missing record.

## How do you test settlement?

I compare eligible successful transactions, refunds, reversals, and fees against the provider’s settlement report and verify the final expected settlement total.

---

# Recruiter Talking Points

This guide demonstrates the ability to:

* Validate financial integrity across multiple systems.
* Understand wallet, ledger, provider, and settlement relationships.
* Use SQL to identify financial exceptions.
* Investigate missing, duplicate, and mismatched transactions.
* Validate reversal and refund recovery.
* Translate reconciliation findings into business and release risk.
* Support Finance, Operations, Product, and Engineering teams.

---

# QA Lead Conclusion

Reconciliation testing is one of the most important quality controls in a financial platform.

Functional testing confirms that a feature appears to work.

Reconciliation testing confirms that the money and records are actually correct.

A fintech release should not be considered safe until wallet balances, ledger entries, transaction records, provider records, reversals, refunds, and settlement data agree within documented rules and timelines.
