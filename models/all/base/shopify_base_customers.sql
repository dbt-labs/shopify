select
  u.id,
  first_name,
  last_name,
  u.email,
  state,
  u.tags,
  tax_exempt,
  u.created_at,
  u.updated_at,
  accepts_marketing

from {{ref('shopify_source_users')}} u