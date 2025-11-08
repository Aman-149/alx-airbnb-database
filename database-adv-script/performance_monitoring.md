# Performance Monitoring & Refinement

## Commands
- Use `EXPLAIN <query>` to view the plan.
- Use `EXPLAIN ANALYZE <query>` in MySQL 8.0.18+ for actual timing.
- Use `SHOW PROFILE` (when enabled) for profiling.

## Steps
1. Identify slow queries (slow query log or application metrics).
2. Run EXPLAIN to see which indexes are used.
3. Add or adjust indexes.
4. Re-run EXPLAIN ANALYZE and compare.
5. Consider partitioning or schema refactor if needed.

## Common Fixes
- Add composite index for common multi-column WHERE clauses.
- Denormalize carefully for read-heavy patterns where normalization imposes heavy join cost.
- Use covering indexes to serve queries without touching the table.

