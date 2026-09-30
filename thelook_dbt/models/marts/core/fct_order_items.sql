with order_items as (

    select
        order_item_id,
        order_id,
        product_id,
        inventory_item_id,
        order_item_status,
        sale_price,
        created_at,
        shipped_at,
        delivered_at,
        returned_at
    from {{ ref('stg_thelook__order_items') }}

),

orders as (

    select
        order_id,
        user_id
    from {{ ref('stg_thelook__orders') }}

),

inventory_items as (

    select
        inventory_item_id,
        cost
    from {{ ref('stg_thelook__inventory_items') }}

),

final as (

    select
        -- ids
        order_items.order_item_id,
        order_items.order_id,
        orders.user_id,
        order_items.product_id,

        -- attributes
        order_items.order_item_status,
        order_items.returned_at is not null as is_returned,

        -- measures
        order_items.sale_price,
        inventory_items.cost,
        order_items.sale_price - inventory_items.cost as gross_margin,

        -- timestamps
        order_items.created_at,
        order_items.shipped_at,
        order_items.delivered_at,
        order_items.returned_at

    from order_items
    left join orders
        on order_items.order_id = orders.order_id
    left join inventory_items
        on order_items.inventory_item_id = inventory_items.inventory_item_id

)

select *
from final