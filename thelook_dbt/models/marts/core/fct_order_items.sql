select
    -- ids
    order_item_id,
    order_id,
    user_id,
    product_id,

    -- attributes
    order_item_status,
    is_returned,
    is_revenue,

    -- measures
    sale_price,
    cost,
    gross_margin,

    -- timestamps
    created_at,
    shipped_at,
    delivered_at,
    returned_at

from {{ ref('int_order_items__enriched') }}