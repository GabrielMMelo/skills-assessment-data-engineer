{% macro format_column(source_column_name, target_column_type, target_column_name) %}
    "{{source_column_name}}"::{{target_column_type}} AS {{ target_column_name }}
{% endmacro %}


{% macro load_target_schema() %}
  {% set yml_str %}
    target_schema:
      names: ["date_witness", "date_agent", "witness", "agent", "latitude", "longitude", "city", "country", "city_agent", "has_weapon", "has_hat", "has_jacket", "behavior"]
      types: ["date", "date", "varchar(255)", "varchar(255)", "float", "float", "varchar(255)", "varchar(255)", "varchar(255)", "boolean", "boolean", "boolean", "varchar(255)"]
  {% endset %}
  {% set conf_yml = fromyaml(yml_str) %}
  {{ return(conf_yml) }}
{% endmacro %}