/*
For each month, which agency region is Carmen Sandiego most likely to be found?
*/

WITH sight_with_location AS (
  SELECT *
  FROM {{ ref('fact_sight') }} fact
  INNER JOIN
    {{ ref('dim_sight_location') }} dim
    ON
        fact.city = dim.city
)
SELECT
    TO_CHAR(TO_DATE (month::text, 'MM'), 'Month') AS month_name,
    agency_region as agency_region_most_likely_to_find
FROM (
    SELECT 
        month,
        agency_region,
        RANK() OVER (PARTITION BY month ORDER BY qtt DESC) AS rank
    FROM (
        SELECT
            date_part('month', date) AS month,
            associated_hq as agency_region,
            COUNT(*) as qtt
        FROM
            sight_with_location
        GROUP BY
            date_part('month', date),
            associated_hq
    ) AS sights_by_month_and_agency_region
) AS ranked_agencies_with_sights_by_month
WHERE
    rank = 1
ORDER BY
    month