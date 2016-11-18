select id as order_item_id, order_id, customer_id
from {{ref('shopify_base_order_items')}}
where oi.subscription_type = 'Subscription'