select

  id,
  product_id,
  sku,
  name,
  title,
  vendor,
  quantity,
  price,
  taxable,
  gift_card,
  total_discount,
  grams

from
  {{ var('source_schema') }}.{{ var('order_items_table') }}
