WITH yearly_consumption AS (
    SELECT 
        e.state,
        p.year,
        p.population,
        CASE p.year
            WHEN 2000 THEN e.year_2000 WHEN 2001 THEN e.year_2001
            WHEN 2002 THEN e.year_2002 WHEN 2003 THEN e.year_2003
            WHEN 2004 THEN e.year_2004 WHEN 2005 THEN e.year_2005
            WHEN 2006 THEN e.year_2006 WHEN 2007 THEN e.year_2007
            WHEN 2008 THEN e.year_2008 WHEN 2009 THEN e.year_2009
            WHEN 2010 THEN e.year_2010 WHEN 2011 THEN e.year_2011
            WHEN 2012 THEN e.year_2012 WHEN 2013 THEN e.year_2013
            WHEN 2014 THEN e.year_2014 WHEN 2015 THEN e.year_2015
            WHEN 2016 THEN e.year_2016 WHEN 2017 THEN e.year_2017
            WHEN 2018 THEN e.year_2018 WHEN 2019 THEN e.year_2019
            WHEN 2020 THEN e.year_2020
        END AS total_consumption
    FROM energy_consumption e
    JOIN state_population p ON e.state = p.state
    WHERE e.msn = 'TETCB'
    AND e.state != 'US'
)
SELECT 
    state,
    year,
    total_consumption,
    population,
    ROUND((total_consumption / population) * 1000000, 2) AS mmbtu_per_person,
    RANK() OVER (PARTITION BY year ORDER BY (total_consumption / population) DESC) AS efficiency_rank
FROM yearly_consumption
WHERE total_consumption IS NOT NULL
ORDER BY state, year;