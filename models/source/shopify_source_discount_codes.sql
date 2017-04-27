select

  _sdc_source_key_id as order_id,
  lower(code) as code,
  amount,
  type,
  _sdc_received_at as updated_at


from
  {{ var('source_schema') }}.{{ var('discount_codes_table') }}
