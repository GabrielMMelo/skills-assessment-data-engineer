/*
What are the three most occuring behaviors of Ms. Sandiego?
*/

SELECT
    behavior as most_occuring_behaviors
FROM
    {{ ref('fact_sight') }}
GROUP BY
    behavior
ORDER BY COUNT(*) DESC
LIMIT 3
