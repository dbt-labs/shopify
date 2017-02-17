{{
  config({
    "materialized" : "incremental",
    "unique_key" : "id",
    "sort" : "created_at",
    "sql_where" : "updated_at >= (select max(updated_at) from {{this}})"
    })
}}

select
	id,
	first_name,
	last_name,
	email,
	state,
	tags,
	tax_exempt,
	created_at,
	greatest(c.updated_at, ca.updated_at) as updated_at,

-- Aggregates
	number_of_orders,
	average_order_value,
	first_order_date,
	last_order_date,
	years_active,
	lifetime_revenue,
	items_purchased,

-- Calculated Columns
	lifetime_revenue / nullif(years_active,0) as annual_revenue,
	items_purchased::float / nullif(number_of_orders,0) as items_per_order

 from {{ref('shopify_base_non_subscription_customers')}} c
 join {{ref('shopify_non_subscription_customer_aggregates')}} ca on ca.customer_id = c.id