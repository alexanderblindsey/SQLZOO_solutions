-- 1. Show the total population of the world.
SELECT SUM(population)
FROM world;



-- 2. List all the continents - just once each.
SELECT DISTINCT continent
FROM world;



-- 3. Give total GDP of Africa.
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';



-- 4. How many countries have an area of at least 1000000?
SELECT COUNT(name)
FROM world
WHERE area > 1000000;



-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');



-- 6. For each continent show the continent and number of countries.
SELECT DISTINCT continent, COUNT(name)
FROM world
GROUP BY continent;



-- 7. For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name)
FROM world
WHERE population>=10000000
GROUP BY continent;



-- 8. List the continents that have a total population of at least 100 million.
WITH t1 AS (SELECT continent, SUM(population) as sum_pop
            FROM world
            GROUP BY continent
            HAVING sum_pop>100000000 # HAVING goes after aggregator GROUP BY, where WHERE goes before. 
            )
SELECT continent
FROM t1;
