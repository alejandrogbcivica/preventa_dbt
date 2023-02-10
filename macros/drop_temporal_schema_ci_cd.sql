{% macro drop_temporal_schema_ci_cd(environment) %}


{% set results %}
show databases like '%{{ environment }}%'
{% endset %}

{% set show_db = run_query(results) %}

{% set get_db_names = run_query(
    'select "name" as DATABASE_NAME from table(result_scan(last_query_id()))'
) %}

{% if execute %} {% set results_list = get_db_names.columns[0].values() %} {% endif %}

{% for db in results_list %}

{% set target_schema = api.Relation.create(database=db, schema=target.schema) %}

{{ drop_schema(target_schema) }}

{% endfor %} {{ log("Dropped schema " ~ target.schema ~ "from database "  ~ target.database, info = true) }}

{% endmacro %}
