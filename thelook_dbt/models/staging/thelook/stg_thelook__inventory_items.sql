with source as (

    select *
    from {{ source('thelook', 'inventory_items') }}

),

renamed as (

    select
        -- ids
        id              as inventory_item_id,
        product_id,

        -- attributes
        cost,

        -- timestamps
        created_at,
        sold_at

    from source

)

select *
from renamed