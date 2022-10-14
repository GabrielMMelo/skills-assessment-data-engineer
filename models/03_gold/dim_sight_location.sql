SELECT
    city,
    country AS country_code,
    latitude,
    longitude,
    city_agent AS associated_hq
FROM
  {{ ref('vw_tmp_all_regions') }}
GROUP BY
    city,
    country,
    latitude,
    longitude,
    city_agent
    