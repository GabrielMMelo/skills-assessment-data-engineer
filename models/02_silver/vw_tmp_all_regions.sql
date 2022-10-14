{% set regions = ["vw_africa", "vw_america", "vw_asia", "vw_atlantic", "vw_australia", "vw_europe", "vw_indian", "vw_pacific"] %}

{% for region in regions %}
SELECT
    *
FROM
    {{ ref(region) }}
{% if not loop.last %}
UNION
{% endif %}
{% endfor %}