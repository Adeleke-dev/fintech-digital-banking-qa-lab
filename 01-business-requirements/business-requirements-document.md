# Business Requirements Document v1.0

## Project Name: Fintech Digital Banking QA Lab

## Domain: Digital Banking and Payments

## Document Type: QA Portfolio Requirement Analysis Deliverable

---

# 1. Product Overview

Fintech Digital Banking QA Lab is a digital banking and wallet-based financial application that allows customers to register, verify their accounts, manage wallet balances, fund wallets, transfer money, pay bills, receive notifications, and view transaction history.

The system is designed to simulate real fintech workflows found in digital banks, wallet applications, payment processors, payroll platforms, lending systems, and investment platforms.

The main QA focus is to validate that financial transactions are processed securely, accurately, and reliably.

---

# 2. Product Purpose

The purpose of this product is to allow customers to perform digital financial activities safely and conveniently.

The application must support:

* secure registration and login
* OTP-based account verification
* wallet creation after verification
* wallet funding through card and bank transfer
* internal wallet-to-wallet transfers
* external bank transfers
* bill payments
* transaction history
* transaction notifications
* prevention of duplicate debit and duplicate credit
* proper handling of failed, pending, reversed, and refunded transactions

---

# 3. Business Objectives

The business objectives of the product are:

1. Allow users to securely access digital banking services.
2. Allow users to verify accounts before wallet access.
3. Allow users to fund their wallets using card and bank transfer.
4. Allow users to transfer money internally and externally.
5. Allow users to pay bills such as airtime, data, and utilities.
6. Ensure accurate wallet balance after every financial transaction.
7. Prevent double debit and double credit.
8. Detect duplicate transaction requests and duplicate provider callbacks.
9. Track all financial transactions using unique transaction references.
10. Support investigation of failed, pending, reversed, and refunded transactions.
11. Provide reliable transaction notifications.
12. Support QA validation through functional testing, API testing, SQL validation, regression testing, and UAT support.

---

# 4. User Roles

## 4.1 Customer

A customer is the main user of the digital banking application.

The customer can:

* register with email, phone number, and password
* verify account using OTP
* log in
* reset password
* access wallet after verification
* view wallet balance
* fund wallet
* transfer money
* manage beneficiaries
* pay bills
* view transaction history
* receive transaction notifications

---

## 4.2 Admin / Operations User

An admin or operations user supports transaction monitoring and issue resolution.

The admin or operations user can:

* review transaction records
* investigate pending transactions
* review failed transactions
* review duplicate transaction attempts
* support reversals and refunds
* review suspicious activity
* support customer complaints
* validate reconciliation issues

---

## 4.3 External Payment Provider

An external payment provider represents third-party systems such as card processors, bank transfer processors, bill payment aggregators, or payment gateways.

The provider may return:

* successful response
* failed response
* pending response
* timeout
* delayed confirmation
* duplicate callback
* reversal confirmation

---

# 5. Project Scope

## 5.1 In Scope

The first version of the project will include:

1. Authentication
2. OTP verification
3. Password reset
4. Session management
5. Wallet creation
6. Wallet balance display
7. Wallet history
8. Card wallet funding
9. Bank transfer wallet funding
10. Internal wallet transfer
11. External bank transfer
12. Beneficiary management
13. Transfer limit validation
14. Transaction status handling
15. Airtime bill payment
16. Data bill payment
17. Utility bill payment
18. Email notifications
19. SMS notifications
20. Push notifications
21. Duplicate transaction prevention
22. Failed transaction handling
23. Reversal/refund handling
24. SQL validation
25. API validation
26. Reconciliation-focused QA checks

---

## 5.2 Out of Scope for Version 1

The following are excluded from the first version:

* BVN verification
* full KYC onboarding
* loan application processing
* investment trading
* virtual card issuing
* merchant settlement dashboard
* crypto transactions
* advanced fraud machine learning
* regulatory compliance certification
* real payment gateway integration

These may be added later as advanced portfolio extensions.

---

# 6. Business Requirement Decisions

## 6.1 Registration Requirement

Users shall register using:

* email address
* phone number
* password

BVN and full KYC are out of scope for version 1.

### Real-World Sample

In many fintech MVPs, users can create an account with basic details first. Full KYC may be introduced later when users need higher transaction limits or regulated financial services.

---

## 6.2 OTP Verification Requirement

Users must verify their account using OTP before wallet access is allowed.

Wallet creation shall happen only after successful OTP verification.

### Real-World Sample

A user registers successfully but has not verified OTP. The user should not be able to perform wallet funding or transfers until OTP verification is completed.

---

## 6.3 Wallet Funding Requirement

The system shall support both:

* card funding
* bank transfer funding

Wallet balance shall only be credited after successful provider confirmation.

Failed funding must not credit the wallet.

Duplicate provider confirmation must not credit the wallet twice.

### Real-World Sample

A customer funds their wallet with ₦10,000 using card payment. The payment provider sends a successful callback twice. The system must credit the wallet only once and mark the second callback as duplicate.

---

## 6.4 Transfer Requirement

The system shall support:

* internal wallet-to-wallet transfers
* external bank transfers

The system shall validate available balance before processing any transfer.

The system shall reject transfers above configured limits.

Duplicate transfer requests must not cause duplicate debit.

### Real-World Sample

A user with ₦20,000 sends ₦5,000 to another wallet user. The sender should be debited once, and the receiver should be credited once. If the user taps the transfer button twice quickly, only one transfer should be processed.

---

## 6.5 Transfer Limit Requirement

The project shall use the following transfer limits:

* ₦50,000 per transaction
* ₦200,000 daily transfer limit

Transfers above these limits shall be rejected.

### Real-World Sample

A user attempts to transfer ₦70,000 in one transaction. The system should reject the transfer because it exceeds the ₦50,000 per-transaction limit.

---

## 6.6 Pending Transaction Requirement

A transaction with `PENDING` status shall not be treated as successful until confirmation is received.

For funding, wallet balance must not increase while the transaction is still pending.

For transfer and bill payment flows, debit behavior must be traceable and reversible where applicable.

Pending transactions may require provider confirmation, timeout handling, or operations review.

### Real-World Sample

A user initiates bank transfer funding, but the provider has not confirmed payment. The transaction remains pending, and the wallet balance does not increase until successful confirmation is received.

---

## 6.7 Duplicate Request Requirement

The system shall detect duplicate transaction requests.

Duplicate requests must not result in:

* duplicate debit
* duplicate credit
* duplicate bill payment
* duplicate transaction success records

### Real-World Sample

A user clicks “Send Money” twice due to slow network response. The system must not process two transfers if both requests share the same idempotency key or transaction reference.

---

## 6.8 Failed Transfer Requirement

If a user is debited but the external transfer fails, the system shall reverse the debit.

The final transaction state should clearly show that the transfer failed and was reversed.

Unclear failed transactions may require operations review.

### Real-World Sample

A user sends ₦15,000 to an external bank account. The wallet is debited, but the provider later confirms failure. The system should reverse ₦15,000 back to the user’s wallet and update the transaction status to `REVERSED`.

---

## 6.9 Bill Payment Requirement

The system shall support:

* airtime purchase
* data purchase
* utility bill payment

Every bill payment must have a unique transaction reference.

If bill payment fails after wallet debit, the user must be refunded or reversed.

### Real-World Sample

A user pays ₦2,000 for electricity. The wallet is debited, but the utility provider fails to deliver value. The system should reverse or refund the ₦2,000 and link the reversal to the original bill payment transaction.

---

## 6.10 Notification Requirement

The system shall support:

* email notification
* SMS notification
* push notification

Notification failure must not change the actual transaction status.

### Real-World Sample

A transfer succeeds, but SMS delivery fails. The transaction should remain successful. The SMS failure should be logged separately for notification retry or investigation.

---

# 7. Transaction States

The system shall support the following transaction states:

| Status     | Meaning                                                                     |
| ---------- | --------------------------------------------------------------------------- |
| PENDING    | Transaction has been initiated but final confirmation has not been received |
| SUCCESSFUL | Transaction has been completed successfully                                 |
| FAILED     | Transaction did not complete successfully                                   |
| REVERSED   | Debit was returned after a failed or cancelled transaction                  |
| REFUNDED   | Customer received money back, usually linked to a previous transaction      |

---

# 8. Wallet Accounting Rules

The wallet balance must follow strict debit and credit rules.

## 8.1 Credit Rules

A wallet shall be credited only when:

* funding is confirmed successful
* internal transfer credit is confirmed
* reversal is completed
* refund is completed

A wallet shall not be credited when:

* funding is pending
* funding failed
* duplicate callback is received
* transaction reference already exists

---

## 8.2 Debit Rules

A wallet shall be debited only when:

* transfer request is valid
* bill payment request is valid
* user has sufficient available balance
* user is within transaction limit
* transaction reference is unique

A wallet shall not be debited when:

* user has insufficient balance
* transfer exceeds limit
* authentication is invalid
* request is duplicate
* account is unauthorized

---

# 9. Core Business Rules

1. Users must verify OTP before wallet access.
2. Wallet creation happens only after successful OTP verification.
3. BVN and full KYC are excluded from version 1.
4. Wallet balance must only change after valid financial events.
5. Failed wallet funding must not credit the wallet.
6. Duplicate funding callback must not cause duplicate credit.
7. Users must not transfer more than their available balance.
8. Users must not exceed ₦50,000 per transaction.
9. Users must not exceed ₦200,000 daily transfer limit.
10. Duplicate transfer requests must not cause duplicate debit.
11. Every transaction must have a unique transaction reference.
12. Pending transactions must not be treated as successful.
13. Failed transfers after debit must be reversed.
14. Failed bill payments after debit must be reversed or refunded.
15. Notification failure must not change transaction status.
16. Refunds and reversals must be traceable to the original transaction.
17. External provider timeout must require confirmation, retry, or operations review.
18. Admin/operations users must be able to investigate transaction records.

---

# 10. QA Focus Areas

The QA focus areas for this project are:

* requirement validation
* risk analysis
* authentication testing
* OTP verification testing
* wallet creation validation
* wallet balance validation
* funding flow validation
* transfer flow validation
* transaction state validation
* duplicate request testing
* duplicate callback testing
* debit and credit validation
* reversal and refund validation
* bill payment testing
* notification testing
* API testing
* SQL validation
* reconciliation testing
* regression testing
* UAT support
* release readiness testing

---

# 11. Common Production Issues To Prevent

The project is designed to demonstrate QA coverage against these common fintech production issues:

| Production Issue                                 | QA Concern                                    |
| ------------------------------------------------ | --------------------------------------------- |
| Customer wallet credited twice                   | Duplicate callback handling                   |
| Customer debited twice                           | Duplicate request handling                    |
| Customer debited but transfer failed             | Reversal handling                             |
| Funding stuck in pending                         | Pending transaction monitoring                |
| Wrong wallet balance                             | Wallet accounting validation                  |
| Failed bill payment not refunded                 | Refund/reversal validation                    |
| Transfer above limit processed                   | Limit validation                              |
| Transaction shown as successful incorrectly      | Transaction status validation                 |
| Notification says success but transaction failed | Notification accuracy                         |
| Operations cannot investigate issue              | Audit trail and transaction record validation |

---

# 12. Real-World Fintech Sample Scenarios

## Scenario 1: Successful Card Funding

A customer funds their wallet with ₦10,000 using card payment.

Expected business behavior:

* funding transaction is created
* payment provider confirms success
* wallet is credited with ₦10,000
* transaction status becomes `SUCCESSFUL`
* wallet history shows credit
* notification is sent to the customer

---

## Scenario 2: Failed Card Funding

A customer attempts to fund their wallet with ₦10,000, but payment fails.

Expected business behavior:

* funding transaction is created
* provider returns failed response
* wallet is not credited
* transaction status becomes `FAILED`
* customer sees failed transaction in history
* failure notification may be sent

---

## Scenario 3: Duplicate Funding Callback

A customer funds wallet with ₦10,000. Provider sends success callback twice.

Expected business behavior:

* first callback credits the wallet
* second callback is identified as duplicate
* wallet is not credited twice
* duplicate event is logged
* transaction remains successful only once

---

## Scenario 4: Successful Internal Transfer

A sender transfers ₦5,000 to another wallet user.

Expected business behavior:

* sender balance is debited by ₦5,000
* receiver balance is credited by ₦5,000
* debit and credit records are created
* transaction status becomes `SUCCESSFUL`
* both users can view transaction history

---

## Scenario 5: Duplicate Transfer Request

A sender clicks the transfer button twice because the app is slow.

Expected business behavior:

* only one transfer is processed
* sender is debited once
* receiver is credited once
* duplicate request is rejected or ignored
* duplicate attempt is logged

---

## Scenario 6: External Transfer Failure After Debit

A user sends ₦15,000 to an external bank account. The wallet is debited, but the provider confirms failure.

Expected business behavior:

* transaction initially moves to `PENDING`
* provider confirms failure
* debit is reversed
* wallet balance is restored
* transaction status becomes `REVERSED`
* reversal is linked to the original transaction

---

## Scenario 7: Bill Payment Failure After Debit

A user pays ₦2,000 for electricity. Wallet debit succeeds, but utility service delivery fails.

Expected business behaviour:

* The bill payment transaction is recorded
* Wallet debit is traceable
* failed delivery is detected
* user is refunded or reversed
* final transaction state is updated
* refund/reversal is linked to the original bill payment

---

## Scenario 8: Notification Failure After Successful Transfer

A transfer succeeds, but the SMS notification fails.

Expected business behaviour:

* transaction remains `SUCCESSFUL`
* SMS failure is logged separately
* notification may be retried
* transaction status is not changed to failed

---

# 13. Success Criteria

The product is considered ready for the next QA phase when:

1. Product purpose is clearly defined.
2. Core user roles are identified.
3. In-scope and out-of-scope features are documented.
4. Authentication and wallet rules are clear.
5. Funding and transfer rules are clear.
6. Transaction states are defined.
7. Wallet debit and credit rules are defined.
8. Duplicate transaction prevention rules are documented.
9. Reversal and refund expectations are documented.
10. Notification behaviour is defined.
11. Key production risks are identified.
12. QA focus areas are ready for user story and acceptance criteria design.

---

# 14. Phase 1 Sign-Off

Phase 1 is complete when the Business Requirements Document is reviewed and accepted as the baseline requirement document for the project.

Status: Ready for review.

Next Phase: Phase 2 — User Stories and Acceptance Criteria.
