-- perfomance.sql
-- Complex query retrieving bookings with user, property, and payment info

SELECT b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
       u.user_id, u.first_name, u.last_name, u.email,
       p.property_id, p.name AS property_name, p.location,
       pay.payment_id, pay.amount, pay.payment_date, pay.payment_method
FROM Booking b
LEFT JOIN `User` u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2025-01-01'
ORDER BY b.start_date DESC;

