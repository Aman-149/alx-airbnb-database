-- ============================================
-- Aggregations and Window Functions Project
-- ============================================

-- ✅ 1. Total number of bookings per property
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings
FROM properties p
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY total_bookings DESC;


-- ✅ 2. Average price per property
SELECT
    p.id AS property_id,
    p.name AS property_name,
    AVG(p.price_per_night) AS average_price
FROM properties p
GROUP BY p.id, p.name
ORDER BY average_price DESC;


-- ✅ 3. Number of bookings per host
SELECT 
    h.id AS host_id,
    h.name AS host_name,
    COUNT(b.id) AS bookings_count
FROM hosts h
LEFT JOIN properties p 
    ON h.id = p.host_id
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY h.id, h.name
ORDER BY bookings_count DESC;


-- ✅ 4. Window Function:
-- Rank properties by total number of bookings using ROW_NUMBER()
SELECT
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY total_bookings DESC;


-- ✅ 5. Window Function:
-- Rank properties using RANK()
SELECT
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS rank_position
FROM properties p
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY total_bookings DESC;


-- ✅ 6. Window Function:
-- Rank properties using DENSE_RANK()
SELECT
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    DENSE_RANK() OVER (ORDER BY COUNT(b.id) DESC) AS dense_rank_position
FROM properties p
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY total_bookings DESC;


-- ✅ 7. Running total of bookings (cumulative sum)
SELECT
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    SUM(COUNT(b.id)) OVER (ORDER BY p.id) AS running_total
FROM properties p
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY p.id;


-- ✅ 8. Percentage of total bookings per property
WITH booking_totals AS (
    SELECT 
        p.id AS property_id,
        p.name AS property_name,
        COUNT(b.id) AS total_bookings
    FROM properties p
    LEFT JOIN bookings b 
        ON p.id = b.property_id
    GROUP BY p.id, p.name
)
SELECT
    property_id,
    property_name,
    total_bookings,
    ROUND(
        (total_bookings * 100.0 / SUM(total_bookings) OVER ()), 
    2) AS booking_percentage
FROM booking_totals
ORDER BY booking_percentage DESC;
