SELECT 

--IDs
       o.id,
       o.customer_id,

--Customer Info
       o.email,
--Order Status
       o.financial_status,
       o.fulfillment_status,
       o.processing_method,
       o.gateway,
       
--Timestamps
       o.created_at,
       o.customer_created_at,
       greatest(c.updated_at, oa.updated_at, o.updated_at) as updated_at,
       po.created_at as previous_order_created_at,
--Numbers
	o.subtotal_price,
	o.total_weight,
       o.customer_order_number,

--Order Aggregates
       oa.count_of_items,

--Customer Aggregates
       number_of_orders,
       average_order_value,
       first_order_date,
       last_order_date,
       years_active,
       lifetime_revenue,
       items_purchased,
       annual_revenue

FROM {{ref('shopify_base_non_subscription_orders')}} o
JOIN {{ref('shopify_non_subscription_order_aggregates')}} oa on oa.order_id = o.id
JOIN {{ref('shopify_non_subscription_customers')}} c on c.id = o.customer_id
LEFT JOIN {{ref('shopify_base_subscription_orders')}} po on po.customer_id = o.customer_id and po.customer_order_number = (o.customer_order_number - 1)