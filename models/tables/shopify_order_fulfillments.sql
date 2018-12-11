select 

  fulfillment_id,
  order_id,
  name,
  service,
  status,
  tracking_company,
  tracking_number,
  tracking_url,
  created_at,
  updated_at,
  shipment_status

from {{ref('shopify_source_order_fulfillments')}}