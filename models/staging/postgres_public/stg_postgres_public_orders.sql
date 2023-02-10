{{
  config(
    materialized='incremental',
    unique_key= 'order_id',
    merge_update_columns = ['order_cost_eur','order_total_eur'],
    on_schema_change = 'append_new_columns'
  )
}}


with
    src_orders as (
        select * from {{ source("postgres_public", "orders") }}),

    orders_renamed as (

        select
             order_id
            ,address_id
            ,shipping_service 
            ,shipping_cost
            ,created_at
            ,case 
                when promo_id = '' then null
                else {{ dbt_utils.surrogate_key(['promo_id']) }}
                end as id_promo
            ,promo_id as promo_desc
            ,estimated_delivery_at
            ,order_cost as order_cost_eur
            ,user_id
            ,order_total as order_total_eur
            ,delivered_at as delivered_at_utc
            ,case 
                when tracking_id = '' then null
                else {{ dbt_utils.surrogate_key(['tracking_id']) }}
                end as tracking_id
            ,{{ dbt_utils.surrogate_key(['status']) }} as estatus_id
            ,status as estatus_desc
            ,_fivetran_synced

        from src_orders
 

    )

select *
from orders_renamed

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}