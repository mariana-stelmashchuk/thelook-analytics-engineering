with source as (

    select *
    from {{ source('thelook', 'distribution_centers') }}

),

renamed as (

    select
        -- ids
        id as distribution_center_id,

        -- attributes
        name as distribution_center_name,
        latitude,
        longitude,
        distribution_center_geom

    from source

)

select *
from renamed