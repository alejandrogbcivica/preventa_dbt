with
    src_promos as (select * from {{ source("postgres_public", "promos") }}),

    promos as (

        select

            {{ dbt_utils.surrogate_key('promo_id') }} as id_promo,
            promo_id as promo_desc,
            discount as descuento_euros,
            status as estado_promo

        from src_promos

    )

select *
from promos