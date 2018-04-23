select

  order_id,
  code,
  amount,
  type,
  updated_at


from
  {{ ref('shopify_source_discount_codes') }}
