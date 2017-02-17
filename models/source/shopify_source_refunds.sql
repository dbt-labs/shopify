select

  id,
  order_id,
  user_id,
  restock,
  note,
  convert_timezone('America/New_York',created_at) as created_at,
  _sdc_received_at as updated_at

from
  {{ var('source_schema') }}.{{ var('refunds_table') }}
