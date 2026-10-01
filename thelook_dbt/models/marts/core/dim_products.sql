with products as (

    select
        product_id,
        distribution_center_id,
        product_name,
        category, 
        brand,
        department,
        sku,
        cost,
        retail_price
    from {{ ref('stg_thelook__products') }}

),

distribution_centers as (

    select
        distribution_center_id,
        distribution_center_name
    from {{ ref('stg_thelook__distribution_centers') }}

),

final as (

    select
        products.*,
        distribution_centers.distribution_center_name

    from products
    left join distribution_centers
        on products.distribution_center_id = distribution_centers.distribution_center_id

)

select *
from final