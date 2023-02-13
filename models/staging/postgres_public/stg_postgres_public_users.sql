

{{ config(materialized="view") }}

with
    src_users as (select * from {{ source("postgres_public", "users") }}),

    users_renamed as (

        select
            user_id,
            cast(updated_at as date) as actualizado_el,
            address_id,
            first_name as nombre,
            last_name as apellido,
            cast(created_at as date) as creado_el,
            phone_number as telefono_movil,
            email as correo,
            _fivetran_synced,
            _fivetran_deleted

        from src_users

    )

select *
from users_renamed