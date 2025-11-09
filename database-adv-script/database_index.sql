-- ================================================================
-- database_index.sql
-- PostgreSQL script for testing performance BEFORE and AFTER indexes
-- Includes EXPLAIN ANALYZE and recommended indexing for Airbnb DB
-- ==============================================================

---------------------------------------------------------
-- 1. Check performance BEFORE creating indexes
---------------------------------------------------------

-- Query: Get bookings for a property and join with users
EXPLAIN ANALYZE
SELECT b.booking_id, b.property_id, b.start_date, b.end_date,
       u.user_id, u.full_name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.property_id = 1200;


-- Query: Count total bookings per property
EXPLAIN ANALYZE
SELECT property_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;


-- Query: Search properties by city
EXPLAIN ANALYZE
SELECT property_id, title, city, price
FROM properties
WHERE city = 'Addis Ababa';


---------------------------------------------------------
-- 2. Create Proper Indexes
---------------------------------------------------------

-- Index on bookings.property_id (improves filtering)
CREATE INDEX IF NOT EXISTS idx_bookings_property_id
ON bookings(property_id);

-- Index on bookings.user_id (speeds up join with users)
CREATE INDEX IF NOT EXISTS idx_bookings_user_id
ON bookings(user_id);

-- Index on properties.city (faster searching by location)
CREATE INDEX IF NOT EXISTS idx_properties_city
ON properties(city);

-- Index on properties.price (optional, helps with range queries)
CREATE INDEX IF NOT EXISTS idx_properties_price
ON properties(price);

-- Composite index for checking overlapping dates (optional)
CREATE INDEX IF NOT EXISTS idx_bookings_date_range
ON bookings(property_id, start_date, end_date);

-- Run analyze so PostgreSQL updates statistics
ANALYZE;


---------------------------------------------------------
-- 3. Check performance AFTER creating indexes
---------------------------------------------------------

-- Query 1
EXPLAIN ANALYZE
SELECT b.booking_id, b.property_id, b.start_date, b.end_date,
       u.user_id, u.full_name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.property_id = 1200;


-- Query 2
EXPLAIN ANALYZE
SELECT property_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;


-- Query 3
EXPLAIN ANALYZE
SELECT property_id, title, city, price
FROM properties
WHERE city = 'Addis Ababa';


---------------------------------------------------------
-- END OF FILE
---------------------------------------------------------
