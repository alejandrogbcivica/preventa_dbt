{% macro drop_temporal_schema_ci_cd(environment) %}


{% set show_db %}
show databases like '%{{ environment }}%'
{% endset %}

{% set show_db = run_query(show_db) %}

{% set name_db %}
select "name" as database_name from table(result_scan(last_query_id()))
{% endset %}

{% set get_db_names = run_query(name_db) %}

{% if execute %} {% set results_list = get_db_names.columns[0].values() %} {% endif %}

{% for db in results_list %}

{% set target_schema = api.Relation.create(database=db, schema=target.schema) %}

{{ drop_schema(target_schema) }}

{% endfor %} {{ log("Dropped schema " ~ {{target_schema}} ~ "from database "  ~ db, info = true) }}

{% endmacro %}
