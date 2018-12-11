select 

  id as fulfillment_id,
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

from shopify.orders__fulfillments