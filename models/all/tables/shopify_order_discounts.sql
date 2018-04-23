select

  order_id,
  discount_number,
  code,
  amount,
  type,
  updated_at


from
  {{ ref('shopify_source_discount_codes') }}
