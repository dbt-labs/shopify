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
	accepts_marketing,

-- Aggregates
	number_of_orders,
	average_order_value,
	first_order_date,
	last_order_date,
	years_active,
	lifetime_revenue,
	items_purchased,
	codes_used,

-- Calculated Columns
	lifetime_revenue / nullif(years_active,0) as annual_revenue,
	items_purchased::float / nullif(number_of_orders,0) as items_per_order

 from {{ref('shopify_base_customers')}} c
 join {{ref('shopify_customer_aggregates')}} ca on ca.customer_id = c.id
 left join {{ref('shopify_customer_discounts')}} cd on cd.customer_id = c.id