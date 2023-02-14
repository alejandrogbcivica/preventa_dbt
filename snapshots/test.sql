{% snapshot orders_snapshot %}

{{
    config(
      unique_key='order_id',
      target_schema= generate_schema_name('snapshots'),
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ source('postgres_public', 'order_items') }}

{% endsnapshot %}
