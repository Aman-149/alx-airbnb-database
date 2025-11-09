-- ==============================================================
-- SQL Script for Creating Indexes and Measuring Query Performance
-- ==============================================================


-- ✅ 1. Measure performance BEFORE adding indexes
EXPLAIN QUERY PLAN
SELECT *
FROM bookings
WHERE property_id = 10;


EXPLAIN QUERY PLAN
SELECT *
FROM properties
WHERE host_id = 5;


-- ✅ 2. Create indexes to optimize common lookups

-- Index on property_id because bookings are frequently queried by property
CREATE INDEX IF NOT EXISTS idx_bookings_property_id
ON bookings(property_id);

-- Index on host_id because properties are frequently filtered by host
CREATE INDEX IF NOT EXISTS idx_properties_host_id
ON properties(host_id);

-- Optional: index on date for faster date range filtering
CREATE INDEX IF NOT EXISTS idx_bookings_booking_date
ON bookings(booking_date);


-- ✅ 3. Measure performance AFTER adding indexes
EXPLAIN QUERY PLAN
SELECT *
FROM bookings
WHERE property_id = 10;


EXPLAIN QUERY PLAN
SELECT *
FROM properties
WHERE host_id = 5;


-- ✅ 4. Optional: analyze performance using ANALYZE (if supported)
ANALYZE;
