select oi.id as order_item_id, oi.order_id, o.customer_id
from {{ref('shopify_source_order_items')}} oi
join {{ref('shopify_source_orders')}} o on o.id = oi.order_id
where oi.title not like '%Gift Subscription%' and (oi.title like '%Subscription%' or oi.title like '%Auto renew%')