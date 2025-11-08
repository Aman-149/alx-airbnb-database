# Optimization Report

## Initial Observations
- Complex query joins Booking, User, Property, Payment.
- Potential inefficiencies: no selective WHERE clause in some cases, lack of indexes on start_date and user_id, repeated large joins.

## Actions Taken
1. Added indexes:
   - `idx_booking_startdate` on Booking(start_date)
   - `idx_booking_user` on Booking(user_id)
   - `idx_payment_booking` on Payment(booking_id)
2. Limited selected rows via date predicate (b.start_date >= '2025-01-01').
3. Ensured only necessary columns are selected in heavy queries.

## Refactored Query (example)
Use derived aggregation to reduce rows if necessary, or use EXISTS to filter:

```sql
SELECT b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
       u.user_id, u.first_name, u.last_name, u.email,
       p.property_id, p.name AS property_name,
       pay.payment_id, pay.amount, pay.payment_date, pay.payment_method
FROM Booking b
JOIN `User` u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2025-01-01'
  AND EXISTS (
    SELECT 1 FROM `User` u2 WHERE u2.user_id = b.user_id AND u2.role != 'admin'
  )
ORDER BY b.start_date DESC;

