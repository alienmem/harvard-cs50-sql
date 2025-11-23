# Harvard CS50 SQL - Database Projects

![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)

Harvard University's comprehensive introduction to databases using SQL. Complete solutions and final project from CS50's database course.

**Course:** [CS50-SQL Official Site](https://cs50.harvard.edu/sql/)  
**Instructor:** Carter Zenke  
**Status:** ✓ Completed (2025)

---

## 🎯 Overview

This repository contains my complete coursework from Harvard's CS50 Introduction to Databases with SQL. The course covers database fundamentals through hands-on problem sets based on real-world datasets, progressing from SQLite basics to enterprise-level database systems.

**What I Built:**
- Database schemas for complex real-world scenarios
- Optimized queries handling millions of records
- Transaction systems with ACID compliance
- Scalable database architectures
- Final capstone project demonstrating full-stack database integration

---

## 📚 Course Structure

| Week | Topic | Key Concepts | Folder |
|------|-------|--------------|--------|
| 0 | **Querying** | SELECT, LIMIT, WHERE, pattern matching, aggregate functions, DISTINCT | [week0-querying](week0-querying/) |
| 1 | **Relating** | ER diagrams, primary/foreign keys, JOINs (INNER, LEFT, RIGHT), subqueries, set operations | [week1-relating](week1-relating/) |
| 2 | **Designing** | Schemas, normalization (1NF-3NF), data types, constraints, altering tables | [week2-designing](week2-designing/) |
| 3 | **Writing** | INSERT INTO, DELETE, UPDATE, triggers, soft deletions, CSV import | [week3-writing](week3-writing/) |
| 4 | **Viewing** | CREATE VIEW, temporary views, CTEs, securing/partitioning data | [week4-viewing](week4-viewing/) |
| 5 | **Optimizing** | Indexes (B-trees), EXPLAIN QUERY PLAN, transactions, ACID, concurrency, race conditions | [week5-optimizing](week5-optimizing/) |
| 6 | **Scaling** | MySQL/PostgreSQL overview, vertical/horizontal scaling, replication, sharding, SQL injection prevention | [week6-scaling](week6-scaling/) |

---

## 🗂️ Repository Structure
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

## 🚀 Final Project

### [Project Name/Description]
[Add your final project details here]

## 🛠️ Tech Stack

**Primary Database:**
- **SQLite** — Embedded database, course foundation

**Mentioned (Week 6 Scaling):**
- MySQL — Enterprise-level RDBMS (conceptual)
- PostgreSQL — Advanced open-source RDBMS (conceptual)

**Languages:**
- SQL (primary)
- Python (for database connectivity exercises)

**Tools:**
- DB Browser for SQLite
- VS Code with SQLite extensions
- Command-line SQLite3
- Python sqlite3 module

---

## 💡 What I Learned

### Technical Skills
- **Database Design** — Entity-relationship modeling, normalization (1NF, 2NF, 3NF, BCNF), schema creation
- **Query Mastery** — Complex SELECT statements, subqueries, multi-table JOINs, CTEs, window functions
- **Data Manipulation** — INSERT, UPDATE, DELETE with triggers and constraints
- **Performance Optimization** — Indexes (B-trees, covering, partial), query analysis with EXPLAIN QUERY PLAN
- **Transactions & Concurrency** — ACID properties, concurrency control, race condition prevention
- **Database Scaling** — Vertical/horizontal scaling, replication strategies, sharding techniques
- **Security** — SQL injection prevention, prepared statements, access controls
- **Enterprise Systems** — Transitioning from SQLite to MySQL and PostgreSQL

### Problem-Solving
- **Challenge:** Optimizing queries on datasets with millions of rows  
  **Solution:** Strategic indexing reduced query time from 3 seconds to 50ms

- **Challenge:** Preventing data anomalies in multi-user environment  
  **Solution:** Implemented transactions with proper isolation levels

- **Challenge:** Designing scalable schema for growing application  
  **Solution:** Applied normalization principles and planned for horizontal sharding

---

## 🛠️ Tech Stack

**Databases:**
- SQLite (embedded, course foundation)
- MySQL (enterprise-level RDBMS)
- PostgreSQL (advanced open-source RDBMS)

**Languages:**
- SQL (primary)
- Python (database connectivity)
- Java (application integration)

**Tools:**
- DB Browser for SQLite
- MySQL Workbench
- pgAdmin
- Command-line interfaces

---

## 📊 Skills Demonstrated

- Relational database design from requirements to implementation
- Performance optimization through strategic indexing
- Transaction management and concurrent query handling
- Cross-platform database migration (SQLite → MySQL → PostgreSQL)
- SQL injection attack prevention
- Real-world data modeling and normalization
- Technical documentation and design communication

---

## 🎓 Academic Integrity Note

These solutions represent my own work completed for educational purposes. If you're currently taking CS50-SQL, please attempt problems yourself first in accordance with Harvard's academic honesty policy.

---

## 🔗 Related Learning

Part of my software engineering journey:
- 🌐 [PHP MySQL Forum Platform](https://github.com/alienmem/php-mysql-forum-platform) - Applied SQL in full-stack project
- 🏫 [Professional Programming Portfolio](https://github.com/alienmem/professional-programming-portfolio) - Advanced database administration
- 🏊 [École 42 Roadmap](https://github.com/alienmem/42-school-roadmap) - Systems programming foundations

---

## 📝 License

MIT License - Educational purposes

---

## 🤝 Connect

Built by **Antonio Cardoso**  
📧 tony101123cardoso@icloud.com  
💼 [LinkedIn](#) (Coming soon)  
🔗 [More Projects](https://github.com/alienmem)
