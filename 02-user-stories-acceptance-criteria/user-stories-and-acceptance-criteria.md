# User Stories and Acceptance Criteria

## Project: Fintech Digital Banking QA Lab

## Phase 2 Deliverable

---

# 1. Document Purpose

This document converts the Business Requirements Document into user stories and acceptance criteria for the Fintech Digital Banking QA Lab.

The goal is to define testable product behavior for authentication, wallet management, wallet funding, transfers, transaction processing, bill payments, notifications, security, and fraud prevention.

---

# 2. User Story Format

Each user story follows this format:

As a [user role],
I want to [perform an action],
So that [business value or user benefit].

---

# 3. Acceptance Criteria Format

Acceptance criteria are written using clear testable conditions.

Where useful, the format follows:

Given [precondition],
When [action],
Then [expected result].

---

# 4. Authentication User Stories

---

## US-AUTH-001: Customer Registration

As a customer,
I want to register with my email, phone number, and password,
So that I can create an account on the digital banking platform.

### Acceptance Criteria

1. Given a new customer provides a valid email, phone number, and password, when they submit the registration form, then the system should create a customer account.
2. Given the email already exists, when the customer attempts registration, the system should reject the request with a clear error message.
3. Given the phone number already exists, when the customer attempts registration, the system should reject the request with a clear error message.
4. Given that the password does not meet password rules, when the customer submits registration, the system should reject the request.
5. Given registration is successful, when the account is created, then the system should send an OTP for verification.
6. Given registration is successful, then the customer should not access wallet features until OTP verification is completed.

### Fintech QA Notes

Registration is low financial risk by itself, but it becomes important because unauthorized or duplicate accounts can affect fraud prevention and account ownership.

---

## US-AUTH-002: OTP Verification

As a customer,
I want to verify my account using OTP,
So that I can activate my account and access wallet services.

### Acceptance Criteria

1. Given a registered customer receives an OTP, when they enter the correct OTP, then the account should be verified.
2. Given a customer enters an incorrect OTP, when they submit verification, then the system should reject the OTP.
3. Given that an OTP has expired, when the customer submits the OTP, the system should reject the OTP.
4. Given OTP verification is successful, then the system should create a wallet for the customer.
5. Given OTP verification is not completed, then the customer should not be able to fund wallet, transfer money, or pay bills.
6. Given a customer requests OTP resend, then the system should send a new OTP and invalidate or supersede the previous OTP based on business rules.

### Fintech QA Notes

OTP verification protects wallet access and reduces the risk of unauthorized financial activity.

---

## US-AUTH-003: Customer Login

As a customer,
I want to log in with my valid credentials,
So that I can access my digital banking account.

### Acceptance Criteria

1. Given a customer provides valid login credentials, when they submit the login form, then the system should allow access.
2. Given a customer provides an invalid password, when they attempt login, then the system should reject access.
3. Given a customer provides an unregistered email or phone number, when they attempt login, then the system should reject access.
4. Given a customer account is not OTP verified, when they log in, then the system should restrict wallet-related actions.
5. Given repeated failed login attempts occur, then the system should detect and limit suspicious activity based on security rules.

### Fintech QA Notes

Login testing must include valid, invalid, unverified, and suspicious login attempts.

---

## US-AUTH-004: Password Reset

As a customer,
I want to reset my password,
So that I can regain access to my account if I forget my password.

### Acceptance Criteria

1. Given a registered customer requests password reset, then the system should send a reset OTP or reset link.
2. Given the reset OTP or link is valid, when the customer submits a new valid password, then the system should update the password.
3. Given the reset OTP or link is invalid, then the system should reject the password reset.
4. Given the reset OTP or link has expired, then the system should reject the password reset.
5. Given password reset is successful, then the customer should be able to log in with the new password.
6. Given password reset is successful, then previous active sessions should be invalidated if required by security policy.

### Fintech QA Notes

Password reset is sensitive because account takeover can lead to unauthorized transfers.

---

## US-AUTH-005: Session Management

As a customer,
I want my session to be managed securely,
So that my account remains protected when I use the platform.

### Acceptance Criteria

1. Given a customer logs in successfully, then the system should create a valid session.
2. Given a customer logs out, then the system should invalidate the active session.
3. Given a session expires, when the customer attempts a protected action, then the system should require login again.
4. Given an invalid session token is used, then the system should reject access.
5. Given a user attempts wallet actions without a valid session, then the system should deny access.

### Fintech QA Notes

Session management prevents unauthorized access to financial actions.

---

# 5. Wallet Management User Stories

---

## US-WALLET-001: Wallet Creation After OTP Verification

As a verified customer,
I want a wallet to be created after OTP verification,
So that I can perform financial transactions.

### Acceptance Criteria

1. Given a customer successfully verifies OTP, then the system should create a wallet.
2. Given a customer has not verified OTP, then the system should not create or activate wallet access.
3. Given wallet creation succeeds, then the initial wallet balance should be ₦0.00.
4. Given wallet creation succeeds, then the wallet should be linked to the correct customer account.
5. Given wallet creation is attempted more than once for the same customer, then the system should not create duplicate wallets.

### Fintech QA Notes

Duplicate wallet creation can cause wallet accounting and reconciliation issues.

---

## US-WALLET-002: View Wallet Balance

As a customer,
I want to view my wallet balance,
So that I know how much money is available for transactions.

### Acceptance Criteria

1. Given a customer has a wallet, when they view wallet balance, then the system should display the current available balance.
2. Given the customer has no successful transactions, then the wallet balance should display ₦0.00.
3. Given a successful funding transaction occurs, then the wallet balance should increase by the funded amount.
4. Given a successful debit transaction occurs, then the wallet balance should decrease by the debit amount.
5. Given a failed transaction occurs, then the wallet balance should not change incorrectly.
6. Given the UI displays wallet balance, then the displayed balance should match the database wallet balance.

### Fintech QA Notes

Wallet balance accuracy is one of the most important fintech QA validation areas.

---

## US-WALLET-003: View Wallet History

As a customer,
I want to view my wallet history,
So that I can track all credits, debits, reversals, and refunds.

### Acceptance Criteria

1. Given a customer has completed transactions, when they open wallet history, then the system should display transaction records.
2. Given a transaction is successful, then the history should show the correct amount, type, date, reference, and status.
3. Given a transaction fails, then the history should show the failed status.
4. Given a transaction is reversed or refunded, then the history should show the reversal or refund clearly.
5. Given a duplicate transaction attempt is rejected, then it should not appear as a successful financial transaction.
6. Given the customer views history, then they should only see their own transaction records.

### Fintech QA Notes

Transaction history supports user trust, complaint resolution, and audit trail validation.

---

# 6. Wallet Funding User Stories

---

## US-FUND-001: Card Wallet Funding

As a customer,
I want to fund my wallet using a card,
So that I can add money to my wallet for transfers and bill payments.

### Acceptance Criteria

1. Given a customer enters valid card funding details, when payment is confirmed successful, then the wallet should be credited with the funded amount.
2. Given that card payment fails, then the wallet should not be credited.
3. Given that card payment is pending, the wallet should not be credited until success confirmation is received.
4. Given that the provider sends duplicate success confirmation, then the wallet should be credited only once.
5. Given funding is successful, then a transaction record should be created with status `SUCCESSFUL`.
6. Given that funding fails, then a transaction record should be created or updated with status `FAILED`.
7. Given that funding is successful, then the customer should receive a notification.

### Fintech QA Notes

This story directly validates the prevention of double credit and the handling of payment confirmations.

---

## US-FUND-002: Bank Transfer Wallet Funding

As a customer,
I want to fund my wallet using a bank transfer,
So that I can add money without using a card.

### Acceptance Criteria

1. Given a customer initiates bank transfer funding, then the system should create a pending funding transaction.
2. Given provider confirmation is successful, then the wallet should be credited.
3. Given provider confirmation is delayed, then the transaction should remain `PENDING`.
4. Given provider confirmation fails, then the wallet should not be credited.
5. Given duplicate provider confirmation is received, then the wallet should not be credited twice.
6. Given funding is successful, then transaction history should show the correct credit record.
7. Given funding remains pending beyond expected time, then it should be available for operations review.

### Fintech QA Notes

Bank transfer funding often has delayed confirmation, making pending and reconciliation testing important.

---

## US-FUND-003: Failed Funding Handling

As a customer,
I want failed funding attempts to be handled correctly,
So that my wallet is not credited incorrectly and I understand the transaction outcome.

### Acceptance Criteria

1. Given funding fails, then the transaction status should be `FAILED`.
2. Given funding fails, then wallet balance should not increase.
3. Given funding fails, then the customer should see the failed transaction status.
4. Given provider response is unclear, then transaction should remain `PENDING` until confirmation or review.
5. Given funding is later confirmed successful, then wallet should be credited once.
6. Given funding is confirmed failed after pending, then wallet should not be credited.

### Fintech QA Notes

Failed funding must be tested carefully because unclear provider responses can cause wrong wallet credits.

---

## US-FUND-004: Duplicate Funding Prevention

As an operations team,
I want duplicate funding callbacks to be detected,
So that customers are not credited more than once for the same payment.

### Acceptance Criteria

1. Given a funding transaction has already been processed successfully, when the same provider reference is received again, then the wallet should not be credited again.
2. Given a duplicate callback is received, then the duplicate event should be logged.
3. Given duplicate callback occurs, then transaction status should remain accurate.
4. Given duplicate callback occurs, then wallet balance should remain unchanged after the first valid credit.
5. Given duplicate callback is reviewed by operations, then the original transaction reference should be traceable.

### Fintech QA Notes

Duplicate funding prevention is a strong hiring-manager signal because it demonstrates real payment risk awareness.

---

# 7. Money Transfer User Stories

---

## US-TRANSFER-001: Internal Wallet Transfer

As a customer,
I want to transfer money to another wallet user,
So that I can send money within the platform.

### Acceptance Criteria

1. Given the sender has sufficient balance, when they transfer to a valid wallet user, then the sender should be debited.
2. Given the internal transfer is successful, then the receiver should be credited.
3. Given internal transfer succeeds, then both debit and credit records should be created.
4. Given the sender has insufficient balance, then the transfer should be rejected.
5. Given the sender attempts to transfer above the per-transaction limit, then the transfer should be rejected.
6. Given the sender attempts duplicate transfer request, then only one transfer should be processed.
7. Given internal transfer succeeds, then both sender and receiver should receive accurate transaction history records.

### Fintech QA Notes

Internal transfers require strong debit-credit validation between two wallets.

---

## US-TRANSFER-002: External Bank Transfer

As a customer,
I want to transfer money to an external bank account,
So that I can send money outside the platform.

### Acceptance Criteria

1. Given the sender has sufficient balance, when they initiate an external transfer, then the system should create a transfer transaction.
2. Given the external provider confirms success, then the transaction should be marked `SUCCESSFUL`.
3. Given the external provider fails the transfer before debit, then wallet balance should not reduce.
4. Given the user is debited and provider later confirms failure, then the system should reverse the debit.
5. Given provider confirmation is delayed, then the transaction should remain `PENDING`.
6. Given a duplicate request is submitted, then the sender should not be debited twice.
7. Given transfer succeeds, then the customer should receive transaction notification.

### Fintech QA Notes

External transfer testing must cover provider success, failure, pending, timeout, and reversal flows.

---

## US-TRANSFER-003: Beneficiary Management

As a customer,
I want to save beneficiaries,
So that I can transfer money faster in the future.

### Acceptance Criteria

1. Given a customer enters valid beneficiary details, then the system should save the beneficiary.
2. Given required beneficiary details are missing, then the system should reject the request.
3. Given a beneficiary already exists, then the system should prevent duplicate beneficiary records or update based on business rules.
4. Given a customer views beneficiaries, then only their own beneficiaries should be displayed.
5. Given a customer deletes a beneficiary, then the beneficiary should no longer appear in their beneficiary list.

### Fintech QA Notes

Beneficiary management must include authorization checks so users cannot access another user’s saved beneficiaries.

---

## US-TRANSFER-004: Transfer Limit Validation

As the business,
I want transfer limits to be enforced,
So that financial risk and fraud exposure are reduced.

### Acceptance Criteria

1. Given a user attempts a transfer above ₦50,000, then the system should reject the transaction.
2. Given a user exceeds ₦200,000 daily transfer total, then the system should reject further transfers for the day.
3. Given a transfer is within limits, then the system should allow processing if all other validations pass.
4. Given a failed transfer occurs, then it should not incorrectly count toward successful daily transferred amount unless business rules define otherwise.
5. Given a reversed transfer occurs, then limit calculation should follow documented business rules.

### Fintech QA Notes

Transfer limits are important for fraud prevention and regulatory-style control.

---

# 8. Transaction Processing User Stories

---

## US-TXN-001: Transaction Status Tracking

As a customer,
I want every transaction to have a clear status,
So that I understand whether my transaction is pending, successful, failed, reversed, or refunded.

### Acceptance Criteria

1. Given a transaction is initiated, then it should have a unique transaction reference.
2. Given a transaction is awaiting confirmation, then its status should be `PENDING`.
3. Given a transaction is completed successfully, then its status should be `SUCCESSFUL`.
4. Given a transaction fails, then its status should be `FAILED`.
5. Given a debit is returned after failure, then the transaction should show `REVERSED`.
6. Given money is returned as a refund, then the transaction should show `REFUNDED`.
7. Given a transaction status changes, then the change should be traceable.

### Fintech QA Notes

Transaction state validation is central to fintech QA.

---

## US-TXN-002: Reversal Handling

As a customer,
I want failed debited transactions to be reversed,
So that I do not lose money when a transaction fails.

### Acceptance Criteria

1. Given a customer is debited and the transaction later fails, then the debit should be reversed.
2. Given reversal is completed, then wallet balance should return to the correct amount.
3. Given reversal occurs, then a reversal record should be linked to the original transaction.
4. Given reversal fails, then the case should be available for operations review.
5. Given reversal is completed, then the customer should see the updated transaction status.

### Fintech QA Notes

Reversal testing proves that you understand customer-impacting financial failure recovery.

---

## US-TXN-003: Refund Handling

As a customer,
I want eligible failed services to be refunded,
So that money is returned when a paid service is not delivered.

### Acceptance Criteria

1. Given a bill payment or eligible transaction fails after debit, then refund should be initiated.
2. Given refund is successful, then wallet balance should increase by the refunded amount.
3. Given refund is successful, then refund record should be linked to the original transaction.
4. Given refund is pending, then the refund status should be visible.
5. Given refund fails, then the case should be available for operations review.

### Fintech QA Notes

Refund validation is important for bill payments, failed services, and customer complaint resolution.

---

## US-TXN-004: Duplicate Transaction Detection

As the business,
I want duplicate transactions to be detected,
So that customers are not debited or credited more than once for the same request.

### Acceptance Criteria

1. Given the same transaction reference is submitted more than once, then the system should process it only once.
2. Given the same provider reference is received more than once, then the system should process only the first valid callback.
3. Given a duplicate request is detected, then no additional financial impact should occur.
4. Given a duplicate is detected, then it should be logged for audit or review.
5. Given duplicate detection works correctly, then wallet balance should remain accurate.

### Fintech QA Notes

Duplicate transaction detection is one of the strongest fintech risk scenarios in this project.

---

# 9. Bill Payment User Stories

---

## US-BILL-001: Airtime Purchase

As a customer,
I want to buy airtime from my wallet,
So that I can recharge my phone.

### Acceptance Criteria

1. Given a customer has sufficient wallet balance, when they buy airtime, then the wallet should be debited.
2. Given that the airtime purchase succeeds, then the transaction status should be `SUCCESSFUL`.
3. Given an airtime purchase fails before debit, then the wallet balance should not change.
4. Given that an airtime purchase fails after debit, then the wallet should be reversed or refunded.
5. Given that the airtime purchase succeeds, then the transaction history should show the correct bill payment record.
6. Given a duplicate airtime purchase request is submitted, then the customer should not be debited twice for the same request.

### Fintech QA Notes

Airtime is useful for testing fast payment flows and handling duplicate requests.

---

## US-BILL-002: Data Purchase

As a customer,
I want to buy mobile data from my wallet,
So that I can purchase internet bundles.

### Acceptance Criteria

1. Given a customer has sufficient balance, when they buy data, then the wallet should be debited.
2. Given data purchase succeeds, then transaction status should be `SUCCESSFUL`.
3. Given data purchase fails after debit, then the customer should be reversed or refunded.
4. Given data purchase is pending, then final status should update after provider confirmation.
5. Given data purchase succeeds, then customer should receive notification.
6. Given duplicate request occurs, then only one data purchase should be processed.

### Fintech QA Notes

Data purchase validates provider dependency, success/failure handling, and refund expectations.

---

## US-BILL-003: Utility Bill Payment

As a customer,
I want to pay utility bills from my wallet,
So that I can pay for electricity or similar services digitally.

### Acceptance Criteria

1. Given a customer enters valid utility bill details and has sufficient balance, then the payment should be processed.
2. Given utility bill payment succeeds, then the wallet should be debited, and the transaction status should be `SUCCESSFUL`.
3. Given that the utility bill payment fails before the debit, then the wallet balance should not change.
4. Given that the utility bill payment fails after debit, then the wallet should be reversed or refunded.
5. Given provider confirmation is delayed, then the transaction should remain `PENDING`.
6. Given that the utility payment is completed, the transaction history should show the correct biller, amount, reference, and status.

### Fintech QA Notes

Utility bill payments are good for testing pending-state and provider-failure recovery.

---

# 10. Notification User Stories

---

## US-NOTIF-001: Successful Transaction Notification

As a customer,
I want to receive a notification after a successful transaction,
So that I know my transaction was completed.

### Acceptance Criteria

1. Given that a transaction succeeds, then the system should send a notification.
2. Given that the notification is sent, it should contain accurate transaction details.
3. Given that the transfer succeeds, then the notification should show the correct amount and transaction type.
4. Given that funding succeeds, then the notification should show the credited amount.
5. Given notification sending fails, then transaction status should remain unchanged.

### Fintech QA Notes

Notifications must reflect transaction truth. They should not become the source of incorrect financial information.

---

## US-NOTIF-002: Failed Transaction Notification

As a customer,
I want to be notified when a transaction fails,
So that I understand the outcome and the next step.

### Acceptance Criteria

1. Given a transaction fails, then the system should notify the customer where applicable.
2. Given that a failed transfer is reversed, then notification should clearly communicate the reversal.
3. Given that bill payment fails after debit, then the notification should not falsely state that the service was delivered.
4. Given notification fails, then the failed notification should be logged separately.
5. Given transaction status changes from pending to failed, then the customer should receive updated information where applicable.

### Fintech QA Notes

Wrong failure messaging can increase customer complaints and support workload.

---

# 11. Security and Fraud Prevention User Stories

---

## US-SEC-001: Invalid Authentication Protection

As the business,
I want invalid authentication attempts to be rejected,
So that customer accounts are protected.

### Acceptance Criteria

1. Given invalid login credentials are submitted, then access should be denied.
2. Given repeated failed login attempts occur, then suspicious activity should be detected.
3. If an invalid session token is used, then protected resources should not be accessible.
4. Given that a user is not authenticated, then wallet, transfer, and bill payment actions should be blocked.
5. Given an unverified user attempts wallet actions, then the system should deny access.

### Fintech QA Notes

Authentication security protects accounts from unauthorised financial actions.

---

## US-SEC-002: Unauthorized Access Prevention

As a customer,
I want only my own financial data to be accessible to me,
So that my wallet and transactions remain private.

### Acceptance Criteria

1. Given a customer is authenticated, when they view their wallet balance, then only their own wallet should be displayed.
2. Given a customer tries to access another customer’s wallet ID, then access should be denied.
3. Given a customer views their transaction history, then only their own transactions should be visible.
4. Given that a customer tries to modify another user’s beneficiary, then the system should reject the request.
5. If unauthorised access is attempted, then the event should be logged.

### Fintech QA Notes

Authorisation testing is critical in fintech because IDOR-style bugs can expose sensitive financial data.

---

## US-SEC-003: Rapid Transfer Attempt Detection

As the business,
I want rapid transfer attempts to be detected,
So that suspicious or accidental duplicate activity can be controlled.

### Acceptance Criteria

1. Given a customer submits multiple transfer requests rapidly, then the system should detect the behavior.
2. Given a duplicate transfer request is detected, then only one valid transaction should be processed.
3. Given that rapid transfer attempts exceed the allowed rules, then additional requests should be rejected or flagged.
4. Given suspicious rapid attempts occur, then the activity should be logged.
5. Given that a legitimate transfer is processed, then the wallet balance should only reflect valid completed transactions.

### Fintech QA Notes

Rapid transfer attempt testing helps demonstrate awareness of fraud and duplicate transactions.

---

# 12. Summary of User Stories

| Module                        | User Story Count |
| ----------------------------- | ---------------: |
| Authentication                |                5 |
| Wallet Management             |                3 |
| Wallet Funding                |                4 |
| Money Transfers               |                4 |
| Transaction Processing        |                4 |
| Bill Payments                 |                3 |
| Notifications                 |                2 |
| Security and Fraud Prevention |                3 |
| Total                         |               28 |

---

# 13. Phase 2 Completion Criteria

Phase 2 is complete when:

1. User stories are defined for all major modules.
2. Acceptance criteria are clear and testable.
3. Financial risk scenarios are included.
4. Duplicate request scenarios are included.
5. Failed transaction scenarios are included.
6. Reversal and refund criteria are included.
7. Security and authorization criteria are included.
8. Stories are ready to be used for risk analysis and test scenario design.

---

# 14. Next Phase

Next Phase: Phase 3 — Risk Register and Risk Assessment Matrix.

