-- joins_queries.sql

-- 1) INNER JOIN: retrieve all bookings with the users who made them
SELECT b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
       u.user_id, u.first_name, u.last_name, u.email
FROM Booking b
INNER JOIN `User` u ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- 2) LEFT JOIN: retrieve all properties and their reviews (include properties with no reviews)
SELECT p.property_id, p.name, p.location, r.review_id, r.rating, r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY p.name;

-- 3) FULL OUTER JOIN behavior in MySQL (simulate using UNION of LEFT and RIGHT)
-- MySQL doesn't support FULL OUTER JOIN directly; simulate:
SELECT u.user_id, u.first_name, b.booking_id, b.total_price
FROM `User` u
LEFT JOIN Booking b ON u.user_id = b.user_id

UNION

SELECT u.user_id, u.first_name, b.booking_id, b.total_price
FROM Booking b
LEFT JOIN `User` u ON b.user_id = u.user_id;
