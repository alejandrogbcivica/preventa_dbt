{{
  config(
    materialized='view'
  )
}}


with
    src_orders as (
        select * from {{ source("postgres_public", "orders") }}),

    orders_renamed as (

        select
            order_id,
            address_id,
            shipping_service as servicio_de_envio,
            shipping_cost as coste_envio,
            created_at as fecha_creacion,
            case 
                when promo_id = '' then null
                else {{ dbt_utils.surrogate_key('promo_id') }}
                end as id_promo ,
            promo_id as promo_desc,
            estimated_delivery_at as fecha_entrega_estimada,
            order_cost as coste_total_sin_envio_euros,
            user_id,
            order_total as venta_final,
            delivered_at as fecha_entrega,
            case 
                when tracking_id = '' then null
                else {{ dbt_utils.surrogate_key('tracking_id') }}
                end as tracking_id,
            {{ dbt_utils.surrogate_key('status') }} as estado_id,
            status as estado_del_pedido

        from src_orders
 

    )



select *
from orders_renamed