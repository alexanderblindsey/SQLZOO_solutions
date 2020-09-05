-- 1. How many stops are in the database.
SELECT COUNT(id)
FROM stops;



-- 2. Find the id value for the stop 'Craiglockhart'.
SELECT id
FROM stops
WHERE name='Craiglockhart';



-- 3. 
SELECT id, name
FROM stops
JOIN route 
  ON (route.stop=stops.id)
WHERE route.num='4' 
  AND route.company='LRT'
