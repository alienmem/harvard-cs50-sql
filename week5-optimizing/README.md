# Week 5: Optimizing

## Topics Covered

- **Indexes** — Data structures for faster queries
- **CREATE INDEX** — Building indexes on columns
- **EXPLAIN QUERY PLAN** — Analyzing query execution
- **Covering Indexes** — Indexes that contain all needed data
- **B-Trees** — How indexes are structured internally
- **Partial Indexes** — Indexes on subset of rows
- **VACUUM** — Reclaiming unused database space
- **Concurrency** — Handling multiple simultaneous operations
- **Transactions** — Grouping operations atomically
- **ACID Properties**
  - **Atomicity** — All or nothing execution
  - **Consistency** — Maintaining valid database state
  - **Isolation** — Concurrent transaction independence
  - **Durability** — Permanent committed changes
- **BEGIN TRANSACTION** — Starting transaction blocks
- **COMMIT** — Finalizing transactions
- **ROLLBACK** — Reverting failed transactions
- **Race Conditions** — Concurrent access problems
- **Locks** — Controlling concurrent access (shared vs. exclusive)

---

## Problem Sets

- In a Snap
- your.harvard

---

## Key Learnings

- Creating indexes to dramatically improve query performance
- Understanding when indexes help (and when they don't)
- Reading EXPLAIN QUERY PLAN output
- Trade-offs: index storage cost vs. query speed gains
- Implementing transactions for data integrity
- Preventing race conditions with proper locking
- Using VACUUM to optimize database size
- Understanding query execution plans

---

## Files

[Add your .sql solution files here]

---

## Resources

- [CS50 SQL Week 5 Lecture](https://cs50.harvard.edu/sql/weeks/5/)

