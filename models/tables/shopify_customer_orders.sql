{{
  config({
    "materialized" : "incremental",
    "sql_where" : "_sdc_received_at > (select max(_sdc_received_at) from {{this}})",
    "unique_key" : "id",
    "sort" : "created_at",
    })
}}

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
       o._sdc_received_at,
--Numbers
		o.subtotal_price,
		o.total_weight,
-- Calculated Columns
      	datediff(second, c.created_at, o.created_at) as time_since_customer_creation,
     	datediff(second, c.first_order_date, o.created_at) as time_since_first_order,
      	datediff(second, po.created_at, o.created_at) as time_since_previous_order,
      	c.number_of_orders = ro.customer_order_number as is_most_recent_order
      

FROM {{ref('shopify_orders')}} o
JOIN {{ref('shopify_customers')}} c on c.id = o.customer_id
JOIN {{ref('shopify_ranked_orders')}} ro on ro.id = o.id
LEFT JOIN {{ref('shopify_ranked_orders')}} po on po.customer_id = ro.customer_id and po.customer_order_number = ro.customer_order_number - 1