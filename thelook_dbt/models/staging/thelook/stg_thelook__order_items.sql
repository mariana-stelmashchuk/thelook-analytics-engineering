with source as (

    select *
    from {{ source('thelook', 'order_items') }}

),

renamed as (

    select
        -- ids
        id                  as order_item_id,
        order_id,
        product_id,
        inventory_item_id,

        -- attributes
        lower(status)       as order_item_status,
        sale_price,

        -- timestamps
        created_at,
        shipped_at,
        delivered_at,
        returned_at

    from source

)

select *
from renamed