-- Assignment 6. Look for questions in Udemy iteself (very big to write!!)

SELECT name , total_supply,  
CASE 
	WHEN total_supply < 20000 THEN 'LOW'
	WHEN total_supply BETWEEN 20000 AND 50000 THEN 'ENOUGH'
	WHEN total_supply > 50000 THEN 'FULL'
	END AS category

FROM (
SELECT name, SUM(supply) as total_supply FROM fruit_imports
GROUP BY name) AS s


-- Assignment 6. Look for questions in Udemy iteself (very big to write!!)

SELECT season, SUM(supply*cost_per_unit) AS total_cost FROM fruit_imports
GROUP BY season; -- Transpose this output

SELECT SUM(CASE WHEN season = 'All Year' THEN supply*cost_per_unit ELSE 0 END) AS all_year,
SUM(CASE WHEN season = 'Winter' THEN supply*cost_per_unit ELSE 0 END) AS Winter,
SUM(CASE WHEN season = 'Spring' THEN supply*cost_per_unit ELSE 0 END) AS Spring,
SUM(CASE WHEN season = 'Summer' THEN supply*cost_per_unit ELSE 0 END) AS Summer,
SUM(CASE WHEN season = 'Fall' THEN supply*cost_per_unit ELSE 0 END) AS Fall

FROM fruit_imports









