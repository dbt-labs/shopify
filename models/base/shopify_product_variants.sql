select 

id,
product_id,
sku,
title,
option1,
option2,
option3,
price,
weight,
weight_unit

from
  {{ var('source_schema') }}.{{ var('product_variants_table') }}