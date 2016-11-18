select
  u.id,
  first_name,
  last_name,
  email,
  state,
  tags,
  tax_exempt,
  u.created_at,
  u.updated_at

from {{ref('shopify_source_users')}} u
join {{ref('shopify_source_orders')}} o on o.customer_id = u.id