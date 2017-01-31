select
  id,
  first_name,
  last_name,
  email,
  verified_email,
  default_address__id as default_address_id,
  note,
  state,
  tags,
  tax_exempt,
  convert_timezone('America/New_York',created_at) as created_at,
  convert_timezone('America/New_York',updated_at) as updated_at,
  accepts_marketing
  
from
  {{ var('source_schema') }}.{{ var('users_table') }}
