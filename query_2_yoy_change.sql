SELECT 
    state,
    msn,
    year,
    consumption,
    LAG(consumption) OVER (PARTITION BY state, msn ORDER BY year) AS prior_year,
    ROUND(
        ((consumption - LAG(consumption) OVER (PARTITION BY state, msn ORDER BY year)) 
        / NULLIF(LAG(consumption) OVER (PARTITION BY state, msn ORDER BY year), 0)) * 100
    , 2) AS yoy_pct_change
FROM (
    SELECT state, msn, 
        unnest(ARRAY[2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,
                     2011,2012,2013,2014,2015,2016,2017,2018,2019,2020]) AS year,
        unnest(ARRAY[year_2000,year_2001,year_2002,year_2003,year_2004,year_2005,
                     year_2006,year_2007,year_2008,year_2009,year_2010,year_2011,
                     year_2012,year_2013,year_2014,year_2015,year_2016,year_2017,
                     year_2018,year_2019,year_2020]) AS consumption
    FROM energy_consumption
    WHERE state = 'TX'
    AND msn IN ('TERCB','TECCB','TEICB')
) sub
ORDER BY msn, year;