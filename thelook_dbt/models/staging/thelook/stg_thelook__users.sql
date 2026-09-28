with source as (

    select *
    from {{ source('thelook', 'users') }}

),

renamed as (

    select
        -- ids
        id                      as user_id,

        -- attributes
        age,
        gender,
        city,
        state,
        country,
        lower(traffic_source)   as traffic_source,

        -- timestamps
        created_at

    from source

)

select *
from renamed