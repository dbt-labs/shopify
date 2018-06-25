select

  order_id,
  listagg(code, ', ') within group (order by code) as codes_used,
  sum(amount) as amount,
  max(updated_at) as updated_at


from
  {{ref('shopify_source_discount_codes')}}
  group by 1