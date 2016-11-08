select

  id,
  product_id,
  sku,
  name,
  title,
  vendor,
  quantity,
  pre_tax_price,
  price,
  taxable,
  gift_card,
  total_discount,
  grams

from
  {{ var('source_schema') }}.{{ var('order_items_table') }}
