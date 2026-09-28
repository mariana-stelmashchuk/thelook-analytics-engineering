with source as (

    select *
    from {{ source('thelook', 'products') }}

),

renamed as (

    select
        -- ids
        id                      as product_id,
        distribution_center_id,

        -- attributes
        name                    as product_name,
        category,
        brand,
        department,
        sku,
        cost,
        retail_price

    from source

)

select *
from renamed