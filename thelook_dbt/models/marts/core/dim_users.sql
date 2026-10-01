with users as (

    select
        user_id,
        age,
        gender,
        city,
        state,
        country,
        traffic_source,
        created_at
    from {{ ref('stg_thelook__users') }}

),

order_items as (

    select
        user_id,
        order_id,
        is_revenue,
        sale_price,
        created_at
    from {{ ref('int_order_items__enriched') }}

),

user_orders as (

    select
        user_id,
        count(distinct order_id) as orders_count,
        sum(case when is_revenue then sale_price else 0 end) as lifetime_revenue,
        min(created_at) as first_order_at,
        max(created_at) as last_order_at
    from order_items
    group by user_id

),

final as (

    select
        -- ids
        users.user_id,

        -- attributes
        users.age,
        case
            when users.age < 25 then 'under 25'
            when users.age < 35 then '25-34'
            when users.age < 45 then '35-44'
            when users.age < 55 then '45-54'
            else '55+'
        end as age_group,
        users.gender,
        users.city,
        users.state,
        users.country,
        users.traffic_source,

        -- order metrics
        coalesce(user_orders.orders_count, 0) as orders_count,
        coalesce(user_orders.lifetime_revenue, 0) as lifetime_revenue,

        -- timestamps
        users.created_at,
        user_orders.first_order_at,
        user_orders.last_order_at

    from users
    left join user_orders
        on users.user_id = user_orders.user_id

)

select *
from final