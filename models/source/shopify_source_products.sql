select

  id,
  title,
  product_type,
  vendor,
  tags,
  handle,
  published_at,
  created_at,
  _sdc_received_at as updated_at

from
  {{ var('source_schema') }}.{{ var('products_table') }}
