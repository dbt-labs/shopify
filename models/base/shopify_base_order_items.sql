select  
    
--IDs
    oi.id,
    oi.order_id,
    oi.product_id,
    oi.variant_id,
    oi.line_item_number,

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
    ri.refunded_quantity,
    ri.refunded_subtotal,
    
--Timestamps
    greatest(oi.updated_at, p.updated_at, pv.updated_at) as updated_at,

--Order Status
    oi.fulfillment_status

from {{ref('shopify_source_order_items')}} oi
left join {{ref('shopify_source_products')}} p on p.id = oi.product_id
left join {{ref('shopify_source_product_variants')}} pv on pv.id = oi.variant_id
left join {{ref('shopify_source_refund_items')}} ri on oi.id = ri.line_item_id
