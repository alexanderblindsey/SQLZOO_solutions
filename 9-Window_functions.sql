-- 1. Show the lastName, party and votes for the constituency 'S14000024' in 2017.
SELECT lastName, party, votes
FROM ge
WHERE constituency='S14000024' AND yr=2017
ORDER BY votes DESC;



-- 2. Show the party and RANK foor the constituency S14000024 in 2017. List the output by party.
SELECT party,
	   votes,
       RANK () OVER (ORDER BY votes DESC) as position
FROM ge
WHERE constituency= 'S14000024' AND yr=2017
ORDER BY party;


/*
3.The 2015 election is a different PARTITION to the 2017 election. We only care about the order of votes for each year.
Use PARTITION to show the ranking of each party in S14000021 in each year. Include yr, party, votes and ranking (the party with the most votes is 1).
*/
SELECT yr,
	   party,
       votes,
       RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as position
FROM ge
WHERE constituency='S14000021'
ORDER BY party, yr



