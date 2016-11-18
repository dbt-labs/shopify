SELECT 

--IDs
       o.id,
       o.customer_id,

--Customer Info
       o.email,
--Order Status
       financial_status,
       fulfillment_status,
       processing_method,
       gateway,
       
--Timestamps
       o.created_at,
       c.created_at as customer_created_at,
       o.updated_at,
--Numbers
	o.subtotal_price,
	o.total_weight

--Calculated Columns
       rank() over (partition by o.customer_id order by o.created_at, o.id ASC) AS customer_order_number

FROM {{ref('shopify_source_orders')}} o
JOIN {{ref('shopify_base_subscription_customers')}} c

where o.id in (select distinct order_id from {{ref('shopify_subscription_filter')}})