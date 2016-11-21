select
  u.id,
  first_name,
  last_name,
  u.email,
  state,
  u.tags,
  tax_exempt,
  u.created_at,
  u.updated_at

from {{ref('shopify_source_users')}} u

where u.id not in (select distinct customer_id from {{ref('shopify_subscription_filter')}})