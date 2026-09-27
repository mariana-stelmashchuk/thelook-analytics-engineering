with source as (

    select *
    from {{ source('thelook', 'orders') }}

),

renamed as (

    select
        -- ids
        order_id,
        user_id,

        -- attributes
        lower(status)   as order_status,
        num_of_item     as items_count,

        -- timestamps
        created_at      as ordered_at,
        shipped_at,
        delivered_at,
        returned_at

    from source

)

select *
from renamed