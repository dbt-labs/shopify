select
  
  id,
  _sdc_source_key_id as order_id,
  product_id,
  variant_id,
  upper(sku) as sku,
  name,
  title,
  variant_title,
  fulfillment_status,
  vendor,
  quantity,
  price,
  taxable,
  gift_card,
  total_discount,
  grams,
  _sdc_received_at as updated_at

from
  {{ var('source_schema') }}.{{ var('order_items_table') }}
