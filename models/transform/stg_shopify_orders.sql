{% set order_seq_number = "row_number() over (partition by customer_id order by created_at)" %}

with orders as (

    select * from {{ref('base_shopify_orders')}}

),

discounts as (
    
    select 
        order_id, 
        code as discount_code,
        type as discount_type,
        case 
            when type = 'shipping' then amount 
            else 0 
        end as shipping_discount
    from {{ ref('stg_shopify_discount_codes') }}
    
),

discounts_joined as (
    
    select
        *,
        coalesce(total_discounts_base, 0) - coalesce(shipping_discount, 0) 
            as final_discounts,
        coalesce(total_shipping_cost_base, 0) + coalesce(shipping_discount, 0) 
            as final_shipping_cost
    from orders
    left join discounts using (order_id)
    
),

final as (

    select
        *,
        {{ order_seq_number }} as order_seq_number,
        case
            when {{ order_seq_number }} = 1 then 'new'
            else 'repeat'
        end as new_vs_repeat,
        case
            when cancelled_at is not null then true
            else false
        end as cancelled
    from discounts_joined

)

select * from final