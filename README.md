# Public Transportation Analytics

## Business Problem
Urban public transport operators such as TransJakarta need insights into passenger demand, corridor utilization, and peak-hour congestion to optimize fleet allocation and service frequency, particularly on high-demand corridors such as Corridor 9.

## Dataset
(To be added)

## Analysis Approach
- SQL-based analysis for aggregation, ranking, and trend analysis
- Business metric–driven exploration
- Dashboard visualization using Tableau

## Key Business Questions
- What is the monthly passenger trend?
- Which routes have the highest utilization rate?
- When does peak traffic occur?
- Are there any underutilized routes?

## Tools Used
- PostgreSQL
- SQL
- Tableau Public
- Python (Pandas)

## Database Setup
This project uses PostgreSQL as the primary analytical database.
Database credentials are managed via environment variables and are not committed to the repository.

### Date Handling
All timestamps are stored in ISO-8601 format (YYYY-MM-DD) in the database
to ensure consistency and avoid locale-dependent issues.
Date formatting is applied only at the presentation layer.
