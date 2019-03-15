{{
    config(
        materialized='table'
    )
}}

with orders as (
    
    select 
        
        created_at::date as date_day,
        count(*) as total_orders,
        sum(total_line_items_price) as total_gross_revenue,
        sum(final_discounts) as total_discounts,
        sum(final_shipping_cost) as total_shipping_cost,
        sum(total_tax) as total_tax
        
    from {{ ref('stg_shopify_orders') }}
    group by 1
    
),

refunds as (

    select
        
        refund_processed_at::date as date_day,
        sum(refund_amount) as total_refund_amount,
        sum(refund_tax_amount) as total_refund_tax_amount,
        sum(refund_shipping_amount) as total_refund_shipping_amount
      
    from {{ ref('stg_shopify_refunds') }}
    group by 1

),

calculated as (

    select
    
        {{ dbt_utils. surrogate_key('date_day')}} as id,
        
        orders.date_day,
        orders.total_orders,
        orders.total_gross_revenue,
        orders.total_discounts,
        coalesce(refunds.total_refund_amount, 0) as total_refund_amount,

        coalesce(refunds.total_refund_shipping_amount, 0) +
            coalesce(orders.total_shipping_cost, 0) 
            as total_shipping_costs,
            
        coalesce(refunds.total_refund_tax_amount, 0) +
            coalesce(orders.total_tax, 0)
            as total_tax,
            
        coalesce(orders.total_gross_revenue, 0) +
            coalesce(orders.total_discounts, 0) +
            coalesce(refunds.total_refund_amount, 0)
            as total_net_sales,
            
        coalesce(orders.total_gross_revenue, 0) + 
            coalesce(refunds.total_refund_amount, 0) +
            coalesce(orders.total_discounts, 0) + 
            coalesce(refunds.total_refund_shipping_amount, 0) +
            coalesce(orders.total_shipping_cost, 0) + 
            coalesce(refunds.total_refund_tax_amount, 0) +
            coalesce(orders.total_tax, 0)
            as total_sales
             
    from orders
    left join refunds using (date_day)
    
)

select * from calculated