"""
Prepare> SQL > Aggregation > Revising Aggregations - The Count Function
https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/
Query a count of the number of cities in CITY having a Population larger than 100,000.
"""

SELECT COUNT(id)
FROM CITY
WHERE population > 100000;

