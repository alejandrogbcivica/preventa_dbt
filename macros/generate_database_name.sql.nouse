{% macro generate_database_name(custom_database_name=none, node=none) -%}
{%- set default_database = target.database -%}
{% if custom_database_name is not none %}
{%- if target.name == "dev" -%} dev_demo_{{ custom_database_name | trim }}_db
{%- elif target.name == "ci/cd" -%} dev_demo_{{ custom_database_name | trim }}_db
{%- elif target.name == "pre" -%} pre_demo_{{ custom_database_name | trim }}_db
{%- elif target.name == "pro" -%} pro_demo_{{ custom_database_name | trim }}_db
{%- else -%} {{ target.database }}_demo_{{ custom_database_name | trim }}_db
{%- endif -%}
{%- else -%} {{ default_database }}
{%- endif -%}
{%- endmacro %}
