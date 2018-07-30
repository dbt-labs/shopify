Select 
  line_item__id as line_item_id,
  line_item__name as line_item_name,
  line_item__sku as line_item_sku,
  quantity as refunded_quantity,
  subtotal as refunded_subtotal
from shopify.order_refunds__refund_line_items