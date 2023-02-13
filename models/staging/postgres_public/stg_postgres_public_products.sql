{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (

    SELECT *

    FROM {{ source('postgres_public', 'products') }}

    ),

products_renamed AS (

    SELECT
          product_id 
        , price as precio_euros
        , name as producto_desc
        , inventory as und_stock

    FROM src_products

    )



SELECT * FROM products_renamed 