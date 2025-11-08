# Index Performance Notes

## Baseline
- Run `EXPLAIN FORMAT=JSON` on heavy queries before indexes.

## Indexes added
- `idx_booking_startdate` on Booking(start_date)
- `idx_booking_user` on Booking(user_id)
- `idx_property_location` on Property(location)
- `idx_payment_booking` on Payment(booking_id)

## Test method
- Use `EXPLAIN`/`EXPLAIN ANALYZE` to compare "rows" and "execution time" before vs after.
- Example:
  - Before: `EXPLAIN` shows type="ALL" (full table scan)
  - After: `EXPLAIN` shows type="range" or "ref" and key used.

## Result summary
- Indexes on filter and join columns typically reduced scanned rows significantly.
- Be careful: too many indexes slow writes; monitor trade-offs.

