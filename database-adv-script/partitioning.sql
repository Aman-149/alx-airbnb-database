-- ============================================================
--  PARTITIONING THE BOOKING TABLE BY start_date (RANGE)
-- ============================================================

-- 1️⃣ Drop the old table safely (ONLY if allowed in the project)
-- Comment this out if your DB already contains data you don't want to delete.
DROP TABLE IF EXISTS Booking;

-- 2️⃣ Recreate the Booking table with RANGE PARTITIONING
CREATE TABLE Booking (
    booking_id      CHAR(36) PRIMARY KEY,
    property_id     CHAR(36),
    user_id         CHAR(36),
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    total_price     DECIMAL(10,2) NOT NULL,
    status          ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pFuture VALUES LESS THAN MAXVALUE
);

-- ============================================================
--  OPTIONAL: TESTING QUERY PERFORMANCE
-- ============================================================

-- Query BEFORE partitioning:
-- SELECT * FROM Booking WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Query AFTER partitioning:
EXPLAIN
SELECT *
FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- ============================================================
--  NOTES:
--  ✅ YEAR(start_date) allows clean yearly partitions.
--  ✅ pFuture partition catches all future dates.
-- ============================================================

