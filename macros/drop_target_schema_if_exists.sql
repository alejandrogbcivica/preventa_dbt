{% macro drop_target_schema_if_exists(dbs_list) %}
{% for db in dbs_list %}
{% set target_schema = api.Relation.create(database=db, schema=target.schema) %}
{{ drop_schema(target_schema) }}
{{
    log(
        "Borrado schema temporal " ~ target.schema ~ " de la base de datos " ~ db,
        info=true,
    )
}}
{% endfor %}
{% endmacro %}
