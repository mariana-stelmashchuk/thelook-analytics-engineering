{{ config(severity = 'warn') }}

select
    oi.order_item_id,
    oi.order_id,
    oi.order_item_status,
    o.order_status
from {{ ref('stg_thelook__order_items') }} as oi
inner join {{ ref('stg_thelook__orders') }} as o
    on oi.order_id = o.order_id
where oi.order_item_status != o.order_status