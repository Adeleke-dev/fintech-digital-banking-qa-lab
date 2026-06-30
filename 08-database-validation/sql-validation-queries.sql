-- =========================================================
-- Fintech Digital Banking QA Lab
-- SQL Validation Queries
-- Purpose: Validate wallet balances, transactions, ledger,
-- reversals, refunds, duplicates, audit trail, and reconciliation.
-- =========================================================


-- =========================================================
-- 1. Verify user record by email
-- =========================================================
SELECT
    id,
    email,
    phone,
    status,
    created_at
FROM users
WHERE email = 'john.doe@test.com';


-- =========================================================
-- 2. Verify wallet created for verified customer
-- =========================================================
SELECT
    w.id AS wallet_id,
    w.user_id,
    u.email,
    w.balance,
    w.status,
    w.created_at
FROM wallets w
JOIN users u ON u.id = w.user_id
WHERE u.email = 'john.doe@test.com';


-- =========================================================
-- 3. Verify only one wallet exists per customer
-- =========================================================
SELECT
    user_id,
    COUNT(*) AS wallet_count
FROM wallets
GROUP BY user_id
HAVING COUNT(*) > 1;


-- =========================================================
-- 4. Validate wallet balance after successful funding
-- Expected: balance should increase by funded amount
-- =========================================================
SELECT
    w.user_id,
    u.email,
    w.balance AS current_wallet_balance,
    t.amount AS funding_amount,
    t.status AS transaction_status,
    t.reference
FROM wallets w
JOIN users u ON u.id = w.user_id
JOIN transactions t ON t.user_id = u.id
WHERE u.email = 'john.doe@test.com'
  AND t.type = 'FUNDING'
  AND t.status = 'SUCCESSFUL'
ORDER BY t.created_at DESC;


-- =========================================================
-- 5. Verify failed funding did not credit wallet
-- Expected: transaction failed, no credit ledger entry
-- =========================================================
SELECT
    t.reference,
    t.amount,
    t.status,
    wl.entry_type,
    wl.amount AS ledger_amount
FROM transactions t
LEFT JOIN wallet_ledger wl ON wl.transaction_id = t.id
WHERE t.reference = 'FAILED_FUNDING_REFERENCE';


-- =========================================================
-- 6. Detect duplicate transaction references
-- Expected: no rows returned
-- =========================================================
SELECT
    reference,
    COUNT(*) AS reference_count
FROM transactions
GROUP BY reference
HAVING COUNT(*) > 1;


-- =========================================================
-- 7. Detect duplicate provider references
-- Expected: no rows returned
-- =========================================================
SELECT
    provider_reference,
    COUNT(*) AS provider_reference_count
FROM transactions
WHERE provider_reference IS NOT NULL
GROUP BY provider_reference
HAVING COUNT(*) > 1;


-- =========================================================
-- 8. Validate internal transfer debit and credit records
-- Expected: sender debit amount equals receiver credit amount
-- =========================================================
SELECT
    t.reference,
    t.amount AS transaction_amount,
    sender_entry.amount AS sender_debit,
    receiver_entry.amount AS receiver_credit,
    sender_entry.entry_type AS sender_entry_type,
    receiver_entry.entry_type AS receiver_entry_type
FROM transactions t
JOIN wallet_ledger sender_entry
    ON sender_entry.transaction_id = t.id
   AND sender_entry.entry_type = 'DEBIT'
JOIN wallet_ledger receiver_entry
    ON receiver_entry.transaction_id = t.id
   AND receiver_entry.entry_type = 'CREDIT'
WHERE t.reference = 'INTERNAL_TRANSFER_REFERENCE';


-- =========================================================
-- 9. Find unbalanced internal transfers
-- Expected: no rows returned
-- =========================================================
SELECT
    t.reference,
    SUM(CASE WHEN wl.entry_type = 'DEBIT' THEN wl.amount ELSE 0 END) AS total_debit,
    SUM(CASE WHEN wl.entry_type = 'CREDIT' THEN wl.amount ELSE 0 END) AS total_credit
FROM transactions t
JOIN wallet_ledger wl ON wl.transaction_id = t.id
WHERE t.type = 'INTERNAL_TRANSFER'
GROUP BY t.reference
HAVING
    SUM(CASE WHEN wl.entry_type = 'DEBIT' THEN wl.amount ELSE 0 END)
    <>
    SUM(CASE WHEN wl.entry_type = 'CREDIT' THEN wl.amount ELSE 0 END);


-- =========================================================
-- 10. Verify failed transaction did not affect wallet balance
-- =========================================================
SELECT
    t.reference,
    t.status,
    t.amount,
    wl.entry_type,
    wl.amount AS ledger_amount
FROM transactions t
LEFT JOIN wallet_ledger wl ON wl.transaction_id = t.id
WHERE t.reference = 'FAILED_TRANSACTION_REFERENCE';


-- =========================================================
-- 11. Verify external transfer reversal
-- Expected: reversal exists and links to original transaction
-- =========================================================
SELECT
    original.reference AS original_reference,
    original.amount AS original_amount,
    original.status AS original_status,
    reversal.reference AS reversal_reference,
    reversal.amount AS reversal_amount,
    reversal.status AS reversal_status,
    reversal.original_transaction_id
FROM transactions original
JOIN transactions reversal
    ON reversal.original_transaction_id = original.id
WHERE original.reference = 'FAILED_EXTERNAL_TRANSFER_REFERENCE'
  AND reversal.type = 'REVERSAL';


-- =========================================================
-- 12. Verify refund links to original transaction
-- =========================================================
SELECT
    original.reference AS original_reference,
    original.amount AS original_amount,
    refund.reference AS refund_reference,
    refund.amount AS refund_amount,
    refund.status AS refund_status,
    refund.original_transaction_id
FROM transactions original
JOIN transactions refund
    ON refund.original_transaction_id = original.id
WHERE original.reference = 'ORIGINAL_BILL_PAYMENT_REFERENCE'
  AND refund.type = 'REFUND';


-- =========================================================
-- 13. Validate refund amount matches original amount
-- Expected: no rows returned if amounts match
-- =========================================================
SELECT
    original.reference AS original_reference,
    original.amount AS original_amount,
    refund.reference AS refund_reference,
    refund.amount AS refund_amount
FROM transactions original
JOIN transactions refund
    ON refund.original_transaction_id = original.id
WHERE refund.type = 'REFUND'
  AND original.amount <> refund.amount;


-- =========================================================
-- 14. Check pending transactions older than expected threshold
-- Useful for operations review
-- =========================================================
SELECT
    reference,
    type,
    amount,
    status,
    created_at
FROM transactions
WHERE status = 'PENDING'
  AND created_at < NOW() - INTERVAL '30 minutes'
ORDER BY created_at ASC;


-- =========================================================
-- 15. Validate bill payment record
-- =========================================================
SELECT
    bp.id,
    bp.transaction_id,
    t.reference,
    t.amount,
    t.status,
    bp.biller,
    bp.customer_identifier,
    bp.provider_reference,
    bp.status AS bill_payment_status
FROM bill_payments bp
JOIN transactions t ON t.id = bp.transaction_id
WHERE t.reference = 'BILL_PAYMENT_REFERENCE';


-- =========================================================
-- 16. Detect duplicate bill payment provider references
-- Expected: no rows returned
-- =========================================================
SELECT
    provider_reference,
    COUNT(*) AS duplicate_count
FROM bill_payments
WHERE provider_reference IS NOT NULL
GROUP BY provider_reference
HAVING COUNT(*) > 1;


-- =========================================================
-- 17. Validate beneficiary ownership
-- =========================================================
SELECT
    b.id,
    b.user_id,
    u.email,
    b.beneficiary_name,
    b.account_number,
    b.bank_code
FROM beneficiaries b
JOIN users u ON u.id = b.user_id
WHERE u.email = 'john.doe@test.com';


-- =========================================================
-- 18. Detect duplicate beneficiaries for same customer
-- =========================================================
SELECT
    user_id,
    account_number,
    bank_code,
    COUNT(*) AS duplicate_count
FROM beneficiaries
GROUP BY user_id, account_number, bank_code
HAVING COUNT(*) > 1;


-- =========================================================
-- 19. Validate notification linked to transaction
-- =========================================================
SELECT
    n.id,
    n.user_id,
    u.email,
    n.transaction_id,
    t.reference,
    n.channel,
    n.status,
    n.created_at
FROM notifications n
JOIN users u ON u.id = n.user_id
LEFT JOIN transactions t ON t.id = n.transaction_id
WHERE t.reference = 'TRANSACTION_REFERENCE';


-- =========================================================
-- 20. Verify notification failure does not change transaction status
-- =========================================================
SELECT
    t.reference,
    t.status AS transaction_status,
    n.status AS notification_status,
    n.channel
FROM transactions t
JOIN notifications n ON n.transaction_id = t.id
WHERE t.reference = 'SUCCESSFUL_TRANSACTION_WITH_FAILED_NOTIFICATION';


-- =========================================================
-- 21. Validate audit logs for security-sensitive activity
-- =========================================================
SELECT
    id,
    user_id,
    action,
    entity_type,
    entity_id,
    created_at
FROM audit_logs
WHERE user_id = 'USER_ID_HERE'
ORDER BY created_at DESC;


-- =========================================================
-- 22. Validate failed login attempt audit trail
-- =========================================================
SELECT
    id,
    user_id,
    action,
    metadata,
    created_at
FROM audit_logs
WHERE action = 'FAILED_LOGIN'
ORDER BY created_at DESC;


-- =========================================================
-- 23. Validate unauthorized access attempt is logged
-- =========================================================
SELECT
    id,
    user_id,
    action,
    entity_type,
    metadata,
    created_at
FROM audit_logs
WHERE action = 'UNAUTHORIZED_ACCESS_ATTEMPT'
ORDER BY created_at DESC;


-- =========================================================
-- 24. Reconcile wallet balance with ledger balance
-- Expected: wallet balance should equal total credits - total debits
-- =========================================================
SELECT
    w.id AS wallet_id,
    w.user_id,
    w.balance AS wallet_balance,
    COALESCE(SUM(CASE WHEN wl.entry_type = 'CREDIT' THEN wl.amount ELSE 0 END), 0)
    -
    COALESCE(SUM(CASE WHEN wl.entry_type = 'DEBIT' THEN wl.amount ELSE 0 END), 0)
    AS calculated_ledger_balance
FROM wallets w
LEFT JOIN wallet_ledger wl ON wl.wallet_id = w.id
GROUP BY w.id, w.user_id, w.balance
HAVING
    w.balance <>
    COALESCE(SUM(CASE WHEN wl.entry_type = 'CREDIT' THEN wl.amount ELSE 0 END), 0)
    -
    COALESCE(SUM(CASE WHEN wl.entry_type = 'DEBIT' THEN wl.amount ELSE 0 END), 0);


-- =========================================================
-- 25. Find orphan ledger entries without transaction
-- Expected: no rows returned
-- =========================================================
SELECT
    wl.id,
    wl.wallet_id,
    wl.transaction_id,
    wl.entry_type,
    wl.amount
FROM wallet_ledger wl
LEFT JOIN transactions t ON t.id = wl.transaction_id
WHERE t.id IS NULL;


-- =========================================================
-- 26. Find transactions without ledger records
-- Review whether type should have ledger movement
-- =========================================================
SELECT
    t.id,
    t.reference,
    t.type,
    t.amount,
    t.status
FROM transactions t
LEFT JOIN wallet_ledger wl ON wl.transaction_id = t.id
WHERE wl.id IS NULL
  AND t.status = 'SUCCESSFUL'
  AND t.type IN ('FUNDING', 'INTERNAL_TRANSFER', 'EXTERNAL_TRANSFER', 'BILL_PAYMENT', 'REVERSAL', 'REFUND');


-- =========================================================
-- 27. Validate transfer limits for a user today
-- =========================================================
SELECT
    user_id,
    SUM(amount) AS total_transferred_today
FROM transactions
WHERE user_id = 'USER_ID_HERE'
  AND type IN ('INTERNAL_TRANSFER', 'EXTERNAL_TRANSFER')
  AND status = 'SUCCESSFUL'
  AND created_at::date = CURRENT_DATE
GROUP BY user_id;


-- =========================================================
-- 28. Find successful transfers above per-transaction limit
-- Expected: no rows returned
-- =========================================================
SELECT
    reference,
    user_id,
    amount,
    status,
    created_at
FROM transactions
WHERE type IN ('INTERNAL_TRANSFER', 'EXTERNAL_TRANSFER')
  AND status = 'SUCCESSFUL'
  AND amount > 50000;


-- =========================================================
-- 29. Find users exceeding daily transfer limit
-- Expected: no rows returned
-- =========================================================
SELECT
    user_id,
    SUM(amount) AS daily_transfer_total
FROM transactions
WHERE type IN ('INTERNAL_TRANSFER', 'EXTERNAL_TRANSFER')
  AND status = 'SUCCESSFUL'
  AND created_at::date = CURRENT_DATE
GROUP BY user_id
HAVING SUM(amount) > 200000;


-- =========================================================
-- 30. Validate transaction statuses distribution
-- Useful for test summary and metrics
-- =========================================================
SELECT
    status,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status
ORDER BY transaction_count DESC;
