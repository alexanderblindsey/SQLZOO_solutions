-- 1. Show matchid, player for all goals scored by Germany.
SELECT matchid, player
FROM goal
WHERE teamid='GER';



-- 2. Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = (SELECT matchid 
	    FROM goal # brings up game 1012
            WHERE player LIKE '%Bender');
            
            
            
/* 
3. You can combine the above two steps with a single JOIN query. 
Show the player, teamid, stadium and mdate for every German goal.
*/
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE teamid='GER';



-- 4. Show the team1, team2 and player for every goal scored by a player called Mario
SELECT team1, team2, player
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE player LIKE 'Mario%';



-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
FROM eteam JOIN goal ON (eteam.id=goal.teamid)
WHERE gtime<=10;



-- 6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game JOIN eteam ON (game.team1=eteam.id)
WHERE coach='Fernando Santos';



-- 7. Show every player that has scored in a game played in 'National Stadium, Warsaw'.
SELECT player
FROM goal JOIN game ON (goal.matchid=game.id)
WHERE stadium = 'National Stadium, Warsaw';



-- 8. Show the name of all players who have scored against Germany
SELECT DISTINCT player
  FROM goal 
  JOIN game ON (goal.matchid=game.id)
  WHERE teamid != 'GER' AND 
  	(team1='GER' OR
  	 team2='GER');
     
     
  
-- 9. Show teamname nd the total number of goals scored
SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname;
  
  
  
-- 10. Show the stadium and number of goals scored in each stadium
SELECT stadium, COUNT(player) as total_goals
FROM game JOIN goal ON (game.id=goal.matchid)
GROUP BY stadium;


-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
WITH t1 AS (SELECT matchid, mdate
	    FROM goal 
            JOIN game ON (goal.matchid=game.id)
	    WHERE team1='POL' OR team2='POL');

SELECT matchid, mdate, count(matchid)
FROM t1
GROUP BY (matchid);

-- alternative answer
SELECT goal.matchid, game.mdate, COUNT(*)
FROM goal
JOIN game ON (goal.matchid=game.id)
WHERE (game.team1='POL' OR game.team2='POL')
GROUP BY goal.matchid, game.mdate;



-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT goal.matchid, game.mdate, COUNT(*)
FROM goal
JOIN game ON (game.id=goal.matchid)
WHERE goal.teamid='GER'
GROUP BY goal.matchid, game.mdate;



-- 13. List every match with the goals scored by each team. Show mdate, team1, score1, team2, score2. Sort your result by mdate, matchid, team1 and team2
WITH t1 AS (SELECT game.mdate, game.team1,
	    CASE WHEN goal.teamid=game.team1 THEN 1 ELSE 0 END score1, -- when goal.teamid=game.team1, then fill 1 in new column. Else, fill 0. Name column "score1" 
	    game.team2, 
	    CASE WHEN goal.teamid=game.team2 THEN 1 ELSE 0 END score2, 
	    game.id
	    FROM game
            JOIN goal ON (matchid = id));

SELECT mdate,
       team1, 
       SUM(score1) AS score1,
       team2,
       SUM(score2) AS score2
FROM t1
GROUP BY id
ORDER BY mdate ASC, id ASC;
