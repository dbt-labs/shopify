select
  _sdc_source_key_id as order_id,
  _sdc_level_0_id as line_item_number,
  name as property_name,
  value as property_value,
  _sdc_received_at as updated_at
from {{ var('source_schema') }}.{{ var('order_items_properties_table') }}