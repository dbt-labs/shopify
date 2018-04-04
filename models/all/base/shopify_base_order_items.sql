select  
    
--IDs
    oi.id,
    oi.order_id,
    oi.product_id,
    oi.variant_id,
    o.customer_id,
    o.order_number,
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
    o.customer_order_number,
    
--Timestamps
    o.created_at,
    greatest(oi.updated_at, p.updated_at, pv.updated_at, o.updated_at) as updated_at,

--Order Status
    o.financial_status,
    oi.fulfillment_status,

--Order Item Properties
subid.property_value as subscription_id,
sif.property_value as subscription_shipping_frequency,
siut.property_value as subscription_shipping_frequency_unit,
cif.property_value as subscription_charge_frequency,
ciut.property_value as subscription_charge_frequency_unit,

  --Calculated Columns
  	case
    	when cif.property_value is not null then 'Gift Subscription'
    	when sif.property_value is not null then 'Subscription'
    	else 'Non-Subscription'
  	end as subscription_type

from {{ref('shopify_source_order_items')}} oi
left join {{ref('shopify_source_products')}} p on p.id = oi.product_id
left join {{ref('shopify_source_product_variants')}} pv on pv.id = oi.variant_id
join {{ref('shopify_base_orders')}} o on o.id = oi.order_id
left join {{ref('shopify_source_order_items_properties')}} subid 
        on subid.order_id = oi.order_id 
        and subid.line_item_number = oi.line_item_number 
        and subid.property_name = 'subscription_id'
left join {{ref('shopify_source_order_items_properties')}} sif 
        on sif.order_id = oi.order_id 
        and sif.line_item_number = oi.line_item_number 
        and sif.property_name = 'shipping_interval_frequency'
left join {{ref('shopify_source_order_items_properties')}} siut 
        on siut.order_id = oi.order_id 
        and siut.line_item_number = oi.line_item_number 
        and siut.property_name = 'shipping_interval_unit_type'
left join {{ref('shopify_source_order_items_properties')}} cif 
        on cif.order_id = oi.order_id 
        and cif.line_item_number = oi.line_item_number 
        and cif.property_name = 'charge_interval_frequency'
left join {{ref('shopify_source_order_items_properties')}} ciut 
        on ciut.order_id = oi.order_id 
        and ciut.line_item_number = oi.line_item_number 
        and ciut.property_name = 'charge_interval_unit_type'

