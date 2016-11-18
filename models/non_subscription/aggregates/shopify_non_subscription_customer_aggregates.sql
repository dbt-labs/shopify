select 

       	o.customer_id,
   
--Calculated Columns
--Orders
		count(o.id) as number_of_orders,
		avg(o.subtotal_price) as average_order_value,
		min(o.created_at) as first_order_date,
		max(o.created_at) as last_order_date,
		datediff(second, min(o.created_at), max(o.created_at))::float / (60*60*24*365) as years_active,
		sum(o.subtotal_price) as lifetime_revenue,
		max(o._sdc_received_at) as _sdc_received_at
--Order Items
		sum(count_of_items) as items_purchased

from {{ref('shopify_base_non_subscription_orders')}} o
join {{ref('shopify_non_subscription_order_aggregates')}} oa on oa.order_id = o.id
group by 1
