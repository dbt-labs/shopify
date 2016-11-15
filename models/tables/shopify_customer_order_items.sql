{{
  config({
    "materialized" : "incremental",
    "sql_where" : "_sdc_received_at > (select max(_sdc_received_at) from {{this}})",
    "unique_key" : "id",
    "sort" : "created_at",
    })
}}

select 
    
--IDs
    oi.id,
    order_id,
    oi.product_id,
    variant_id,
    co.customer_id,

--Item Info
    oi.name,
    oi.title,
    oi.variant_title,
    pv.sku,
  
--Numbers
    oi.price,
    oi.quantity,
    oi.total_discount,
    pv.weight,
    pv.weight_unit,
    co.subtotal_price as order_subtotal,
    co.customer_order_number,
    
--Timestamps
    co.created_at,
    oi._sdc_received_at,

--Order Status
    co.financial_status,
    co.fulfillment_status,

--Calculated Columns
	case
		when oi.title like '%Gift Subscription%' then 'Gift Subscription'
		when oi.title like '%Subscription%' or oi.title like '%Auto renew%' then 'Subscription'
		else 'Non-Subscription'
	end as subscription_type

from {{ref('shopify_order_items')}} oi
join {{ref('shopify_product_variants')}} pv on pv.id = oi.variant_id
join {{ref('shopify_customer_orders')}} co on co.id = oi.order_id