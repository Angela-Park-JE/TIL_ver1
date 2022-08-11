"""
Prepare > SQL > Basic > Select > Revising the Select Query I
https://www.hackerrank.com/challenges/revising-the-select-query/
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
The CITY table is described as follows:
"""

SELECT *
FROM CITY
WHERE population > 100000 AND countrycode = 'USA'


"""
Prepare > SQL > Basic > Select > Revising the Select Query II
https://www.hackerrank.com/challenges/revising-the-select-query-2/
Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
The CITY table is described as follows:
"""

SELECT name
FROM CITY
WHERE population > 120000 AND countrycode = 'USA'
