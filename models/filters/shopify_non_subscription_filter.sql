select oi.id as order_item_id, oi.order_id, o.customer_id
from {{ref('shopify_source_order_items')}} oi
join {{ref('shopify_source_orders')}} o on o.id = oi.order_id
where oi.title like '%Gift Subscription%' or (oi.title not like '%Subscription%' and oi.title not like '%Auto renew%')