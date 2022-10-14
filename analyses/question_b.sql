/*
Also for each month, what is the probability that Ms. Sandiego is armed AND wearing a jacket, but NOT a hat? What general observations about Ms. Sandiego can you make from this?
*/

-- A: Carmen could be more likely to use hat in November or use less a combination of weapon and jacket. On the other hand, Ms. Sandiego could be less likely to wear a hat on June, while also being armed and wearing a jacket.

WITH all_sights_by_month AS (
    SELECT
        date_part('month', date) AS month,
        COUNT(*)
    FROM
        {{ ref('fact_sight') }}
    GROUP BY
        date_part('month', date)
),
sights_of_weapon_and_jacket_but_not_hat_by_month AS (
    SELECT
        date_part('month', date) AS month,
        COUNT(*)
    FROM
        {{ ref('fact_sight') }}
    WHERE
        has_weapon  AND
        has_jacket  AND
        NOT has_hat
    GROUP BY
        date_part('month', date)
)
SELECT
    TO_CHAR(TO_DATE (a.month::text, 'MM'), 'Month') AS month_name,
    CONCAT((b.count::decimal / a.count * 100)::text, '%') AS perc
FROM
    all_sights_by_month AS a
INNER JOIN
    sights_of_weapon_and_jacket_but_not_hat_by_month AS b
    ON
        a.month = b.month
ORDER BY
    a.month