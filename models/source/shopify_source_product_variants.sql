select 

id,
product_id,
upper(sku) as sku,
title,
option1,
option2,
option3,
price,
weight,
weight_unit,
_sdc_received_at as updated_at

from
  {{ var('source_schema') }}.{{ var('product_variants_table') }}