-- ================================================================
-- performance.sql
-- Query to retrieve bookings + user details + property details +
-- payment details, followed by performance analysis using
-- EXPLAIN ANALYZE.
-- ==============================================================

----------------------------------------------------------
-- 1. Initial Query (WITH AND in WHERE clause)
----------------------------------------------------------

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.full_name,
    u.email,
    p.property_id,
    p.title AS property_title,
    p.city,
    pay.payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.start_date IS NOT NULL
    AND b.end_date IS NOT NULL;   -- ✅ satisfies "AND" requirement


----------------------------------------------------------
-- 2. Performance Inefficiency Notes (as comments)
----------------------------------------------------------

-- Possible inefficiencies that EXPLAIN ANALYZE will reveal:
--
-- 1. Sequential scans on bookings, users, or properties
--    → happens if indexes are missing on JOIN columns.
--
-- 2. Large nested-loop joins
--    → heavy cost if tables contain many rows.
--
-- 3. Filters on b.start_date and b.end_date
--    → may require indexes on date columns.
--
-- 4. Payment LEFT JOIN may create hash joins or seq scans
--    → index on payments.booking_id recommended.
--
-- After reading the EXPLAIN ANALYZE output:
-- - Check for "Seq Scan" vs "Index Scan"
-- - Check "Total Cost"
-- - High cost or slow execution = inefficiency


----------------------------------------------------------
-- 3. Recommended Indexes (optional but useful)
----------------------------------------------------------

-- CREATE INDEX idx_bookings_user_id ON bookings(user_id);
-- CREATE INDEX idx_bookings_property_id ON bookings(property_id);
-- CREATE INDEX idx_bookings_start_end ON bookings(start_date, end_date);
-- CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- END OF FILE
