select

  _sdc_source_key_id as order_id,
  code,
  amount,
  type,
  _sdc_received_at

from
  {{ var('source_schema') }}.{{ var('discount_codes_table') }}
