-- 2. When was Citizen Kane released?
SELECT yr 
FROM movie
WHERE title='Citizen Kane';



-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr ASC;



-- 4. What id number does the actor Glenn Close have?
SELECT id
FROM actor
WHERE name='Glenn Close';



-- 5. What is the id of the film Casablanca?
SELECT id
FROM movie
WHERE title='Casablanca';



-- 6. Obtain the cast list (names of all the actors) for Casablanca
SELECT actor.name
FROM actor
JOIN casting
ON actor.id=casting.actorid
WHERE casting.movieid=(SELECT id
                       FROM movie
                       WHERE title='Casablanca');
                       
                       
                       
-- 7. Obtain the cast list for the film 'Alien'
SELECT actor.name
FROM actor
JOIN casting
   ON actor.id=casting.actorid
WHERE casting.movieid=(SELECT id
                       FROM movie
                       WHERE title='Alien');
                       
                       
                   
-- 8. List the films in which 'Harrison Ford' has appeared
SELECT movie.title
FROM movie
JOIN casting
   ON movie.id=casting.movieid
JOIN actor
   ON actor.id=casting.actorid
WHERE actor.name='Harrison Ford';



-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. This is where casting position != 1
SELECT movie.title
FROM movie
JOIN casting
   ON movie.id=casting.movieid
JOIN actor
   ON actor.id=casting.actorid
WHERE actor.name='Harrison Ford' AND casting.ord!=1;



-- 10. List the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name
FROM movie
JOIN casting
   ON movie.id=casting.movieid
JOIN actor
   ON actor.id=casting.actorid
WHERE casting.ord=1 AND movie.yr='1962';



-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT movie.yr, COUNT(movie.title) as movie_count
FROM movie
	JOIN casting
	   ON movie.id=casting.movieid
JOIN actor
   ON actor.id=casting.actorid
WHERE actor.name='Rock Hudson'
GROUP BY movie.yr
HAVING movie_count>2



-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT movie.title, actor.name
FROM movie
JOIN casting 
   ON (movie.id=casting.movieid AND casting.ord=1)
JOIN actor 
   ON (casting.actorid=actor.id)
-- gives the title and leading actor for all films
WHERE casting.movieid IN (SELECT movieid
    			  FROM casting
			  WHERE actorid IN (SELECT id 
					    FROM actor 
					    WHERE name='Julie Andrews')
			 ) -- selects movieids associated with Julie Andrews
    
    

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT actor.name
FROM actor 
JOIN casting 
   ON  casting.actorid = actor.id
WHERE casting.ord=1
GROUP BY actor.name
HAVING COUNT(casting.movieid)>=15;



-- 14. List the films released in the year 1978 ordered by the nuymber of actors in the cast, then by title
SELECT movie.title, COUNT(casting.actorid) AS cast_count
FROM casting
JOIN movie 
   ON (movie.id=casting.movieid)
WHERE movie.yr=1978
GROUP BY movie.title
ORDER BY cast_count DESC



-- 15. List all the people who have worked with 'Art Garfunkel'.
with t1 AS (SELECT movie.title AS ag_movies,
	           actor.name
	    FROM movie
	    JOIN casting 
	       ON (casting.movieid=movie.id)
	    JOIN actor 
	       ON (casting.actorid=actor.id)
	    WHERE actor.name='Art Garfunkel')
	-- t1 gives all movies with Art Garfunkel 

SELECT actor.name
FROM actor
JOIN casting 
   ON (casting.actorid=actor.id)
JOIN movie
    ON (casting.movieid=movie.id)
WHERE actor.name != 'Art Garfunkel' 
	AND movie.title IN (SELECT ag_movies
            		    FROM t1) 
