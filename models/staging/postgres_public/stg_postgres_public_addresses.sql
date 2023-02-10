{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (

    SELECT *

    FROM {{ source('postgres_public', 'addresses') }}

    ),

addresses_renamed AS (

    SELECT
          address_id as id_address
        , country as Pais
        , zipcode as Codigo_Postal
        , address as Direccion
        , state as Estado_region

    FROM src_addresses

    )

SELECT * FROM addresses_renamed