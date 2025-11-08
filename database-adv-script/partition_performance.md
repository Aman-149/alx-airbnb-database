# Partition Performance Report

## Approach
- Partitioned bookings by `YEAR(start_date)` to speed up queries filtering by year-range.
- Migrated existing Booking rows into partitioned table.

## Tests
- Query: SELECT * FROM Booking_partitioned WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';
- Measured using `EXPLAIN` and timing via client.

## Outcome (expected)
- Queries restricted to a single partition inspect fewer rows.
- Reduced I/O and improved response times on year-bounded queries.
- For wide-range queries spanning many years, impact is less pronounced.

## Notes
- Partitioning requires care with primary keys: composite primary key included `start_date`.
- Re-evaluate maintenance (ALTER, REORGANIZE PARTITION) strategy for production.

