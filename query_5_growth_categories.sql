WITH endpoints AS (
    SELECT
        state,
        year_2000 AS consumption_2000,
        year_2020 AS consumption_2020
    FROM energy_consumption
    WHERE msn = 'TETCB'
    AND state != 'US'
)
SELECT
    state,
    consumption_2000,
    consumption_2020,
    ROUND(consumption_2020 - consumption_2000, 2) AS absolute_change,
    ROUND(((consumption_2020 - consumption_2000) / NULLIF(consumption_2000, 0)) * 100, 2) AS pct_change,
    CASE
        WHEN consumption_2020 > consumption_2000 * 1.15 THEN 'High Growth'
        WHEN consumption_2020 < consumption_2000 * 0.85 THEN 'Declining'
        ELSE 'Stable'
    END AS growth_category
FROM endpoints
ORDER BY pct_change DESC;
