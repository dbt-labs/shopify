select
	id,
	first_name,
	last_name,
	email,
	state,
	tags,
	tax_exempt,
	created_at,
	updated_at,

-- Aggregates
	number_of_orders,
	average_order_value,
	first_order_date,
	last_order_date,
	years_active,
	lifetime_revenue,
	items_purchased,

-- Calculated Columns
	lifetime_revenue / years_active as annual_revenue,
	items_purchased::float / number_of_orders as items_per_order

 from {{ref('shopify_base_customers')}} c
 join {{ref('shopify_customer_aggregates')}} ca on ca.customer_id = c.id