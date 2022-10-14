{% set source_table = "ASIA" %}
{% set source_columns = adapter.get_columns_in_relation(
    ref(source_table)
) %}
{% set target_schema = load_target_schema()['target_schema'] %}
-- If I needed to make any schema handling for a specify region, I could do here, changing target_schema

SELECT 
{% for col in source_columns %}
    {{ format_column(col.name, target_schema.types[loop.index0], target_schema.names[loop.index0]) }}
    {% if not loop.last %}
        ,
    {% endif %}
{% endfor %}
FROM
  {{ ref(source_table) }}

