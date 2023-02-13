{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (

    SELECT *

    FROM {{ source('postgres_public', 'order_items') }}

    ),

orders_items_renamed AS (

    SELECT
          order_id 
        , product_id 
        , quantity as cantidad
       

    FROM src_order_items

    )



SELECT * FROM orders_items_renamed 