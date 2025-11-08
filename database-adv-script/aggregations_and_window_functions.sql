-- aggregations_and_window_functions.sql

-- 1) Total number of bookings made by each user
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM `User` u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- 2) Rank properties by number of bookings using window function
SELECT property_id, name, total_bookings,
       RANK() OVER (ORDER BY total_bookings DESC) AS ranking
FROM (
  SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings
  FROM Property p
  LEFT JOIN Booking b ON p.property_id = b.property_id
  GROUP BY p.property_id, p.name
) q
ORDER BY total_bookings DESC;

