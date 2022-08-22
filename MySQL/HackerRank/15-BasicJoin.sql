"""
Prepare> SQL> Basic Join> Population Census
https://www.hackerrank.com/challenges/asian-population/
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
"""

/*- MySQL -*/
SELECT SUM(c.population)
FROM CITY c 
    LEFT JOIN COUNTRY 
    r ON c.countrycode = r.code 
WHERE r.continent = 'Asia';



"""
Prepare> SQL> Basic Join> African Cities
https://www.hackerrank.com/challenges/african-cities/
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
"""

/*- MySQL -*/
SELECT c.name
FROM CITY c JOIN COUNTRY r ON c.countrycode = r.code
WHERE r.continent = 'Africa';



"""
Prepare> SQL> Basic Join> Average Population of Each Continent
https://www.hackerrank.com/challenges/average-population-of-each-continent/
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) 
and their respective average city populations (CITY.Population) rounded down to the nearest integer.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
"""

/*- MySQL : floor 같은 것은 완전히 버림이라 몇 째 자리에서 버리라는지 쓸 수 없었다 -*/
SELECT r.continent, floor(AVG(c.population))
FROM CITY c JOIN COUNTRY r ON c.countrycode = r.code
GROUP BY r.continent;
