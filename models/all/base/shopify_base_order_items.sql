select  
    
--IDs
    oi.id,
    oi.order_id,
    oi.product_id,
    oi.variant_id,
    o.customer_id,
    o.order_number,

--Item Info
    oi.name,
    oi.title,
    oi.variant_title,
    coalesce(pv.sku, oi.sku) as sku,
    p.product_type,

--Numbers
    oi.price,
    oi.quantity,
    oi.total_discount as line_item_discount,
    (oi.price * oi.quantity) - oi.total_discount as line_item_net_sales,
    (oi.price * oi.quantity) as line_item_gross_sales,
    pv.weight,
    pv.weight_unit,
    pv.weight * oi.quantity as line_item_weight,
    o.customer_order_number,
    
--Timestamps
    o.created_at,
    greatest(oi.updated_at, p.updated_at, pv.updated_at, o.updated_at) as updated_at,

--Order Status
    o.financial_status,
    oi.fulfillment_status,

  --Calculated Columns
  	case
    	when oi.title like '%Gift%' and (oi.title like '%Subscription%' or oi.title like '%Auto renew%') then 'Gift Subscription'
    	when oi.title like '%Subscription%' or oi.title like '%Auto renew%' then 'Subscription'
    	else 'Non-Subscription'
  	end as subscription_type

from {{ref('shopify_source_order_items')}} oi
left join {{ref('shopify_source_products')}} p on p.id = oi.product_id
left join {{ref('shopify_source_product_variants')}} pv on pv.id = oi.variant_id
join {{ref('shopify_base_orders')}} o on o.id = oi.order_id