select 
    
--IDs
    oi.id,
    order_id,
    oi.product_id,
    variant_id,

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
    co.total_weight as order_total_weight,
    co.subtotal_price as order_subtotal,
    co.customer_order_number,
    
--Timestamps
    co.created_at,
    
--Order Status
    co.financial_status,
    co.fulfillment_status

from {{ref('shopify_order_items')}} oi
join {{ref('shopify_product_variants')}} pv on pv.id = oi.variant_id
join {{ref('shopify_customer_orders')}} co on co.id = oi.order_id