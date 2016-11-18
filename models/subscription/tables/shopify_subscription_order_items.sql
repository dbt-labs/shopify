select  
    
--IDs
    oi.id,
    oi.order_id,
    oi.product_id,
    oi.variant_id,
    oi.customer_id,

--Item Info
    oi.name,
    oi.title,
    oi.variant_title,
    oi.sku,
    oi.subscription_type
  
--Numbers
    oi.price,
    oi.quantity,
    oi.total_discount,
    oi.weight,
    oi.weight_unit,
    oi.subtotal_price as order_subtotal,
    oi.customer_order_number,
    
--Timestamps
    oi.created_at,
    oi.updated_at,

--Order Status
    oi.financial_status,
    oi.fulfillment_status

--Order Aggregates
    

FROM {{ref('shopify_base_subscription_order_items')}} oi
JOIN {{ref('shopify_subscription_orders')}} o on oi.order_id = o.id