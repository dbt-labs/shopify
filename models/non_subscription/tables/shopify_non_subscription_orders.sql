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
       customer_created_at,
       o.updated_at,
--Numbers
	o.subtotal_price,
	o.total_weight,
       customer_order_number,

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