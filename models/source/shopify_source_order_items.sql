select
  
  id,
  _sdc_source_key_id as order_id,
  product_id,
  variant_id,
  upper(sku) as sku,
  name,
  title,
  variant_title,
  vendor,
  quantity,
  price,
  taxable,
  gift_card,
  total_discount,
  grams,
  _sdc_received_at

from
  {{ var('source_schema') }}.{{ var('order_items_table') }}
