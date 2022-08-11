"""
Prepare > SQL > Basic > Select > Revising the Select Query I
https://www.hackerrank.com/challenges/revising-the-select-query/
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
The CITY table is described as follows:
"""

SELECT *
FROM CITY
WHERE population > 100000 AND countrycode = 'USA'
