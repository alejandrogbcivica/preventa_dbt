WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

budget AS (
    SELECT
          product_id
        , quantity as quantity_und
        , month
        
    FROM src_budget
    )

SELECT * FROM budget