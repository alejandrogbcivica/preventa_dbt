WITH src_events AS (
    SELECT * 
    FROM {{ source('heroku_postgres_events', 'events') }}
    ),

events_renamed AS (
    SELECT
         event_id
        ,page_url as pagina_url
        ,event_type as tipo_evento
        ,user_id
        ,product_id
        ,session_id
        ,cast(created_at as date) as creado_el
        ,order_id

    FROM src_events
    )

SELECT * FROM events_renamed