SELECT 

--IDs
       o.id,
       o.customer_id,

--Customer Info
       o.email,
       ro.customer_order_number,
--Order Status
       financial_status,
       fulfillment_status,
       processing_method,
       gateway,
       
--Timestamps
       o.created_at,
       po.created_at as previous_order_created_at,
       c.created_at as customer_created_at,
       
--Numbers
		o.subtotal_price,
		o.total_weight,
-- Calculated Columns
      	o.created_at - c.created_at as time_since_customer_creation,
     	o.created_at - c.first_order_date as time_since_first_order,
      	o.created_at - po.created_at as time_since_previous_order,
      	c.number_of_orders = ro.customer_order_number as is_most_recent_order
      

FROM {{ref('shopify_orders')}} o
JOIN {{ref('shopify_customers')}} c on c.id = o.customer_id
JOIN {{ref('shopify_ranked_orders')}} ro on ro.id = o.id
LEFT JOIN {{ref('shopify_ranked_orders')}} po on po.customer_id = ro.customer_id and po.customer_order_number = ro.customer_order_number - 1