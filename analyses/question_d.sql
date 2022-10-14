/*
For each month, what is the probability Ms. Sandiego exhibits one of her three most occurring behaviors?
*/

WITH most_occuring_behaviors AS (
    SELECT
        behavior
    FROM
        {{ ref('fact_sight') }}
    GROUP BY
        behavior
    ORDER BY COUNT(*) DESC
    LIMIT 3
), most_occuring_behaviors_by_month AS (
    SELECT
        date_part('month', date) AS month,
        COUNT(*)
        FROM
            {{ ref('fact_sight') }}
        WHERE
            behavior IN (SELECT behavior FROM most_occuring_behaviors)
        GROUP BY
            date_part('month', date)
), all_sights_by_month AS (
    SELECT
        date_part('month', date) AS month,
        COUNT(*)
    FROM
        {{ ref('fact_sight') }}
    GROUP BY
        date_part('month', date)
)
SELECT
    TO_CHAR(TO_DATE (a.month::text, 'MM'), 'Month') AS month_name,
    CONCAT((b.count::decimal / a.count * 100)::text, '%') AS perc
FROM
    all_sights_by_month AS a
INNER JOIN
    most_occuring_behaviors_by_month AS b
    ON
        a.month = b.month
ORDER BY
    a.month