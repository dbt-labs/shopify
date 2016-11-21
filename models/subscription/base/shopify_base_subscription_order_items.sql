select  
    
--IDs
    oi.id,
    oi.order_id,
    oi.product_id,
    oi.variant_id,
    o.customer_id,

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
    o.subtotal_price as order_subtotal,
    o.customer_order_number,
    
--Timestamps
    o.created_at,
    oi._sdc_received_at as updated_at,

--Order Status
    o.financial_status,
    o.fulfillment_status,

  --Calculated Columns
  	case
    	when oi.title like '%Gift Subscription%' then 'Gift Subscription'
    	when oi.title like '%Subscription%' or oi.title like '%Auto renew%' then 'Subscription'
    	else 'Non-Subscription'
  	end as subscription_type

from {{ref('shopify_source_order_items')}} oi
left join {{ref('shopify_source_product_variants')}} pv on pv.id = oi.variant_id
join {{ref('shopify_base_subscription_orders')}} o on o.id = oi.order_id

where oi.id in (select distinct order_item_id from {{ref('shopify_subscription_filter')}})