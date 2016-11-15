select
--IDs
       id,
       customer_id,
       created_at,
-- Calculated Columns
       rank() over (partition by customer_id order by created_at, id ASC) AS customer_order_number

FROM {{ref('shopify_orders')}}