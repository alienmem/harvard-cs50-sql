# Harvard CS50-SQL: Introduction to Databases

Harvard University's comprehensive introduction to databases using SQL. Learn to create, read, update, and delete data with relational databases while mastering design, optimization, and scaling techniques.

**Course Link:** [CS50-SQL Official Site](https://cs50.harvard.edu/sql/)  
**Instructor:** Carter Zenke  
**Status:** ✓ Completed

---

## Course Overview

This repository contains my complete coursework from Harvard's CS50-SQL. The course covers database fundamentals through hands-on problem sets based on real-world datasets, progressing from SQLite basics to enterprise-level database systems.

---

## Course Structure

| Week | Topic | Key Concepts | Folder |
|------|-------|--------------|--------|
| 0 | Querying | SELECT, LIMIT, WHERE, Pattern Matching, Aggregate Functions, DISTINCT | [week0-querying](week0-querying/) |
| 1 | Relating | Entity Relationship Diagrams, Primary/Foreign Keys, JOINs (INNER, LEFT, RIGHT), Subqueries, Set Operations | [week1-relating](week1-relating/) |
| 2 | Designing | Schemas, Normalizing, Data Types, Storage Classes, Table/Column Constraints, Altering Tables | [week2-designing](week2-designing/) |
| 3 | Writing | INSERT INTO, DELETE, UPDATE, Triggers, Soft Deletions, CSV Import | [week3-writing](week3-writing/) |
| 4 | Viewing | CREATE VIEW, Temporary Views, Common Table Expressions (CTEs), Views for Securing/Partitioning | [week4-viewing](week4-viewing/) |
| 5 | Optimizing | Indexes, EXPLAIN QUERY PLAN, B-Trees, Transactions, ACID Properties, Concurrency, Race Conditions | [week5-optimizing](week5-optimizing/) |
| 6 | Scaling | MySQL, PostgreSQL, Vertical/Horizontal Scaling, Replication, Sharding, SQL Injection Prevention | [week6-scaling](week6-scaling/) |

---

## Projects

### [Final Project](final-project/)
[Course capstone project - description to be added]

---

## What I Learned

- **Database Design** — Entity-relationship modeling, normalization (1NF, 2NF, 3NF), schema creation
- **Query Mastery** — Complex SELECT statements, subqueries, JOINs, CTEs, window functions
- **Data Manipulation** — INSERT, UPDATE, DELETE with triggers and constraints
- **Optimization** — Indexes (B-trees, covering, partial), query performance analysis, EXPLAIN QUERY PLAN
- **Transactions** — ACID properties, concurrency control, race condition prevention
- **Scaling** — Vertical/horizontal scaling, replication strategies, sharding techniques
- **Security** — SQL injection prevention, prepared statements, access controls
- **Enterprise Systems** — Transitioning from SQLite to MySQL and PostgreSQL

---

## Technologies

- **SQLite** — Course foundation, embedded database for portability
- **MySQL** — Enterprise-level relational database system
- **PostgreSQL** — Advanced open-source database with robust features
- **Python/Java** — Database connectivity and application integration

---

## Skills Demonstrated

- Relational database design from requirements to implementation
- Performance optimization through indexing strategies
- Transaction management and concurrent query handling
- Cross-platform database migration (SQLite → MySQL → PostgreSQL)
- SQL injection attack prevention
- Real-world data modeling and normalization
- Technical documentation and design communication

---

## Repository Structure
```
harvard-cs50-sql/
├── week0-querying/          # Fundamentals: SELECT, WHERE, aggregates
├── week1-relating/          # Relationships, JOINs, foreign keys
├── week2-designing/         # Schema design, constraints, types
├── week3-writing/           # INSERT, UPDATE, DELETE, triggers
├── week4-viewing/           # Views, CTEs, query abstraction
├── week5-optimizing/        # Indexes, transactions, concurrency
├── week6-scaling/           # MySQL, PostgreSQL, scaling strategies
├── sample-project/          # Practice implementation
├── mock-project/            # Tony's Titanic Titles
└── final-project/           # Course capstone
```

---

## Academic Integrity Note

These solutions represent my own work completed for educational purposes. If you're currently taking CS50-SQL, please attempt problems yourself first in accordance with Harvard's academic honesty policy.
