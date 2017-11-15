select

  id,
  barcode,
  created_at,
  fulfillment_service,
  grams,
  inventory_policy,
  inventory_quantity,
  position,
  price,
  product_id,
  requires_shipping,
  sku,
  taxable,
  title,
  weight,
  weight_unit,
  image_id,
  inventory_item_id
  
from
  {{ var('product_variants_table') }}